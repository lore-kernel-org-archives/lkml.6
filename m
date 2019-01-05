Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F7CC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 12:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F05420868
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 12:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFNKa+A1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfAEMQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 07:16:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46361 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfAEMQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 07:16:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so34508753ljh.13;
        Sat, 05 Jan 2019 04:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YgOCaScMyS179dYbYLf7NlPr/N+JginK2XnVCgeGpK4=;
        b=FFNKa+A14Ej/0BL7uXofITrh0O6QIHCifgekKr07kF0SHEMPcIH132tEmQ4H4pguXL
         ZamG4I+FA4nXe7caIBEUkbF9l8IyqNvZYgb2BTzHvv4Irv/vSQzl4vR5nBU8rNvL66As
         NhdV4YdPdgsP4+U1Nd8s4xY5ZSNBAZREqmuM7x+x0p2QySnOm6xn7GygPjTnkvBUe72R
         fHXF5zAZNMlMbPg2RzSGQVLjAjh/1P61B0oghdfC7Uf9PWcYgJH2m2A1YMAwZwkgrZ42
         nN6QjKEQgGZSJZcd8xHJf0LLiVV5xNc+9H7OMoUjLn1FJug3kF2mhIJTD+q1oIrIqiz6
         Pt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YgOCaScMyS179dYbYLf7NlPr/N+JginK2XnVCgeGpK4=;
        b=WDDAr5V1qS8C8tCJIXDgHPSWeYrgLQgDcoqaQl0geCvHcikzAuKQbvi5/gQtQCwh62
         aGQ7Fkmsufr7vkHkfn5CiIBMlndfQIF4VWAQYuNUoFqdqhNdcHe6ma33uH/4IUsFPZyD
         TBJjtBo2sDEc0TWOkAH1+KXhlf6EuhYl7Ea0eLHs/74OwyY13y7oLnRA/eXWtJ/AaRLK
         5IjMLqVGEOBN8CvT9yW9tl1++/do2/+N323C3pI3b8awhjhEqiknxvzRUInxSv7jl1di
         5WwJKkQQOTnGEeYMH7HXFZZ3X1rCl+xRPtaKcgucz8eZmIoZtckAq7WzpEmgNpiT+53t
         a5Lw==
X-Gm-Message-State: AJcUukfcqQtNOlNMqDhKaTAWpFEMmo0W6ug7e8tqs0b3r27o73DD2D+F
        /nc8UqXUwDkxq3RWBKw95ZzRjY18
X-Google-Smtp-Source: ALg8bN4dogu2v5TZZNvBC0ZxRecItm/HQtQrkwIyVpZR3MBGmxp9mISldSesl3WCVILRtwYFPYCf3Q==
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr9738057ljh.59.1546690575039;
        Sat, 05 Jan 2019 04:16:15 -0800 (PST)
Received: from [192.168.1.18] (ciw155.neoplus.adsl.tpnet.pl. [83.31.46.155])
        by smtp.gmail.com with ESMTPSA id m4-v6sm12602576ljb.58.2019.01.05.04.16.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 04:16:14 -0800 (PST)
Subject: Re: [PATCH 2/2] leds: lp5024: Add the LP5024/18 RGB LED driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <dachaac@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <fd624cc1-9997-1cd5-c5cc-62e6897997cf@ti.com>
 <54f28115-0a7d-8e9c-3bec-6e91fb3981ec@gmail.com>
 <cd90f179-6c16-823f-496f-27f141e9c322@ti.com>
 <a72c11c0-949b-bdbc-df2c-4490e04a1065@gmail.com>
 <986b5105-2fdb-bd25-7c8a-ca8fd1ade821@gmail.com>
 <7f205102-e854-f1cb-cc03-1307d1cddc87@gmail.com>
 <c9f8965a-90f4-b456-8225-c70694c9f071@gmail.com>
 <cf6c0025-36e7-197b-b27a-1f31fb45cc38@gmail.com> <20190104201256.GA2931@amd>
 <a4e3a782-de76-ba91-3727-4db69cf27c3a@gmail.com> <20190104220726.GA12395@amd>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <4cf79414-578e-eea7-4f46-fc8789206988@gmail.com>
Date:   Sat, 5 Jan 2019 13:16:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190104220726.GA12395@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 1/4/19 11:07 PM, Pavel Machek wrote:
> Hi!
> 
>> But, aside from that hypothetic issue, we need a solution for
>> LEDn_BRIGHTNESS feature of lp5024, i.e. setting color intensity
>> via a single register write. How would you propose to address that?
> 
> So they have hardware feature that allows control of 3 LEDs at the
> same time, right?
> 
> Actually turris routers (IIRC) have similar feature, but shared for
> all their LEDs.
> 
> I'd suggest simply ignoring that feature for now :-).

Why not use brightness file for that?

> We will need to solve RGB leds somehow, hopefully this is solved with
> it.

When? With this attitude we will procrastinate it forever.
It's been almost 3 years since first HSV patches.

I proposed rough design of LED RGB class interface in [0].
If you find it totally flawed, then please spot the problems.
If not, let's improve it and implement.

[0] https://lkml.org/lkml/2019/1/3/550

-- 
Best regards,
Jacek Anaszewski
