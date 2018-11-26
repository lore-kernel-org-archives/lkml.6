Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7CBC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5B32086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FX/2xae8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5B32086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeK0F5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:57:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45510 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeK0F5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:57:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so7018193pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 11:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=uBNHJaDJQCRKJOepZeX1Aj3ggaGlI29cAcH02bAD7S4=;
        b=FX/2xae8ixStDERZwFotkIXhj1jU5TAYxOfmKmubnOQHcyFc7ojaulhwDrWB/LDIPc
         efJu1OmakgEDTels6cggWZw9/QGAeKaH5pq3AMl+ZCA4+ffgvjYF3zg3IsNqwdae4WlI
         qSstVsjiE/C+eLe4K5kRQtcUT4ZvbwVBx3EH2lLnYNpNYIURiyeIdWPoVcrG8nurKkrU
         smMK+q6cvGYCu2RC89bLKSvHnTzA1hHUOVkEQkQGHhNNydXwKOWVKzg5oVrfC5lZCs3a
         QV1wxXT8u1cKQrDseuT7Sa2pXB1tiNAp+QLMd6txbn/iorpdgD/aEcbroT5alSyAc1Y8
         6eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=uBNHJaDJQCRKJOepZeX1Aj3ggaGlI29cAcH02bAD7S4=;
        b=KNzpTta6NZ5B62i5xYX3DlOeXRLbYGz7URipdA7az04DGbbcTgznZMYFH5CCBt2aCU
         +4qT9672WzivYNFFg/I4j7XqKTvN+7qZASLPV11J3kRwvdFUIukUN+ZYNcPOyhRuKDBl
         MrFRptLF5GkK1bDORBj4RDtE8YLJ/W+zZGP9ZSMv2S8cmzf8kEtuxshlwyhaDJO99p6u
         vR3JrcWcBykea2+jhPNJdIX5NY7EjD1uHeX5VngjNiK7fzBj70QTokuH82jR20HiAF0O
         uTHcYbi7nrSq91lBInMwv4bQTM5+Ksb0jMWbbund7IGNTrSiny0WYjkh3HUzFduzsCXe
         /Iyg==
X-Gm-Message-State: AA+aEWb9aFtqGkZPFEl+zEIBGH0vppz6uHZz6S6t1Eq4j9canfGa4CYF
        pjwDdcgM5lsgyoFTJOXr2HXzIg==
X-Google-Smtp-Source: AFSGD/VzvgObLSUQry+IQsGDdhC9mirv/khMibS1mZ8bX5FMLqXMCpQS4IYWFGHq2shGmwTU6R55AQ==
X-Received: by 2002:a63:e19:: with SMTP id d25mr26002599pgl.272.1543258971600;
        Mon, 26 Nov 2018 11:02:51 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id w136sm1371764pfd.169.2018.11.26.11.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 11:02:50 -0800 (PST)
Date:   Mon, 26 Nov 2018 11:02:50 -0800 (PST)
X-Google-Original-Date: Mon, 26 Nov 2018 10:56:08 PST (-0800)
Subject:     Re: [PATCH] dt-bindings: sifive: describe sifive-blocks versioning
In-Reply-To: <eda63b4a-4371-7d34-38a0-d7136dfc417f@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com, paul@pwsan.com,
        Megan Wachs <megan@sifive.com>, linux-kernel@vger.kernel.org,
        Wesley Terpstra <wesley@sifive.com>,
        linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-9dfdf5d7-fe41-4418-ba3d-d03ed9b2265c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 17:33:02 PST (-0800), atish.patra@wdc.com wrote:
> On 11/21/18 5:07 PM, Paul Walmsley wrote:
>>
>> For IP blocks that are generated from the public, open-source
>> sifive-blocks repository, describe the version numbering policy
>> that its maintainers intend to use, upon request from Rob
>> Herring <robh@kernel.org>.
>>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Palmer Dabbelt <palmer@sifive.com>
>> Cc: Megan Wachs <megan@sifive.com>
>> Cc: Wesley Terpstra <wesley@sifive.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-riscv@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> ---
>>
>> Hi Rob, please let me know if this document works with your
>> requirements, or if some changes are needed.  - Paul
>>
>>   .../sifive/sifive-blocks-ip-versioning.txt    | 38 +++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
>>
>> diff --git a/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt b/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
>> new file mode 100644
>> index 000000000000..b899e5c6e00c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
>
> It should be be under
> Documentation/devicetree/bindings/riscv/sifive/sifive-blocks-ip-versioning.txt
> ?
>
>> @@ -0,0 +1,38 @@
>> +DT compatible string versioning for SiFive open-source IP blocks
>> +
>> +This document describes the version specification for DT "compatible"
>> +strings for open-source SiFive IP blocks.  HDL for these IP blocks
>> +can be found in this public repository:
>> +
>> +https://github.com/sifive/sifive-blocks
>> +
>> +IP block-specific DT compatible strings are contained within the HDL,
>> +in the form "sifive,<ip-block-name><integer version number>".
>> +
>> +An example is "sifive,uart0" from:
>> +
>> +https://github.com/sifive/sifive-blocks/blob/master/src/main/scala/devices/uart/UART.scala#L43
>> +
>> +Until these IP blocks (or IP integration) support version
>> +autodiscovery, the maintainers of these IP blocks intend to increment
>
> /s/autodiscovery/auto discovery
>
>> +the suffixed number in the compatible string whenever the software
>> +interface to these IP blocks changes, or when the functionality of the
>> +underlying IP blocks changes in a way that software should be aware of.
>> +
>> +Driver developers can use compatible string "match" values such as
>> +"sifive,uart0" to indicate that their driver is compatible with the
>> +register interface and functionality associated with the relevant
>> +upstream sifive-blocks commits.  It is expected that most drivers will
>> +match on these IP block-specific compatible strings.
>> +
>> +DT data authors, when writing data for a particular SoC, should
>> +continue to specify an SoC-specific compatible string value, such as
>> +"sifive,fu540-c000-uart".  This way, if SoC-specific
>> +integration-specific bug fixes or workarounds are needed, the kernel
>> +or other system software can match on this string to apply them.  The
>> +IP block-specific compatible string (such as "sifive,uart0") should
>> +then be specified as a subsequent value.
>> +
>> +An example of this style:
>> +
>> +    compatible = "sifive,fu540-c000-uart", "sifive,uart0";
>>
>
> Just for the sake of completion, should this document also specify what
> should be the style of any possible closed IP as well?

Let's restrict ourselves to the open-source IP for now, as versioning the 
closed source stuff is a bit of a different problem -- when everyone can see 
the source it's easier because we can all agree on exactly what a version 
string means.

For the closed source stuff we currently have just the chip-specific strings, 
as all that stuff is very chip specific (all sorts of special clocking 
constraints).  Essentially you'll have to just trust us as to what's compatible 
with what -- FWIW, since this is mostly driven by the chip process we really 
just have to trust the hardware designers, so we're kind of in the same boat 
(though we can at least peek under the covers if we want to).  Any versioning 
scheme here is doubly complicated because it's closed source and it's chip 
specific, so trying to match this up with the open source stuff seems like too 
much work.

For now we can at least get everyone on the same page as to how we're 
versioning the open-source blocks, which is more important because anyone can 
build a chip with those so we need a well defined scheme.
