Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEAEC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7454321A34
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7454321A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbeHFQE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 12:04:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:31078 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbeHFQE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 12:04:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 06:55:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,452,1526367600"; 
   d="scan'208";a="246520891"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga005.jf.intel.com with ESMTP; 06 Aug 2018 06:55:41 -0700
Subject: Re: [PATCH v3] usb: host: xhci-plat: Iterate over parent nodes for
 finding quirks
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     v.anuragkumar@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1533560671-32640-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <532f004d-8a79-e61b-e668-958c162599aa@linux.intel.com>
Date:   Mon, 6 Aug 2018 16:58:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1533560671-32640-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.08.2018 16:04, Anurag Kumar Vulisha wrote:
> In xhci_plat_probe() both sysdev and pdev->dev are being used
> for finding quirks. There are some drivers(like dwc3 host.c)
> which adds quirks(like usb3-lpm-capable) into pdev and the logic
> present in xhci_plat_probe() checks for quirks in either sysdev
> or pdev for finding the quirks. Because of this logic, some of
> the quirks are getting missed(usb3-lpm-capable quirk added by dwc3
> host.c driver is getting missed).This patch fixes this by iterating
> over all the available parents for finding the quirks. In this way
> all the quirks which are present in child or parent are correctly
> updated.
> 
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> ---
>   Changes in v3:
> 	1. As Mathias suggested, moved the position of reading devicetree
> 	   property "imod-interval-ns" into for loop
> 
>   Changes in v2:
> 	1. As suggested by Mathias, restoring immod_interval changes to
> 	   default
> ---

Thanks, adding to queue

-Mathias
