Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F36EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F413A207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F413A207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbeJWTCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:02:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:40346 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbeJWTCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:02:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 03:40:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,415,1534834800"; 
   d="scan'208";a="273697728"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga005.fm.intel.com with ESMTP; 23 Oct 2018 03:40:02 -0700
Subject: Re: [PATCH v2 2/2] usb: xhci: fix timeout for transition from RExit
 to U0
To:     Aaron Ma <aaron.ma@canonical.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1540230167-12528-1-git-send-email-aaron.ma@canonical.com>
 <1540230167-12528-2-git-send-email-aaron.ma@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <51228131-b860-dd87-a517-61724842b0b1@linux.intel.com>
Date:   Tue, 23 Oct 2018 13:43:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540230167-12528-2-git-send-email-aaron.ma@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.2018 20:42, Aaron Ma wrote:
> This definition is used by msecs_to_jiffies in milliseconds.
> According to the comments, max rexit timeout should be 20ms.
> Align with the comments to properly calculate the delay.
> 
> Verified on Sunrise Point-LP and Cannon Lake.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

Thanks, adding to queue, will send forward after rc1

-Mathias
