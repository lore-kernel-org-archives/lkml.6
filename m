Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9DFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834C520700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfBUOwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:52:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:47552 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbfBUOwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:52:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 06:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,395,1544515200"; 
   d="scan'208";a="128222854"
Received: from um.fi.intel.com (HELO localhost) ([10.237.72.178])
  by orsmga003.jf.intel.com with ESMTP; 21 Feb 2019 06:52:49 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 7/7] stm class: Prevent division by zero
In-Reply-To: <20190221144231.GC9283@kroah.com>
References: <20190221134959.15121-1-alexander.shishkin@linux.intel.com> <20190221134959.15121-8-alexander.shishkin@linux.intel.com> <20190221144231.GC9283@kroah.com>
Date:   Thu, 21 Feb 2019 16:52:48 +0200
Message-ID: <87o975chxb.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Thu, Feb 21, 2019 at 03:49:59PM +0200, Alexander Shishkin wrote:
>> Using STP_POLICY_ID_SET ioctl command with dummy_stm device, or any STM
>> device that supplies zero mmio channel size, will trigger a division by
>> zero bug in the kernel.
>> 
>> Prevent this by disallowing channel widths other than 1 for such devices.
>> 
>> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>
> Fixes: tag?
>
> stable?

Right, let me respin the whole set.

Thanks,
--
Alex
