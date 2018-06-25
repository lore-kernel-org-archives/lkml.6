Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B020C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16310253B3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 01:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbrmMlva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16310253B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeFYBgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 21:36:17 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41016 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbeFYBgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 21:36:15 -0400
Received: by mail-pf0-f196.google.com with SMTP id a11-v6so5669629pff.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 18:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=meHRlJqg2ruAuLpLR74WKYY7dFkiXTRSc/OFcDRES2E=;
        b=pbrmMlva5EmNAE7A2FPu0dndgOOYZ+A2VtbSRMuNU/KyJqjtWJsRbtVis5pwLHmqsb
         hSCREA1gXzfZQZOc/13EU7n2CypBLp88o2CB4r6IVy3Irax6ifM+hzb8I6BGBAO96Fkj
         tSxiMLCUuhoM/sxmXNTigYVIrzXA6c21KzZHmdqPFB1GRQM7z8etTo++DJ7TVJcd2Lxa
         YE1H3p0hrtDzdxCxXWv6txOXMCBNCB9uRThc8HRQ82wBWkBK1tlBGxbEbqcT2HfpcBtS
         M6ZxAO+ut7Qp7BL6V/Zj5GnTrI9L3BsEjNopoGhMUDEFyQ+DVpxVQvBGoGot3NSsFc4P
         TuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=meHRlJqg2ruAuLpLR74WKYY7dFkiXTRSc/OFcDRES2E=;
        b=Zs4PTad4E+EiV2MfBfD9T1/4ZZ1bEPZpBBIoezHdoZy7tghXs2th/ajaKx8d0ouqk3
         0r8OV9ROPDh4vfYAQCH6SXLUcLJFWCbKG8uiLLWGs7wAgSDqPIt8/Z+QLNcjFWHf1I8A
         V2fJs5CSKtcpNZTVJogmRG20qUn7++QPD3kNW9i5KHOaJH1tfjho4Llo5LR+hZv5u6O2
         ZF/+TBRl9T/iw4zeyITlq23WpsAB5DAX+RjUMmIuMpbpFOtIECeQBq0kZjDhyZQg5AnY
         0f6sqlZiEIjxiwOxi5QbHyEl8ZtmMxbDnd+5MLwsb9DEpfJWl93cymOs5GaQSnoQGCq3
         Qg9A==
X-Gm-Message-State: APt69E3WZocz1F6HU1LAoxfUxFeeeFA8TxArGBJI92PQUaliq2m9skRe
        SP1QkZlQXgVsQ8j+zd0Ecwf0wQ==
X-Google-Smtp-Source: ADUXVKLtbBx06uJYNVcShaptU9srAPxQ+TDA11W3GzN+n/cdS9ePp90atXT0yGQ2KDNTt73/Hc8YSA==
X-Received: by 2002:a63:714e:: with SMTP id b14-v6mr7340516pgn.73.1529890574708;
        Sun, 24 Jun 2018 18:36:14 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id h24-v6sm344449pfd.69.2018.06.24.18.36.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 18:36:13 -0700 (PDT)
Subject: Re: m68k boot failure in -next bisected to 'xarray: Replace
 exceptional entries'
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Josef Bacik <jbacik@fb.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20180622184246.GA21226@roeck-us.net>
 <20180622210519.GA18630@bombadil.infradead.org>
 <20180622223335.GA12581@roeck-us.net>
 <20180624011703.GH18630@bombadil.infradead.org>
 <a62d8a6a-0376-2cbe-a34c-13e1242f06c6@roeck-us.net>
 <20180624032615.GA32667@bombadil.infradead.org>
 <31d75d3d-2184-6053-5283-f9fe3b10bf82@roeck-us.net>
 <20180624233937.GA3533@bombadil.infradead.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <755c8562-0989-8d8b-aac5-b8fac82702a1@roeck-us.net>
Date:   Sun, 24 Jun 2018 18:36:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180624233937.GA3533@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/2018 04:39 PM, Matthew Wilcox wrote:
> On Sat, Jun 23, 2018 at 09:01:37PM -0700, Guenter Roeck wrote:
>> Yes, that is much better:
>>
>> Build reference: next-20180622-1-g023ad92e94da
>>
>> Building mcf5208evb:m5208:m5208evb_defconfig:initrd ... running .... passed
>> Building q800:m68040:mac_defconfig:initrd ... running .... passed
>> Building q800:m68040:mac_defconfig:rootfs ... running .... passed
> 
> great!  Here's a version which fixes idr_replace() too.
> 

Still passes:

Build reference: next-20180622-1-g374388bcb967

Building mcf5208evb:m5208:m5208evb_defconfig:initrd ... running .... passed
Building q800:m68040:mac_defconfig:initrd ... running .... passed
Building q800:m68040:mac_defconfig:rootfs ... running .... passed

Guenter
