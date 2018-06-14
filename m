Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EA315C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D61208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ac499Xns";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nJM+JQSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D61208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755221AbeFNLwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:52:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45498 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752874AbeFNLwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:52:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 61912602FC; Thu, 14 Jun 2018 11:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528977133;
        bh=JgKhEap6KBmONRqmNTsXAwM/BsCcxAaeXu3ZWrNGZYU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=ac499XnsAOfiRtBnnrQfubx8D/uo4IwDNB5d6fLQouaL5IE90CKhD91SaAj18Oeyj
         OarTQ36jEGyn+bF57ulayzZM8okbDzCttXuVQo0spuLgDqb8NbMKzGwGWfm4Zin4OZ
         8xFhUQ/hVYk/Cy/ToA8uvCvNmaoFlobz2/vbvNQw=
Received: from SAYALIL (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CF6960116;
        Thu, 14 Jun 2018 11:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528977127;
        bh=JgKhEap6KBmONRqmNTsXAwM/BsCcxAaeXu3ZWrNGZYU=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=nJM+JQSkNhm+52CZ7vxkRUWghPO+0j4252lWbGu3g4e6hGykB4AlNdCHVBjkKdcM3
         Jt9rWl1igMbW0JmBSSrKeAZmkgo5Qu7rwS7c87Y+AGurdRhuzWY8/JZATDQY+wSu8U
         tp+YCUEcbCdTtP/GXI1I6S4Zga754tWWeH5FfYxw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CF6960116
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
From:   "sayali" <sayalil@codeaurora.org>
To:     "'Greg Kroah-Hartman'" <gregkh@linuxfoundation.org>
Cc:     <subhashj@codeaurora.org>, <cang@codeaurora.org>,
        <vivek.gautam@codeaurora.org>, <rnayak@codeaurora.org>,
        <vinholikatti@gmail.com>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>, <asutoshd@codeaurora.org>,
        <evgreen@chromium.org>, <linux-scsi@vger.kernel.org>,
        "'Stanislav Nijnikov'" <stanislav.nijnikov@wdc.com>,
        "'Adrian Hunter'" <adrian.hunter@intel.com>,
        "'open list'" <linux-kernel@vger.kernel.org>
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org> <1528455990-24572-4-git-send-email-sayalil@codeaurora.org> <20180609072454.GH24148@kroah.com>
In-Reply-To: <20180609072454.GH24148@kroah.com>
Subject: RE: [PATCH V2 3/3] scsi: ufs: Add sysfs support for ufs provision
Date:   Thu, 14 Jun 2018 17:22:01 +0530
Message-ID: <000301d403d6$1ed2e790$5c78b6b0$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH7CPwp+aWAYn25mLDVi5cVOXIbUwJ6HtT/Ai201PSj7Fr+EA==
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org] 
Sent: Saturday, June 09, 2018 12:55 PM
To: Sayali Lokhande <sayalil@codeaurora.org>
Cc: subhashj@codeaurora.org; cang@codeaurora.org;
vivek.gautam@codeaurora.org; rnayak@codeaurora.org; vinholikatti@gmail.com;
jejb@linux.vnet.ibm.com; martin.petersen@oracle.com;
asutoshd@codeaurora.org; evgreen@chromium.org; linux-scsi@vger.kernel.org;
Stanislav Nijnikov <stanislav.nijnikov@wdc.com>; Adrian Hunter
<adrian.hunter@intel.com>; open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 3/3] scsi: ufs: Add sysfs support for ufs provision

On Fri, Jun 08, 2018 at 04:36:30PM +0530, Sayali Lokhande wrote:
> Add sysfs support to trigger ufs provisioning at runtime.
> Usage : echo <desc_buf> > /sys/bus/platform/drivers/*/
> 	config_descriptor/ufs_provision
> To check provisioning status:
> cat /sys/bus/platform/drivers/*/config_descriptor/ufs_provision
> 1- > Success (Reboot device to check updated provisioning)
> 
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  Documentation/ABI/testing/sysfs-driver-ufs |  16 ++++
>  drivers/scsi/ufs/ufs-sysfs.c               |  25 ++++++
>  drivers/scsi/ufs/ufs.h                     |   2 +
>  drivers/scsi/ufs/ufshcd.c                  | 128
+++++++++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.h                  |   5 ++
>  5 files changed, 176 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs 
> b/Documentation/ABI/testing/sysfs-driver-ufs
> index 016724e..43419b5 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -883,3 +883,19 @@ Contact:	Subhash Jadavani <subhashj@codeaurora.org>
>  Description:	This entry shows the target state of an UFS UIC link
>  		for the chosen system power management level.
>  		The file is read only.
> +
> +What:
/sys/bus/platform/drivers/ufshcd/*/config_descriptor/ufs_provision
> +Date:		February 2018
> +Contact:	Sayali Lokhande <sayalil@codeaurora.org>
> +Description:	This file shows the status of runtime ufs provisioning.
> +		This can be used to provision ufs device if bConfigDescrLock
is 0.
> +		Configuration buffer needs to be written in space separated
format
> +		specificied as:
> +		echo <bNumberLU> <bBootEnable> <bDescrAccessEn>
<bInitPowerMode>
> +		<bHighPriorityLUN> <bSecureRemovalType>
<bInitActiveICCLevel>
> +		<wPeriodicRTCUpdate> <bConfigDescrLock> <LUNum> <bLUEnable>
> +		<bBootLunID> <size_in_kb> <bDataReliability>
<bLUWriteProtect>
> +		<bMemoryType> <bLogicalBlockSize> <bProvisioningType>
> +		<wContextCapabilities> > ufs_provision

That's crazy big, please use configfs for this if you really want to
"provision" hardware with a new api.  That is what configfs was created for,
do not abuse sysfs like this, it is not a "single" value.
[Sayali] Sure. I will check and update my next patchset accordingly to use
configfs for provisioning at runtime.

thanks,

greg k-h

