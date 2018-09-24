Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D0DECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBA6214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD3cHRx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBA6214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbeIXUg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:36:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41112 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbeIXUg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:36:28 -0400
Received: by mail-wr1-f65.google.com with SMTP id j15-v6so15843019wrt.8;
        Mon, 24 Sep 2018 07:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=aBPKqR/n5BjqXnSvkqOsKROveni0783ITST5+Mc8ikQ=;
        b=nD3cHRx5c5TJ/+ABYsYVFIc4lwo7RoCO+QYVdJMfOHg5Isk0Gp6PIS273zlCL+zehW
         +/bmxcwpiu/Iye/xDua3uBSDbpVoe/V7vyhq8QcptdTtN42pKppE5dVTWkm5UGPvHZbu
         xWvdTc7m44oh706iQsIGjbzld/cYywPnx1J8Q35qnUwrb6RkVsycdUrWEIlArCDSKGsh
         Q1VuFJ3iApgwPsb0KBzRuCa55SFwOG46Pqq5FrtOuat2sGErUtKwWrZA5qLAeGNOrhs0
         WHfVSUtQuQoqpfZ8jxGvgg0KDT8NJRqD3nBIYF9WLkN3ltE4/+vT8TFgMNwxau4rNyIB
         URzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=aBPKqR/n5BjqXnSvkqOsKROveni0783ITST5+Mc8ikQ=;
        b=hKHeIzIR8fFuGYi9DN3pdJsHTJwHUHZCoCGT6Ty7iDK05O/8qGEgvTS6B6kxpqiiuZ
         x2ATQF3DWKeJnP9FmkzfgGpgvj4SuMp94EXa4po1V+tHbqu5UQTwjMtD8MsX4OIA4HSv
         Nw5EJdotHwy1dbpHUTsCqvXEcVE3VSq0kJ5xKm8shCOl5+Mg3iZoQb3bxA+Vd5i+iB78
         u0UzCYCcKya7d47Wc7z5qGEpQvXLIcswcRGPUaZpgHYLT4IsAFiVPxrASiUKEvdL+vQf
         DfN73SJ429pP3dRyNKeDXm7HugvR4G95fBZii7u5yTr/P+EaAGcHfwh+fPKaVB8EZ/1+
         G1iw==
X-Gm-Message-State: ABuFfojpjA8yVECB2zjPts9oPxjqcfMjMWubNlfmfEbKAdJMp8gY6zIr
        VtQ/sNUkCtSGT17mN9E8fg==
X-Google-Smtp-Source: ACcGV61hnGAOZ95fhCmO898sPbEac34nODFSXfDg4m4tX+EvXKCLBMhG2+fWMsp1xwY5Yr2GF4sTpg==
X-Received: by 2002:a5d:4b52:: with SMTP id w18-v6mr9012119wrs.87.1537799640062;
        Mon, 24 Sep 2018 07:34:00 -0700 (PDT)
Received: from android-dhcp-8-1-0-d4-38-9c-a2-1f-05.home (host86-147-9-252.range86-147.btcentralplus.com. [86.147.9.252])
        by smtp.gmail.com with ESMTPSA id 132-v6sm11759386wmd.13.2018.09.24.07.33.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 07:33:59 -0700 (PDT)
Date:   Mon, 24 Sep 2018 15:33:56 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <9156720.4hgryJ20kK@phil>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <69cf26ba-5dae-e84c-2fa8-15699fdd9986@codeaurora.org> <63F4E7C0-6925-4EC0-84B9-75B31AC664E4@gmail.com> <9156720.4hgryJ20kK@phil>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: qcom: Add Global Clock controller (GCC) driver for SDM660
To:     Heiko Stuebner <heiko@sntech.de>
CC:     Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org
From:   Craig <ctatlor97@gmail.com>
Message-ID: <0E2DD374-B1DA-47D9-B327-D5BBC39F7FBB@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24 September 2018 13:44:33 BST, Heiko Stuebner <heiko@sntech=2Ede> wrot=
e:
>Hi Craig,
>
>Am Montag, 13=2E August 2018, 09:45:09 CEST schrieb Craig Tatlor:
>> On 13 August 2018 07:55:34 BST, Taniya Das <tdas@codeaurora=2Eorg>
>wrote:
>> >Hello Craig,
>> >
>> >Could you please correct the authorship and also provide the
>reference=20
>> >to code where this is picked from?
>> Okay,=20
>> Got code from here
>https://github=2Ecom/sonyxperiadev/kernel/blob/aosp/LA=2EUM=2E6=2E4=2Er1/=
drivers/clk/qcom/gcc-sdm660=2Ec
>> but changed it quite a bit for upstream,
>> Should I change the commit author and add your signed off by and say
>I did cleanups on my signed off by=2E
>
>yep, for something this huge it is really the correct way to keep the
>original authorship intact as Taniya did the initial big work, and just
>add you change-description, so something like
>
>---- 8< ------
>Add support for the global clock controller found on SDM660
>based devices=2E This should allow most non-multimedia device
>drivers to probe and control their clocks=2E
>Based on CAF implementation=2E
>
>Signed-off-by: Taniya Das <tdas@codeaurora=2Eorg>
>[ description of changes =2E=2E=2E often seen in these brackets ]
>Signed-off-by: Craig Tatlor <ctatlor97@gmail=2Ecom>
>---- 8< ------
>
Sure, will do, though I'm sure qcom have a program to generate the drivers=
 :)

>Also, do you plan to continue working on this, as I would be
>interessted
>in the clock driver for a sdm660-based phone as well
Yup, was really just waiting for reply to this question,
>
>
>Thanks
>Heiko

--=20
