Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C129EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E1420658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dbCO1ck4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E1420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbeH2R6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:58:07 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:43532 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeH2R6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:58:06 -0400
Received: by mail-io0-f196.google.com with SMTP id y10-v6so4556698ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 07:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0KSz7CN8nN7wRGrdCOKlAgDzPXs2O7otTl6j05+gS2U=;
        b=dbCO1ck4I1I1UPDResl9VN9Fx1lHgo/oifSfpJtil+IlbwJdc4RW3+4y4drNI/CsuR
         ezyID5PttqxYfuaETcnuzaPLraqIeFvwyZQG7RDa6MpU6t6lxLqxvE31hUEkaM7TUi4/
         /CtBXwL24RHV9T+XwIt2iPL4As521+rpgkH+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0KSz7CN8nN7wRGrdCOKlAgDzPXs2O7otTl6j05+gS2U=;
        b=k5O3a4YnVihLZuFBVxQBfj2Z8xztrhD0NdWn5Le4OCBMpjHJbngprIGVo44iNB7LHT
         77PMV3ZboTJqRvq0+pshkd2rXtv+gFlKLFqGrx/wJelJDN5BcirT4Tu0d7tcjgGvPE/r
         CDRX15J0l6Ur3R0kfjkL07QaEn1W0SWJ+8kH9SSrF/NnO8fzsnG90V7dF5aMLZKotSx+
         eNinfpCPvlecC1ERlMYx/3PRC+8/qgBdlRP0rD/FiTYMh8JapFqIsXalo7/hgbH/ldXK
         Z95+T51KqhzANq5I42S9cNgoOvj7e12tmBar/Hxk4mxL73OQDSXiLaj3q8LdCBEIlNDH
         I1mg==
X-Gm-Message-State: APzg51CK6HRp3MDHFV6wHQ5UBlMLEYF6qVOQqEr6IUeWvAkvuin4WxrO
        zG5m/KWTbK+igN6IWsAr9aqF0bbBeyQvGqANffEUVA==
X-Google-Smtp-Source: ANB0VdbJLkQPsNrh/RjJkp9rYqLP/27nyWe0ZXOGiuFHRF6iz363C69Kh7rSomSaeJYcXGBRNgfzl16MeTkeX92Kscw=
X-Received: by 2002:a5e:db07:: with SMTP id q7-v6mr5456976iop.81.1535551261134;
 Wed, 29 Aug 2018 07:01:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:c046:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 07:01:00
 -0700 (PDT)
In-Reply-To: <20180829063244.GA32392@infradead.org>
References: <20180828142421.15335-1-semen.protsenko@linaro.org>
 <20180828142421.15335-3-semen.protsenko@linaro.org> <20180829063244.GA32392@infradead.org>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 29 Aug 2018 17:01:00 +0300
Message-ID: <CAKaJLVsPYG8CvOj1NjBuH4GrfobfXvsLeQE6kFEiyRkSZ_Omaw@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi: aic7xxx: Fix build using bare-metal toolchain
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Paul Sokolovsky <paul.sokolovsky@linaro.org>,
        Miklos Szeredi <mszeredi@suse.cz>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 9:32 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Aug 28, 2018 at 05:24:21PM +0300, Sam Protsenko wrote:
>> Bare-metal toolchains don't define __linux__, so aic7xxx build with
>> bare-metal toolchain is broken. Let's check __KERNEL__ definition
>> instead of __linux__ (as this code won't be build for user-space anyway)
>> in order to fix that.
>
> Please just drop the ifdefs entirely.  The codebase used to be partially
> shared with at least FreeBSD, but these days there is no point in
> keeping the compatibility around.

Thanks, Christoph. Will do in v2.
