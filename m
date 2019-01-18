Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15949C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99B82087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3rPnwyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfARIIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:08:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37636 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfARIIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:08:46 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so6218835pfb.4;
        Fri, 18 Jan 2019 00:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+jg9/pF74H4/g+qe4E4Pd7knwQxYPNTbU/FbsRxX9kI=;
        b=b3rPnwyk1KfVJE2frvqOT9+cHwpFtrRVjbpUl7cJqwHD8eUX7DxqRHPpmLDfglOLyg
         I2K6K5+BJS/BIps5L8zn4+SgN3Kh98+E2tSb4JiSNuktyc/SXVdbtN156z77tEQaEele
         5OnstU08Rys6H+NW9Mu4gNef03g2VZiFy3s7rYvSIWkcGYK19ppSVqgQooEpXd+tu2dP
         kwi6VBNERkFJGHcrV/K7K5FdU0gH/fV4k0jkLiLCkK+nmzjhvMRcytj6k7rGhIdJvxFi
         hjLcPfDa7vCwI6/R5rd5qvEQgul/2X4SMOvyDSTYklD+pEEOY44+FAMvoneW9rkXjDNC
         lKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+jg9/pF74H4/g+qe4E4Pd7knwQxYPNTbU/FbsRxX9kI=;
        b=GBZwW7OEYZVBNEkkt5MtUa+skUop7kL5JKrq0It4Rv1bqWPrh4h8zeBKK86mJdKnLd
         +6oi5m4V8lhqv2nK4/RkMn61iqpc1LfunPlXKDqNE7fCxw1pSwxQnjJ//D8C713AEw+f
         R1mtA8DaqCJBAnyw/EYvSJVRgdt01aIYzFO/bFNuYE6aRv4H3IhEWggJ4RpI/kzu4wya
         edVxd02tv0d6FPiEDFLk3yz813bauBDjJsjJbnSjkVshUBOcwSEIOFDFld58PdXfMH4G
         dfExxZYFnD16LzZNmT6mSrgLmQmLxjCkaOxsvFUSNGPEwTsBItIr6Y5htvUGMEakz9rI
         XTcA==
X-Gm-Message-State: AJcUukd1qA5/xc1E9dk7OExVS9ybBfu0zf51mk99Gi1M738lqX1Xkepl
        S5ksO8m1jOmrB9UZmZgP1Bk=
X-Google-Smtp-Source: ALg8bN5tMgFgP2GsVbIj9NCaR+rWjlzRJrOBgevBDNC2/d/YEEHH7k8OWOPYdT/G1SHbOnZz9plCdg==
X-Received: by 2002:a63:be4d:: with SMTP id g13mr16766929pgo.378.1547798925211;
        Fri, 18 Jan 2019 00:08:45 -0800 (PST)
Received: from [192.168.42.184] ([103.44.164.150])
        by smtp.gmail.com with ESMTPSA id c13sm7964643pfe.93.2019.01.18.00.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 00:08:44 -0800 (PST)
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Mason Yang <masonccyang@mxic.com.tw>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1547790855-22120-1-git-send-email-masonccyang@mxic.com.tw>
 <1547790855-22120-3-git-send-email-masonccyang@mxic.com.tw>
 <CAMuHMdXiW=4qgZGFqvwGHL7V3ZHfQ2EJ2B96dG14B-jh5+XqOw@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <dc043bfe-7a56-9810-1e5e-802f8b6beee2@gmail.com>
Date:   Fri, 18 Jan 2019 09:08:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXiW=4qgZGFqvwGHL7V3ZHfQ2EJ2B96dG14B-jh5+XqOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 9:03 AM, Geert Uytterhoeven wrote:
> Hi Mason,
> 
> On Fri, Jan 18, 2019 at 6:55 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
>> Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
>>
>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> 
> Thanks for the update!
> 
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
>> @@ -0,0 +1,37 @@
>> +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
>> +----------------------------------------------------------
>> +
>> +Required properties:
>> +- compatible: should be
> 
>     compatible: should be an SoC-specific compatible value, followed by
>     "renesas,rcar-gen3-rpc" as a fallback.
> 
>     Examples of the latter are:
>       - "renesas,r8a7795-rpc" (R-Car H3).
> 
> This makes it future-proof, in case the RPC on a specific SoC version needs
> to be handled specially. We already know that is the case for R-Car V3M.
> 
>> +- #address-cells: should be 1
>> +- #size-cells: should be 0
>> +- reg: should contain three register areas:
>> +       first for the base address of rpc-if registers,
>> +       second for the direct mapping read mode and
>> +       third for the write buffer area.
>> +- reg-names: should contain "regs", "dirmap" and "wbuf"
>> +- clock-names: should contain "rpc"
>> +- clocks: should contain 1 entries for the module's clock
>> +
>> +Example:
>> +
>> +       rpc: rpc@ee200000 {
>> +               compatible = "renesas,rcar-gen3-rpc";
> 
> compatible = "renesas,r8a7795-rpc," renesas,rcar-gen3-rpc";

Without the extra comma after r8a7795-rpc, of course ;-)

-- 
Best regards,
Marek Vasut
