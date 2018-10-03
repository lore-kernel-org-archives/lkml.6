Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3351CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E941D2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYZeGzNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E941D2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeJCXLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:11:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36222 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCXLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:11:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id b7-v6so1938342pfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pyMX4oZVAb9kWFyfJzSbUGaup+9yQZk3V9tA+AqtpFc=;
        b=FYZeGzNU39a+Fk73U5YqDG81TMGWMi8p9NRZCB8slpFIMBoEMsdztFNVIsvCGVxKFG
         k7U9SK34OV38vL7VgT9uzYUmu+BSX1L3xND5Lq3jsHAlq2+J8aJhkUOeGSBfaUD8qJhz
         8eqO1FOKoXXdocwIrvi+MN87xbw4hw80TzGw3kESYMB8ZsbzPZuz5LnzHRsqsP483S9l
         8fJp6F2BakDE9E1I0xw0mIWSxbHAzHE6JMd59m5QAwHnaFb7Sr+MZlI5TTUl88otS+Hy
         Pcd5GV5gy9ZIRt5M7yr0NVTXImS1nw9whhWiSpqgcHll51CSkOSi3tyBP6kF85i6DTfm
         MD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pyMX4oZVAb9kWFyfJzSbUGaup+9yQZk3V9tA+AqtpFc=;
        b=RaUqLSdYP1VexzqFJHgra/HEW/bD2vALR1cILYn3aW0s+36F/0Bw3TM3hHPMLNxkUK
         jiao1IEJZ0JQo6HDszfcqL1+zhZMqo7i0to7QtCIkxhWMMmrwGjDSfu9Hr6Jvg3wHwie
         biWCGrori+79KBQMTHj4ZqwpuKP76a0wo63xayHm0IRTq4i8kbdOwFV0WKVSVZC420BW
         WwKy7ogd/ivpwHAaVeJ4drR81NEaU7jMADIDFByNSXfP+3Tnp1gWMt2yAN37Iku2A9pM
         IRIn/cCfoNMv7kFqIlx3Us5pMATRsRYqhXWH0s4Q6TUnV88TcVjLbYU6/3KRg4ao6ZnK
         eQeA==
X-Gm-Message-State: ABuFfohK2+VKpNKLxb6KPVX5F1Eb0oseKZwl3Cw7fT5G9YltmjKXZHdO
        DZCPrZJNJTdnxRyX7frgKg8=
X-Google-Smtp-Source: ACcGV62Mfh4Y1rd2qadcVwZLHYUu/w4D06IeGNi49aTL+yYUjZtgiiv0focEXfjVMjlE3ckcUAuqXw==
X-Received: by 2002:a63:d0e:: with SMTP id c14-v6mr2000232pgl.281.1538583726752;
        Wed, 03 Oct 2018 09:22:06 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id i2-v6sm2190055pgq.35.2018.10.03.09.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 09:22:06 -0700 (PDT)
Date:   Wed, 3 Oct 2018 21:51:58 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v5 1/3] staging: mt7621-mmc: Remove #if 0 blocks
Message-ID: <20181003162153.GA19341@nishad>
References: <cover.1538402548.git.nishadkamdar@gmail.com>
 <b0ae4cb302d68d2fb0f6584bd8ecc8043f88845c.1538402548.git.nishadkamdar@gmail.com>
 <20181002221636.GA8586@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002221636.GA8586@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2018 at 03:16:36PM -0700, Greg Kroah-Hartman wrote:
> On Mon, Oct 01, 2018 at 08:13:40PM +0530, Nishad Kamdar wrote:
> > This patch removes #if 0 code blocks and usages of
> > functions defined in the #if 0 blocks.
> > 
> > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > ---
> >  drivers/staging/mt7621-mmc/dbg.c |  21 +--
> >  drivers/staging/mt7621-mmc/dbg.h |  14 --
> >  drivers/staging/mt7621-mmc/sd.c  | 269 -------------------------------
> >  3 files changed, 1 insertion(+), 303 deletions(-)
> 
> This patch did not apply :(

Oh, do you mean it gave conflicts while applying?
I'll check and resubmit it in that case.

Thanks for the review.

regards,
Nishad
