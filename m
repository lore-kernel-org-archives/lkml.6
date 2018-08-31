Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D1FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64982083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64982083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeHaLUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:20:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:57905 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbeHaLUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:20:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 00:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,309,1531810800"; 
   d="scan'208";a="87840540"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.98]) ([10.237.72.98])
  by orsmga002.jf.intel.com with ESMTP; 31 Aug 2018 00:14:24 -0700
Subject: Re: [PATCH V12 2/2] scsi: ufs: Add configfs support for UFS
 provisioning
To:     Sayali Lokhande <sayalil@codeaurora.org>, subhashj@codeaurora.org,
        cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, evgreen@chromium.org,
        riteshh@codeaurora.org
Cc:     stummala@codeaurora.org, jlbec@evilplan.org,
        linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <1535626003-4966-1-git-send-email-sayalil@codeaurora.org>
 <1535626003-4966-3-git-send-email-sayalil@codeaurora.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <317ec142-2238-ce9f-adba-d6335b1fab8e@intel.com>
Date:   Fri, 31 Aug 2018 10:12:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535626003-4966-3-git-send-email-sayalil@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/18 13:46, Sayali Lokhande wrote:
> This patch adds configfs support to provision UFS device at
> runtime. This feature can be primarily useful in factory or
> assembly line as some devices may be required to be configured
> multiple times during initial system development phase.
> Configuration Descriptors can be written multiple times until
> bConfigDescrLock attribute is zero.
> 
> Configuration descriptor buffer consists of Device and Unit
> descriptor configurable parameters which are parsed from vendor
> specific provisioning file and then passed via configfs node at
> runtime to provision ufs device.
> CONFIG_CONFIGFS_FS and CONFIG_UFS_PROVISION needs to be enabled
> for using this feature.
> 
> Usage:
> 1) To read current configuration descriptor with index X
>    (where index X can be 0/1/2/3) :
>    cat /config/XXXX.ufshc/ufs_config_desc_X
> 
> 2) To write configuration descriptor with index X :
>    echo <config_desc_buf> > /config/XXXX.ufshc/ufs_config_desc_X
> 
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---

<SNIP>

> +static struct configfs_attribute ufshcd_attr_provision_0 = {

Actually, wasn't the original suggestion to use a binary attribute? i.e.
configfs_bin_attribute

