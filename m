Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A09FC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 13:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4250E2070D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 13:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+NpqmJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfAENQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 08:16:24 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:46717 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfAENQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 08:16:24 -0500
Received: by mail-lj1-f180.google.com with SMTP id v15-v6so34579840ljh.13;
        Sat, 05 Jan 2019 05:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0MJ0iuKCYn0ZvnRPx3DFVYfWs6x1JIAmy6Ml4pmaTq0=;
        b=r+NpqmJKiVYZtRnD6iBw+ht29mz3s7ZtAnTzrLn0dAF5wSbcrC/ciq8YTpiqK2VOjD
         gJV3ON4f0bDP/v79Z2CSDS7vwbPYtFsU+M0THH4iclSHBqytunN+fgzKLHmqopgEdBmu
         N5oJwbJKnEhIOzYYJcEy4bqeSqMqnr75X/f6Ljfpw5CrkNCbWvTw53KwXlW40fqcEzPt
         lAkgc/U+5IKTOJeGwwy44BK46PsKdiHRVGXrH8jJTlaWpnvn7+ang8FDcMUtqjEUjoT2
         c4J4+mtyA9G2ZaNsgYdoww+d7MbxIZ2zd7nGkohrFn9E2F5P/X6Rd8XeB57vDRx/SO4f
         RhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0MJ0iuKCYn0ZvnRPx3DFVYfWs6x1JIAmy6Ml4pmaTq0=;
        b=tEA6gHl4zh445W0wsMIsFrMSU6Jeo83xc3QRZ9nqM9cee2Sdc9/qrDuTNq2DE3QThB
         NpwZ/p4/CDP7CcbitEgHRSFSLEn0VPXIK5YV7Dcb/pgIPvflDVvMU2z4Omp8bMMljYma
         w4Psv2aw90cE/houBeKU15BjFiFbqOGeOPaOi3O1gWkmy2p3l5lSV27n2GGKn6ceaGfo
         6MNt/8UPFfNdncjlLWU0oZwdqObERm6J2GhfIqwmomxS5shnKeLvgH6lEP412JZwefbR
         Cen9O2OnJFoVRa2z1Cj7K63Gyt+F82YlrxbSDgxGKGpo9GXaKSKezmJIkByCQfCryCeJ
         LbXQ==
X-Gm-Message-State: AJcUukc2G6D//FZWlbVODg5egT2l51PB2tmJoJuBT9yYnW5hLPHP0AzF
        wgQdjSvsyMcVvHNucdeWbZAKvd5v
X-Google-Smtp-Source: AFSGD/X+0TWe/MPGSdQlQwbFOJiWoTKSDvsu2OlAZcHAx7JJE3msOEKbaOKObP8zIS6l4j3hoDBJSg==
X-Received: by 2002:a2e:8596:: with SMTP id b22-v6mr31092433lji.122.1546694180926;
        Sat, 05 Jan 2019 05:16:20 -0800 (PST)
Received: from [192.168.1.18] (ciw155.neoplus.adsl.tpnet.pl. [83.31.46.155])
        by smtp.gmail.com with ESMTPSA id h3sm11482325lfj.25.2019.01.05.05.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 05:16:20 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
 <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com> <20190104201256.GA2931@amd>
 <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com> <20190104220726.GA12395@amd>
 <4cf79414-578e-eea7-4f46-fc8789206988@gmail.com> <20190105123146.GA16354@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <8044cdd9-b9b3-fddd-6106-184b906859e2@gmail.com>
Date:   Sat, 5 Jan 2019 14:16:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190105123146.GA16354@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/19 1:31 PM, Pavel Machek wrote:
>>> We will need to solve RGB leds somehow, hopefully this is solved with
>>> it.
>>
>> When? With this attitude we will procrastinate it forever.
>> It's been almost 3 years since first HSV patches.
>>
>> I proposed rough design of LED RGB class interface in [0].
>> If you find it totally flawed, then please spot the problems.
>> If not, let's improve it and implement.
> 
> That is fatally flawed, and inferior to the HSV patches, sorry...

Please spot the problems.

> Grab yourself an RGB LED and play with it; you'll see what the
> problems are. It is hard to explain colors over email...

Video [0] gives some overview of lp5024 capabilities.

I don't see any problems in exposing separate red,green,blue
files and brightness for the devices with hardware support for
that.

I want to push things forward and I'm going to ask Dan
to give this design a try.

[0] https://www.youtube.com/watch?v=qdt-alh8i6E

-- 
Best regards,
Jacek Anaszewski
