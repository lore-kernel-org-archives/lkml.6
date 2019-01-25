Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3967AC282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134CA218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 20:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbfAYUbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 15:31:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:50533 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfAYUbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 15:31:03 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jan 2019 12:31:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,523,1539673200"; 
   d="scan'208";a="133144004"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2019 12:30:59 -0800
Received: from andy by smile with local (Exim 4.92-RC4)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1gn87u-0004L3-Bj; Fri, 25 Jan 2019 22:30:58 +0200
Date:   Fri, 25 Jan 2019 22:30:58 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mogens Jensen <mogens-jensen@protonmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dean Wallace <duffydack73@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
Message-ID: <20190125203058.GT9224@smile.fi.intel.com>
References: <3e12e051-b874-187d-d4f5-e146f59c659b@redhat.com>
 <U9ny3qDg8fEQ-IaXWgwAmDf_U7yb1NZxpwoOvTorCbG86v8wUae3kWsa5omAv-ngu3VMaSONp6RdzmaI26Cz6uoyf5ddIiXuJQbzGf2MN3w=@protonmail.com>
 <20190117091214.7djttnpo4jjzi4su@spock>
 <c935552f-951f-ab9f-b41c-76c729c6d85c@redhat.com>
 <pozwYTgSVvWumpTgwwf_C-qvYFNnl7yl9gcq9M-LOUXQTvkSX5f8E_2d-HYNYV_ruL8kAURaIR3ItM_UmFJeV-e28eYy8b2MomlwHMbb-5U=@protonmail.com>
 <983fb777-df22-1b53-acea-8bbcab23b260@redhat.com>
 <G5Oa_GRw3iClWMtIg1FeCwj1szJHRH6ToqQqCskS_HKzyNhpFFQ3sJndttzyvP3IHRJuHXvDsUC82dnw8r66OIroHCzyqTYbZoki5sSKPUE=@protonmail.com>
 <43070180-1f10-9285-7564-cfa24e1d222e@linux.intel.com>
 <3ERhUwlxf4lWV_mn3MgjNMrm8ZDgFevrwjq0KRjy05oM1hGiQUdsPpbIlKytNGHi1ViQ_2Xv7bxzqusfruSjbZJyUSpQ9Uo8HCiNyUdyNdU=@protonmail.com>
 <1305936b-908d-e256-cc2a-667b6e5e0851@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1305936b-908d-e256-cc2a-667b6e5e0851@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 11:57:57AM -0600, Pierre-Louis Bossart wrote:
> 
> > > > The only minor annoyance I'm experiencing now, is a large amount of debug output from something in kernel log when audio is played on the system:
> > > > writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 00 ............U...
> > > > writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 00 ............u...
> > > > ...
> > > That's enabled via dynamic debug so that's rather a configuration issue
> > > than a kernel problem?
> > Do you have any suggestions on how to disable it?
> > 
> > My kernel is compiled without DYNAMIC_DEBUG, DEBUG_FS and other debug features, so I don't understand why all this debug output is flooding the kernel log.
> > 
> > It's a minor issue, but it would be nice to get rid of it.
> I can confirm that this happens without DYNAMIC_DEBUG, and somehow changing
> the log level doesn't seem to matter. I tried changing the console log as a
> kernel parameter or with playing /proc/sys/kernel/printk, no luck. weird.

Are you sure you did a clean build?

The logic behind print_hex_dump_bytes() is following:
- if !CONFIG_PRINTK — nothing should be printed at all
- otherwise if CONFIG_DYNAMIC_DEBUG — it goes thru its facilities
- else if goes to KERN_DEBUG level and thus loglevel should affect this either
  thru command line or via procfs

If none of the above works like it should, the couple of possibilities I can see:
- unclean build where previously it was compiled somehow with DEBUG
- ignore_loglevel is in the kernel command line

-- 
With Best Regards,
Andy Shevchenko


