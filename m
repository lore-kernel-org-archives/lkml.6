Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87A0ECDE35
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8832086E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhFehsl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8832086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbeJQThH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:37:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43122 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeJQThH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:37:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id p34-v6so19519323lfg.10;
        Wed, 17 Oct 2018 04:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sN9X7L740FZrYuYJfMLztPC1DIlobjMOaUJhoF7YYcw=;
        b=WhFehsl5sa90Z8xNBGfts1rEggW56ePeLslTIxCzljDyocC8Q24XifZwMFYB37sdEe
         oq9KiymwuXeocAcQli8daHdvh6bQBIsTx7zgJ3Qj4HXH+PMDHWASkzOcmx2cGnKI79LK
         Lq+NRz/bL3KHV17Nj+8Gqekh/5pt/tVEaORzscUv0EfVuGgwMcKgSn2LwPmjNWwRnIJg
         0sptBPKQ6aXdkTrXFoDNrnUix5fCwfW71asCJRMoNr7K7oB/HgSM0GaK8g/bcrbxGEfI
         3oR+WlfAlee7LA98qCHzMkokQr4WLPPBNAaTAB5TMneqx/duDkmvXDAR9+6iRwGunm4c
         ct1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sN9X7L740FZrYuYJfMLztPC1DIlobjMOaUJhoF7YYcw=;
        b=W/3UFSc0O+Ig+bCQzUFrsvthmRZmDY2eAOv4u+onVRzUby4Q7Zsk8kBy+11L72vw/D
         QSXOAmgUmOVbxh5XPaAtBSttUhIPJjChY7IJJAAjPzzPQUsdGnjbI7wwZI+484WscESx
         rjs88gIgGRfjEVEWElWVmjXdlwp2QUnL5f528hPzpzhuoK5yUikEAGR7ZTci9OQklus9
         qAmHjUgGoYR1Cd6/+uVGjhq+IeiJdvORTD9N8wvDOR0ncMrfM2kYtrufrzISO4TJkNiW
         KzxpKUUIYcM/ISqhYNugqwDg2Zy+Ii7JHCjOzeQqPcgyGl8TZSywVAIZO0DFHtsjyqKe
         w57g==
X-Gm-Message-State: ABuFfojB9jk8waj1MU4buPWQm8Njh6IaThiIVFldW7PlOo78L7sdgk3P
        RCaFXzfYFOEUvykgjRAYm6XfC3Gt
X-Google-Smtp-Source: ACcGV611/z7I2HXyk7dW61AGoBXQylJLWdmZ76YGuvglVuEb3/G45FxtkofXlhiu9IJhJO0WxDYw9Q==
X-Received: by 2002:a19:274b:: with SMTP id n72-v6mr14920238lfn.153.1539776504537;
        Wed, 17 Oct 2018 04:41:44 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.118])
        by smtp.googlemail.com with ESMTPSA id 1-v6sm3975742ljc.46.2018.10.17.04.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 04:41:43 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] clk: tegra20: Enable lock-status polling for PLLs
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "pdeschrijver@nvidia.com" <pdeschrijver@nvidia.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "pgaikwad@nvidia.com" <pgaikwad@nvidia.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20180830184210.5369-1-digetx@gmail.com>
 <20180830184210.5369-2-digetx@gmail.com>
 <20180831092948.GP1636@tbergstrom-lnx.Nvidia.com>
 <1539773948.6233.23.camel@toradex.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2a011477-26cb-7e89-a468-54a84465f178@gmail.com>
Date:   Wed, 17 Oct 2018 14:41:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1539773948.6233.23.camel@toradex.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 1:59 PM, Marcel Ziswiler wrote:
> On Fri, 2018-08-31 at 12:29 +0300, Peter De Schrijver wrote:
>> On Thu, Aug 30, 2018 at 09:42:10PM +0300, Dmitry Osipenko wrote:
>>> Currently all PLL's on Tegra20 use a hardcoded delay despite of
>>> having
>>> a lock-status bit. The lock-status polling was disabled ~7 years
>>> ago
>>> because PLLE was failing to lock and was a suspicion that other
>>> PLLs
>>> might be faulty too. Other PLLs are okay, hence enable the lock-
>>> status
>>> polling for them. This reduces delay of any operation that require
>>> PLL
>>> to lock.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>
>>> Changelog:
>>>
>>> v2:	Don't enable polling for PLLE as it known to not being
>>> able to lock.
>>>
>>
>> This isn't correct. The lock bit of PLLE can declare lock too early,
>> but the
>> PLL itself does lock.
> 
> Is there an errata documenting this? As I could not really find any
> mentioning of this anywhere at least up to the v11 from Dec 21, 2010 I
> still have access to.
> 
> BTW: It looks like also PLLA may not always lock properly with those
> changes. Is there anything known about that as well? Here is what I get
> on various Colibri T20 modules (while random other ones seem to work
> fine):
Could you please try to increase the timeout value?
