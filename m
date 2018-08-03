Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE08EC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C5921759
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C5921759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbeHCOV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:21:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:63356 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeHCOV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:21:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 05:25:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,438,1526367600"; 
   d="scan'208";a="61818894"
Received: from chanse1-mobl.ger.corp.intel.com (HELO [10.252.51.109]) ([10.252.51.109])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2018 05:24:26 -0700
Subject: Re: [PATCH v1] drm/kms/crtc: Improving the func drm_mode_setcrtc
To:     Satendra Singh Thakur <satendra.t@samsung.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     vineet.j@samsung.com, hemanshu.s@samsung.com, sst2005@gmail.com
References: <66ead941-3c64-45e4-7835-949360e2b01f@linux.intel.com>
 <CGME20180803114404epcas5p1c5aaec7ca27e520b5cba52b0d7f09124@epcas5p1.samsung.com>
 <20180803114404epcas5p1c5aaec7ca27e520b5cba52b0d7f09124~HXSyqLTJ81698916989epcas5p1G@epcas5p1.samsung.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <419670d5-bba9-d5e3-9ad6-f7b3324099c5@linux.intel.com>
Date:   Fri, 3 Aug 2018 14:24:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803114404epcas5p1c5aaec7ca27e520b5cba52b0d7f09124~HXSyqLTJ81698916989epcas5p1G@epcas5p1.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 03-08-18 om 13:43 schreef Satendra Singh Thakur:
> Following changes are done to this func:
> 1. The declaration of plane and it's assignment plane = crtc->primary
> are only used when mode_valid is set. Therefore, moved it inside
> the if(mode_valid) statement.
>
> 2. The declaration of connector and set_connectors_ptr and out_id
> are moved inside the for loop, as their scope is limited within
> that block.
>
> 3. Currently, there are 3 checks on count_connectors
> and 4 checks on mode related params (mode_valid, mode, fb).
> if (crtc_req->mode_valid) {
> if (crtc_req->count_connectors == 0 && mode) {
> if (crtc_req->count_connectors > 0 && (!mode || !fb)) {
> if (crtc_req->count_connectors > 0) {
>
> In the modified code, there are just 1 check on mode_valid and
> 2 checks  count_connectors.
> Checks on mode and fb are not needed as these variables will
> be non-NULL by the end of if(mode_valid) statement if mode_valid is set.
> If mode_valid is clear, mode and fb will be NULL.
> Therefore, we just check mode_valid and NOT mode or fb.
>
> 4. Moved kfree inside if statement
>
> Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
>
> ---
>  
>  v1: Hi Mr Maarten, Thanks for the comments.
>      I have fixed some of them and done more modifications to the patch.
>      Please review.
Could you read the suggestions on https://patchwork.freedesktop.org/patch/241508/ ?
I'm not saying this code is incorrect, I think that if you want to improve drm then you should tackle something bigger than just function readability. :)

Cheers,
~Maarten
