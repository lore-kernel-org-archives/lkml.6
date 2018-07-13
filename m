Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3E0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3173220878
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZlvofoc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3173220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbeGMOo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:44:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36256 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729670AbeGMOo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:44:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id u7-v6so22040395lji.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=s+rIM8TrGMbKoLFB7YRABgTeO55itijQ1jxBxHFnQaU=;
        b=OZlvofocF4G3z+c8Lpdq02Vo8pR3IR9pcjpE459tPH4S90J02HXYiSiT4j+U15aYq+
         PgsX9ImiHJg1zoCvNWHV273zAlbb7GmHqtrE2UCfj6Mpzu3pMq6fkcBke77ni/8imA4+
         z9P5+xarWF3BP3RAhQPPAmXmVniMZqcUxAiaXE6JjyuKIpNqxD9I4T6U0SGddWqtZ0HW
         w5ThEqrw2xDwj28q3z2cVjs656Itec3CIFMHFF9QGCA6c7XS4OYsvw+9+YyVAt2e4o9Z
         f1fWGLoHH/scaLEoO7j6UhkMdr4TzUvnMr+LGQzqStq0y8auw6Gev8FZM65GxLJGVNfL
         A3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=s+rIM8TrGMbKoLFB7YRABgTeO55itijQ1jxBxHFnQaU=;
        b=B4VE2ClytlwKQ3zPGNURNKwoNS9EPI3iosolsbVwAjdx7apkFDlVUiZXrmX+r6gKpr
         DYcwjzpshcdtJVoc3cTeJbF/nshUCzqk3Omg/Dx5xQvJorQQ+hICVgEOSwMCc3Pt6vBW
         mXwAWOmj/EPJGCoJgg6mi1bB6MN7b6Y0+mrW8dPiREmpBgxlI4p1rK+LsUOX6eAbzZwZ
         0eXOhCl0b53rErF7W1ixrZphYGdmGk7uuHTC2vBOSEDHRCPKCegj2h74B4LYY8XSOma6
         1N0vtckiYNnaVRyluGhqo4PIbeTGMUkM3HHEl/hhOWe2eYhQpc9xo+ZmbtGJWXLuqvbT
         eRIQ==
X-Gm-Message-State: AOUpUlGw16kO2ixw1PH7U/qzyhpc2NQaDQ0je66FYMthivDcuhQcGSRV
        X/mdZQsmLXJgg9pj6/mQzIfM/dRVInVdjfyzcAHWZw==
X-Google-Smtp-Source: AAOMgpcHumTmYz/hWB5LrL+TuVMAXjPbPrh5NeircOiR+c9i5+PDxSsk0HPNMtjCjQpWabnCKqvbiAKo7zV/0oWWLNo=
X-Received: by 2002:a2e:118f:: with SMTP id 15-v6mr3424711ljr.38.1531492202313;
 Fri, 13 Jul 2018 07:30:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 07:30:01
 -0700 (PDT)
In-Reply-To: <61251850.EbJPfQiGNC@blindfold>
References: <20180620081311.126158-1-arnd@arndb.de> <61251850.EbJPfQiGNC@blindfold>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 13 Jul 2018 16:30:01 +0200
X-Google-Sender-Auth: 0NFNwww2KUlOkV9rKkU9XFCr_Yg
Message-ID: <CAK8P3a1bfy0xDninx0Er-L-2bbEh5-5ZOE6g2ZAVa-UcLNZMAA@mail.gmail.com>
Subject: Re: [PATCH] ubifs: use timespec64 for inode timestamps
To:     Richard Weinberger <richard@nod.at>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Eric Biggers <ebiggers@google.com>, Jan Kara <jack@suse.cz>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Hyunchul Lee <cheol.lee@lge.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 4:20 PM, Richard Weinberger <richard@nod.at> wrote:
> Am Mittwoch, 20. Juni 2018, 10:12:58 CEST schrieb Arnd Bergmann:
>> Both vfs and the on-disk inode structures can deal with fine-grained
>> timestamps now, so this is the last missing piece to make ubifs
>> y2038-safe on 32-bit architectures.
>
> Acked-by: Richard Weinberger <richard@nod.at>
>
> Shall this patch go through the ubifs tree?

Sorry I missed the question earlier. Yes, it would be nice if you could pick
it up there. I'm resending both patches now for your convenience.

       Arnd
