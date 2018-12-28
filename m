Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231F6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C7220874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 15:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbeL1P6O convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 10:58:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51193 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeL1P6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 10:58:14 -0500
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gcuWa-00029l-Lk
        for linux-kernel@vger.kernel.org; Fri, 28 Dec 2018 15:58:12 +0000
Received: by mail-pg1-f200.google.com with SMTP id r16so20175729pgr.15
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 07:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ulLqU3PlhucDKkxvVuvxhe6MyXAHLoaby6+i54zQTAc=;
        b=uj2ILhvwdp1/xaq4+mgZ8DAFT6w+aN4kUCzdb2Zeu+xzYksqZw0TaGHUybwkpEOBEi
         lxI4lz/m9pMy0kwFgcl6wSezz5A9C53mHNTbvXB+I8sy8hjQmjbvlodVgnu1PGztw9xH
         uNT+hPtXNE6uEIcS/64V23gomizASOccXj6nUZLCJn1jZ4flZTO15aDr4ChBucYGMycg
         yWLxgsYGTEAifw24ZWwI7ryF+MYBbLPSYd49ABE9uv2k7wLXL5EdqXdFibnc60AjC7wh
         ixXSFuep6l30EN1DUrR1bOS+o9k1zWK8R9NfRwE7UpYA/FBMQ3WVF68U+1SFxc8Oqz7h
         +ypQ==
X-Gm-Message-State: AA+aEWa9LYEByYcwk2WTxDTWWt5waMocfGxURPwy5rpStDqdSU5EUIDg
        +fJnDi74FXQlxxtNOkibmWSd0/dF17pPprwFRyJgSqIyhplzRxVKefl7lelyF7x1mGphl5LSasM
        Z0ocK5V9x2PSgaINt+9gpRghMzBpAroIFSHR16suFNA==
X-Received: by 2002:a62:509b:: with SMTP id g27mr28801041pfj.48.1546012691044;
        Fri, 28 Dec 2018 07:58:11 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VWV4H7KPkGUWy/hSdExjqltyuto1L9J3vkMdopmSB6yWJ/vzIb+BPAAVWGGhTI+qN7peNnSg==
X-Received: by 2002:a62:509b:: with SMTP id g27mr28801025pfj.48.1546012690714;
        Fri, 28 Dec 2018 07:58:10 -0800 (PST)
Received: from 2001-b011-380f-3f3d-00b6-82e2-e99e-76d3.dynamic-ip6.hinet.net (2001-b011-380f-3f3d-00b6-82e2-e99e-76d3.dynamic-ip6.hinet.net. [2001:b011:380f:3f3d:b6:82e2:e99e:76d3])
        by smtp.gmail.com with ESMTPSA id b7sm58008003pfa.52.2018.12.28.07.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 07:58:09 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] HID: i2c-hid: Ignore input report if there's no data
 present on Elan touchpanels
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <nycvar.YFH.7.76.1812191406240.17216@cbobk.fhfr.pm>
Date:   Fri, 28 Dec 2018 23:58:07 +0800
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C2BE37B9-E122-45FD-BFC6-C3DB79DB141D@canonical.com>
References: <20181214090930.13386-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.1812191406240.17216@cbobk.fhfr.pm>
To:     Jiri Kosina <jikos@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 19, 2018, at 21:09, Jiri Kosina <jikos@kernel.org> wrote:
> 
> On Fri, 14 Dec 2018, Kai-Heng Feng wrote:
> 
>> While using Elan touchpads, the message floods:
>> [  136.138487] i2c_hid i2c-DELL08D6:00: i2c_hid_get_input: incomplete report (14/65535)
>> 
>> Though the message flood is annoying, the device it self works without
>> any issue. I suspect that the device in question takes too much time to
>> pull the IRQ back to high after I2C host has done reading its data.
>> 
>> Since the host receives all useful data, let's ignore the input report
>> when there's no data.
> 
> Interesting, never seen such a bug before.
> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/hid/i2c-hid/i2c-hid-core.c | 9 +++++++++
>> 1 file changed, 9 insertions(+)
>> 
>> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
>> index 8555ce7e737b..1776afa6d69c 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
>> @@ -50,6 +50,7 @@
>> #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
>> #define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(2)
>> #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP		BIT(3)
>> +#define I2C_HID_QUIRK_BOGUS_IRQ			BIT(4)
>> 
>> /* flags */
>> #define I2C_HID_STARTED		0
>> @@ -179,6 +180,8 @@ static const struct i2c_hid_quirks {
>> 		I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
>> 	{ USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
>> 		I2C_HID_QUIRK_NO_RUNTIME_PM },
>> +	{ USB_VENDOR_ID_ELAN, HID_ANY_ID,
>> +		 I2C_HID_QUIRK_BOGUS_IRQ },
>> 	{ 0, 0 }
>> };
>> 
>> @@ -503,6 +506,12 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
>> 		return;
>> 	}
>> 
>> +	if (ihid->quirks & I2C_HID_QUIRK_BOGUS_IRQ && ret_size == 0xffff) {
>> +		dev_dbg(&ihid->client->dev,
>> +			"%s: IRQ triggered but there's no data\n", __func__);
>> +		return;
>> +	}
> 
> Would it perhaps make sense to make this some sort of printk_once(), so 
> that it's immediately apparent from dmesg that the system/device is 
> suffering from this particular problem? Might potentially be helpful piece 
> of information.

Good advice, I’ll send a v2 patch to address this issue.

Kai-Heng

> 
> Thanks,
> 
> -- 
> Jiri Kosina
> SUSE Labs
> 

