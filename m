Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2316BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F037A2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 08:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfBGI1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 03:27:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:2465 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbfBGI1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 03:27:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2019 00:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,342,1544515200"; 
   d="scan'208";a="317026112"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga006.fm.intel.com with ESMTP; 07 Feb 2019 00:27:47 -0800
Subject: Re: [PATCH] xhci: Convert xhci_handshake() to use
 readl_poll_timeout()
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-usb@vger.kernel.org
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20190207000308.7051-1-andrew.smirnov@gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <63866354-48b8-5787-39de-5c23e7471f6f@linux.intel.com>
Date:   Thu, 7 Feb 2019 10:32:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190207000308.7051-1-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.02.2019 02:03, Andrey Smirnov wrote:
> Xhci_handshake() implements the algorithm already captured by
> readl_poll_timeout(). Convert the former to use the latter to avoid
> repetition.

readl_poll_timeout() doesn't really work here as it might sleep.

iopoll.h:

/**
  * readx_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
  *
...                                                                                                              
  * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
  * case, the last read value at @addr is stored in @val. Must not
  * be called from atomic context if sleep_us or timeout_us are used.
  
-Mathias
