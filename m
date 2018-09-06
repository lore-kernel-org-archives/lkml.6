Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C26C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2082A206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfHWvqKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2082A206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeIFQOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:14:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36950 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeIFQOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:14:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so11010534wrr.4;
        Thu, 06 Sep 2018 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KNZCk5yZxOc9EAU/E0u02jx9OQOOem/IpHr6WLenJes=;
        b=BfHWvqKVxudNwHYlXtE/l4YY9RGz8MtaA5pYF5l66QOpsZBerikh1vo2BBI3JSxOMz
         vGbpBsXvpUrm6oUrYllP8ymb4GE0YSAjvsuwRu4iTfPiRmryMaq1byaH2gDCL97ugiCS
         7C1EiUo33Pgbl1HtAmdiA63mi+v5Otim6IHcwqI8KbEzXaqmSTrHT9ScQIKYTWU448sj
         zmj9I1cuCQU0H5PtXG9cmrfufx3EmG4NOxktuOLp6lG0ja7UkvHnSpvL+yBYmPd43zS4
         9KJR7PNnvV4rS3n4JsWYKRSP9ibge/AmD+mtg4/eFnNCGvGUYhXHLYBx7BcPxILpxHf1
         QWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KNZCk5yZxOc9EAU/E0u02jx9OQOOem/IpHr6WLenJes=;
        b=XzdC06IjEQq+BpUBvo9tAKN2mvuVyDUs8h/09OOK73SqQLsIdM0X0jy+Gaingt3BKG
         mes3YcE47gC33gwPFAObOeuYNRRmjis3RTqSuYBNxljRTzHc1/VPq1JV1bXz03y7/Mhd
         Rm/9fBtQYWkIE+aocAgysJ1eZ3vG5X+84FRFHbPGpc0UaHkzU9hR2W7h4Ied5pT2z1A8
         XcLwFtB5/Mp0KCNiz/814NvwlcqZj3ijPFZwQcfjW2xjEvrT1mglg+SmVUcY47W2uOV8
         TP6flXJDEBYst7mTsnH+t0t7hfPxRhDWG7M+zm/ZV/RMV1H0VleppHnzUBKtp/vSOBOH
         uq0A==
X-Gm-Message-State: APzg51A4hGbIES6QHn6XjWH4p2hmIfbvLdukB8xSZy4cvafTHDZ0w3un
        WNXD5V9zPnbt7ij22k0oZis=
X-Google-Smtp-Source: ANB0VdYz9NndK2mL+dQKGPnU66aiJKQH6GBnuaUIc/QuWi3118d41aNeCD59pjReRTknUC6Tl55HMw==
X-Received: by 2002:adf:9385:: with SMTP id 5-v6mr2096611wrp.157.1536233984876;
        Thu, 06 Sep 2018 04:39:44 -0700 (PDT)
Received: from [10.104.24.89] (eduroam-nat3.rz.uni-ulm.de. [134.60.112.238])
        by smtp.gmail.com with ESMTPSA id b124-v6sm5163609wmh.17.2018.09.06.04.39.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 04:39:44 -0700 (PDT)
Subject: Re: [PATCH v3 30/30] ARM: sun8i: a83t: full range OPP tables and
 CPUfreq
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, linux@armlinux.org.uk,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, eugen.hristev@microchip.com,
        rdunlap@infradead.org, vilhelm.gray@gmail.com,
        clabbe.montjoie@gmail.com, geert+renesas@glider.be,
        lukas@wunner.de, icenowy@aosc.io, arnd@arndb.de,
        broonie@kernel.org, arnaud.pouliquen@st.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-31-embed3d@gmail.com>
 <20180906072429.7qjwbbqsjlbskk6v@qschulz>
From:   Philipp Rossak <embed3d@gmail.com>
Message-ID: <c76e71bc-6bc5-f73c-2c7a-c9315cf2da31@gmail.com>
Date:   Thu, 6 Sep 2018 13:39:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906072429.7qjwbbqsjlbskk6v@qschulz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.2018 09:24, Quentin Schulz wrote:
> Hi Philipp,
> 
> On Thu, Aug 30, 2018 at 05:45:18PM +0200, Philipp Rossak wrote:
>> Since we have now thermal trotteling enabeled we can now add the full
>> range of the OPP table.
>>
> That's not the reason why they were not added.
> 
> Please see commit 2db639d8c1663d7543c9ab5323383d94c8a76c63[1].
> 
> Basically, you only want the OPPs which can work below or at the default
> voltage of the CPU supply, because the CPU supply is specific to each
> board.
> 
> If you set your CPU to work at a given frequency and the voltage isn't
> updated (saying opp-microvolt = <x>; in DT isn't enough, you need
> cpu-supply to be provided and functional), the CPU might just crash.
> 
> Without cpu-supply property, underclocking isn't effective in term of
> thermal cooling or power saving. Overclocking is very, very, very likely
> to make the CPU crash.
> 
> It's not a very difficult thing to do to test if a given frequency work
> well but it needs a specific test environment and it's a lengthy test,
> you can have a look at those tools here[3] if you like. It's not because
> it works in a given test case that'll work on the long term under heavy
> load and constant frequency changes.
> 
> For A83T, I already did it and the outcome is the patch in [1]. Same for
> A33.
> 
> So, if you want to use these three higher OPPs, you need to define them
> in your board DTS and add the cpu-supply property. See what's done for
> the A33 and more specifically the Sinlinx SinA33[2] as an example.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2db639d8c1663d7543c9ab5323383d94c8a76c63
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
> [3]http://linux-sunxi.org/Hardware_Reliability_Tests#CPU
> 
> Quentin
> 

Hey Quentin,

thanks for your feedback!

Sounds like we will never be able to run the A83T on its maximum 
frequency in mainline.

I will do some testing, during the next weeks/months when I have time.
With the old Allwinner kernel I was able to run the A83T with its 
maximum frequency without any problems since my board is very good cooled.

For now I will drop this patch.

Philipp
