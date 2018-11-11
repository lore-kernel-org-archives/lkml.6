Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9983DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5337020871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI+n+9ET"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5337020871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbeKLFxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:53:02 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44535 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeKLFxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:53:01 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so5745825lji.11;
        Sun, 11 Nov 2018 12:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jdq7yJlHOzgQ129ItnN/4NX/qh676dTo3uewlmSlOCA=;
        b=BI+n+9ET5H/tzUxdSIjbp5NiSCxYKMmCDYfcCOQ01xtzUQujhcTc1hol1drZ6rcW2y
         uDb/+YVsZtlMt5maMUyzPMlqFTDTRTGDXe/voiGOcQ5H9MF2XTY3oH24cZvLGYNasju1
         6eYprXZTucr3/Tp4O5FKgzpYLELJkCIog1HNs04W4r1YOEFOAeJSvtS69qEDWqC2yuMA
         Dh6XQDx4TDQ8Zml/QqA4Fp2L8QdFV1ytVo1ZS2z0ncjWT1hJEnl97xdH4P1h7PsNv6D9
         U3rzcXM8DgTMbMG1X7KQZSZZ9soGdf4i6rFwunkaA6nSAvZ9dtCH/2F2UVXd060eV4ua
         i2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jdq7yJlHOzgQ129ItnN/4NX/qh676dTo3uewlmSlOCA=;
        b=sLNaSZva5ObPWjXu36VBZTqAvP2Ww1qMrgWm/JxsJ7/MglJx85dbcFSLtpEeHFiceD
         esj4jOk7irM2zPeJmB+it1sZltpCldDx7k0Y7uRusqoRn70rwPoAhJdC1hqg5zI8w+bE
         YgR5iW8KIcGrcw7zICq3DXtYVIkA4VEygDqsIKazVpQ/ZnwwzO3K0AuDr2gRzqiIqUr5
         DZZkupjJXcJzcJiOGkUANjeXZ5LrdHNEBIy+mKgfq4ygL4UQLLAu24OaAiI+2ZVrMWyq
         cGP5VLcnsL6xLyZ0mNwfuuIHA2zxZ2WDj9L+xjI9dGFJfJQQ0ov1hyAT9T2qmp5VE4nL
         rOSQ==
X-Gm-Message-State: AGRZ1gJEX+6TaA8mxGcY+/yMKANzJv/E9RSoxhgSLF+SyGmXSVjbgKxP
        Un3mkrqs9XP+iEzH56J2NkA=
X-Google-Smtp-Source: AJdET5ciokKo6aDE6HEPhX2IvsSYkYmfZAvSKI1bE81k09RjPjE4Wm0LUaprJTdbviqn5nWDs5RJNg==
X-Received: by 2002:a2e:9213:: with SMTP id k19-v6mr10144929ljg.100.1541966611185;
        Sun, 11 Nov 2018 12:03:31 -0800 (PST)
Received: from [192.168.1.18] (cjk171.neoplus.adsl.tpnet.pl. [83.31.60.171])
        by smtp.gmail.com with ESMTPSA id y1-v6sm2671833ljh.39.2018.11.11.12.03.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 12:03:30 -0800 (PST)
Subject: Re: [PATCH 05/24] dt-bindings: sc27xx-blt: Add function and color
 properties
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>,
        Baolin Wang <baolin.wang@linaro.org>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-6-git-send-email-jacek.anaszewski@gmail.com>
 <20181111142941.GA5215@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <c6e09153-eb16-640f-3ebe-81b533408a73@gmail.com>
Date:   Sun, 11 Nov 2018 21:03:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181111142941.GA5215@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel.

On 11/11/2018 03:29 PM, Pavel Machek wrote:
> On Tue 2018-11-06 23:07:13, Jacek Anaszewski wrote:
>> Refer to new "function" and "color" properties and mark "label"
>> as deprecated.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>> Cc: Baolin Wang <baolin.wang@linaro.org>
> 
> Don't you want to keep both color and label? New dts on old kernel
> should still work...?
> 
> Ok, I see these are only examples....

Right, this is only an example, and we'd rather want to encourage
people to switch to using new LED naming.

>> @@ -25,17 +27,17 @@ led-controller@200 {
>>  	reg = <0x200>;
>>  
>>  	led@0 {
>> -		label = "red";
>> +		color = "red";
>>  		reg = <0x0>;
>>  	};
>>  
>>  	led@1 {
>> -		label = "green";
>> +		color = "green";
>>  		reg = <0x1>;
>>  	};
>>  
>>  	led@2 {
>> -		label = "blue";
>> +		color = "blue";
>>  		reg = <0x2>;
>>  	};
>>  };
> 

-- 
Best regards,
Jacek Anaszewski
