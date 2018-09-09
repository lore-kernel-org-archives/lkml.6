Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842D4C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 02:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194662086B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 02:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194662086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeIIGuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 02:50:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:57994 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbeIIGuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 02:50:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Sep 2018 19:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,349,1531810800"; 
   d="scan'208";a="87187064"
Received: from allen-box.sh.intel.com (HELO [10.239.161.122]) ([10.239.161.122])
  by fmsmga004.fm.intel.com with ESMTP; 08 Sep 2018 19:02:25 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: No video output on 4.19-rc1 on Dell XPS 13 9360
To:     Dmitrii Tcvetkov <demfloro@demfloro.ru>
References: <20180908165747.16c2843c@fire.localdomain>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <89dff474-7baa-83ce-d70d-fffc4699d3ce@linux.intel.com>
Date:   Sun, 9 Sep 2018 10:01:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180908165747.16c2843c@fire.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The fix has been posted here.

https://lkml.org/lkml/2018/9/8/14

Best regards,
Lu Baolu

On 09/08/2018 09:57 PM, Dmitrii Tcvetkov wrote:
> I've sent the email[1] before to iommu and lkml mailing lists only, but
> according to iommu mailing list archive it wasn't received[2]. I'm
> resending it to Lu Baolu and Joerg Roedel with proper kernel .config
> file. Sorry if the duplication is unnecessary.
> 
> Since 4.19-rc1 my laptop boots with vertical static set of rows of dots
> on the screen instead of proper video output. SSH'ing into it allowed
> to get dmesg-without-pt.log output, PCI device 00:02.0 is VGA
> compatible controller: Intel Corporation HD Graphics 620 (rev 02)
> 
> Appending "iommu=pt" to kernel cmdline allowed to boot with functional
> graphics, but gave dmesg-with-pt.log output.
> 
> Bisect between v4.18 and v4.19-rc1 tags led me to commit
> a7fc93fed94b173e2 (iommu/vt-d: Allocate and free pasid table).
> 
> Reverting this commit allows to build kernel on current master
> (a12ed06ba2d3fa60e), which boots with functional graphical output
> without specifying "iommu=pt".
> Dmesg output is in dmesg-with-revert.log.
> 
> Without the revert current master boots like 4.19-rc1.
> 
> [1] https://lkml.org/lkml/2018/9/7/1081
> [2] https://lists.linuxfoundation.org/pipermail/iommu/2018-September/date.html
> 
