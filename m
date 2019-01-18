Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7BBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC8E20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfARPdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:33:33 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44918 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbfARPdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:33:33 -0500
Received: by mail-ed1-f54.google.com with SMTP id y56so11391174edd.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 07:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OicbcI/ZJQ0HD5yOUpjGM+ozb9B2AD0E9k5SOUAqi9w=;
        b=Xh7nCdIYD3Q2Zzh1uUZpKr3vT1sVc2HVDPgsFUlu/9m6+JEaPIygtuGVarzkEnXzUw
         Qaa6yAsRqoddZ8Ht2zImN+ETVTg5VF7wgOkgNgsykJAtvkYWcF+qo/SixqQbZjs4OWZv
         1cMRQ+jUFqUgqEdyMzRBkidzuWkvvj29MXY1qtJLodChqVYEhkH41qMKNy3mtQIXR9+O
         LPlC8SfqwZeUDqKhBOcfYewotu9Gfge0iHxf9zAoNKc2pNwZIMJKjYqcg6w2BEec7i/s
         tEXZlzwjfn3lW7b14OINUbkZu9DkMwzyDWBurvLVBkALFCAZlzMGOeNLKhsJWSHan+cx
         wM5Q==
X-Gm-Message-State: AJcUukfsETSY0pMteZ0p7zjH/HqKBHVEk2iSvx9Fw9oP2bQ15/xHDW9q
        0Yy53R/S8RhRUyKqJYWTdIRRgcnGIqM=
X-Google-Smtp-Source: ALg8bN6O0wYAZcrlhPgNxlSbOBKW9fZesC+BUbB3LZJORiaNkXbGCdVMUv8qNRV4n7n8NRImB5oayw==
X-Received: by 2002:a50:c017:: with SMTP id r23mr16703724edb.278.1547825611497;
        Fri, 18 Jan 2019 07:33:31 -0800 (PST)
Received: from dhcp-44-202.space.revspace.nl ([2a01:4f8:1c0c:6c86:46e0:a7ad:5246:f04d])
        by smtp.gmail.com with ESMTPSA id c12sm6925621edi.52.2019.01.18.07.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 07:33:30 -0800 (PST)
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Dean Wallace <duffydack73@gmail.com>
Cc:     Mogens Jensen <mogens-jensen@protonmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e48696f0-aa3e-e20e-d038-9d8dda9cbfce@redhat.com>
 <BaxBOBmUCld7THAnRIDXUpKq8uQ2oJ49EaNlq0mZ11gFjA5JjhbfhVouLZGc1q74PrQC6uGfddKklIP059D_DtQwBqK-sn9rd4xEPhW9E6s=@protonmail.com>
 <d53738e1-4ba5-640e-7ef7-1705ab205061@redhat.com>
 <kAuINEBUUnlS5_uJafGtvryMEJVkDO4pb_yLfClwMcTS1h3sB1gYPcXBvg9X3RINfp5Uch7kLXuhTRX_JtouTYxoS6xNr77_b46e-mugl3k=@protonmail.com>
 <b8849ae1-5a38-e7a1-da14-dc7f9d164825@redhat.com>
 <3iO9ehQbZm_haTV0IuZ0qhsVHR0QLUbTgRJT8ZenGuRsnz2_uBvO93f0bHVYnsApibUT16JsJ0dgphLhUBd-u0t-lDBNsbvvlKWTgq8XOlw=@protonmail.com>
 <3e12e051-b874-187d-d4f5-e146f59c659b@redhat.com>
 <U9ny3qDg8fEQ-IaXWgwAmDf_U7yb1NZxpwoOvTorCbG86v8wUae3kWsa5omAv-ngu3VMaSONp6RdzmaI26Cz6uoyf5ddIiXuJQbzGf2MN3w=@protonmail.com>
 <20190117091214.7djttnpo4jjzi4su@spock>
 <c935552f-951f-ab9f-b41c-76c729c6d85c@redhat.com>
 <20190117131601.qlkdk6tqznyr2s7x@spock>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <44dbe275-a6bb-4a83-35ce-06dc69e063ff@redhat.com>
Date:   Fri, 18 Jan 2019 16:33:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117131601.qlkdk6tqznyr2s7x@spock>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/17/19 2:16 PM, Dean Wallace wrote:
> On 17-01-19, Hans de Goede wrote:
>> Mogens, Dean, can you please try the SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH
>> driver, without reverting any patches, with the attached patch on top and
>> see if that helps?
> 
> Hi Hans.   Just compiled 4.20.3 with your new patch and no other
> patches.  First impressions are, this is now as stable as it has ever
> been in my experiences with this baytrail drama.  A quick run down on my
> tests/findings:-
> 
> No PLL messages on boot, good.
> Played audio using mpd, all fine.  Plugged in headphones, switches,
> stays stable, no messages.
> Unplugged/plugged again few times, no issues.
> Ran pavucontrol, stayed stable, no messages.
> I can still make it lose the lock and turn on the dalek distortion by
> switching profiles in pavucontrol (from stereo output to any other, like
> putput + input) but that has always been the case afaik for this
> machine.  So basically this is now back to working as it was before the
> 4.18.5 'clk' breakage.
> 
> One thing to mention, I don;t normally use UCM files, tho I have in the
> past, which is where I assume my asound.state file has come from, which
> makes my sound work /shrug.  Well I've just tested using the UCM, and
> things are a little less stable regarding plugging/unplugging headset a
> few times.  It loses lock, but, what's different now is after maybe 3-4
> seconds it corrects itself.  Not sure if it matters, but shows things
> are a little more stable with this patch than previously known.

Ok, thank you for testing. Lets wait a bit and then if no problems
show up I will submit the patch upstream.

Regards,

Hans
