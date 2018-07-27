Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAE9C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD6920857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD6920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbeG0Cf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 22:35:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:6157 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731737AbeG0Cf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 22:35:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 18:16:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,407,1526367600"; 
   d="scan'208";a="243690029"
Received: from dengjie-mobl.ccr.corp.intel.com (HELO [10.239.205.75]) ([10.239.205.75])
  by orsmga005.jf.intel.com with ESMTP; 26 Jul 2018 18:16:31 -0700
Cc:     jie.deng@intel.com, "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "Wang, Yu1" <yu1.wang@intel.com>,
        "Liu, Shuo A" <shuo.a.liu@intel.com>,
        "Chen, Conghui" <conghui.chen@intel.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: why vdev->config->reset(vdev) is not called in virtinput_freeze
To:     "Chen, Jian Jun" <jian.jun.chen@intel.com>,
        "kraxel@redhat.com" <kraxel@redhat.com>
References: <EDFBBACC5AACAB41A7E4FE37D03F62254F58C37F@shsmsx102.ccr.corp.intel.com>
From:   Jie Deng <jie.deng@intel.com>
Message-ID: <5c2c5fb8-f85a-a3e3-24b4-2103a8ddaff7@intel.com>
Date:   Fri, 27 Jul 2018 09:16:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <EDFBBACC5AACAB41A7E4FE37D03F62254F58C37F@shsmsx102.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

Do you have any comments ?


On 2018/7/23 16:56, Chen, Jian Jun wrote:
> Hi Gerd Hoffmann,
>
> vdev->config->reset(vdev) is not called before vdev->config->del_vqs(vdev) in virtinput_freeze. 
> Backend driver cannot receive notification about the suspend.
> Is it possible that backend driver tries to write a buffer pointed by a desc which has been freed by frontend driver?
>
> Can you please explain why vdev->config->reset(vdev) is not called in virtinput_freeze?
> Virtio_net/virtio_block/virtio_rng... all have the reset in their pm suspend callback.
>
> Best regards,
> Chen Jian Jun
>

Regards,
Jie
