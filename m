Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC6AC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1382082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 11:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D1382082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeJ3UQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:16:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:57538 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbeJ3UQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:16:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 04:23:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="86735215"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga006.jf.intel.com with ESMTP; 30 Oct 2018 04:23:06 -0700
Subject: Re: [PATCH v3] xhci: Add quirk to workaround the errata seen on
 Cavium Thunder-X2 Soc
To:     "Cherian, George" <George.Cherian@cavium.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
References: <1540896507-23876-1-git-send-email-george.cherian@cavium.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <d450f63d-b1ed-afe2-4bde-4d1aa246d079@intel.com>
Date:   Tue, 30 Oct 2018 13:26:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540896507-23876-1-git-send-email-george.cherian@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.10.2018 12:48, Cherian, George wrote:
> Implement workaround for ThunderX2 Errata-129 (documented in
> CN99XX Known Issues" available at Cavium support site).
> As per ThunderX2errata-129, USB 2 device may come up as USB 1
> if a connection to a USB 1 device is followed by another connection to
> a USB 2 device, the link will come up as USB 1 for the USB 2 device.
> 
> Resolution: Reset the PHY after the USB 1 device is disconnected.
> The PHY reset sequence is done using private registers in XHCI register
> space. After the PHY is reset we check for the PLL lock status and retry
> the operation if it fails. From our tests, retrying 4 times is sufficient.
> 
> Add a new quirk flag XHCI_RESET_PLL_ON_DISCONNECT to invoke the workaround
> in handle_xhci_port_status().
> 
> Signed-off-by: George Cherian <george.cherian@cavium.com>

Thanks, adding to queue

-Mathias
