Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF75DC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A966B2085B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfAYOMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:12:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:15635 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbfAYOMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:12:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 06:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,521,1539673200"; 
   d="scan'208";a="119443924"
Received: from jshavlix-mobl.amr.corp.intel.com (HELO [10.251.5.52]) ([10.251.5.52])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jan 2019 06:12:35 -0800
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
Message-ID: <99a58213-2921-9dc3-d6d4-1469f8019fc4@linux.intel.com>
Date:   Fri, 25 Jan 2019 08:12:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3ERhUwlxf4lWV_mn3MgjNMrm8ZDgFevrwjq0KRjy05oM1hGiQUdsPpbIlKytNGHi1ViQ_2Xv7bxzqusfruSjbZJyUSpQ9Uo8HCiNyUdyNdU=@protonmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/24/19 11:16 PM, Mogens Jensen wrote:
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Tuesday, January 22, 2019 7:27 PM, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
>
>> On 1/20/19 11:55 PM, Mogens Jensen wrote:
>>
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

I don't see it so it's definitively a config issue. I use

make defconfig

scripts/kconfig/merge_config.sh .config base-defconfig sst-defconfig  
hdaudio-codecs-defconfig

with all 3 defconfigs fetched from https://github.com/thesofproject/kconfig

