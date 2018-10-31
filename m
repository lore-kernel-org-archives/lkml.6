Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DA9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15D82080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cQEtco8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15D82080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeKADEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:04:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44281 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbeKADEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:04:37 -0400
Received: by mail-lf1-f67.google.com with SMTP id m18-v6so12350580lfl.11
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=myIFttpvT9dibX+rGH7NfO62U63KMSfQ6XMDAGbeP7U=;
        b=cQEtco8yyr05cIqJ14UOD3Ht4cKTo+46WXF9meaTkwnr7ECkWBlKolROsdlFbh6SLv
         +JTFbXjtjjlPL/QcdocRM5uzd4t80GJaSeRmMzfL7nWA4O6k5XixRn4G2U+2SdRuVW18
         GtBYJP7YN1kSZOZZZPaHcYTkQ6H23YDoMFcK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=myIFttpvT9dibX+rGH7NfO62U63KMSfQ6XMDAGbeP7U=;
        b=otLBm5zvNETjrV2GAKb/4HmnJHitv0EfeoBzQeoE3S00BJO3r0HcN/CjTmdWZPenyp
         epB1aTiP0aLvwY8pX6E3aNu5Y47IX3UWwBfeEdUzxZ/GOLVqQ0LSdT5I6gqpPjuaAS3F
         q7xiG/amPe4Y850/2FH9+wUakUOiWG0nxZSn4BGJDVdLP60WcEsiros6KloVEVuDYuQT
         GK7kYasMJkj0Do69N8Fw2xhpVJufQBWPZLuvJOGJihELf+FV+6F7KiLl7JklgBNaW7M5
         +xD0FWhgCeuvYAshdOyscXkdPvyJeA/Zn4Zp9kqULWsZ9LmCvbnGJXaSj0Xn5pvCIKey
         ytdA==
X-Gm-Message-State: AGRZ1gKxExmOtfYTbxsFWIJs0Wv5+u20y9mExgzHWbxgrI4aTxGXidip
        VfzVrh7wXwNXYmws6U9NH4iSPB3Be8QXyQ==
X-Google-Smtp-Source: AJdET5eVeosZz6liJwgFUJ0yAUhj29Sp3G/2YTbYZP3JSA+Tk/xXlsWwZMLNjeEJ0pVv12yBoVp4Lg==
X-Received: by 2002:a19:db82:: with SMTP id t2mr2684654lfi.130.1541009129440;
        Wed, 31 Oct 2018 11:05:29 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 18-v6sm4078295ljo.74.2018.10.31.11.05.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:05:27 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id f3-v6so15689764ljk.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:05:27 -0700 (PDT)
X-Received: by 2002:a2e:7f14:: with SMTP id a20-v6mr2660142ljd.148.1541009126681;
 Wed, 31 Oct 2018 11:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20181030105328.0667ec68@coco.lan>
In-Reply-To: <20181030105328.0667ec68@coco.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 11:05:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQKCA18MEi7FT=10c0HVa=kxSyYBJeAQH-C2mA5gBhbg@mail.gmail.com>
Message-ID: <CAHk-=whQKCA18MEi7FT=10c0HVa=kxSyYBJeAQH-C2mA5gBhbg@mail.gmail.com>
Subject: Re: [GIT PULL for v4.20-rc1] new experimental media request API
To:     mchehab+samsung@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 6:53 AM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
>
> For a new media API: the request API

Ugh. I don't know how much being in staging matters - if people start
using it, they start using it.

"Staging" does not mean "regressions don't matter".

But pulled,

                Linus
