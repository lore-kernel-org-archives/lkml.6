Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE82C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C8120843
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C8120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbeGKIgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:36:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:44849 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbeGKIgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:36:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 01:33:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,337,1526367600"; 
   d="scan'208";a="56011731"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga008.jf.intel.com with ESMTP; 11 Jul 2018 01:33:09 -0700
Subject: Re: [PATCH] scsi: switch to scsi-mq by default
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20180704085356.10888-1-jthumshirn@suse.de>
 <yq1d0vupjq2.fsf@oracle.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6cf082e4-6fff-21dd-4df5-a6e9e4f2847c@intel.com>
Date:   Wed, 11 Jul 2018 11:31:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <yq1d0vupjq2.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/18 05:52, Martin K. Petersen wrote:
> 
> Johannes,
> 
>> It has been more than one year since we tried to change the default
>> from legacy to multi queue in SCSI with commit c279bd9e406 ("scsi:
>> default to scsi-mq"). But due to issues with suspend/resume and
>> performance problems it had been reverted again with commit
>> cbe7dfa26eee ("Revert "scsi: default to scsi-mq"").
>>
>> In the meantime there have been a substantial amount of performance
>> improvements and suspend/resume got fixed as well, thus we can
>> re-enable scsi-mq without a significant performance penalty.
> 
> Applied to 4.19/scsi-queue, thanks!
> 

But there is no runtime pm support, is there?  I tried enabling runtime PM
for UFS SCSI devices with scsi-mq and it didn't work, which is a regression.
