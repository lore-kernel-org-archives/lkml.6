Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD84CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 03:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973852089F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 03:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VsNYFQvN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973852089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeKONhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 08:37:20 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40832 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeKONhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 08:37:20 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so16825534oth.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 19:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2DCCBWAcvyCdil0kZZpG/T7gSF0R0qOiXC+zRkx04bA=;
        b=VsNYFQvNSPxSBpXvAJtX0VxTjCHSBb1vSsS2l1/KjJoJMneQGT15qk5qARbGTZK4SD
         +pgWrzcLd4n6uA4t1toGjJguQtonQN0NsmClD8014eCFJPTCFWMSKQU9UM2UN/F1p9EP
         oGqFTgc0xMllN5LJmsZT32tygqfc1Gbd+Or78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2DCCBWAcvyCdil0kZZpG/T7gSF0R0qOiXC+zRkx04bA=;
        b=DCpQZWlriK87RkL85/0VJlDo2yDnGsZIt//cWZdrtNJYp5hk84Wn+OT8fdjOIih90s
         Y9blkNs4kPrforGkKQbDCV8mbxWeG0DbSm6CXRPKWlWh+OawZsqFUNhMf/2HKR8fnP3v
         4c3KEqgpOJvNzzh65mRXLouO4QEkrzHMpTWGpneytRL8rbaQTepvKJcL7mk6EkNB34lm
         a4S9SnUyBTZDcpQNsjy2SnK6+4iD/JAB/RdpodEQ8eEZEY5FdjnroGnqZE1mpQsHKXts
         OtK8v9VzU1n1m+of9vF5lEeHFWBZ3ZBP+JBSayrRj+vsIrCHr0+5g6VcfWrazQT1Yh59
         OCLw==
X-Gm-Message-State: AGRZ1gJMczKISGDyI/K2o4kvPfdskvlclmhKGFrhuTytPSZ/TlBF9jIY
        jBKweCuz298DZghKXR17sTmMsw==
X-Google-Smtp-Source: AJdET5cmWmi6XRYAtUfjcVqIwQHg+PZ9NtB22ja+n8nl2Rgq2e7kt0hJpsuE0qsqdJ9JJoqKg2x8gQ==
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr2525147oth.279.1542252675035;
        Wed, 14 Nov 2018 19:31:15 -0800 (PST)
Received: from [172.22.22.26] (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.googlemail.com with ESMTPSA id c58sm19104505otd.34.2018.11.14.19.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 19:31:14 -0800 (PST)
Subject: Re: [RFC PATCH 10/12] soc: qcom: ipa: data path
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20181107003250.5832-1-elder@linaro.org>
 <20181107003250.5832-11-elder@linaro.org>
 <CAK8P3a0nkfwFCCVHaTJ+kJGWxO+qFTzTLnRgB-NG0AyMEsv3bA@mail.gmail.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <a1517ea0-b651-f24e-4890-8ceb6e2b14c6@linaro.org>
Date:   Wed, 14 Nov 2018 21:31:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0nkfwFCCVHaTJ+kJGWxO+qFTzTLnRgB-NG0AyMEsv3bA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 8:55 AM, Arnd Bergmann wrote:
> On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>>
>> This patch contains "ipa_dp.c", which includes the bulk of the data
>> path code.  There is an overview in the code of how things operate,
>> but there are already plans to rework this portion of the driver.
>>
>> In particular:
>>   - Interrupt handling will be replaced with a threaded interrupt
>>     handler.  Currently handling occurs in a combination of
>>     interrupt and workqueue context, and this requires locking
>>     and atomic operations for proper synchronization.
> 
> You probably don't want to use just a threaded IRQ handler to
> start the poll function, that would still require an extra indirection.

That's a really good point.  However I think that the path I'll
take to *getting* to scheduling the poll in interrupt context
will use a threaded interrupt handler.  I'm hoping that will
allow me to simplify the code in steps.

The main reason for this split between working in interrupt
context when possible, but pushing to a workqueue when not, is
to allow IPA clock(s) to be turned off.  Enabling the clocks
is a blocking operation, so can't' be done in the top half
interrupt handler.  The thought was it would be best to work
in interrupt context--if the clock was already active--but
to defer to a workqueue to turn the clock on if necessary.

The result requires locking and duplication of code that I
find to be pretty confusing--and hard to reason about.  I
have been planning to re-do things to be better suited to
NAPI, and knowing that, I haven't given the data path as
much attention as some of the rest.

> However, you can probably use the top half of the threaded
> handler to request the poll function if necessary but use
> the bottom half for anything that does not go through poll.
> 
>>   - Currently, only receive endpoints use NAPI.  Transmit
>>     completion interrupts are disabled, and are handled in batches
>>     by periodically scheduling an interrupting no-op request.
>>     The plan is to arrange for transmit requests to generate
>>     interrupts, and their completion will be processed with other
>>     completions in the NAPI poll function.  This will also allow
>>     accurate feedback about packet sojourn time to be provided to
>>     queue limiting mechanisms.
> 
> Right, that is definitely required here. I also had a look at
> the gsi_channel_queue() function, which sits in the middle of
> the transmit function and is rather unoptimized. I'd suggest moving
> that into the caller so we can see what is going on, and then
> optimizing it from there.

Yes, I agree with that.  There are multiple levels of abstraction
in play and they aren't helpful.  We have ipa_desc structures that
are translated by ipa_send() into gsi_xfer_elem structures, which
are ultimately recorded by gsi_channel_queue() as 16 byte gsi_tre
structures.  At least one of those translations can go away.

>>   - Not all receive endpoints use NAPI.  The plan is for *all*
>>     endpoints to use NAPI.  And because all endpoints share a
>>     common GSI interrupt, a single NAPI structure will used to
>>     managing the processing for all completions on all endpoints.
>>   - Receive buffers are posted to the hardware by a workqueue
>>     function.  Instead, the plan is to have this done by the
>>     NAPI poll routine.
> 
> Makes sense, yes.

Thanks.

					-Alex

> 
>       Arnd
> 

