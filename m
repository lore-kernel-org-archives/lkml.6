Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A0AC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847AB2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfAUN2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:28:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:7347 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbfAUN2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:28:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 05:28:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="313540676"
Received: from epg-ubt28.iil.intel.com (HELO [143.185.152.137]) ([143.185.152.137])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jan 2019 05:28:51 -0800
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Ramon Fried <ramon.fried@linux.intel.com>
Subject: pinctrl: -EAGAIN not supported but documented
Message-ID: <94b9acab-a739-a014-b068-768f40de38ec@linux.intel.com>
Date:   Mon, 21 Jan 2019 15:28:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Stated in Documentation/driver-api/pinctl.rst:

Since some controllers have special logic for handling entire groups of pins
they can exploit the special whole-group pin control function. The
pin_config_group_set() callback is allowed to return the error code -EAGAIN,
for groups it does not want to handle, or if it just wants to do some
group-level handling and then fall through to iterate over all pins, in 
which
case each individual pin will be treated by separate pin_config_set() 
calls as
well.

----

This is not supported, and there's no code for handling it.

Should we add the necessary code or just remove the wrong documentation.

Thanks,

Ramon

