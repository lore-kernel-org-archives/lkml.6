Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54BCC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF6221757
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF6221757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389408AbeHGQYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:24:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:45928 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388569AbeHGQYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:24:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 07:10:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,455,1526367600"; 
   d="scan'208";a="74441198"
Received: from mylly.fi.intel.com (HELO [10.237.72.64]) ([10.237.72.64])
  by fmsmga002.fm.intel.com with ESMTP; 07 Aug 2018 07:10:09 -0700
Subject: Re: [PATCH v3 0/6] Add support for MSCC Ocelot i2c
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <ce7bc15f-5742-8d1b-4b47-2e8b66d3e5c3@linux.intel.com>
Date:   Tue, 7 Aug 2018 17:10:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 09:54 PM, Alexandre Belloni wrote:
> Hello,
> 
> Because the designware IP was not able to handle the SDA hold time before
> version 1.11a, MSCC has its own implementation. Add support for it and then add
> i2c on ocelot boards.
> 
> I would expect patches 1 to 4 to go through the i2c tree and 5-6 through
> the mips tree once patch 4 has been reviewed by the DT maintainers.
> 
For the patches 1-4/6 that touch i2c-designware:

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

I tested acpi_match_device() conversion to device_get_match_data() 
didn't affect MODEL_CHERRYTRAIL case and quick test that i2c 
communication continue working.
