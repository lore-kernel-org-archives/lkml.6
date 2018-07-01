Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453EAC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26B425478
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/bI8W4P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26B425478
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933609AbeGAQut (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:50:49 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35384 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752873AbeGAQuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:50:44 -0400
Received: by mail-wm0-f67.google.com with SMTP id z137-v6so6436329wmc.0;
        Sun, 01 Jul 2018 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hbzMh4np3nNpWsge8Niuje1qITp9FoaR4HiegnCo+GU=;
        b=W/bI8W4PpcCPbukTR68YaOrVL31dgeGZKfqyGQq4G5CX9Ntb3fyxn5OzS1H7yNiCCX
         m3cPoIBJVAWU35xacaTt9QBgF0ytEF/ga3iNqmNBtYJ9At92PAH2EJzbnjPw2mVaiz7N
         wWq52nuaoP87+1cNiV8WUxAFjHZgaesuhzE56CEhVUdA2zmufBYjdYN22WiutKvMqDgr
         L+TDe1k2ju1EH3+ISskBrccsi+GZyu3/08oL3HPJZ/JR7mEhj6UvyyKjTs03koE4mFkX
         5dA0DlqrRhh1B5KhK5OejZx6U6l+bdFQrueaQ3m8JV9wOVG+XxWZTNpLjO0L4RlQyNan
         97fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hbzMh4np3nNpWsge8Niuje1qITp9FoaR4HiegnCo+GU=;
        b=ZmV6p7hS6KJURIyUhr23DTirTLzvmXgZZ5HGSZTIlclK6IBPE8qkJhjy5QBnDxE8ns
         YQQ8fZ/ON9+VCLB2yK5R0+MeZlfGE0ufbxfjaFKGgtcrBMOVOSuXhJ5wzGgggR+MlUb+
         YXRZPUGV5YO3c3Kg7BJeuUVZNhGvEKNGDDiZkaT4R0cTxnSB5AZE4x4wJKBTG7cpK+GH
         BttD2dV7VxFOJ3ke6zAuxdSO0k7bOYv2AND1gd9swZ918nF/iNvu5EMWKrxYOLwXPisJ
         VobMpCz9c037Og3iUcID/3Ookg3iUVjR6qehGwLdJX1YMREfhmkfNW/hPXFfPVV035ZL
         KoQw==
X-Gm-Message-State: APt69E2U3jubvUgsgGYwy0k6uKgOkHOuQtah2M+gtOjrsECugeQituyk
        98VDpaexGlbUmc6Y1caURtQae6GvHDg=
X-Google-Smtp-Source: AAOMgpcb0s1exyCr9HwDvt4vNIpJK7VsWfhkN1Yy/li1uPSKY4yNGw5a+CZ+xMDKgT7gQCab33Fehw==
X-Received: by 2002:a1c:ce0a:: with SMTP id e10-v6mr5791945wmg.135.1530463843328;
        Sun, 01 Jul 2018 09:50:43 -0700 (PDT)
Received: from [192.168.0.103] (p5B3F6705.dip0.t-ipconnect.de. [91.63.103.5])
        by smtp.gmail.com with ESMTPSA id w24-v6sm4873951wmc.15.2018.07.01.09.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 09:50:42 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] arm64: dts: actions: Enable clock controller for
 S700
To:     Stephen Boyd <sboyd@kernel.org>, afaerber@suse.de
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, manivannan.sadhasivam@linaro.org, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <20180628191805.3722-2-sravanhome@gmail.com>
 <153029379879.143105.2037926027438984922@swboyd.mtv.corp.google.com>
From:   Saravanan Sekar <sravanhome@gmail.com>
Message-ID: <149ebcc4-1430-37a6-e222-4328e8481df9@gmail.com>
Date:   Sun, 1 Jul 2018 18:50:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <153029379879.143105.2037926027438984922@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 06/29/18 19:36, Stephen Boyd wrote:
> Quoting Saravanan Sekar (2018-06-28 12:18:03)
>> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
>> index ef79d7905f44..28f3f4a0f7f0 100644
>> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
>> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
>> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
>> index 66dd5309f0a2..3530b705df90 100644
>> --- a/arch/arm64/boot/dts/actions/s700.dtsi
>> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> Can the above part be split from the below part? I don't want to merge
> dts bits into clk tree, when those should normally go through arm-soc.
Sure I will spilt into bindings commit
>> diff --git a/include/dt-bindings/clock/actions,s700-cmu.h b/include/dt-bindings/clock/actions,s700-cmu.h
>> new file mode 100644

