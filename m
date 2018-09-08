Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA17C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 19:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D75820645
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 19:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruwwb6Kf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D75820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbeIIAj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 20:39:57 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55206 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727638AbeIIAj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 20:39:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id c14-v6so17707328wmb.4;
        Sat, 08 Sep 2018 12:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2r3zCFSw/IjFiL/fUWZuZ54FGPgqIyCtVjUIuIW0hfM=;
        b=ruwwb6KfSBptDQvhcerb4A/A3+A0IiHZawSEe9lW5XLct03cremqAtoX6IrcQu42gj
         KWpBUWbUEbRprIlf+8I4LSjumXFBPIilYYbGo0zySbT+FMmKDl/arkvfiidLUwG0Jbuo
         IWfAHkxu6YtUOsFWCCvdCnLv0xtoAgw1C9nWCX/R+8DP/wT15Vt7VJWUWdnDK6guj31M
         wmT0kBdfjNSDXtTfvzW+whU4lt6MqRI5nwkWsKDqKnkWJ4sdNCmnEoncDHsTJZ0ixOwh
         SFu9+3n64IglR5YzD+dCsOlFnWXm0botMlZbonTVFKr+yTE3/zQ8uh+Fq4GsE6yNCciV
         epsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2r3zCFSw/IjFiL/fUWZuZ54FGPgqIyCtVjUIuIW0hfM=;
        b=ARd8VrR+98+yd9xGiXJ/6zJ6s/GrmKDJYa3RsJCZ2GKbbDUHIJYhXSi2aSiqOMYdh6
         DME8gb/aw1ym/ToGHxXacmVSxU7cEqKNtmhJETyOQOzD1GNSldI4njngEC1gJS07fImg
         TCoEwrQTLa4d3Pl4RXUxfpfeIP9cNn/zX1neh0Z2lZ3DVEvvINpJ2fZuVe4rLpgKr7nj
         1JQBrmYxaGqXk4d8wQ88HOdrZbKeTt8oKtnfGr98OUKJevg/R5P+dqsAmuU7OC/rDF1C
         wSglqSYaHR+q+6N0LCtBplQ0AkTlZV7U2D3pl4p7GR7W+AK1gJVi/F5omhEXai5SaEz2
         1thA==
X-Gm-Message-State: APzg51B4/WAfizUM5QWwxYAZ5RJ7Al4DhlHfHEujlk8KBMKJ8Vtpfoma
        9wxEEp2XBFRk+bbGPANUd+L0Hqpi
X-Google-Smtp-Source: ANB0VdYrnDtsXPTbsD/Jn3onjATD+eRAdqpfd/ebOXcbjWqGZ+Z4XCdTqcClPPvEcOszLVNRCFCNRw==
X-Received: by 2002:a1c:5411:: with SMTP id i17-v6mr8659884wmb.53.1536436382978;
        Sat, 08 Sep 2018 12:53:02 -0700 (PDT)
Received: from [192.168.1.18] (civ14.neoplus.adsl.tpnet.pl. [83.31.45.14])
        by smtp.gmail.com with ESMTPSA id r66-v6sm22358393wmb.37.2018.09.08.12.53.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 12:53:02 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: leds: Add bindings for lm3697 driver
To:     Dan Murphy <dmurphy@ti.com>, Pavel Machek <pavel@ucw.cz>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
References: <20180906135005.6718-1-dmurphy@ti.com>
 <20180906211617.GB16899@amd> <b8ac9d52-f16d-5fc4-0e9a-9246b9f984c5@ti.com>
 <20180907133228.GA16297@amd> <70f7506c-6a3d-3830-59a4-a246dc6163f7@ti.com>
Message-ID: <226b8770-7041-39a4-5a06-6002a7c1225f@gmail.com>
Date:   Sat, 8 Sep 2018 21:53:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <70f7506c-6a3d-3830-59a4-a246dc6163f7@ti.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 09/07/2018 03:52 PM, Dan Murphy wrote:
[...]
>>
>>> And I think Jacek pointed out that the bindings references in this bindings
>>> don't even exist.
>>>
>>> I am thinking we need to deprecate this MFD driver and consolidate these drivers
>>> in the LED directory as we indicated before.  I did not find any ti-lmu support
>>> code.
>>>
>>> ti-lmu common core code and then the LED children appending the feature differentiation.
>>
>>> Need some maintainer weigh in here.
>>
>> Hehe. I'm maintnainer. Fun.
> 
> I know.  I want to see if there was any other opinion.  Especially for the LED driver.
> 
[...]

I have a question - is this lm3697 LED controller a cell of some MFD
device? Or is it a self-contained chip?

-- 
Best regards,
Jacek Anaszewski
