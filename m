Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9C2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A0C2083D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:51:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A0C2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeH2Ss3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:48:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:1849 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbeH2Ss3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:48:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 07:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="81216389"
Received: from shudy1-mobl.ger.corp.intel.com (HELO [10.252.24.102]) ([10.252.24.102])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2018 07:51:07 -0700
Subject: Re: [PATCH 0/3] lightnvm: pblk: support variable OOB size
To:     =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        mb@lightnvm.io
Cc:     marcin.dziegielewski@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
From:   Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <106d492e-4f09-7af5-d89a-75c204f3da38@intel.com>
Date:   Wed, 29 Aug 2018 16:51:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.08.2018 12:09, Javier González wrote:
> This patchset adds pblk support for variable metadata sizes on the out
> of bound area.
> 
> Igor, Marcin, you sent a patch some time ago implementing a similar
> functionality, but it never got re-posted after review. Can you test
> this and see if it works for your case? I did not implement support for
> outlined metadata for the case where the reported OOB area is 0. It
> should be pretty simple to do that on top of these patches though.
> 

Sure, we will test that and let you know. I was busy last time and due 
to that I never repost it. I will do this on top of your patches, 
hopefully soon.

> Thanks,
> Javier
> 
> Javier González (3):
>    lightnvm: use internal allocation for chunk log page
>    lightnvm: do no update csecs and sos on 1.2
>    lightnvm: pblk: support variable OOB size
> 
>   drivers/lightnvm/pblk-core.c     | 60 ++++++++++++++++++++++++++++++----------
>   drivers/lightnvm/pblk-init.c     | 16 ++++++++++-
>   drivers/lightnvm/pblk-map.c      | 19 +++++++++----
>   drivers/lightnvm/pblk-read.c     | 55 ++++++++++++++++++++++--------------
>   drivers/lightnvm/pblk-recovery.c | 34 ++++++++++++++++-------
>   drivers/lightnvm/pblk.h          | 18 +++++++++---
>   drivers/nvme/host/lightnvm.c     | 26 +++++++++++------
>   7 files changed, 164 insertions(+), 64 deletions(-)
> 
