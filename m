Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9386CC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C86620877
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 10:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YFWluSXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C86620877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754549AbeGIKai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 06:30:38 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39673 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754425AbeGIKag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 06:30:36 -0400
Received: by mail-oi0-f68.google.com with SMTP id d189-v6so34904209oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rOeBaU7BcuIfjNr/2lPDr8PlckZXkAFicRQJef1PNzM=;
        b=YFWluSXsCE1QusBtSFpWD7ExObNiTtMBScXUkQMEpAwq8hi55zJhTI/QyHT+LI6RJ7
         lmLJEaBGwlXuW1+LXreYhzhNt47YsKo9DIEcprNZbVTk4qr1vFf1l7OuYwNT7ctj84Tv
         laksbGsEV6n3Wyk6IAL0YiBxWpbNU8FqXUi4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rOeBaU7BcuIfjNr/2lPDr8PlckZXkAFicRQJef1PNzM=;
        b=pzBF0lxOhebnZDrvX3efDpXnljdj6a+B6c+QozQoNsrluIY+MBOPGfrvEVsFXTkeEL
         GkJ0HQD6RnpthneFEllmpYN/k4wI5QRfPsTNOX9FqOQOZWqSiq48T70W1nEylGM3Q+sG
         glHuAuEDNGOaS28mnjaVyMquaps5H66FszjaYVCKj9ZiLxOjSrFVozgO7pE6k0+v+2bu
         UQPNyDu4LkV91D9E3j3m4BssHqdnf3cH6+0uObtCDVzJndtr3WmY7fAlfHu3f5M6Rjy4
         KmfQ683LLrUb5Q+BuSHU3SCQLJRHbt/TLYTKhTCWtQcZQmq5rmVKcwahA58MLsB0wpnm
         Radw==
X-Gm-Message-State: APt69E3PH6mEpDgknorPEX89T5oqgwJbPGB7zHVGGENIIU9u/wIThdoY
        4kRwql48BYvEpVAyrx7ly42T7BCMK1zCK02JwmvE9w==
X-Google-Smtp-Source: AAOMgpdM0cTX9W7pBIO6YTm86MHOn5uShwwRzc5TaWDm3kwsRvqKTh5M4SDNu5XA25tnfUTsVcmJ5ieBJa2JDNOztXI=
X-Received: by 2002:aca:bb56:: with SMTP id l83-v6mr23289033oif.42.1531132236041;
 Mon, 09 Jul 2018 03:30:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 03:30:35 -0700 (PDT)
In-Reply-To: <068e3671-2624-7e16-7387-185e688cb6ed@linaro.org>
References: <a469ed55cb7c43901eaa8881cdd2a8845616d987.1529908086.git.baolin.wang@linaro.org>
 <d49c27421b2166dc5d535fb448e6cc11475a2a79.1529908086.git.baolin.wang@linaro.org>
 <CAMz4kuLWAT0aXy=xNPaeBDdixZCxUoE+joWsLMXb6MrmRiBr1Q@mail.gmail.com> <068e3671-2624-7e16-7387-185e688cb6ed@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 9 Jul 2018 18:30:35 +0800
Message-ID: <CAMz4kuKBxxJwbezu6RY23HBQG7jBCFPPVvb5nAkYnKZTT=r44w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] nvmem: Add Spreadtrum SC27XX efuse support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>, freeman.liu@spreadtrum.com,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 July 2018 at 17:41, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 09/07/18 10:26, Baolin Wang wrote:
>>
>> Hi Srinivas,
>>
>> On 25 June 2018 at 14:31, Baolin Wang<baolin.wang@linaro.org>  wrote:
>>>
>>> From: Freeman Liu<freeman.liu@spreadtrum.com>
>>>
>>> This patch add the efuse driver which is embeded in Spreadtrum SC27XX
>>> series PMICs. The sc27xx efuse contains 32 blocks and each block's
>>> data width is 16 bits.
>>>
>>> Signed-off-by: Freeman Liu<freeman.liu@spreadtrum.com>
>>> Signed-off-by: Baolin Wang<baolin.wang@linaro.org>
>>> ---
>>> Changes since v1:
>>>   - Fix one typo.
>>> ---
>>
>> Do you have any comments for this patch set? Thanks.
>
> Thanks for your patience!
>
> These patches look good!, Normally I tend to send nvmem patches to Greg K.H
> just before rc5! I will queue them by end of this week!

Thanks.

-- 
Baolin Wang
Best Regards
