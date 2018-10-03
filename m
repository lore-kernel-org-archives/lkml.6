Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11181C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECD420835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 09:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECD420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJCQIt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 12:08:49 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57855 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbeJCQIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 12:08:49 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1g7dLG-0005we-Eb
        for linux-kernel@vger.kernel.org; Wed, 03 Oct 2018 09:21:14 +0000
Received: by mail-pl1-f197.google.com with SMTP id ce7-v6so4903925plb.22
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 02:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cVcEbU2/n5kfBUmtcw0bxIB6rMrNxWoCtIUIqOImKq0=;
        b=JclUBVVYNh+Av2NCPBYrgpbtsW2c7DdnkVPyr726dns2yI87ylW82gUDKbOzQVvkiT
         KJxRDNxN8dKHMnxJRIVFnCxuSx2jtnySudLVP6InDsNsJ5n2g3PtG7d2mfYnYiA+4OKk
         MxiTsuJUTdVZJD1hXAERPqANa23c8q0Uj+8ohkWyY1PTBdUlFsvNGaTW0DD41Y30evEC
         QdPCBlSNPN6qxUMfSTGeQzOWtvtJ7zD4gCm7ADFxGYVEpn6dT8J27QMkNjeoa+jvsVhp
         tPcBn1AU6hPj4RVp2A6lr/44zW+u68p9siyEEDsz327wZTY7vcfDCm6bN2kH2MaMhCmu
         U4SQ==
X-Gm-Message-State: ABuFfojmzXWmbhrjwK+Cut1hoBjM5kfzQkCMPbhfcKc3yy/nzVvbo0sQ
        I1pak0rtcqrX+51NWyEF/e+mz/2caDB2avH3UmqedSSxHjsatJgnC6x5SscLDUsFI/K9Lmm99fx
        fYcc75KmOLYrEFmx55/zS8yjyXfmhvng4fKtUly3I2w==
X-Received: by 2002:a17:902:50e3:: with SMTP id c32-v6mr656089plj.194.1538558472678;
        Wed, 03 Oct 2018 02:21:12 -0700 (PDT)
X-Google-Smtp-Source: ACcGV62IGy9e9pRTQ/g7u65tNiB0vBCxlfnjwii/88JdvufJj9Pv49yeIDeKYxtY+6da9SGUOZ2psA==
X-Received: by 2002:a17:902:50e3:: with SMTP id c32-v6mr656067plj.194.1538558472315;
        Wed, 03 Oct 2018 02:21:12 -0700 (PDT)
Received: from [10.101.46.95] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id p62-v6sm2676036pfp.111.2018.10.03.02.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 02:21:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.39\))
Subject: Re: [PATCH] HID: i2c-hid: Add a small delay after powering on/off the
 device
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <nycvar.YFH.7.76.1810031109200.14430@cbobk.fhfr.pm>
Date:   Wed, 3 Oct 2018 17:21:07 +0800
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <0C967268-A741-47F8-9791-01A94F551AB3@canonical.com>
References: <20181001035313.21453-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.1810031109200.14430@cbobk.fhfr.pm>
To:     Jiri Kosina <jikos@kernel.org>
X-Mailer: Apple Mail (2.3445.100.39)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 3, 2018, at 5:10 PM, Jiri Kosina <jikos@kernel.org> wrote:
> 
> On Mon, 1 Oct 2018, Kai-Heng Feng wrote:
> 
>> Raydium touchpanel (2386:4B33) sometimes does not workin desktop session
>> although it works in display manager.
>> 
>> During user logging, the display manager exits, close the HID device,
>> then the device gets runtime suspended and powered off. The desktop
>> session begins shortly after, opens the HID device, then the device gets
>> runtime resumed and powered on.
>> 
>> If the trasition from display manager to desktop sesesion is fast, the
>> touchpanel cannot switch from powered off to powered on in short
>> timeframe. So add a small delay to workaround the issue.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> drivers/hid/i2c-hid/i2c-hid.c | 2 ++
>> 1 file changed, 2 insertions(+)
>> 
>> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
>> index f3076659361a..ff5682cc1bce 100644
>> --- a/drivers/hid/i2c-hid/i2c-hid.c
>> +++ b/drivers/hid/i2c-hid/i2c-hid.c
>> @@ -409,6 +409,8 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
>> 
>> 	if (ret)
>> 		dev_err(&client->dev, "failed to change power setting.\n");
>> +	else
>> +		msleep(20);
> 
> In case there really is no other way around it, at least please add 
> comment explaining why this ugly msleep() is there. Thanks,

I am working on a better approach for this issue, I’ll send a v2 soon.

Kai-Heng

> 
> -- 
> Jiri Kosina
> SUSE Labs
> 

