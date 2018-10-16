Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C305C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2BC2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=interia.pl header.i=@interia.pl header.b="N38JF4uA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2BC2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poczta.fm
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeJQB54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:57:56 -0400
Received: from smtpo.poczta.interia.pl ([217.74.65.157]:53671 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeJQB54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:57:56 -0400
X-Interia-R: Interia
X-Interia-R-IP: 188.121.17.172
X-Interia-R-Helo: <x220.localdomain>
Received: from x220.localdomain (unknown [188.121.17.172])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by www.poczta.fm (INTERIA.PL) with ESMTPSA;
        Tue, 16 Oct 2018 20:06:11 +0200 (CEST)
Date:   Tue, 16 Oct 2018 20:06:31 +0200
From:   Slawomir Stepien <sst@poczta.fm>
To:     Gabriel Capella <gabriel@capella.pro>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        apw@canonical.com, joe@perches.com
Subject: Re: [PATCH] staging: iio: adc: Add comments to prevent checks
 corrections
Message-ID: <20181016180631.GA6085@x220.localdomain>
References: <20181015212521.GA24512@mantaray>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181015212521.GA24512@mantaray>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Interia-Antivirus: OK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=interia.pl;
        s=biztos; t=1539713174;
        bh=Yz9hCEz77zW2NMvRbpfktcaJYlCVZ58WLz7TvEIWAiA=;
        h=X-Interia-R:X-Interia-R-IP:X-Interia-R-Helo:Date:From:To:Cc:
         Subject:Message-ID:References:MIME-Version:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         User-Agent:X-Interia-Antivirus;
        b=N38JF4uA1Z9xhFMnn9NZGUMb1oISpdoYYW8ijQAiyv3qYGZ8VRxVqZWe1teZSYyTo
         kbTBgUEcLYicrQ4FDo7ZJiQE0cV17zrxpa9PynPZj5L+x5+mhTUSvxE3gpmc1wY+SS
         DlgTEKW33yAnPnyRJ+QFOpXx0WQP0QhLVxNM+NUw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On paź 15, 2018 18:25, Gabriel Capella wrote:
> This patch adds 3 comments in 2 different files.
> These comments warn to don't correct the checks of type:
> "CHECK: spaces preferred around that '-'"
> 
> Signed-off-by: Gabriel Capella <gabriel@capella.pro>
> ---
>  drivers/staging/iio/adc/ad7192.c  | 1 +
>  drivers/staging/iio/adc/ad7280a.c | 2 ++
>  2 files changed, 3 insertions(+)

I have this simpler solution...let's focus our efforts on moving the two drivers
out of staging. This will prevent the CHK to appear:

Cut from checkpatch.pl:

if ($realfile =~ m@^(?:drivers/net/|net/|drivers/staging/)@) {
	$check = 1;

Existing driver out of staging, with this "problem":
$ ./scripts/checkpatch.pl --types SPACING --file drivers/iio/adc/ad7793.c        
total: 0 errors, 0 warnings, 827 lines checked

drivers/iio/adc/ad7793.c has no obvious style problems and is ready for submission.

NOTE: Used message types: SPACING

In my opinion it would stop this incorrect patches.

I have also this changes to checkpatch.pl:
https://github.com/s-stepien/linux-1/commit/c976a31b392393fb417f2d9e2ec9639bc226ad0b
and usage:
https://github.com/s-stepien/linux-1/commit/1adc0428b496f44f6a931637084bb619ddd9992d
but I'm not that sure it is the best way to go.

What do you all think?

-- 
Slawomir Stepien
