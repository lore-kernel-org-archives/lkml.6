Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256B0C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E898220815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 15:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731723AbfACP44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 10:56:56 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:46071 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731091AbfACP4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 10:56:55 -0500
Received: from [192.168.178.52] ([109.104.40.230]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MxE5Y-1hYHNZ3h16-00xZ5C; Thu, 03 Jan 2019 16:56:17 +0100
Subject: Re: [PATCH v4 0/5] BCM2835 PM driver
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20181212235150.6491-1-eric@anholt.net>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <7dde45e2-8e26-5051-dea6-da3566bb5e0e@i2se.com>
Date:   Thu, 3 Jan 2019 16:56:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212235150.6491-1-eric@anholt.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
X-Provags-ID: V03:K1:nnCIVsHC5iQW+EBjhvSdfBl3uDHf7k1up7g8vU4rhY1V658Se90
 jQzeKkmHMIU11fvB86ZH74oan5vrgDmqytYEXar8w+CGSObUf96HMFxZM7pdUdheMjpEaC9
 ickBHMvuzDOCfMmPz50Tq49N8emvE1mqvI44R2uKhBSnJo481QvJummr9JDObcAPKNsy9fx
 OHJWIabsJk0hlsRhKUULw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3DqAjtG1nc8=:bOi76EcKcmABfiCfyGOlqN
 RbAy5h+XDnhsCFrT7I3mlIG1KY8ewrb6N+8O81gTVTvsD8ksmGbu+up3eSoRUNO5kKWmy7ahj
 FZam5RHj1SwJDtBsB6efk5C/zqySKp1Ol7vG8ionZY8YSWFsRppNeDkwH0zxzPpNeYnMAspad
 dR6kBAR8y+Hm+so+x6mKarY5Z7gyPApd3bgemHL51AzAS7V5Y7ti9EuaNXBEPc/sgS/oQcVoj
 wm4q4Z1IPDahKQkRScN4qyxeYaib7sdEBy05Vqd8+GEmXVVmGKmaWKgWU3yyKXNtsEFWqKb1q
 oIBeMs6g7j8c3UYym+X1mMXE9YPgIX/wV0c2OShLw/g/TUZeuo7GcMi3GG+PctBM3TsGNfjPY
 QKM2aCmssolmDWJga5glF+UtuE1wMC3cDxHmTeBEaQ+4Ep9cQ/jp1qQLQhaFzuq2XBvIijoEy
 geYlHKN8myMGZO8s/+Ryd6kgGFftce04tNoL60F/MlAClwp3RCGWCfqq8SOos8Qu2oUM/Fbjx
 xZQu/8pxev5JlyQAlfPPtikdxygHdy5Beme5w8PDxxvfVkJezWd52SUJFSQJQhM4Doovh/hjN
 rmtsNAH7+yosI+qu1lyJEUMb2qXHRIkOasr3pcpS40JQc0TVZrHFKp+xot6Ns2Kjq7edk6o+W
 SmC6Tajj7+0ITkj04VVRrV1OQnQQ32zlGugtzaPAJPELgXOtBikYpKajrw99CU19dI2FFK5ni
 VwrjT44HfnrviCVKDtnFG9OPd8vRPz73XKp7XE2cBe4j60n47+iyTV4YuQM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Am 13.12.2018 um 00:51 schrieb Eric Anholt:
> v4 adds the system-power-controller node to the binding as requested
> by Stefan.  No driver changes are added to make the power controller
> behavior optional yet, since it's really unrelated to this series.
>
apologize for my late reply. This whole series is

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

I would take care of the power controller behavior with an incremental 
patch.

Should i also make patches to add the driver to the relevant defconfigs 
(bcm2835, multi_v7, arm64)?

Thanks
Stefan

