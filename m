Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06425C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2872222FE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mly0Z3tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfAETlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:41:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46148 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfAETlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 14:41:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id y14so8625977lfg.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 11:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6X69VWjhSzmMz+DfKXJoVaWJg1SFXxvRInBWo6yu6D0=;
        b=Mly0Z3tbmahrJa01WWarei2RrQyKofg1unyu0xqN5e7H+6DXO8mu/dkGZkCKVz+50+
         ob0Qk9cWYudG99TfdlilfIWEO3RpHeCettaydGeH0dFmrkCuGza2Kuw+Vbl26wcZpGNx
         3DYY4ty6P/0LZofQyWJ/ydC2zdxj/KwSrVYiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6X69VWjhSzmMz+DfKXJoVaWJg1SFXxvRInBWo6yu6D0=;
        b=lPdQ2CfP7nXJneU6t1+UaphT0fluLvWTQTLB6sPSU8ztygUXWHxzWGJfnwU8WKVd7j
         Q59mqoo/g05WrgVUq8MJrkRwYLFuWPEOvJF2/VsTkYJdqDLVVUQOPwpUMiEy0C29VuQS
         9+2WmQuQgSbmHlrGtTSEFHS2jsiW5Rq09eerIrfRxMZl2cd7OJW9Km8tRrniRlms4gMX
         vdXNslGZNQD7MIOJV00Dt+MBt5/CeOC9WwmQmJg/GdVhhi5u8ZzbU5Bf6NfKFRJPlRFB
         M5kWeERRiR62Uo4KL45IyYklHgIIDSwzJHpY3NtmiwKuXN/a6+EZqVyFxO64mHOHYFV5
         DGSQ==
X-Gm-Message-State: AJcUukdOGKTv92JAjBSuxjybpnC84/hI6vpcb0rD8sJfdkhNTon5ymAP
        c+uDShIYMKJ0jYebP+OkIh6IF8yNChM=
X-Google-Smtp-Source: ALg8bN65sc6mTnBph34tt/lOULQeFYtK4WNuACFbRv4PFaT8Cr8GIDGcfgkucxqAiMeTjBtEiFsYag==
X-Received: by 2002:a19:c203:: with SMTP id l3mr6225312lfc.113.1546717272138;
        Sat, 05 Jan 2019 11:41:12 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id h12-v6sm12935119ljb.80.2019.01.05.11.41.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 11:41:11 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id c19-v6so35069599lja.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 11:41:11 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr8138468ljk.80.1546717270756;
 Sat, 05 Jan 2019 11:41:10 -0800 (PST)
MIME-Version: 1.0
References: <878szzla6t.wl-ysato@users.sourceforge.jp>
In-Reply-To: <878szzla6t.wl-ysato@users.sourceforge.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 11:40:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiuzkhzr8SJXvy7NHGS+3XyQk1VUAg2s=-xE_BSqCCoXg@mail.gmail.com>
Message-ID: <CAHk-=wiuzkhzr8SJXvy7NHGS+3XyQk1VUAg2s=-xE_BSqCCoXg@mail.gmail.com>
Subject: Re: [GIT PULL] arch/h8300 update
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 1:34 AM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
>
>   git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git tags/for-4.21

New signing key?

That's ok, but please sign it with your old one unless there's some
major reason you can't (ie "oops, I've lost the old one").

And yes, I see that the new key is nice and much stronger, but it
would still be nice to have the signature chain to your old one.

              Linus
