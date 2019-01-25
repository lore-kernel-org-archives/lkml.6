Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E600C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC68218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbfAYR6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:58:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:18539 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfAYR57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:57:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 09:57:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,522,1539673200"; 
   d="scan'208";a="119489396"
Received: from jldaniel-mobl1.amr.corp.intel.com (HELO [10.254.181.12]) ([10.254.181.12])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jan 2019 09:57:58 -0800
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Mogens Jensen <mogens-jensen@protonmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Dean Wallace <duffydack73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181025232517.ywnw54qibemosjws@picard>
 <3e12e051-b874-187d-d4f5-e146f59c659b@redhat.com>
 <U9ny3qDg8fEQ-IaXWgwAmDf_U7yb1NZxpwoOvTorCbG86v8wUae3kWsa5omAv-ngu3VMaSONp6RdzmaI26Cz6uoyf5ddIiXuJQbzGf2MN3w=@protonmail.com>
 <20190117091214.7djttnpo4jjzi4su@spock>
 <c935552f-951f-ab9f-b41c-76c729c6d85c@redhat.com>
 <pozwYTgSVvWumpTgwwf_C-qvYFNnl7yl9gcq9M-LOUXQTvkSX5f8E_2d-HYNYV_ruL8kAURaIR3ItM_UmFJeV-e28eYy8b2MomlwHMbb-5U=@protonmail.com>
 <983fb777-df22-1b53-acea-8bbcab23b260@redhat.com>
 <G5Oa_GRw3iClWMtIg1FeCwj1szJHRH6ToqQqCskS_HKzyNhpFFQ3sJndttzyvP3IHRJuHXvDsUC82dnw8r66OIroHCzyqTYbZoki5sSKPUE=@protonmail.com>
 <43070180-1f10-9285-7564-cfa24e1d222e@linux.intel.com>
 <3ERhUwlxf4lWV_mn3MgjNMrm8ZDgFevrwjq0KRjy05oM1hGiQUdsPpbIlKytNGHi1ViQ_2Xv7bxzqusfruSjbZJyUSpQ9Uo8HCiNyUdyNdU=@protonmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <1305936b-908d-e256-cc2a-667b6e5e0851@linux.intel.com>
Date:   Fri, 25 Jan 2019 11:57:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3ERhUwlxf4lWV_mn3MgjNMrm8ZDgFevrwjq0KRjy05oM1hGiQUdsPpbIlKytNGHi1ViQ_2Xv7bxzqusfruSjbZJyUSpQ9Uo8HCiNyUdyNdU=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> The only minor annoyance I'm experiencing now, is a large amount of debug output from something in kernel log when audio is played on the system:
>>> writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 00 ............U...
>>> writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00 ............u...
>>> ...
>> That's enabled via dynamic debug so that's rather a configuration issue
>> than a kernel problem?
> Do you have any suggestions on how to disable it?
>
> My kernel is compiled without DYNAMIC_DEBUG, DEBUG_FS and other debug features, so I don't understand why all this debug output is flooding the kernel log.
>
> It's a minor issue, but it would be nice to get rid of it.
I can confirm that this happens without DYNAMIC_DEBUG, and somehow 
changing the log level doesn't seem to matter. I tried changing the 
console log as a kernel parameter or with playing 
/proc/sys/kernel/printk, no luck. weird.
