Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38193C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E762B2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TMTwml2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E762B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731692AbeKEBao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:30:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39234 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbeKEBao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:30:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so2625686ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 08:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GH/tKmuvnwOZEdfMhADkJVipQMEo38WPWC9tYTzrPoI=;
        b=TMTwml2UuW9L2DvOsV1CqyX++ibr76gSsaUqwB/jwj+ZenMnt0BlKrW814+hzw89p/
         /+GpB+QKtLqEyU8RwrsnJWDH+v650y+Er/d7kjW/Iru6w6LZUWrzYxU4nCOq2gQOjKJj
         3w0Bm3hgbkYAyT+G7MgGEOogLV8n6PlshiS3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GH/tKmuvnwOZEdfMhADkJVipQMEo38WPWC9tYTzrPoI=;
        b=FE0DVrOqMKi1wUPEVbfuID3miBFWvIHUH1/puUlv/Jt3hhhcneVzqgzH+HV6phabrv
         nmicgjICKJGIm0bXZltv1npYoij4lSqWdbFyUoLoraRvCW59QZ2HZmOnN094ArZJQw3o
         RJzb34Thw7v4C5Z5CMbt0BGccfMv+U2S2wOrbhI/9q3dUYLSjc01L2ftiKFAgOBCEYc/
         A8MuMlptxm6HkBXpxTc+IHPW1hNAqv3a+X0Stwdq+29bQXVZJAEsGe02ix5QXTsQ+eNZ
         XH8eooRh4i+gj/dn/IjD020Dubq3Gi7ZElp1G4fnxkLOZ7HmiIBaPh1tWBvnAC4sLwxh
         Q/JQ==
X-Gm-Message-State: AGRZ1gJI3MwUj+4fFyUSzH+UIO55P5kygHkIN+LK2EF8e9VtGHc511lQ
        XFFeNGQYxlbM/dmQKYxZNzDJqH70bm4=
X-Google-Smtp-Source: AJdET5erOaZOHJw4HyxFKbui0Ap8G+Vneav2stbhhcx5S9gOPiWOd+MmsKLGp9bjEZJV5jiS3W0E8g==
X-Received: by 2002:a2e:58b:: with SMTP id 133-v6mr13104950ljf.127.1541348113483;
        Sun, 04 Nov 2018 08:15:13 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id q2sm951661lfg.35.2018.11.04.08.15.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 08:15:12 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id x3-v6so5774608lji.13
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 08:15:12 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr6904190ljk.80.1541348111606;
 Sun, 04 Nov 2018 08:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20181104040002.GA2439@graymalkin.kudzu.us>
In-Reply-To: <20181104040002.GA2439@graymalkin.kudzu.us>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 4 Nov 2018 08:14:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whk1UXWJY5m+hMgCuTD_mWZKbe+_prbxwMUujyVS6LqGw@mail.gmail.com>
Message-ID: <CAHk-=whk1UXWJY5m+hMgCuTD_mWZKbe+_prbxwMUujyVS6LqGw@mail.gmail.com>
Subject: Re: [GIT PULL] NTB patches for v4.20
To:     jdmason@kudzu.us
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ntb@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 9:00 PM Jon Mason <jdmason@kudzu.us> wrote:
>
> Here are a few NTB patches for v4.20.  Fairly minor changes and bug
> fixes.

Pulled,

               Linus
