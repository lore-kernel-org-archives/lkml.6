Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2497AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC91720652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC91720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeJWTCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:02:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:33923 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbeJWTCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:02:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 03:39:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,415,1534834800"; 
   d="scan'208";a="273697488"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga005.fm.intel.com with ESMTP; 23 Oct 2018 03:39:08 -0700
Subject: Re: [PATCH v2 1/2] usb: xhci: fix uninitialized completion when USB3
 port got wrong status
To:     Aaron Ma <aaron.ma@canonical.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1540230167-12528-1-git-send-email-aaron.ma@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <f0bc503c-f128-d427-37ce-8b609319dc13@linux.intel.com>
Date:   Tue, 23 Oct 2018 13:42:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540230167-12528-1-git-send-email-aaron.ma@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.2018 20:42, Aaron Ma wrote:
> Realtek USB3.0 Card Reader [0bda:0328] reports wrong port status on
> Cannon lake PCH USB3.1 xHCI [8086:a36d] after resume from S3,
> after clear port reset it works fine.
> 
> Since this device is registered on USB3 roothub at boot,
> when port status reports not superspeed, xhci_get_port_status will call
> an uninitialized completion in bus_state[0].
> Kernel will hang because of NULL pointer.
> 
> Restrict the USB2 resume status check in USB2 roothub to fix hang issue.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

Thanks, adding to queue, will send forward after rc1

-Mathias
