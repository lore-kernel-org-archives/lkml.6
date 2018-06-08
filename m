Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CCxtNVigGltxZgAAmS7hNA
	; Fri, 08 Jun 2018 15:27:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 3F2BB6089E; Fri,  8 Jun 2018 15:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528471647;
	bh=MzY4n2skDAtNkxQ6D1/W4e3XFg32ruaosLwyENENLYQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=A9EtKlfefISCOECR0NIuJHJkIqN1sV4mp7I0/OgC0A2iNmS+rgpboaQwfLJ/xBHnf
	 aWG0MUJC9tkFD5OMdzbCDwkG3q1folgc/tDeEAQRTbfqJv+YJdWkchmNgvVgiHiq8i
	 EcmPKgeADtNNH9HI39HLwBCdcXUP8MNcYK9EVBAM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AEC4D606FA;
	Fri,  8 Jun 2018 15:27:26 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mB/byTqO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SkO7N15j"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AEC4D606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeFHP1Z (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:27:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37274 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeFHP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:27:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F3608608C1; Fri,  8 Jun 2018 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528471640;
        bh=MzY4n2skDAtNkxQ6D1/W4e3XFg32ruaosLwyENENLYQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mB/byTqOostUiFQOF/JPNGqMtMICP99slZEFGVk7uF/TH/HdSIkXvCPYpCNO0zG95
         Us5FlUvvhoECnb0+G5pX8Cn9buAZR9n8xxh9cngzQxBhNR8K5MgsxMfidraqNa/oEj
         UVfzBb+kWluONUKK0ggXvztj7KQDOaBH/tAKdoxk=
Received: from [192.168.0.106] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6837A60590;
        Fri,  8 Jun 2018 15:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528471639;
        bh=MzY4n2skDAtNkxQ6D1/W4e3XFg32ruaosLwyENENLYQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SkO7N15jC5GyaWziPvZ0kg7Tin9iQAohESZH55xpwMEE2fsbW202volOKBDUeXbbJ
         Zaj+oc7bh5Ix6MyJGiJU0PGC53r/WtG5U4T8Vp+Cb4PSxuZjH/atdjhoAvTb49dMjc
         HamJvaP1IVapVn1jT+QTMnUnbp05drQ2D/AmtYuk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6837A60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH] scsi: ipr: fix build on 32-bit architectures
To: Arnd Bergmann <arnd@arndb.de>, Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Kees Cook <keescook@chromium.org>, Hannes Reinecke <hare@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Wen Xiong <wenxiong@linux.vnet.ibm.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>
References: <20180608144617.2900894-1-arnd@arndb.de>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <04758f3a-0f03-4fe9-6eb8-10ebb2430a98@codeaurora.org>
Date: Fri, 8 Jun 2018 11:27:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608144617.2900894-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Will,

On 6/8/2018 10:46 AM, Arnd Bergmann wrote:
> Replacing writeq() with writeq_relaxed() doesn't work on many architectures,
> as that variant is not available in general:
> 
> net/Makefile:24: CC cannot link executables. Skipping bpfilter.
> drivers/scsi/ipr.c: In function 'ipr_mask_and_clear_interrupts':
> drivers/scsi/ipr.c:767:3: error: implicit declaration of function 'writeq_relaxed'; did you mean 'writew_relaxed'? [-Werror=implicit-function-declaration]
>    writeq_relaxed(~0, ioa_cfg->regs.set_interrupt_mask_reg);
>    ^~~~~~~~~~~~~~
>    writew_relaxed
> 
> The other issue here is that the patch eliminated the wrong barrier.
> As per a long discussion that followed Sinan's original patch submission,
> the conclusion was that drivers should generally assume that the barrier
> implied by writel() is sufficient for ordering DMA, so this reverts his
> change and instead removes the extraneous wmb() before it, which is no
> longer needed on any architecture now.
> 
> Fixes: 0109a4f2e02d ("scsi: ipr: Eliminate duplicate barriers on weakly-ordered archs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This looks good on paper however we need an input from the driver maintainer
because some drivers like Intel NIC are using write barriers in place of
a SMP barrier + write barrier combination as an optimizatin.

Removing the barrier itself can actually break the driver if SMP barrier is
actually needed instead.

So, it is difficult to judge how this barrier has been used without an
expert opinion.

Changing 

wmb() + writel()

to 

wmb() + writel_relaxed()

is safer than dropping the wmb() altogether.

Will Deacon should probably look at why writeq_relaxed is missing on some ARM
arches too.

Drivers shouldn't worry about write derivatives.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
