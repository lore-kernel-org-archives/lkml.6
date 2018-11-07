Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D87C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FBC20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FBC20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeKHEgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 23:36:53 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:54039 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725727AbeKHEgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 23:36:53 -0500
Received: from null ([172.19.246.153]) by mrelayeu.kundenserver.de (mreue108
 [213.165.67.113]) with ESMTPSA (Nemesis) id 1MQeDw-1g7rfE251K-00NgCl; Wed, 07
 Nov 2018 20:04:46 +0100
Date:   Wed, 7 Nov 2018 20:04:44 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     matthias.bgg@kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org
Cc:     pmladek@suse.com, Matthias Brugger <mbrugger@suse.com>,
        eric@anholt.net, geert+renesas@glider.be,
        bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rjui@broadcom.com,
        sbranden@broadcom.com, f.fainelli@gmail.com,
        linux-rpi-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org
Message-ID: <1393364689.141956.1541617484605@email.ionos.de>
In-Reply-To: <20181021215848.5827-1-matthias.bgg@kernel.org>
References: <20181021215848.5827-1-matthias.bgg@kernel.org>
Subject: Re: [PATCH] thermal: bcm2835: enable hwmon explicitly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:tdrabfo1AwHTk8y9NAE17+47cPlfwj35Re8XALLAVZiqmJ5sh0S
 G9xt+7sJA3zQwrpWSHbLpzL0QpUCJdko/tjJ1BsmbRCvnrDBg7PmtvEw3Dywo2Jlh1e3nth
 LjNz6MJP+O/z3dfMC5X3moYm8e1Ad3cDiiGPaLQ2qiMVi/l34/qo1PbCMHBtWbKtQW4vcqG
 VAeRHXlOmvqTSmw7BphQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:apzc+Hhd1KQ=:arDIL81sM1GYF3TLhzeO7w
 c832GfvpBvAt4pFX8MrFYqXH8gwY4791JvVMzWucv9o+QH2p26NtI3mvmlwmG732KQC304rf4
 17Ut1QzC32GmoQnj91kP8fnE0gRc/9mnV8ngDWZoJjGj0UJc9bQGRyHX8s2VTKeGhW63BmXlg
 V6i2xVRG0lUTErit0fkM2rGiz6YteqAy60dQAV04eo8wXXY1ZF40e+WV1Tj2ZKZp+Vf8U4Eun
 i6pwYSOZwbWAMuUDz+gYTxb273jsVipGqWzvhbEIPALvydvBp7ar/YHR340A5WvL/sZh0VW1U
 RC6j55KN0SFGFqBF0iOIvJuIYQAeb+/5QFFP8tnby/CWh9BimY1cvCcyMhcKlRKAc9oloZmjL
 VakvkJItzmKsXXeXdLBl/07dS6YSfzYXbeh+ozYZbTMh30odqymYowDBS9knoH8e00mSa2zgX
 td7fP1k/m4zuKYSLH5XGnJX11yQhbb8U66YhXPGhIjCUV2xTYz0DoVzQtnQ5r5+9PTeRPGGFH
 bA5zH3pp8HMu8Pw+/3Zg6Ww09/8FpJTpPq5kV60C/pVVAb1IbXOq/bcDvGG2gynJLPUvtBo2o
 i+pdGhFAPWu8NoOm+3oKYRzivbPf1bQQAvbIe1GEsXHvP4+8mbJFKEpTMX4+cLe/7kp0SsDz4
 1FGzE2yH8XeEaLElUzmonq0kWjS8JFWgmPivV2Vxq01xHkIPJ8o4Nkh+m8ZrMHWFIF5XlWHVy
 S1VnmbpMIPKnGWM0+1OVkdWyjph29E2ojdTXkSZkN3CzrmZwDM/0Fdh/n9dkOzL9jyz134ez5
 5+xNuUjZex730Eb613kdZlHErp6lV1HpBUUg8d/p8jUArZzFU8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,
hi Eduardo,
hi Daniel,

> matthias.bgg@kernel.org hat am 21. Oktober 2018 um 23:58 geschrieben:
> 
> 
> From: Matthias Brugger <mbrugger@suse.com>
> 
> By defaul of-based thermal driver do not enable hwmon.
> This patch does this explicitly, so that the temperature can be read
> through the common hwmon sysfs.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---

any objections except of the missing t in default?

Stefan
