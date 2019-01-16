Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB73C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6554320859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A9yfAR5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbfAPAOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 19:14:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41547 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730376AbfAPAO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 19:14:28 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so2098435pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 16:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZA20ebCNbHqeH+NvZr746IlKnzu2haXNYszOlgma2HQ=;
        b=A9yfAR5h0fZfr9gAbSLybL81lgfUym/wQcT6X0/PAHuGeU2zHXqxCwvF/kacUe9ONz
         VIUYQyCgTAtp73Z1J8IVcwL9FxkLYdxWYVVa1WekbPiXXpyiy0e7HnAs7UoADDnX0cVO
         yxDOuJb1LtV5cLOIdw8UKDTy3AwE/tWhG3amM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZA20ebCNbHqeH+NvZr746IlKnzu2haXNYszOlgma2HQ=;
        b=FDUThJh7MNdrewC4PXTy9arD4BcSigPZK8Lai26FUIeMQOaEUmjArVStRIoi5OeCTs
         hPR0yhHeejTWrefnAweiYw/c1gjjveQX+ygN4JuoWSDdDKaJBsFKWAaj7W9MbXBaq+G6
         aodfVJIfVd21bZRP3CWXKYuijdwxvtlVWmVEfO6CEt61b++qBSacaG/p2jYbQ45Na/fh
         O72nAOpD69g/26xnh5JX194Hm7p4q0Gl6dkoz4BgNJjiJcAHPt4pa/FxBFWCMdyFKCos
         YkOwOASSQH1GjNAYbTiWEe9lSuM5v1f23aFivBCmaBSeMogWvVAdct6LwpG9XcINwEcy
         R/QQ==
X-Gm-Message-State: AJcUukds82Y0eaQcg50HC4ktBWKMEHla7Ly+eaIgawt3rNvnBW/0nbvf
        3uS0eNcoi8jfy3TA3AlbHRhuDA==
X-Google-Smtp-Source: ALg8bN521l1NRwW8yuyctaZqkY8KD2IwR4iVboInTLhR3OIAgolSZCAy6yn2Cgok3Fd56d1DnbsVmg==
X-Received: by 2002:a63:1013:: with SMTP id f19mr6251463pgl.38.1547597666850;
        Tue, 15 Jan 2019 16:14:26 -0800 (PST)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id d18sm5194007pfj.47.2019.01.15.16.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 16:14:25 -0800 (PST)
Subject: Re: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Praveen Kumar B <praveen.b@broadcom.com>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
 <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
 <f1ec3121-a8e7-a1c0-008a-ea4ae6028157@broadcom.com>
 <20190112150515.i7mwq7rtd62wlifh@pengutronix.de>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <faadc46d-94b5-a32c-79ae-4206fbc26608@broadcom.com>
Date:   Tue, 15 Jan 2019 16:14:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190112150515.i7mwq7rtd62wlifh@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On 2019-01-12 7:05 a.m., Uwe Kleine-König wrote:
> Hello Scott,
>
> On Fri, Jan 11, 2019 at 01:28:45PM -0800, Scott Branden wrote:
>> On 2019-01-11 12:48 p.m., Uwe Kleine-König wrote:
>>> On Fri, Jan 11, 2019 at 10:51:14AM +0530, Sheetal Tigadoli wrote:
>>>> From: Praveen Kumar B <praveen.b@broadcom.com>
>>>>
>>>> Add new compatible string for new version of pwm-kona
>>>>
>>>> Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
>>>> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>>>> Reviewed-by: Scott Branden <scott.branden@broadcom.com>
>>>> Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
>>>> index 8eae9fe..d37f697 100644
>>>> --- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
>>>> +++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
>>>> @@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
>>>>    This controller has 6 channels.
>>>>    Required Properties :
>>>> -- compatible: should contain "brcm,kona-pwm"
>>>> +- compatible: should contain "brcm,kona-pwm" or "brcm,kona-pwm-v2"
>>> Is v2 used on a newer generation of kona SoCs? On i.MX these variants
>>> are usually named after the first SoC that came with the new variant. Is
>>> this sensible here, too?
>> It doesn't make as much sense here as different revs of the IP block are
>> picked up based on various decisions.
>>
>> A new SoC could decide to use an old version.
> IMHO this is no reason to not use the name of the oldest SoC with this
> variant. I don't know how the SoC names are in the broadcom family, but
> if they were (in order of age, oldest first):
>
> 	ant
> 	bear
> 	crocodile
>
> and ant and crocodile use the same IP block we would have
>
> a) with v1, v2:
>
> 	ant:
> 		compatible = "brcm,kona-pwm-v1";
> 	bear:
> 		compatible = "brcm,kona-pwm-v2";
> 	crocodile:
> 		compatible = "brcm,kona-pwm-v1";
>
> ; and
>
> b) with the SoC naming:
>
> 	ant:
> 		compatible = "brcm,kona-ant-pwm";
> 	bear:
> 		compatible = "brcm,kona-bear-pwm";
> 	crocodile:
> 		compatible = "brcm,kona-crocodile-pwm", "brcm,kona-ant-pwm";
>
> (If you want, drop "brcm,kona-crocodile-pwm", but keeping it is more
> defensive.)
>
> I like b) (with "...-crocodile-...") better than a). crocodile using
> "...-ant-..." is not more ugly than crocodile using "...-v1". This is
> also a tad more robust because if broadcom releases kona-dolphin and
> someone finds a minor difference between the IPs used on ant and
> crocodile it depends on the order of these events who gets v3, while
> with the SoC naming the result is clear.
>
> (OK, and given that "brcm,kona-pwm" is already fixed, both approaches
> need slight adaption, but I guess you still get what I meant.)

Thanks for your thoughts and explanation.

It is unfortunate devicetree has no proper guidelines or documentation on

binding naming.  In the interest of getting this upstream we can name it

"brcm, omega-pwm".  We can drop kona from the binding name as that 
architecture

is really no more - only IP derived from it is - hence the name kona-v2 
previously.

>
> Best regards
> Uwe
>
>
Cheers,
Scott
