Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BCAC9C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E2E208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Yr9HF717";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OcYuMJqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E2E208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755192AbeFNLdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:33:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55104 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754790AbeFNLdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:33:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id ED2AB602FC; Thu, 14 Jun 2018 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528976015;
        bh=JjHKFaiD/4rKBd5bdAvZaZ2JxRWWnwsY6ur6dZVjIoA=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=Yr9HF717t8kGIPxCHobuK+rrNHDKC4gmVYvAOWDsh2WfbW6Zc/0BNVdRG64c/0pJd
         EJ+LTfYNpl3nvnDRmUGukE5mPUGHDoPKii4g37FVdUonuOsiE2OW676nvr8jVbvtNE
         Vg35YQLWU40kUYwIgFvOjRTaR4onmAtld42ERIlo=
Received: from SAYALIL (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6CBD1602B8;
        Thu, 14 Jun 2018 11:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528976014;
        bh=JjHKFaiD/4rKBd5bdAvZaZ2JxRWWnwsY6ur6dZVjIoA=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=OcYuMJqCF2En+9V/oQnyd+0JFNEBacaE5o++sqPSYDwDfpUGisrV1IAuvkATwfYMu
         BnXN8drhxI39fphfzXPzllsQ+9WsPQBLLkJ69U7Qo5Q3GPZGm36IoL4JCXGZEyu9oB
         fbAWYb0l2zUlZ18QQJtobSjellH6RoAvbpRzw48k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6CBD1602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   "sayali" <sayalil@codeaurora.org>
To:     "'Rob Herring'" <robh@kernel.org>
Cc:     <subhashj@codeaurora.org>, <cang@codeaurora.org>,
        <vivek.gautam@codeaurora.org>, <rnayak@codeaurora.org>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <asutoshd@codeaurora.org>,
        <evgreen@chromium.org>, <linux-scsi@vger.kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Mathieu Malaterre'" <malat@debian.org>,
        "'open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS'" 
        <devicetree@vger.kernel.org>,
        "'open list'" <linux-kernel@vger.kernel.org>
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org> <1528455990-24572-2-git-send-email-sayalil@codeaurora.org> <20180612192636.GA31725@rob-hp-laptop>
In-Reply-To: <20180612192636.GA31725@rob-hp-laptop>
Subject: RE: [PATCH V2 1/3] scsi: ufs: set the device reference clock setting
Date:   Thu, 14 Jun 2018 17:03:27 +0530
Message-ID: <000101d403d3$87210d20$95632760$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH7CPwp+aWAYn25mLDVi5cVOXIbUwKfFWNnAa5me4Wj7yVwAA==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment inline.

Thanks,
Sayali
-----Original Message-----
From: Rob Herring [mailto:robh@kernel.org] 
Sent: Wednesday, June 13, 2018 12:57 AM
To: Sayali Lokhande <sayalil@codeaurora.org>
Cc: subhashj@codeaurora.org; cang@codeaurora.org;
vivek.gautam@codeaurora.org; rnayak@codeaurora.org; vinholikatti@gmail.com;
jejb@linux.vnet.ibm.com; martin.petersen@oracle.com;
asutoshd@codeaurora.org; evgreen@chromium.org; linux-scsi@vger.kernel.org;
Mark Rutland <mark.rutland@arm.com>; Mathieu Malaterre <malat@debian.org>;
open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
<devicetree@vger.kernel.org>; open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock
setting

On Fri, Jun 08, 2018 at 04:36:28PM +0530, Sayali Lokhande wrote:
> From: Subhash Jadavani <subhashj@codeaurora.org>
> 
> UFS host supplies the reference clock to UFS device and UFS device 
> specification allows host to provide one of the 4 frequencies (19.2 
> MHz,
> 26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the 
> device reference clock frequency setting in the device based on what 
> frequency it is supplying to UFS device.
> 
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  7 +++
>  drivers/scsi/ufs/ufs.h                             |  9 ++++
>  drivers/scsi/ufs/ufshcd-pltfrm.c                   | 24 ++++++++++
>  drivers/scsi/ufs/ufshcd.c                          | 52
++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.h                          |  1 +
>  5 files changed, 93 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt 
> b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index c39dfef..4522434 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -41,6 +41,12 @@ Optional properties:
>  -lanes-per-direction	: number of lanes available per direction - either 1
or 2.
>  			  Note that it is assume same number of lanes is
used both
>  			  directions at once. If not specified, default is 2
lanes per direction.
> +- dev-ref-clk-freq	: Specify the device reference clock frequency, must
be one of the following:
> +			  0: 19.2 MHz
> +			  1: 26 MHz
> +			  2: 38.4 MHz
> +			  3: 52 MHz
> +			  Defaults to 26 MHz if not specified.

I must have misunderstood your last response. I thought you could handle
things without DT. If not, my question remains.
[Sayali]: Ref clk frequency setting could vary from
platfrom-to-platform(vendor specific). Hence we need to pass it via DT.
	Currently in DT we do not set/mention any ref clk frequency
parameter. Hence I have added one new DT entry to configure
	required ref clk freq.

Rob

