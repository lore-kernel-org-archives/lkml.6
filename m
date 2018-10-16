Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98A4C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D50B21479
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Tij+a/vV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D50B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeJQBXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:23:13 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:44922 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJQBXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:23:13 -0400
Received: by mail-pf1-f180.google.com with SMTP id r9-v6so11788337pff.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Nz+s1fq47X5/tu2PUFqFtpaCvyk5Jvn12B4Jt34WfdQ=;
        b=Tij+a/vVR5UJBfRbD6QFNoeWPVM2vyWEpbGPdFnqbc953KwSPSBHllc0LpN+l7p1V2
         GfLeEW6EWm15937hAwEgD3hdlP0HOkz3vLJfvv3PH0/SxX/QlkiagpYTvj9UvKNNWmGO
         cQ7S2QIVFA7sb4yV0ajys/4alqPPVURvqAxFgKUQ9He8bQSgE6XD01oNBJ3dsEiRTjQ9
         uB8/ha24w4d/bguUY49WcTjTtaUHtizXoD9xNa/yGswfP6ShcRA0LGRm4QAwXyp+POV3
         1y1Fgc/WdT0xzdqZd4vdmelogWubL997KVtSs6z+cQDC8VLLwdOnyGX1GHNIKu2Sl06c
         Scvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Nz+s1fq47X5/tu2PUFqFtpaCvyk5Jvn12B4Jt34WfdQ=;
        b=KRf6+re9xenT5U5uAF2mJXu6GfF+yRi+vQaoi3wSYyxwo/8bc2a1cCSHfzDPQsLgjb
         g6O06DI7SunTypb4ckyYTNJVld3WOtCoQ9Y7A2tqJZRxlX+55oWlSJnChhesw4nyeryZ
         A1Jd/3Zyjm6AInLFJ3g+0FMS+Jp71pkkddJaNfbLvTTX3d6CdptV2ps/Pjzt6EwkSMcC
         TTJPWEtMRAULckC4eUrOPH/wIxlktKp9eZNTalj+4b872gNpPSgRVJx//m7l5TSiujLA
         aTC078xSNYj0p21Bz2UheZIn5JQjFnMsr2gkBG8gjZXGrsdJ0Sg1PCoMgsJQsY8gY04d
         ztIw==
X-Gm-Message-State: ABuFfohw+GgbT/v0S1UMC1h8UFi9e7rjcH5gp1Evmknqlc7H7lEhMHUD
        kUj2EC+7Tp0l8BuKEchH+Vz2vw==
X-Google-Smtp-Source: ACcGV60oxet49enyexZROKkznZaXNAJF9gjKNfM0xepagrr3RD+J8+ysVC3L2ifXD852nBgFipG4Mg==
X-Received: by 2002:a62:2845:: with SMTP id o66-v6mr22895541pfo.17.1539711104628;
        Tue, 16 Oct 2018 10:31:44 -0700 (PDT)
Received: from [192.168.0.21] (97-120-178-141.ptld.qwest.net. [97.120.178.141])
        by smtp.gmail.com with ESMTPSA id z15-v6sm18183925pfn.170.2018.10.16.10.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 10:31:44 -0700 (PDT)
Subject: Re: [RFC 1/4] pwm: sifive: Add DT documentation for SiFive PWM
 Controller.
To:     Thierry Reding <thierry.reding@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, Wesley Terpstra <wesley@sifive.com>,
        linus.walleij@linaro.org, palmer@sifive.com,
        linux-kernel@vger.kernel.org, hch@infradead.org,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org
References: <1539111085-25502-1-git-send-email-atish.patra@wdc.com>
 <1539111085-25502-2-git-send-email-atish.patra@wdc.com>
 <20181010134926.GD21134@ulmo> <25758ab9-eb36-741b-6264-42412b3ddd8e@wdc.com>
 <20181016110142.GC8852@ulmo>
From:   Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <6e108e3c-15c1-b13b-ac3e-60c5eb209c7b@sifive.com>
Date:   Tue, 16 Oct 2018 10:31:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181016110142.GC8852@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/16/18 4:01 AM, Thierry Reding wrote:
> On Mon, Oct 15, 2018 at 03:57:35PM -0700, Atish Patra wrote:
>> On 10/10/18 6:49 AM, Thierry Reding wrote:
>>> On Tue, Oct 09, 2018 at 11:51:22AM -0700, Atish Patra wrote:
>>>> +Required properties:
>>>> +- compatible: should be one of
>>>> +	"sifive,fu540-c000-pwm0","sifive,pwm0".
>>> What's the '0' in here? A version number?
>>>
>> I think yes. Since fu540 is the first Linux capable RISC-V core, SiFive Guys
>> decided mark it as version 0.
>>
>> @Wesly: Please correct me if I am wrong.
> It seems fairly superfluous to me to have a version number in additon to
> the fu540-c000, which already seems to be the core plus some sort of
> part number. Do you really expect there to be any changes in the SoC
> that would require a different compatible string at this point? If the
> SoC has taped out, how will you ever get a different version of the PWM
> IP in it?
>
> I would expect any improvements or changes to the PWM IP to show up in a
> different SoC generation, at which point it would be something like
> "sifive,fu640-c000" maybe, or perhaps "sifive,fu540-d000", or whatever
> the numbering is.


The "0" suffix refers to a revision number for the underlying PWM IP block.

It's certainly important to keep that version number on the 
"sifive,pwm0" compatible string that doesn't have the chip name 
associated with it.

As to whether there could ever be a FU540-C000 part with different IP 
block versions on it: FU540-C000 is ultimately a marketing name.  While 
theoretically we shouldn't have another "FU540-C000" chip with different 
peripheral IP block versions on it, I don't think any engineer can 
guarantee that it won't happen.


- Paul

