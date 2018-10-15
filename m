Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDF3C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F24720881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F24720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeJOTwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:52:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:6228 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbeJOTwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:52:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2018 05:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,384,1534834800"; 
   d="scan'208";a="272520527"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by fmsmga006.fm.intel.com with ESMTP; 15 Oct 2018 05:07:52 -0700
Subject: Re: Can we just remove the sw_lpm_support from current xhci driver?
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <678F3D1BB717D949B966B68EAEB446ED1F18C855@dggemm526-mbx.china.huawei.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <155e2a10-d324-6bc6-b3fc-b23d15a3af25@intel.com>
Date:   Mon, 15 Oct 2018 15:11:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED1F18C855@dggemm526-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.10.2018 12:35, Zengtao (B) wrote:
> Hi:
> 
> I am recently reading the LPM related code in xhci driver, and I find
> that the xhci->sw_lpm_support is not really used, but I am not sure
>   whether we should remove it or not?
> 
> Any ideas, Thanks.

I think it was used to prevent LPM in pre-0.96 xHC controllers.
Now driver only supports HW LPM for 1.0 and later controllers, so xhci->sw_lpm_support
doesn't really do anything.

You can send a patch removing it

Thanks
-Mathias
