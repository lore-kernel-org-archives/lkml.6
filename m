Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C302BECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7771520875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 07:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YM4IIjqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7771520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeGVIgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 04:36:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39419 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbeGVIgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 04:36:17 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so392550edi.6
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=sLPgzMHO3ScaLri+Vq68NHlMbAkkKzQvCdcVmQzjbY8=;
        b=YM4IIjqcpBr4299WpcxXpS9Qh8iiE4npHLkKgnKQSEmWgn1AlQF8ZWPIDLYeqM3WkI
         +WDihfSZJwUltwL4yzv7BNdXRmaQLWJ2iUnoaming/gupQhM6lxthC1C930FCBxiTq6J
         tM+tDlvYiP2fsSvg1Uf0PDqCxxNbnVBA5jzFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=sLPgzMHO3ScaLri+Vq68NHlMbAkkKzQvCdcVmQzjbY8=;
        b=UJttCinecl925ZhS2zj6gyPpMl7IClJGzxBBgDeAapAsAMSWGjbefyYVV2IW6y10so
         N5YBf6lL4sf6ae2rhtb1S2fgJaVAyLd36C4vYyhhdHTOS/7wTKfT7PYMHUu71qhHzC3G
         ed26j9LTnpI3NFP7pMJTmesjjbdvcaiuR0NHw0WJf0DnP8NCNmC0AWGEq4aHriasFQAB
         yWxzK1HVFbi1JpwjQRzABQt/eccX1iyx97QjJfmXpewRXBNu/jg3u36aiLXOahNRpwfJ
         /JvznZso/mETJbK0Dp7HUqYCsrmaNxEcPh8GLRXMzlNRh0b55Mp3ci4NcKiKWsGKbgih
         mttA==
X-Gm-Message-State: AOUpUlHz1XaBiQE3K92CqWc2YEKgcdZKShBlG7qLucBeDuIGlYn+JG4G
        OA195eI2odhCWf4+c1jA4e8vkA==
X-Google-Smtp-Source: AAOMgpekasAdqmGqQzmAsVPz7Iaa/bgq4GHj4TMH6uRIZsD8PkX5ZU+zxD4McD5SiF6iux3PkQELCg==
X-Received: by 2002:a50:9b5d:: with SMTP id a29-v6mr9049706edj.167.1532245231947;
        Sun, 22 Jul 2018 00:40:31 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id a8-v6sm945239eda.27.2018.07.22.00.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 00:40:31 -0700 (PDT)
Subject: Re: Does Linux kernel 4.18-rc5 have drivers for IEEE 802.11AC Wave 2
 USB Wireless Adapters?
To:     Randy Dunlap <rdunlap@infradead.org>,
        Turritopsis Dohrnii Teo En Ming 
        <turritopsis.dohrnii@teo-en-ming.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <de6161f3fe0549fba89f81d8db571981@teo-en-ming.com>
 <9e3f493b-f7a7-c493-9bae-ac3038c29ada@infradead.org>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5B5434ED.2070900@broadcom.com>
Date:   Sun, 22 Jul 2018 09:40:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <9e3f493b-f7a7-c493-9bae-ac3038c29ada@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/2018 4:46 AM, Randy Dunlap wrote:
> [adding linux-wireless mailing list]
>
> On 07/20/2018 08:49 PM, Turritopsis Dohrnii Teo En Ming wrote:
>> Good morning from Singapore,
>>
>> Does Linux kernel 4.18-rc5 have drivers for IEEE 802.11AC Wave 2 USB Wireless Adapters?
>>
>> I noted that Linux usually has poor support for USB Wireless AC Adapters.

Not sure what makes you say that, but you can find a list of AC devices 
here [1] include those fitted with USB interface.

Regards,
Arend

[1] https://wikidevi.com/wiki/List_of_802.11ac_Hardware

