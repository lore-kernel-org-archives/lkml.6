Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B39C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91E720C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91E720C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbeGLG1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:27:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:3952 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732191AbeGLG1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:27:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 23:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,341,1526367600"; 
   d="scan'208";a="56271324"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by orsmga008.jf.intel.com with ESMTP; 11 Jul 2018 23:19:06 -0700
Subject: Re: [PATCH] scsi: switch to scsi-mq by default
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <20180704085356.10888-1-jthumshirn@suse.de>
 <yq1d0vupjq2.fsf@oracle.com> <6cf082e4-6fff-21dd-4df5-a6e9e4f2847c@intel.com>
 <CACVXFVOSssuveZDN185FUYpjX1i0ma59Cn30XBSJ1dAHDKLnLQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0f4af58b-5684-eba8-961a-b912a60befff@intel.com>
Date:   Thu, 12 Jul 2018 09:17:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVOSssuveZDN185FUYpjX1i0ma59Cn30XBSJ1dAHDKLnLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/18 19:35, Ming Lei wrote:
> On Wed, Jul 11, 2018 at 4:31 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 11/07/18 05:52, Martin K. Petersen wrote:
>>>
>>> Johannes,
>>>
>>>> It has been more than one year since we tried to change the default
>>>> from legacy to multi queue in SCSI with commit c279bd9e406 ("scsi:
>>>> default to scsi-mq"). But due to issues with suspend/resume and
>>>> performance problems it had been reverted again with commit
>>>> cbe7dfa26eee ("Revert "scsi: default to scsi-mq"").
>>>>
>>>> In the meantime there have been a substantial amount of performance
>>>> improvements and suspend/resume got fixed as well, thus we can
>>>> re-enable scsi-mq without a significant performance penalty.
>>>
>>> Applied to 4.19/scsi-queue, thanks!
>>>
>>
>> But there is no runtime pm support, is there?  I tried enabling runtime PM
>> for UFS SCSI devices with scsi-mq and it didn't work, which is a regression.
> 
> I just posted one RFC patchset for supporting runtime PM on scsi_mq, and
> looks it works in my test on usb-storage.
> 
> https://marc.info/?l=linux-block&m=153132657922233&w=2

Cool, please cc me on the next revision of your patch set.
