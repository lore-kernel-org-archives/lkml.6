Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7319ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF84204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkMC+9QY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF84204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeJQVlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:41:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42563 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeJQVlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:41:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so12555419pgq.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 06:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kM34RWHdo1dsxzgEGyEIx7zoQmZu0P/fdfEc0PS3/FU=;
        b=XkMC+9QYXQepp3CJ28tZJibsHmvsYgUztJoFjBzYfkAtmOIX4H4Ry/QXnP+ujz5Qzc
         RbigJqhOOokCVxz/J8D1vc3R+evzQETyXh5cQPhThrfjWc7zjkOJsVONxEbPjzF8ZRT5
         ksQvjwRDJRHAOBckW08gu1xGU4M/xa4CJJLEjQPUsUqJ2c9nSdLaGB1OVzfvZu3NO5c6
         d8yHWEpt63IAN2A4K1FHax3ISDDQnfgX3WmhpV9UnaUAFeCw5kOR1r2l8rDtE/f3snK3
         1hI5kffV9OiWdBMHq4E8JYBCJf5nZs+wxWtWy8huYiA9IRI1uvdVluakPP9TRPZW2d9R
         zxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kM34RWHdo1dsxzgEGyEIx7zoQmZu0P/fdfEc0PS3/FU=;
        b=GAIvC/0YKohytYWFAPaVSvv2nsJtaEI+Ik/ojpIRluii4/XRc2QjyFqKIvZie2n19o
         ZKqtj2q9QdGYjGUtIiBl3T4VQQ0XvPKX75shrczvcJjCe6wpeuuu89cUIRFEPy0N1RkU
         Ad+xxkLAcn6LRdR/lNYZnAnEbgh3mEbHLHwjnfFnGprmypetl6hjZu8yLYAe8iAV5Xuk
         +ai7FbhXxPUGtmeaninqytGVLaNlYF2TEXN3PiKmDNo4DZHXTmVFpAjATQWBzxIPc+vJ
         2gRFQAC+iluAjSV1pfl7wPTDgZv/5IWBTIzOP/Xf8FhUfULaQuBU+1mOiwS3jB5AZd8g
         ZbCA==
X-Gm-Message-State: ABuFfojEFBpN5wMGxnTYSxGnfdNoSoVJGDa4ix837FEC1zvxf0Gcc6s4
        6IvMCm0AqAHmCEOUZ/a/Dy3PJ8g3
X-Google-Smtp-Source: ACcGV63czIGcf7ZKDCkjlruNgC84VqTDhhzmicC32xFGmhEcLXZXQYp9RV/0F9Y3Qam8YA3JpRVoUA==
X-Received: by 2002:a63:a902:: with SMTP id u2-v6mr24605535pge.207.1539783924774;
        Wed, 17 Oct 2018 06:45:24 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q24-v6sm20429977pff.83.2018.10.17.06.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 06:45:24 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH] code-of-conduct: Remove explicit list
 of discrimination factors
To:     Josh Triplett <josh@joshtriplett.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org,
        ksummit-discuss@lists.linuxfoundation.org,
        Tomi Valkeinen <tomi.valkeinen@iki.fi>
References: <20181017071902.30102-1-geert@linux-m68k.org>
 <20181017091325.GA15991@localhost>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c28df7c4-eb3f-3864-862c-edc330a8fce8@roeck-us.net>
Date:   Wed, 17 Oct 2018 06:45:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017091325.GA15991@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2018 02:13 AM, Josh Triplett wrote:
> On Wed, Oct 17, 2018 at 09:19:01AM +0200, Geert Uytterhoeven wrote:
>> Providing an explicit list of discrimination factors may give the false
>> impression that discrimination based on other unlisted factors would be
>> allowed.
> 
> This impression is, in fact, false, as has already been discussed
> elsewhere. I had hoped that discussion would suffice.
> 
> As mentioned there: The original commit explicitly said "Explicit
> guidelines have demonstrated success in other projects and other areas
> of the kernel."; this is precisely the kind of explicit guideline it
> refers to. Listing explicit cases to cover does not imply other cases
> are not covered; it does, however, ensure that the listed cases *are*,
> and helps people know that they're covered.
> 

That is really a matter of opinion. Mathematically speaking, your statement
is incorrect. One may wonder why the list is made explicit without hint
that it is an example. For example, political or social views are _not_
listed. Wasn't the same CoC used in other projects to at least try to
punish individuals with specific political and/or social opinions,
just for having those opinions and expressing them outside the scope of
the project ?

> This patch is not OK, and defeats one of the purposes of the original
> change.

The CoC, as it stands, singles out maintainers for enforcement action.
Based on your statement, is it correct to assume that this was on
purpose ? If not, what is the explicit list of purposes of the
original change ?

Guenter
