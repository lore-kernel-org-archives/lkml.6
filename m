Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CA1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A44217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVC0zNZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfBKVVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:21:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33031 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfBKVVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:21:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so413293wrw.0;
        Mon, 11 Feb 2019 13:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=27uK8IkgX4QUTPOFdkGcrw5lMHZndoqN9RDS0WLggLQ=;
        b=MVC0zNZhdxfa0DuQlG6U+PbrgTi4tbgfQEqEDnNp2V9TqsqxD+CpG2qGVn90YGQbEs
         C4XcYy675L6b0DP56PzQa7PNHQo46XMhsd4xTu9cffTtVQIVvkdTAqAFEgRBfou7ZcpL
         CVz+Cbh3eL9qyZmYCgWWY9rIu3oD8dHTlhaOpMd2AbIBmoMk8tpfhMvY614A/Vz1Va8W
         ihXY5xY2WWbtl05UOU3HVqZWz7IVAqCxqKb1zfysTlB8hIQ1uFWp1HJbKp+AYgw6lsus
         gvGS/DTymty+P/gejdtCE7F5gprPK+06zDCNwyit1Q1eA55gicjRB9haKo/zNPTkedi+
         GruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=27uK8IkgX4QUTPOFdkGcrw5lMHZndoqN9RDS0WLggLQ=;
        b=JJhQ70xnJDIHxudZyQDqyeZ4peEZgrQhjH9ENuhXORo5LfllliKOUHlx0XQaBoZqoe
         wvGbU8iBkfzaQXeanDTmnWi17XdNeNdCf9l+Jjtygu4HrNaImg7gIlAo1OioK1JwR0JX
         WaSQIrN0Pd548J3stEJMwCa5sjqdsQpSAGi8URE0riYSjQO2cMvQ7ExJlVKJantt8jnu
         OwE5IyB1knT3bwx/s+x+GHQZYo0D3H108aRI7UOO2bvKoN55YEYS53Xgeu0Mq6mupcNv
         n3gHgOvFORFaj2a3HycX8MHV/O1UBPMHsYXfpR5zRlqWn+B1nNfWLLif0tEyLhZIvXKz
         KaNQ==
X-Gm-Message-State: AHQUAub8E2Akkx3QRxd+KWYyZsId+11TH1Gki9B6ZuSTZOUqxSvYmxyl
        iS19b7aVx/ewjblAWVzF9cE=
X-Google-Smtp-Source: AHgI3IbNv5dXft7EE2I686xhbVKIYKgD4f07wv2VMQmdzaNhZCR9GiVU2HXTEBWksbsl3KOAxjrHDw==
X-Received: by 2002:a5d:428b:: with SMTP id k11mr190940wrq.17.1549920058366;
        Mon, 11 Feb 2019 13:20:58 -0800 (PST)
Received: from [192.168.1.18] (dkl6.neoplus.adsl.tpnet.pl. [83.24.15.6])
        by smtp.gmail.com with ESMTPSA id w3sm5297064wrl.22.2019.02.11.13.20.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 13:20:57 -0800 (PST)
Subject: Re: [PATCH 0/2] Intel Cherry Trail Whiskey Cove LEDs support
To:     Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
References: <20190209221213.24052-1-jekhor@gmail.com>
 <20190211115951.GC9224@smile.fi.intel.com> <20190211130554.GA10203@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <21b0b6a3-0b5c-684e-adc4-06fa8bc958f6@gmail.com>
Date:   Mon, 11 Feb 2019 22:20:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211130554.GA10203@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/19 2:05 PM, Pavel Machek wrote:
> On Mon 2019-02-11 13:59:51, Andy Shevchenko wrote:
>> On Sun, Feb 10, 2019 at 01:12:12AM +0300, Yauhen Kharuzhy wrote:
>>> This patch series introduces new driver for controlling LEDs connected
>>> to Intel Cherry Trail Whiskey Cove PMIC (general-purpose LED and charger
>>> status led). Only simple 'always on' and blinking modes are supported
>>> for now, no breathing.
>>>
>>> Driver was tested only with Lenovo Yoga Book notebook, and I don't have
>>> any documentation for the PMIC, so proposals and testing are welcome.
>>>
>>
>> I'm not sure you have a correct Cc list here. LED maintainers are
>> M:      Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> M:      Pavel Machek <pavel@ucw.cz>
>>
>> Also would be nice to cc to Hans de Goede.
> 
> I follow the list. I beileve Jacek does, too.

Right, there is no issue with that.

-- 
Best regards,
Jacek Anaszewski
