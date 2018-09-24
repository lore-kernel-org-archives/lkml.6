Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D54C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7C821486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 13:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7C821486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbeIXTPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:15:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:26022 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729176AbeIXTPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:15:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 06:12:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="265227524"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga005.fm.intel.com with ESMTP; 24 Sep 2018 06:06:41 -0700
Subject: Re: [PATCH] xhci: Add check for invalid byte size error when UAS
 devices are connected.
To:     Sandeep Singh <Sandeep.Singh@amd.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com
Cc:     Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <1537536150-11721-1-git-send-email-Sandeep.Singh@amd.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <58201720-ee34-a866-b177-084b9f36c40c@linux.intel.com>
Date:   Mon, 24 Sep 2018 16:09:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1537536150-11721-1-git-send-email-Sandeep.Singh@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.09.2018 16:22, Sandeep Singh wrote:
> From: Sandeep Singh <sandeep.singh@amd.com>
> 
> Observed "TRB completion code (27)" error which corresponds to Stopped -
> Length Invalid error(xhci spec section 4.17.4) while connecting USB to
> SATA bridge.
> 
> Looks like this case was not considered when the following patch[1] was
> committed. Hence adding this new check which can prevent
> the invalid byte size error.
> 
> [1] ade2e3a xhci: handle transfer events without TRB pointer
> 

Thanks, adding to queue.

Just out of curiosity, was the TRB pointer bits all zeroes
in this  Stopped -Length invalid transfer event TRB?

-Mathias

