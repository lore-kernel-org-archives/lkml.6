Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6A8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3D42083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2aMX8N5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3D42083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755481AbeFSB20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:28:26 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41023 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755375AbeFSB2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:28:24 -0400
Received: by mail-pl0-f66.google.com with SMTP id w8-v6so8495813ply.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 18:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ch8Waowzx1UdmTfHet4nTFEbozPKSbml3tzNtcN0Mdc=;
        b=i2aMX8N5XPc4AWuot973Jii36o6J1Z7ePXzU2BeOXMP7NpIh3G81Kc3Jk6N2mvr7aY
         BVjjU3yP77S8bXO0sOTNSoc9pb46YkFJ8BVrLj51JiiJWb8ObNXbYChVD/vzhyze8SMD
         iJtt+K0kTTFlAF1ReN5FcLQVe/JshDYyp3XvxJs74mFsfaJy4zlIbTrJQrbYFEb9cXJp
         I600Lm+Q7G7s67j1CoTX6dEbTxES+t1dY8V3W9s3GC0FptXqmOm/TpbagCIEUqXF9a2b
         nahngmKYpF7PzybU6fMDxDsBKRb9ApcqLo+MtcQYg8xA/PYbvA+6IEI+9taN4VgG3Ecg
         WwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ch8Waowzx1UdmTfHet4nTFEbozPKSbml3tzNtcN0Mdc=;
        b=Ewy2rASkOIshMJoIFCLqC0ghUWBFTdL/KHuuMszQvJZmB5XLGkisT331fQLipLim9j
         8jyV251unpHpC+E94cQE+NjV84IMKztlOxpeMYh0+vyucMaUV2rv3vGfmaHp3thGYcz6
         Ql2B3kkVl2Kh7xZF7XZ43jqAKFsiUES+n7hk5b/iQwYXKLix6JWL1lANDCJWwte8a43T
         oCI+71NFLecQjZiEX+9dNJmdQ2R9ehlRJYnF+mZYn3wGn30MFVBrUrE/f8xTKmaL1T3a
         FJXlYMkX4NlAQgHIcfScMcbIKxVO191lgc3T7pZxJNiiqwXHPghcJ50va83WtlVUrD7B
         s7Vg==
X-Gm-Message-State: APt69E1piiHb10y1yXHkG7hOiwJCRFfYqbrfH9mOPkIUEBw/LHFxjacy
        5ZfeHn0wTrpStboFKXXpUBY=
X-Google-Smtp-Source: ADUXVKJ8VfgyIxJxE3EMau2kp41tUWZ+j8ISGkuCPkscfChO0fWn6lchB/9C51agLhhyDGC5LZhFHQ==
X-Received: by 2002:a17:902:650a:: with SMTP id b10-v6mr16668371plk.45.1529371704324;
        Mon, 18 Jun 2018 18:28:24 -0700 (PDT)
Received: from [192.168.43.97] ([1.1.125.112])
        by smtp.gmail.com with ESMTPSA id t192-v6sm22542025pgc.74.2018.06.18.18.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 18:28:23 -0700 (PDT)
Subject: Re: [PATCH v2] mtd: atmel-quadspi: add suspend/resume hooks
To:     Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     dwmw2@infradead.org, computersforpeace@gmail.com, richard@nod.at,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1528101993-4772-1-git-send-email-claudiu.beznea@microchip.com>
 <20180618114920.654647c0@bbrezillon>
 <8474a744-5552-932f-7ba8-85b7d95368ea@gmail.com>
 <0be344a2-9878-2b92-9436-bc2f4d4fd6e0@microchip.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <5b66cafe-782e-43a9-c221-cf0a1528f382@gmail.com>
Date:   Tue, 19 Jun 2018 03:28:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0be344a2-9878-2b92-9436-bc2f4d4fd6e0@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 02:00 PM, Claudiu Beznea wrote:
> 
> 
> On 18.06.2018 12:53, Marek Vasut wrote:
>> On 06/18/2018 11:49 AM, Boris Brezillon wrote:
>>> Hi Claudiu,
>>>
>>> The subject prefix should be "mtd: spi-nor: atmel-quadspi: ". No need
>>> to send a new version just for that, I'll fix it when applying the
>>> patch.
>>>
> Hi Boris,
> 
> Thank you!
> 
>>> Looks good otherwise. Marek, any objection? If not, can you add your
>>> Acked-by?
>>
>> Will this work if you have ie. ubifs mounted on that QSPI NOR and you
>> suspect and resume during IO ? I think it would, but just curious if
>> there could be some problem.
> 
> Hi Marek,
> 
> I tested only with read/writes while suspending, simple scripts, but not
> having ubifs mounted on QSPI NOR. I will double check also with ubifs
> mounted on QSPI NOR and come back with the results.

Thanks. I think it's gonna be OK, but let's just be sure.
Make sure to disable 4K sector support when fiddling with UBI/UBIFS on
QSPI NOR.

-- 
Best regards,
Marek Vasut
