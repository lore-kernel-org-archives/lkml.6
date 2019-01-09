Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57811C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B20E21741
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 06:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hba7yK8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfAIGUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:20:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41217 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfAIGUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 01:20:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id k15-v6so5456062ljc.8;
        Tue, 08 Jan 2019 22:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=unhJqH5dkl5zwyjOSBpErYG4HvgIPNC57FRiJi4Fosw=;
        b=hba7yK8aJGWTFB74wgdRFgefPiaiqYvDkftZTCutJCN9whuxJZUw0l0hpve/nqdCYT
         E595b/pGW8M76A2e0TtxC67STTIQlcLZV+EF7t0RFE7Kks886XI1CcjsVA3POQ0cTOud
         YU0aONb/rxXCmdZCXiJnRu5ELCr7Tp+1vuCGFZWhp4zf4DryALtQeiDuEbuqoLGeSdAp
         AoBgMrTGQdsw/pFc2A1ux4LsWbG21uVxgnsW2nSLKzkONWw1QsdoiwpEIM5ujHNX+D8P
         uRRX2hZm0xezVUCNSdbqkSbEyBIPh6hIU0ziL7sysDbYjeu3zOSNEQGvCQ5fLkGIRUGh
         aSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=unhJqH5dkl5zwyjOSBpErYG4HvgIPNC57FRiJi4Fosw=;
        b=d/FLA+l9JdtnxSBEc3RPhcdkYTTHH4Qd4rCtlE/ajue9V4n56uqToLlR3WM/Joj5Bx
         7OdVu+umzVUrBdryTtYyGrTqasOwwh6wBhtFy5kJYtx9pexUfEXrDkMz2Avoa8e3wnem
         sJbYkKHDUu1CvILixAAvhDkCYFisK0yE780Fv+jQtob3g5p0W2OFsnDFZIwrYbPaaqY5
         th9psDeVlMIvqHyjASFGvwIlpJ8R1bCe+vzJZgXpVFfq0HcikjcZ1F4DxMoPHrCashC4
         GTn1U5zNt7aR8jPmXeTsv/6pcP+otMXz36HBXPgzP5d+VQDYuoQu13TtamBZZ8TIB3yk
         0vPw==
X-Gm-Message-State: AJcUukcFUiE7mL6NBcaMp9WmBj/f+c4o2x4kT0oMg11k1ldoxUbouzMt
        h0dBVjPqKm+dzQ4+lyY5TTy9NWhojlU=
X-Google-Smtp-Source: ALg8bN6SbEVdOIAIYIBWNSuURhtNSh3QOnL8oYOkncJRbS5Vu3YUBHN7taiDZRM9GpBW+gDmQEjc+A==
X-Received: by 2002:a2e:3218:: with SMTP id y24-v6mr2849213ljy.157.1547014807720;
        Tue, 08 Jan 2019 22:20:07 -0800 (PST)
Received: from ?IPv6:2001:14ba:8017:3300:884:4687:bd95:28f1? (dtynxhyyktvdkssp1gd4t-3.rev.dnainternet.fi. [2001:14ba:8017:3300:884:4687:bd95:28f1])
        by smtp.googlemail.com with ESMTPSA id r7-v6sm14645354ljc.10.2019.01.08.22.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 22:20:06 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <8740cfd6-a6b5-ad27-313b-984a9febf18a@ti.com>
 <20181219201047.GA23448@amd> <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
 <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com> <20190104201256.GA2931@amd>
 <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com>
 <90a2ed79-b437-af14-4538-430d8723cc6b@gmail.com>
 <d73aa021-509d-ad34-5871-76560e868d03@ti.com>
From:   =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>
Message-ID: <34e8b474-0a3e-f51b-aa8a-5b892102044d@gmail.com>
Date:   Wed, 9 Jan 2019 08:20:04 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <d73aa021-509d-ad34-5871-76560e868d03@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 07/01/2019 21.34, Dan Murphy wrote:
> Vesa
> 
> On 1/4/19 6:39 PM, Vesa Jääskeläinen wrote:
>> Hi Jacek,
>>
>> On 04/01/2019 23.37, Jacek Anaszewski wrote:
>>> But, aside from that hypothetic issue, we need a solution for
>>> LEDn_BRIGHTNESS feature of lp5024, i.e. setting color intensity
>>> via a single register write. How would you propose to address that?
>>
>> You could model it to something like this in device tree:
>>
>> led-module @ <i2c-address> {
>>      compatible = "lp5024";
>>
>>      // There is in hardware setup to use either linear or
>>      // logarithmic scaling:
>>      //enable-logarithmic-brightness;
>>
>>      led0 {
>>          // this will create led instance for LED0 in lp5024
>>          label = "lp-led0";
>>         
>>          // This specifies LED number within lp5024
>>          led-index = <0>;   // set output-base as 0*3 == 0
>>         
>>          element-red {
>>              // refers to OUT0
>>              output-offset = <0>;
>>          };
>>         
>>          element-green {
>>              // refers to OUT1
>>              output-offset = <1>;
>>          };
>>         
>>          element-blue {
>>              // refers to OUT2
>>              output-offset = <2>;
>>          };
>>         
>>      };
>>
>>      led1 {
>>          // this will create led instance for LED1 in lp5024
>>          label = "lp-led1";
>>         
>>          // This specifies LED number within lp5024
>>          led-index = <1>;   // set output-base as 1*3 == 3
>>
> 
> Can we not use led-sources like I have done already?

It was just for illustration of the idea. Names can be agreed. I have 
nothing against led-sources name. I was just looking at datasheet to try 
to undestand what it did and then tried to figure out if it could be 
mapped the idea I have been playing with.

> I really like to keep the DT nodes simple and re-use nodes that exist if possible.

I'll reply to Jacek's email about more clarifications of the idea.

Thanks,
Vesa Jääskeläinen

> My code already maps and groups the outputs into the associated banks


