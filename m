Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8CFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC0E2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC0E2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbeKAH1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:27:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:18521 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725755AbeKAH1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:27:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2018 15:27:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,449,1534834800"; 
   d="scan'208";a="87663182"
Received: from marifin-mobl.amr.corp.intel.com (HELO [10.251.11.212]) ([10.251.11.212])
  by orsmga006.jf.intel.com with ESMTP; 31 Oct 2018 15:27:30 -0700
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Dean Wallace <duffydack73@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mogens Jensen <mogens-jensen@protonmail.com>
References: <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
 <20181029190819.2ivlx73n6y6sx4vk@picard>
 <ffc4bcc9-62c3-8940-85d6-d0fd01f3a1b8@linux.intel.com>
 <c8fb730a-c160-41b4-dad0-8ed8594e5687@redhat.com>
 <20181030143836.feo7zcxiestylxoo@picard>
 <2d429c87-24c5-4075-683e-b0d12c3eb1c2@linux.intel.com>
 <d00df762-e4fc-06c5-701e-d5100bfd0e35@redhat.com>
 <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <20181030161534.wk5cf7nxbwhp2far@picard>
 <307c2074-d268-a87a-6040-1240a2091a4d@redhat.com>
 <20181031200709.xrmu6wsdel7dtcjq@picard>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <da025116-580d-e442-d96f-875282306f1b@linux.intel.com>
Date:   Wed, 31 Oct 2018 17:27:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181031200709.xrmu6wsdel7dtcjq@picard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Just thought it worth mentioning, this new patch that fixes sound
> again, seems to have ressurected an old issue with PLL unlock.  I'm
> seeing journal entries after fresh boot ......
>
> ```
> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> picard systemd[462]: Started Sound Service.
> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> picard kernel: max98090_pll_work: 141 callbacks suppressed
> picard kernel: max98090 i2c-193C9890:00: PLL unlocked
> ```
>
> sound is ok, but sometimes plugging in headphones spams journal with
> those PLL messages, and sound turns into "daleks", and I have to
> remove/insert headphones few times or stop/start audio to fix it.
> It's a very old issue, maybe you'd know more about it.

I noticed this error on my Orco device used for tests many moons ago, 
but I could never find out what led to this error case, it wasn't 
deterministic and didn't impact the audio quality. All I could do is 
rate_limit it... If we have an A vs. B situation it'd be really helpful 
to diagnose further.

Is there really a causality between the changes from Hans and this PLL 
unlock error? Are you 100% sure this was not present in the previous 
install you used (4.18.14 as mentioned earlier in the thread)?

Thanks

-Pierre

