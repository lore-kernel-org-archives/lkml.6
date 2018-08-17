Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF1BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F6D2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 19:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mi+7s5/J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F6D2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeHQWlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 18:41:50 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:52596 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeHQWlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 18:41:50 -0400
Received: by mail-wm0-f45.google.com with SMTP id o11-v6so8496903wmh.2;
        Fri, 17 Aug 2018 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DZAf/2YPCNxssptilhXkH2PzMRFRBTF5w+KjTTupe4Q=;
        b=mi+7s5/JteGIMrJ0hdgCh9rX1sW+jt5IDC/qWem4U4nV2okA0Yl9bRKMu/IZbXL1kZ
         h2Aup9LCHdt9v3cn8yTdwtIUjoTxDhwJFXwhiJG/61MxqCZJ0u8s8PC/A/t6qR6dddof
         UqOQ+QpsJWj6E89wKX64cPv/egGlgulD1AuR7Rz/6wsFQ0RWZIXA97PT8Tp24BJxUv7H
         felQi7W05vH4Hx6f/ClACfiehCOEKNGSyz4KM+w0fgkkEOEytJauoPfhFxjX1fbOvwJV
         cAgArMvMf8NC8mUs7e+GvkGyoCR9rmHTocfImT3SxstJQzGl7gSqPCXeeyM/89FLh/i3
         Wr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DZAf/2YPCNxssptilhXkH2PzMRFRBTF5w+KjTTupe4Q=;
        b=WbepUovKV18JP1U1bR/5GIb9lP7gUOylyHTXFJWry7XcpdE5DgIPDh6r+fBh1uY7ta
         sTkoBlVgUuj4Xsr4BTTAmEUiuLiCEs0UOhO0QNmpxHkQzs1IGXmiv1nyulbr9Vu5CPvi
         YXJ+DKTGDLJTJF1DV60fnf9qprhGuRnhW1/29XcRcyPgFyxGUHuZAQ4h/+KR4cdRD/+y
         UKj8zfVXWvcoTSe6onh4syI95b8ywYsRO+eEexNltF5X1SJeISZBzt8aDAZ1QPTrC3QE
         ebif8bdVysYAV8Mk0jnR13CFJ+nn17guT5SIsBB9YRfD3/iDWo2CFst3Ww8zk813Wr3J
         rIxw==
X-Gm-Message-State: AOUpUlGYOWViY5IPPK8hP+ipTLxvvbLUpzKnbwcu8R9PKB0vFhLwG48v
        Kl6hnQW2E/moi8ULSVnaMcrz03jh
X-Google-Smtp-Source: AA+uWPzeX7a++V8AlhpocRc9xM90HZUBYN0ZCIQJKqcZAFCXBFhCFzS7GRnBNMR8a8ZIbPwJy7LX4g==
X-Received: by 2002:a1c:1004:: with SMTP id 4-v6mr19799103wmq.68.1534534630329;
        Fri, 17 Aug 2018 12:37:10 -0700 (PDT)
Received: from [192.168.1.18] (chm50.neoplus.adsl.tpnet.pl. [83.31.10.50])
        by smtp.gmail.com with ESMTPSA id m8-v6sm5960180wrf.93.2018.08.17.12.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 12:37:09 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] leds: lm3697: Introduce the lm3697 driver
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180816172058.31700-1-dmurphy@ti.com>
 <20180816172058.31700-2-dmurphy@ti.com>
 <9ef9cd25-5c73-964c-ac09-55c0c78e5dc9@gmail.com>
 <c751759a-d0c2-4ee7-2299-99d83538bdc4@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <24e05753-8ec7-e1b0-8671-8443bc20130a@gmail.com>
Date:   Fri, 17 Aug 2018 21:37:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c751759a-d0c2-4ee7-2299-99d83538bdc4@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 08/16/2018 10:44 PM, Dan Murphy wrote:
> Jacek
> 
> On 08/16/2018 02:58 PM, Jacek Anaszewski wrote:
>> Dan,
>>
>> Thank you for the patch.
>>
>> I didn't review DT parsing details in v3, but now I've produced
>> diff between v3 and v4 to check what has changed.
>>
>> I'm quite surprised realizing that you're not validating
>> HVLED and control banks assignment, having in mind earlier
>> discussions and your concerns about numerous DT configurations
>> to check.
>>
>> Is it on purpose?
>>
> 
> Yes.  It was on purpose.  After sleeping on it and going through the overall
> control to HVLED assignments I realized the user will know quite quickly
> that their configuration is messed up.
> 
> The suggestions actually simplified the code quite nicely which I am happier to have

Ack. Thanks for the v5 - I'll let it sit on the lists for a week anyway,
until the merge window gets closed.

-- 
Best regards,
Jacek Anaszewski
