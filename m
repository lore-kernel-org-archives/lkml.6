Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3786AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079422086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPcdA1Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfARIMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:12:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34875 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfARIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:12:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so6033542plo.2;
        Fri, 18 Jan 2019 00:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ppq7NT2cXfi405H1vGpRF/BnaUgG7iU0cC1QzEFgu1g=;
        b=gPcdA1RoIevKvvyjsb2c5Nw4DdwZk6KafnNJwqEK/XhGvGahWO2Sn2lEuKAJNrOC8M
         HKF5Po4kTF1p2skYBa8a+4O+TEPfGR8xX0NkyGKx0qqpxw7xPzfBgxmec8y29Ok1xSgO
         tuXmUcC+xX0dUVe3M9GFNtIE+3uh0zB9zPeRUoW32FHCgUsitfO0luxYmo+Ps9zlEHPu
         EK0IjBHa2G+wwswq67TcNS/ZjUC2x2LpmufBMZeVR/ge384hhi4z09X4lhq9DXHqG6ru
         LQDo5J4Zy37JRD7GwM9/mNU2PdqSaH+vdnUGa+50FWl7Ca1nVTBYoPKIbEiglCJFwhW9
         hgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ppq7NT2cXfi405H1vGpRF/BnaUgG7iU0cC1QzEFgu1g=;
        b=JEHd97MNElmRQcinoDO7rHoH5cjhiy98wxcP//1NgbbU+7YWfOSSqH35qACm6UjgtZ
         ++8Ky/9BkwfpHhPYniRY7LIouhSlGQLgTjP46Zv/359GYTPWHytq/yzJyXjGzAPpc0IR
         u1Be8oOXDcTAzzO8KdCXL0dD8BxbpD/jx1IzAJOgPOLokaJh+aV445T5G6Tz3n32vF0s
         WosdDHiQjafd0Tr1jVVmnkbED9BtFYj+sejDP7hsUjnKBff/sQtx0ANp04oXgorWt0BV
         000iyPfaoZY/eflWGjgUGkXbcOzXqh4/VpiOxN7h3BfarQDRN4V8LghxH3619owKeS8O
         NbfQ==
X-Gm-Message-State: AJcUukexOi3UJfhgobVI5nDVb/z1+hh/Bma141mAhFEjwHD/ax0ba8kC
        XJpKAm0piCxiqK4FClpHpt0=
X-Google-Smtp-Source: ALg8bN5UnyeWuUHBVl4ihG8PATtfdHjFx8V2cYvgqTV5w2gAXTUZhfCK0HX0RLS/w25992DnNZs7Gw==
X-Received: by 2002:a17:902:5601:: with SMTP id h1mr18704090pli.160.1547799152786;
        Fri, 18 Jan 2019 00:12:32 -0800 (PST)
Received: from [192.168.42.184] ([103.44.164.150])
        by smtp.gmail.com with ESMTPSA id i5sm7014667pfg.34.2019.01.18.00.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 00:12:32 -0800 (PST)
Subject: Re: [PATCH v6 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
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
 <dc043bfe-7a56-9810-1e5e-802f8b6beee2@gmail.com>
 <CAMuHMdWwvY=4NgoJmjfpOnetNwxPWqCsH-k-y5FqrbRif_PB7g@mail.gmail.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <33f0ea16-1b87-1aae-e5b7-531182008d6d@gmail.com>
Date:   Fri, 18 Jan 2019 09:12:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWwvY=4NgoJmjfpOnetNwxPWqCsH-k-y5FqrbRif_PB7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 9:10 AM, Geert Uytterhoeven wrote:
> Hi Marek,
> 
> On Fri, Jan 18, 2019 at 9:08 AM Marek Vasut <marek.vasut@gmail.com> wrote:
>> On 1/18/19 9:03 AM, Geert Uytterhoeven wrote:
>>> On Fri, Jan 18, 2019 at 6:55 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> 
>>>> +Example:
>>>> +
>>>> +       rpc: rpc@ee200000 {
>>>> +               compatible = "renesas,rcar-gen3-rpc";
>>>
>>> compatible = "renesas,r8a7795-rpc," renesas,rcar-gen3-rpc";
>>
>> Without the extra comma after r8a7795-rpc, of course ;-)
> 
> Let's move it after the closing double quotes. Would that be OK for you? ^-)

Ack

-- 
Best regards,
Marek Vasut
