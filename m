Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC5BC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 00:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BE320827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 00:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dsnz3NmC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BE320827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbeJ2JdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 05:33:01 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:43244 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeJ2JdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 05:33:01 -0400
Received: by mail-lf1-f43.google.com with SMTP id u18so4719029lff.10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 17:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JpWK2Xlzv987CjbAcsLoDxIaIcL5CuDaUjds0o8f+ak=;
        b=dsnz3NmCCby1mbbDsU4uzfaeuI8SPXH/5jF5kCQTsL5y3nANSav5olMbzhbOUbntwN
         rOiocrRXnNiSUXTNaTWPZIA96kyokUN8lBRHLNW6NbkHegqfUlUgohgdEg0LXtrNmM8n
         IiHxdkIm+wSK2nR5WnCf9eWZ+CBq3fsw2AjMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JpWK2Xlzv987CjbAcsLoDxIaIcL5CuDaUjds0o8f+ak=;
        b=l4cWRFRrWRLj+Poj57M2QYTuTixI57u0tnxjkYptJnm8wDXwOL570s50k1Nb3/yqxX
         V5xAD/Yu/P7LnqK+R3OE/zCk93amTzeOHc3C3+iEG2YBjT9uWpbELWMpm0nbQCtToPgT
         tN86YfX5qkQVKLoGHTYPrkq8Yqa/opNd2z6JWaTP3QHWk8kM+ktzl0jqK1tKqDz73Vnz
         tjMhUOu0O7H5QeEl5pxTYUggzBjkxz16rC2wLuSZTWYSRPvPMKl+NGjmkDNK5fVzhTD4
         zOg4IsfFEdWD+1pgg1rPnZR12N65dZ2/ag+/wAQN2T7HOpTr3K3lg6zzbU4S4qf67Rge
         gYPQ==
X-Gm-Message-State: AGRZ1gIVO93iAjxd0aGSCjo71EwcY2Wo0rK+iyBHYhW4CZZkh7/WC/xB
        jEqjTwfE8TU6FvnfzXCS8i6dfQupMulvyA==
X-Google-Smtp-Source: AJdET5dG7yt7IcVYNWnKMl5eWcqTMPfEyz4Y4v/Mr5oPm3IGxIFmqlrYQIGBC9RxkiPJS4vanSbJfg==
X-Received: by 2002:a19:c7c2:: with SMTP id x185mr7179724lff.123.1540774001868;
        Sun, 28 Oct 2018 17:46:41 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 1-v6sm2778771ljc.46.2018.10.28.17.46.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 17:46:40 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id i26so416157lfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 17:46:39 -0700 (PDT)
X-Received: by 2002:ac2:41d8:: with SMTP id d24-v6mr6618821lfi.138.1540773998839;
 Sun, 28 Oct 2018 17:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tw3SBUaueL2JGTybfkQo3f6qbQ291i3XTW-w32xdKsT-g@mail.gmail.com>
 <CAPM=9tzoxXgznLGhDt1CXwyrLw3ZUSetviPHEq5Fk=ojTNLZ3A@mail.gmail.com>
In-Reply-To: <CAPM=9tzoxXgznLGhDt1CXwyrLw3ZUSetviPHEq5Fk=ojTNLZ3A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Oct 2018 17:46:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgG_htAk+WMmJXsStc5h06Xz6YEyb1GB_8vGuHXr6mOPQ@mail.gmail.com>
Message-ID: <CAHk-=wgG_htAk+WMmJXsStc5h06Xz6YEyb1GB_8vGuHXr6mOPQ@mail.gmail.com>
Subject: Re: [git pull] drm pull for 4.20-rc1
To:     airlied@gmail.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 4:47 PM Dave Airlie <airlied@gmail.com> wrote:
>
> I was just about to ask if I'd gotten a reply that require Linus
> filtering, then I realised I hadn't sent this to you, but the mailing
> list by mistake.

Heh. And _I_ was just about to send you a query about where the pull
request was, since it was one of the bigger missing pieces..

Yeah, I don't pick up the pull requests from the mailing lists at all,
only from emails sent directly yo me.

                       Linus
