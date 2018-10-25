Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C5CECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CB7204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CB7204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbeJYQXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 12:23:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:21756 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbeJYQXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 12:23:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 00:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,423,1534834800"; 
   d="scan'208";a="94874232"
Received: from reinig-mobl1.ger.corp.intel.com (HELO [10.252.35.227]) ([10.252.35.227])
  by orsmga003.jf.intel.com with ESMTP; 25 Oct 2018 00:51:36 -0700
Subject: Re: [PATCH] drm: fix call_kern.cocci warnings (fwd)
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <easy2remember.chk@googlemail.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <alpine.DEB.2.21.1810241955110.3776@hadrien>
 <BY1PR12MB05028BA16A21896179679800B4F70@BY1PR12MB0502.namprd12.prod.outlook.com>
 <823eb7cc-ba7e-b816-1821-c73dfd4c70bf@googlemail.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <8c956766-57ba-c6f7-405c-04a41ae926be@linux.intel.com>
Date:   Thu, 25 Oct 2018 09:51:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <823eb7cc-ba7e-b816-1821-c73dfd4c70bf@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 25-10-18 om 08:53 schreef Christian König:
> Am 25.10.18 um 03:28 schrieb Zhou, David(ChunMing):
>> Reviewed-by: Chunming Zhou <david1.zhou@amd.com>
>
> NAK, GFP_ATOMIC should be avoided.
>
> The correct solution is to move the allocation out of the spinlock or drop the lock and reacquire. 
Yeah +1. Especially in a case like this where it's obvious to prevent. :)
