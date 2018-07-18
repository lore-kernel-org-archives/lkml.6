Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A18CECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8AD2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHuODB6r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A8AD2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbeGRPgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:36:12 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42683 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbeGRPgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:36:12 -0400
Received: by mail-pf0-f196.google.com with SMTP id l9-v6so2331327pff.9;
        Wed, 18 Jul 2018 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nq51BrPwe1daJGoFWhW9/6BO+3gUd7vQEeg8W7aXAoE=;
        b=MHuODB6r1pRBCvpt3Ba0X+nA5kUTSPonvsM3THq05aaqBDgAW6tz/PtwFRg2bYMNVt
         jS5zg/K+EBledbvdLHaKfn2PwvwMKknKjMRAIGNBlzA/XHrb0lJrY5pMvyX7KfPLlUCY
         h+Awsm2bnUv4N8qi4MIs3RwFThCRFykrwurpweC9YqA7+nELfES6UHm12T8Q91GmB0q4
         zUkylK3grisKSoOjpPE1WCCEeXTiCG6VmH3XpQHM38HKmR/kfo2cs3kwSllDiTA/NLqG
         wf/UoAMbVj9th3bbauFgkjkBkjq88FrYCjmc67wJx9iYdGIJwL0XmuNKbZLQdp4x2qTf
         WNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nq51BrPwe1daJGoFWhW9/6BO+3gUd7vQEeg8W7aXAoE=;
        b=HmUAU4gQuhbJkzvRh4TXYRg8P7cod0sCWTj1xgEpn7pItEJLPxoSyp8rljG0y/Vex/
         T1GwdjJWkar7EtRISyayqcb9zFZk9YVu+tjJ879zUvbEhHUAoBEVmkdrnsCOBsN+WnDM
         hdB3tmMvA9puKH2R1TYb16I23Aue00gjMf+5+z2XfmkZLBIugBMFnKMSS93BIY2wHOWs
         qQrlouA5Lm5Iug5UOxSBC7so4DgPq+qFekbnaIoN1kvNoNg+ekNElsxc6sGXtv18GHJc
         do7unggpSWr6AEXcbrG+0p6AAUN0/O0rxRzan2y78qSS/14Bpg95R/WVk3nNlNAT2lUz
         7N/Q==
X-Gm-Message-State: AOUpUlEaNuXFNJ7AO4A9tfj6zMTQy8TxPkbkbvKRYb6PyOxlQ0CkDDR2
        VuK7ILS7imnS5Ll3ODK6qDM=
X-Google-Smtp-Source: AAOMgpc6G4dh3eAWfJXo4yknCgGhd5w+PS1VjkRlBmOmE6eOvvmfTVMqZgx/TDgd3BBUxdRW6G79Cg==
X-Received: by 2002:a63:da04:: with SMTP id c4-v6mr5856030pgh.398.1531925873810;
        Wed, 18 Jul 2018 07:57:53 -0700 (PDT)
Received: from ziggy.stardust ([37.223.136.20])
        by smtp.gmail.com with ESMTPSA id h69-v6sm18554021pfh.13.2018.07.18.07.57.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 07:57:52 -0700 (PDT)
Subject: Re: [resend PATCH v4 3/5] clk: mediatek: mt8173: switch mmsys to
 platform device probing (fwd)
To:     Julia Lawall <julia.lawall@lip6.fr>, matthias.bgg@kernel.org
Cc:     ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
        ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, lee.jones@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        rdunlap@infradead.org, pi-cheng.chen@linaro.org,
        sean.wang@mediatek.com, linux-clk@vger.kernel.org,
        linux@armlinux.org.uk, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>, kbuild-all@01.org
References: <alpine.DEB.2.20.1807181651360.3113@hadrien>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSlNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPsLBkgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyyc7BTQRT9gkSARAApxtQ4zUMC512
 kZ+gCiySFcIF/mAf7+l45689Tn7LI1xmPQrAYJDoqQVXcyh3utgtvBvDLmpQ+1BfEONDWc8K
 RP6Abo35YqBx3udAkLZgr/RmEg3+Tiof+e1PJ2zRh5zmdei5MT8biE2zVd9DYSJHZ8ltEWIA
 LC9lAsv9oa+2L6naC+KFF3i0m5mxklgFoSthswUnonqvclsjYaiVPoSldDrreCPzmRCUd8zn
 f//Z4BxtlTw3SulF8weKLJ+Hlpw8lwb3sUl6yPS6pL6UV45gyWMe677bVUtxLYOu+kiv2B/+
 nrNRDs7B35y/J4t8dtK0S3M/7xtinPiYRmsnJdk+sdAe8TgGkEaooF57k1aczcJlUTBQvlYA
 Eg2NJnqaKg3SCJ4fEuT8rLjzuZmLkoHNumhH/mEbyKca82HvANu5C9clyQusJdU+MNRQLRmO
 Ad/wxGLJ0xmAye7Ozja86AIzbEmuNhNH9xNjwbwSJNZefV2SoZUv0+V9EfEVxTzraBNUZifq
 v6hernMQXGxs+lBjnyl624U8nnQWnA8PwJ2hI3DeQou1HypLFPeY9DfWv4xYdkyeOtGpueeB
 lqhtMoZ0kDw2C3vzj77nWwBgpgn1Vpf4hG/sW/CRR6tuIQWWTvUM3ACa1pgEsBvIEBiVvPxy
 AtL+L+Lh1Sni7w3HBk1EJvUAEQEAAcLBXwQYAQIACQUCU/YJEgIbDAAKCRDZFAuyVhMC8Qnd
 EACuN16mvivnWwLDdypvco5PF8w9yrfZDKW4ggf9TFVB9skzMNCuQc+tc+QM+ni2c4kKIdz2
 jmcg6QytgqVum6V1OsNmpjADaQkVp5jL0tmg6/KA9Tvr07Kuv+Uo4tSrS/4djDjJnXHEp/tB
 +Fw7CArNtUtLlc8SuADCmMD+kBOVWktZyzkBkDfBXlTWl46T/8291lEspDWe5YW1ZAH/HdCR
 1rQNZWjNCpB2Cic58CYMD1rSonCnbfUeyZYNNhNHZosl4dl7f+am87Q2x3pK0DLSoJRxWb7v
 ZB0uo9CzCSm3I++aYozF25xQoT+7zCx2cQi33jwvnJAK1o4VlNx36RfrxzBqc1uZGzJBCQu4
 8UjmUSsTwWC3HpE/D9sM+xACs803lFUIZC5H62G059cCPAXKgsFpNMKmBAWweBkVJAisoQeX
 50OP+/11ArV0cv+fOTfJj0/KwFXJaaYh3LUQNILLBNxkSrhCLl8dUg53IbHx4NfIAgqxLWGf
 XM8DY1aFdU79pac005PuhxCWkKTJz3gCmznnoat4GCnL5gy/m0Qk45l4PFqwWXVLo9AQg2Kp
 3mlIFZ6fsEKIAN5hxlbNvNb9V2Zo5bFZjPWPFTxOteM0omUAS+QopwU0yPLLGJVf2iCmItHc
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <4a62b859-7d57-4901-d13f-5c5a9de8588c@gmail.com>
Date:   Wed, 18 Jul 2018 16:57:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1807181651360.3113@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/07/18 16:53, Julia Lawall wrote:
> Hello,
> 
> Please check on whether the kfree in the remove function is still needed.
> Also the platform_driver structure has two probe fields.

Fair enough, kfree(private) is not needed, because it is allocated with
devm_kzalloc.

I'll fix both errors. Thanks for noting.
Matthias

> 
> julia
> 
> ---------- Forwarded message ----------
> Date: Wed, 18 Jul 2018 22:31:13 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: Re: [resend PATCH v4 3/5] clk: mediatek: mt8173: switch mmsys to
>     platform device probing
> 
> In-Reply-To: <20180717220328.792-4-matthias.bgg@kernel.org>
> References: <20180717220328.792-4-matthias.bgg@kernel.org>
> TO: matthias.bgg@kernel.org
> 
> Hi Matthias,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on sof-driver-fuweitax/master]
> [also build test WARNING on v4.18-rc5 next-20180718]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/matthias-bgg-kernel-org/arm-arm64-mediatek-Fix-mmsys-device-probing/20180718-191916
> base:   https://github.com/fuweitax/linux master
> :::::: branch date: 3 hours ago
> :::::: commit date: 3 hours ago
> 
>>> drivers/clk/mediatek/clk-mt8173.c:1195:1-6: WARNING: invalid free of devm_ allocated data
> --
>>> drivers/clk/mediatek/clk-mt8173.c:1200:48-49: probe: first occurrence line 1201, second occurrence line 1202
> 
> # https://github.com/0day-ci/linux/commit/112857d0f58413a87875dfc9e1b43fdfde3b55eb
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 112857d0f58413a87875dfc9e1b43fdfde3b55eb
> vim +1195 drivers/clk/mediatek/clk-mt8173.c
> 
> 112857d0 Matthias Brugger 2018-07-18  1189
> 112857d0 Matthias Brugger 2018-07-18  1190  static int mtk_mmsys_remove(struct platform_device *pdev)
> 112857d0 Matthias Brugger 2018-07-18  1191  {
> 112857d0 Matthias Brugger 2018-07-18  1192  	struct mtk_mmsys_priv *private = platform_get_drvdata(pdev);
> 112857d0 Matthias Brugger 2018-07-18  1193
> 112857d0 Matthias Brugger 2018-07-18  1194  	kfree(private->clk_data);
> 112857d0 Matthias Brugger 2018-07-18 @1195  	kfree(private);
> 112857d0 Matthias Brugger 2018-07-18  1196
> 112857d0 Matthias Brugger 2018-07-18  1197  	return 0;
> 29859d93 James Liao       2015-05-20  1198  }
> 112857d0 Matthias Brugger 2018-07-18  1199
> 112857d0 Matthias Brugger 2018-07-18 @1200  static struct platform_driver clk_mt8173_mm_drv = {
> 112857d0 Matthias Brugger 2018-07-18 @1201  	.probe = mtk_mmsys_probe,
> 112857d0 Matthias Brugger 2018-07-18 @1202  	.probe = mtk_mmsys_remove,
> 112857d0 Matthias Brugger 2018-07-18  1203  	.driver = {
> 112857d0 Matthias Brugger 2018-07-18  1204  		.name = "clk-mt8173-mm",
> 112857d0 Matthias Brugger 2018-07-18  1205  	},
> 112857d0 Matthias Brugger 2018-07-18  1206  };
> 112857d0 Matthias Brugger 2018-07-18  1207  module_platform_driver(clk_mt8173_mm_drv);
> 29859d93 James Liao       2015-05-20  1208
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
