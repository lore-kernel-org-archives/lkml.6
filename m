Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067FCC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44CF2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTABAfeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44CF2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJZCSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:18:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44011 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbeJZCSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:18:49 -0400
Received: by mail-lj1-f195.google.com with SMTP id y22-v6so2412603lji.10;
        Thu, 25 Oct 2018 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BxEszvb4SN2Y3byd2a8tlp8WZ66gjzKkAeOMRyPI3qs=;
        b=YTABAfeRub4E/pbSbbNXwZH1LNHUOHQ8t8jHad6L52C0WXEwrBCYHNG47IuqIJCtLI
         47VsWzjQxgyarzqpmU+c2InJ5Vj4DXuxAk/e70oFvicNASzteNXouTLi3WdocS9LBOpH
         7hHcOtfTLenFox0TIzHQYlFk5zsPq3Ak7Hyj7SGyUtpgVXeYaYDoc5ZD1KgokS8SyVbY
         JjOAscfBpz88pg0EtwLetbymfDFyGBng/MdFD9R6BCRPkmMlIq15kRDrjnISJw9g/WQA
         zBuyoGWpfxJNErDmWUOeIBkyFeuNsZ51qTaA198pdGBTcF39MFavrPjAQicLLma6MPAL
         QPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BxEszvb4SN2Y3byd2a8tlp8WZ66gjzKkAeOMRyPI3qs=;
        b=YAAdsQUuLUyPGGjpmdMUGGb1bfFUC13mDZDvUWrZh90eAdSdBMFIT6gVdDJ5tguEc/
         ZZDVchoTytv0TYYkQWI13O/aWuJ/sDBdNaSoihz2vZwg0LcWWcH2wIl7PyaGYmIwgUXt
         4GPuxfYrRBaxfOoOyV26CndT8OHjQ19s3bmNlrInhVPzhaPF0Gl3Me/EFMYF9IjBunya
         uG2Adzxv0Xoj4vacH4M2iQg5b9D8nlp/J8t/kBqllxqbAao1E5cWMl6PdroDlHLCIPwt
         6k8JAube1XbUx7oksZkOYIcY0EmRnk6DzWp9JZdYrUjDnK2ra8vnc3XJzK9xmkpwBXzd
         W25w==
X-Gm-Message-State: AGRZ1gIc3d66KyHl7LzeXxlbWab9oGXuZbmdwwci1Z75W/uY3oa/yr9g
        EKQ+JIoEAc2+GLgWc8YV0gA=
X-Google-Smtp-Source: AJdET5cpS+vb4QuwZldPTlMSEuOo76tpaPRz2XrLWs7zPNnDNS8hQdwI9H2L4BOlRemUjt4QV15CxQ==
X-Received: by 2002:a2e:20f:: with SMTP id 15-v6mr105799ljc.141.1540489501674;
        Thu, 25 Oct 2018 10:45:01 -0700 (PDT)
Received: from [192.168.1.18] (dnt139.neoplus.adsl.tpnet.pl. [83.24.101.139])
        by smtp.gmail.com with ESMTPSA id s129-v6sm905601lja.87.2018.10.25.10.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 10:45:00 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] leds: upboard: Add LED support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan O'Donovan <dan@emutex.com>,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Javier Arteaga <javier@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
 <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-3-git-send-email-dan@emutex.com>
 <ede59ef8-7caf-413d-6858-33a1eab5f084@gmail.com> <20181023185453.GA27397@amd>
 <226e0df2-83f9-bee5-f359-a3e040d12311@gmail.com> <20181023193014.GA32003@amd>
 <00720f10-a525-32d1-0aa5-00fc88251f5e@gmail.com>
 <20181025092221.GW10650@smile.fi.intel.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <041272ab-b994-39e7-5773-fdea039f4a69@gmail.com>
Date:   Thu, 25 Oct 2018 19:44:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025092221.GW10650@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2018 11:22 AM, Andy Shevchenko wrote:
> On Wed, Oct 24, 2018 at 10:07:30PM +0200, Jacek Anaszewski wrote:
> 
>> Yet, there are many out of LED subsystem files to update:
>>
>> find -name "*.c" -o -name "*.h" | xargs grep  "enum led_brightness" |
>> awk -F: '{print $1}' | sort -u | grep -v "leds" | wc -l
>>
>> returns 87.
> 
> Side note: 
> 
> git grep -n 'enum led_brightness' | ...
> 
> a bit more effitient.

Right, thanks for the hint.

-- 
Best regards,
Jacek Anaszewski
