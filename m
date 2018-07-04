Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705E4C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE1C242EB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 18:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="hP6WcB/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CE1C242EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752897AbeGDSJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 14:09:39 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53441 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbeGDSJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 14:09:37 -0400
Received: by mail-it0-f68.google.com with SMTP id a195-v6so8785742itd.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0bZqXQM6qFpWkZUl4JBtiwUnTD3G3aq4yiPnmOfiqLg=;
        b=hP6WcB/GxffIcWDYObE2elyC0hJ6itfDLoXtxlhXUdKTUmWYjylC+BmqEw+ZKwt9YF
         9wbYV0UZBiJiGLdXh05w4969btFzDYUOuATk0b1glflrJbC+2EHjrpg7fZabaXHCtkhL
         VC11VjbMsqMIshhTdTTIiulgZYZEp1U2WMpW62WN+158unEdao1JdhreXaHv9estCj8H
         c+vhCzQqpAA+4Gt4bCczsTZFF7tcJKXwYdnHpVh5FYoA5/WT291cgscsfTYtg8cD9T4H
         d+fv0e0PHilia6++DEX548Sg+E5WVwXZKrd/uHBeicwDaEQENRHShtlCszzgWLa110q9
         UzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0bZqXQM6qFpWkZUl4JBtiwUnTD3G3aq4yiPnmOfiqLg=;
        b=e1u4xyl32z1t1C4RfE78po6TnmKIXLFnuxvDYlVLErZAdBHh/vzVjW4wcP0lfltI+t
         oPWqWMeCkjEd54fHgODa4rBhbrJmcY7KsTUQNlYlshDeN0qMPchVRbFB2a9AXps4pwBn
         hBlqZIx1KwetNdZ7FnnpykScJu+xsFi/T6qwtlQNYheA9Sk9FlQjRzI25/w9DPKFKoX8
         Iu2Pbk6fihbIu5DOyNLmBEvtuIFQDHN1hSvfj3gL2MIlmHuCaiAHQenKQCEXxu1PD/Dg
         l8szvZzkkKr/rKizf8ZBJ1kMlcAsWERivE903kKChF+qP/faxwvfhAbrWd1Ee6q411a9
         iz3w==
X-Gm-Message-State: APt69E312g45OngrzjxxHy9Kb9cJakocuzzkDD0mIStOLBWxQKotcXLw
        qtnQDwqLPqJKORn7T1smEn31o6h2Mns=
X-Google-Smtp-Source: AAOMgpetoHw22QOYjCb45KxXiWwlOiDQD4bAtg4eHnmGhpTXJ/xvZwPjLcoWUUVoj1ipUTbdsTk8hg==
X-Received: by 2002:a24:2b56:: with SMTP id h83-v6mr2358217ita.94.1530727776682;
        Wed, 04 Jul 2018 11:09:36 -0700 (PDT)
Received: from [192.168.43.158] ([172.58.139.43])
        by smtp.googlemail.com with ESMTPSA id g68-v6sm1903422iog.62.2018.07.04.11.09.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 11:09:36 -0700 (PDT)
Subject: Re: [PATCH] Fix platform data in leds-pca955x.c
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     clg@kaod.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Andrew Jeffery <andrew@aj.id.au>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <62fb47ea-9296-139b-1eeb-28ddc5826091@landley.net>
 <CAHp75Vc+2rjFcLfuV5ao0eGmz2aF4jRS_YTZQTaRx=45sOSFOw@mail.gmail.com>
 <CAHp75VdEUquwcd3_OxbHAK+gOCnpff_Fd91jkHx87XKkD2xwKQ@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <fda04867-b470-5266-65db-edb90023f8dc@landley.net>
Date:   Wed, 4 Jul 2018 13:09:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdEUquwcd3_OxbHAK+gOCnpff_Fd91jkHx87XKkD2xwKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2018 12:04 PM, Andy Shevchenko wrote:
> On Wed, Jul 4, 2018 at 8:00 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Wed, Jul 4, 2018 at 3:46 AM, Rob Landley <rob@landley.net> wrote:
> 
>> For now, you can switch to unified device properties API (basically
>> un-ifdef pca955x_pdata_of_init() and replacing of_* by device_* or
>> fwnode_* compatible calls) and providing a static table of built-in
>> device properties in the platform code in question.
>> (see include/linux/property.h, for example users of
>> PROPERTY_ENTRY_U*() macros, like arch/arm/mach-pxa/raumfeld.c)
> 
> Taking into consideration that device is enumerated by i2c core, which
> is being aware of device properties (1), better example might be
> drivers/platform/x86/intel_cht_int33fe.c

This file doesn't include the word "LED".

  $ grep -i led drivers/platform/x86/intel_cht_int33fe.c
  $

Examining it... this is an ACPI driver, Intel's Not-Invented-Here proprietary
device tree.

So I should convert an sh7760 board to ACPI? How would this fix the problem
where the driver's probe function expects a structure as input that is locally
defined, instead of the generic structure from linux/leds.h it used to accept?

If we feed the probe function NULL platform data _and_ don't have device tree
enabled, doesn't it error out?

Rob
