Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFC5C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAF520815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfACK0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:26:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:12320 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfACK0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:26:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 02:26:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,434,1539673200"; 
   d="scan'208";a="122992002"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jan 2019 02:26:15 -0800
Message-ID: <5C2DE48D.4090105@intel.com>
Date:   Thu, 03 Jan 2019 18:31:41 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Cornelia Huck <cohuck@redhat.com>
CC:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        mst@redhat.com, borntraeger@de.ibm.com, pbonzini@redhat.com,
        dgilbert@redhat.com, pasic@linux.ibm.com
Subject: Re: [PATCH v1 1/2] virtio-balloon: tweak config_changed implementation
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>        <1546493462-32244-2-git-send-email-wei.w.wang@intel.com> <20190103104018.33eeaa29.cohuck@redhat.com>
In-Reply-To: <20190103104018.33eeaa29.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2019 05:40 PM, Cornelia Huck wrote:
> On Thu,  3 Jan 2019 13:31:01 +0800
> Wei Wang <wei.w.wang@intel.com> wrote:
>
>> virtio-ccw has deadlock issues with reading config registers inside the
> s/config registers/the config space/ ?

Sounds good.

>
>> interrupt context, so we tweak the virtballoon_changed implementation
>> by moving the config read operations into the related workqueue contexts.
> Also credit Christian with a Reported-by:?

Yes, definitely. Sorry for missing that.

Best,
Wei
