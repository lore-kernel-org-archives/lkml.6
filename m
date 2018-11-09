Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82848C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C5820825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 20:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C5820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeKJFmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 00:42:03 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:50572 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeKJFmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 00:42:03 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 5377519F5BC;
        Fri,  9 Nov 2018 20:59:47 +0100 (CET)
Subject: Re: [PATCH v3 5/9] arm64: defconfig: Replace PINCTRL_MT7622 with
 PINCTRL_MTK_MOORE
To:     Matthias Brugger <matthias.bgg@gmail.com>, arm-soc <arm@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
 <cb016b53-906a-adec-d8c6-019d2c74569b@free.fr>
 <f4cd05f5-3b97-6167-ef42-5b4af41681c0@gmail.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <a098095c-fda2-92f2-73ec-0da3b4464f3c@free.fr>
Date:   Fri, 9 Nov 2018 20:59:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <f4cd05f5-3b97-6167-ef42-5b4af41681c0@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 14:03, Matthias Brugger wrote:

> On 09/11/2018 02:03, Marc Gonzalez wrote:
>
>> Commit e78d57b2f87c ("pinctrl: mediatek: add pinctrl-moore that
>> implements the generic pinctrl dt-bindings") made PINCTRL_MT7622
>> depend on PINCTRL_MTK_MOORE.
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>> ---
>>  arch/arm64/configs/defconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 6fe418d72337..725b9471b21c 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -369,7 +369,7 @@ CONFIG_PINCTRL_MSM8994=y
>>  CONFIG_PINCTRL_MSM8996=y
>>  CONFIG_PINCTRL_QDF2XXX=y
>>  CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
>> -CONFIG_PINCTRL_MT7622=y
>> +CONFIG_PINCTRL_MTK_MOORE=y
> 
> This would disable pinctrl for mt7622, I don't think that is what we want.

I don't think so, because PINCTRL_MT7622 is "default y"

I compared the .config files before and after the patch series
to make sure no option changed unexpectedly.

Regards.
