Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B599C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2534D25566
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2534D25566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeFYIXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:23:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:40991 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751930AbeFYIXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:23:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 01:23:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,269,1526367600"; 
   d="scan'208";a="235333664"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga005.jf.intel.com with ESMTP; 25 Jun 2018 01:23:16 -0700
Subject: Re: [PATCH] usb: xhci: dbc: Don't decrement runtime PM counter if DBC
 is not started
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        mathias.nyman@intel.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180625052004.15298-1-kai.heng.feng@canonical.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <59b5789b-a33d-6a61-af53-dc6feba8951f@linux.intel.com>
Date:   Mon, 25 Jun 2018 11:25:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180625052004.15298-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.2018 08:20, Kai-Heng Feng wrote:
> pm_runtime_put_sync() gets called everytime in xhci_dbc_stop().
> 
> If dbc is not started, this makes the runtime PM counter incorrectly
> becomes 0, and calls autosuspend function. Then we'll keep seeing this:
> [54664.762220] xhci_hcd 0000:00:14.0: Root hub is not suspended
> 
> So only calls pm_runtime_put_sync() when dbc was started.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thanks, nice catch.
Adding to queue

-Mathias

