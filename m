Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD423C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814F42086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814F42086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbeK0Wly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:41:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:31800 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729696AbeK0Wly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:41:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 03:44:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="112262218"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.164]) ([10.237.72.164])
  by orsmga002.jf.intel.com with ESMTP; 27 Nov 2018 03:44:14 -0800
Subject: Re: [PATCH v3] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC
To:     Kai Heng Feng <kai.heng.feng@canonical.com>,
        "Singh, Sandeep" <sandeep.singh@amd.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>
References: <1542990218-30495-1-git-send-email-Sandeep.Singh@amd.com>
 <4B40F321-BE33-4D36-BE1A-59139D9AA711@canonical.com>
From:   Mathias Nyman <mathias.nyman@intel.com>
Message-ID: <d2583bdb-c63c-6d62-6b36-2f21d558bbbb@intel.com>
Date:   Tue, 27 Nov 2018 13:48:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4B40F321-BE33-4D36-BE1A-59139D9AA711@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.11.2018 09:44, Kai Heng Feng wrote:
> 
> 
>> On Nov 24, 2018, at 00:24, Singh, Sandeep <sandeep.singh@amd.com> wrote:
>>
>> From: Sandeep Singh <sandeep.singh@amd.com>
>>
>> Occasionally AMD SNPS 3.0 xHC does not respond to
>> CSS when set, also it does not flag anything on SRE and HCE
>> to point the internal xHC errors on USBSTS register. This stalls
>> the entire system wide suspend and there is no point in stalling
>> just because of xHC CSS is not responding.
>>
>> To work around this problem, if the xHC does not flag
>> anything on SRE and HCE, we can skip the CSS
>> timeout and allow the system to continue the suspend. Once the
>> system resume happens we can internally reset the controller
>> using XHCI_RESET_ON_RESUME quirk
>>
>> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> Signed-off-by: Sandeep Singh <Sandeep.Singh@amd.com>
>> cc: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
> 
> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thanks, applying

-Mathias
