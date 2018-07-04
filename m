Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E9DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4A82407C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 22:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGiaLE8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4A82407C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeGDWV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 18:21:58 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:54530 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbeGDWV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 18:21:56 -0400
Received: by mail-it0-f49.google.com with SMTP id s7-v6so9414944itb.4;
        Wed, 04 Jul 2018 15:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9mwJlkbPCqCr891ErskqDfmSaaPgfBrxu42G9lzUckw=;
        b=uGiaLE8Ou2Lm5OztvRQJZU/e/IBbQTvQPGG9hvLg73So9xg409HdlJinOvs8oGIIZH
         DNsYdDT5k1g6AOMAxfqlWAC8x4j+AWJN1vc+DmS0nYgsJBnZTHs/mYI8HsVjSESyNyoG
         hzDM9datWMrlwxpvlL5ijmTbyG2IQaJToFu06SgRrxjUfY0nKRJja2kiNb5LSk6hTtuA
         YJ9whnZkbgOO+OliiQ0o4h/uVpJeFwMNujt1pdlMixShmcHe/gfJsx9Cy9tilwgxfVMh
         6S/nL8aOS/hR7LgBNLI3y3Xi1scPASf1/FGYlXlUrGVCnPp4sbOq1kgEp2y0+Qd15TMv
         qzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9mwJlkbPCqCr891ErskqDfmSaaPgfBrxu42G9lzUckw=;
        b=G4ob9gx1sM4KiG68y1xkwl/+68bCW/q9HdETkPHrzGFRCz+/QOLO6cuiSQoR51oJJH
         BI+fH9SWw4iEKJjqS9clMP7QBjBWWsk5CFVr8PyAMuzjMY5ZCysGrPlkRbPEh1g8frfW
         zJrGEvWsm0JLEGX69rPr/if0K9YXjumlassn5Zxz38Whm4BN3lHQLCtJSscEoxo+CpT8
         wuEvX+3PtBRinO16KGcVyrjVTwRGtHWJLT/QGfIWjCC20hEpdP8p4ZVfosYuiQCCvw8U
         egcTHx36aGG+IafTyy1qyDs+gOK/Nule5GDc0QKT5FO42ExzoX1rYRM/U7y+3RXbrlQk
         3S5A==
X-Gm-Message-State: APt69E1aMi1xHhqh0IXhOve8Qfvj1Zky3hSGBB3Qb2koTJff4tkeWTT2
        5ZxWcm6DFjNCsPzzRjkxCgSaTs8fyfmftoWtIic=
X-Google-Smtp-Source: AAOMgpe9MREP8FPiCrFqPx2dtaherQWmTAt0jXxPucOgiRTNTKCMp790fSiqkOcx3rWvG8G7FcOiVpIo4x3QzMraY1c=
X-Received: by 2002:a24:130c:: with SMTP id 12-v6mr3153988itz.35.1530742915784;
 Wed, 04 Jul 2018 15:21:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad5:5002:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 15:21:55 -0700 (PDT)
In-Reply-To: <20180705075716.7b4cccf4@canb.auug.org.au>
References: <20180705075544.70f2eacf@canb.auug.org.au> <20180705075716.7b4cccf4@canb.auug.org.au>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Thu, 5 Jul 2018 00:21:55 +0200
Message-ID: <CAHpGcM+qtiOHguReGQohXsEo5kVQAs8i8EREEnf--ZcpKBZK9g@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the gfs2 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-04 23:57 GMT+02:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi all,
>
> On Thu, 5 Jul 2018 07:55:44 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Commits
>>
>>   0627518adcc8 ("GFS2: rgrp free blocks used incorrectly")
>>   b30cbec54def ("gfs2: Don't reject a supposedly full bitmap if we have blocks reserved")
>>
>> are missing a Signed-off-by from their committer.
>>
>> Not updated in the rebase.
>
> Just cc'ing the committer.

Yeah thanks, fixed now.

Andreas
