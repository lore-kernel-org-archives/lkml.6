Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D751CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF1C2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cdvrhFXi";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YhLMa6yW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF1C2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeIDRro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:47:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44810 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeIDRro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:47:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 04170607BD; Tue,  4 Sep 2018 13:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536067357;
        bh=rl3ojnmiDgwDgIZOKyZkBiUFw+ccXyPfIIwTsb8AVz0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=cdvrhFXiFzR81en8BQIwHbgaaw2uqonoD9zHJIEIadUY3e5kOl+dweGFXhW8BTmyw
         S3Ky4WN6Lr/bbnWBbiSyv3sHMjOu6h+zyWjPzK9piIpFNGdY/fhmWtlE40EF7oyG79
         /YmdQ+L2x5PegborDT0hXn3NjgKFzOGeukkVloxg=
Received: from WUFANW10 (c-71-205-14-210.hsd1.co.comcast.net [71.205.14.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wufan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3F066044E;
        Tue,  4 Sep 2018 13:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536067347;
        bh=rl3ojnmiDgwDgIZOKyZkBiUFw+ccXyPfIIwTsb8AVz0=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=YhLMa6yWmiNra39HCuYsavE4/+NUjGlLT7jtTac9Cz9hHF4k6ChDz18OjG9loRbcV
         Xq3fs+X4eyaI3GGx696Ypt346vwUXVaJnhD92j9qEg2iVmdjzZUAGPUAbjJZj2d8Vc
         CXMgDoRaun73xqyRPhF8wxYXJghxII9w6smkx87U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3F066044E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wufan@codeaurora.org
From:   "wufan" <wufan@codeaurora.org>
To:     "'Borislav Petkov'" <bp@alien8.de>
Cc:     <mchehab@kernel.org>, <james.morse@arm.com>,
        <baicar.tyler@gmail.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <john.garry@huawei.com>,
        <toshi.kani@hpe.com>, <tanxiaofei@huawei.com>,
        <wanghuiqiang@huawei.com>, <shiju.jose@huawei.com>
References: <1536033055-25522-1-git-send-email-wufan@codeaurora.org> <20180904072858.GA32615@zn.tnic>
In-Reply-To: <20180904072858.GA32615@zn.tnic>
Subject: RE: [PATCH v3] EDAC, ghes: use CPER module handles to locate DIMMs
Date:   Tue, 4 Sep 2018 07:22:25 -0600
Message-ID: <003601d44452$531d4060$f957c120$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKPRs6m4luRznbEo0Ny3bXcoujxLAHRqk+vo1uJbaA=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Tuesday, September 4, 2018 1:29 AM
> To: Fan Wu <wufan@codeaurora.org>
> Cc: mchehab@kernel.org; james.morse@arm.com; baicar.tyler@gmail.com;
> linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; john.garry@huawei.com; toshi.kani@hpe.com;
> tanxiaofei@huawei.com; wanghuiqiang@huawei.com;
> shiju.jose@huawei.com
> Subject: Re: [PATCH v3] EDAC, ghes: use CPER module handles to locate
> DIMMs
> 
> On Tue, Sep 04, 2018 at 03:50:55AM +0000, Fan Wu wrote:
> > For platforms whose firmwares provide valid module handles (SMBIOS
> > type 17) in error records, this patch uses the module handles to
> > locate corresponding DIMMs and enables per-DIMM error counter update.
> >
> > Signed-off-by: Fan Wu <wufan@codeaurora.org>
> > Reviewed-by: Tyler Baicar <baicar.tyler@gmail.com>
> > Tested-by: Toshi Kani <toshi.kani@hpe.com>
> 
> Those two tags I did see being given to you ...
> 
> > Reviewed-by: Borislav Petkov <bp@alien8.de>
> > Reviewed-by: James Morse <james.morse@arm.com>
> > Reviewed-by: tanxiaofei <tanxiaofei@huawei.com>
>
> ... but how in the world did you come up with those?

Sorry. Will remove these in v4. 
Thanks,
Fan

 
> Do you understand how Reviewed-by works or do you need to look at
> Documentation/process/submitting-patches.rst, section 13 ?
> 
> --
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

