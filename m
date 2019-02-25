Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB679C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE2E2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9gjqnJJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfBYUh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:37:59 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:50488 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfBYUh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 15:37:59 -0500
Received: by mail-wm1-f47.google.com with SMTP id x7so297263wmj.0;
        Mon, 25 Feb 2019 12:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OlMfOERKozt0qCMopgmfdQ2h0YOTELN011HcmqzEV9s=;
        b=o9gjqnJJZ7PyKFRd/AhbVmlk0ALQg6hynrw1/yZPSPoeUI/0ZgcIInuEWdt/Ws3stV
         IpXDfvus0eNTR20XuIJ0D1kS4a5QKEfcVua57JaAMNClSwUlheQsAIIPB8UrP5+e7zEu
         6DgFn3Oc8Sa/gFKBIeCmku4UvtVXKxBVMc1aFhAz9eqPjpJ1qSKE6s5YoxCo1k3IiUMg
         Rmy62U77zPIICGnLkOcTks5jgYkaSFYDz/EyezLTbylcDij50GZ+iAjrFukRbPO3rSVL
         zoDQZ2xT/KXPDkK5YzHLaGEtnFFb3aAepxd3QDbLsA8asTAmf45Mr9GCo1N+iAXXUu+a
         7NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OlMfOERKozt0qCMopgmfdQ2h0YOTELN011HcmqzEV9s=;
        b=GmE8gb3YsAzFWccUHxX4RhcJPuSx20PzpmVcX16f4ciqKWbdtjqK4bs3SLwu/glFBs
         c3R7yJMeC8DG6DxS3fWl7PSIgu0o0ipOb5FmPY/pigZcHP9DVFb85Jik+3QnhtSs9p1H
         QA6iNufRQdpwTMfzcH/AWgU4abkFJ7TPvsGlt+Rbup4ieqCpM4bDETKBjNDGmnGl0uPB
         LWJ5gsVtdTJCgvRbq3QpElUwFv4OLcE4wVFJp1DA9KD9C7JCY87n1QqMfxDhoKW6Unr8
         7IGtzgU+M6YXufW8Y46spIOLNfcSxQp++zbfbABwpfSG4F1uDUcWc7j/wIyf6cLGJM4j
         z96g==
X-Gm-Message-State: AHQUAua7Qlxhaf1Gf5GSg/gs7Vz6MIr0FdESoxWeDswHmlhEdt4WOWlc
        li4bw2Ir2C3weVYkvHzejJk=
X-Google-Smtp-Source: AHgI3Iat2Vez/Yw8eQjcbBw0HXd/LW7bK4USr5BGZCbAyMoNRDQPiRHrX4XxQBKhmocYaD3FGT4uqw==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr380532wmd.110.1551127077093;
        Mon, 25 Feb 2019 12:37:57 -0800 (PST)
Received: from ?IPv6:2a02:810d:340:17ec::1b62? ([2a02:810d:340:17ec::1b62])
        by smtp.gmail.com with ESMTPSA id v6sm13268375wrd.88.2019.02.25.12.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 12:37:56 -0800 (PST)
Subject: Re: Allwinner SID THS calibration data cell representation?
To:     Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Emmanuel Vadot <manu@bidouilliste.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-iio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-28-embed3d@gmail.com>
 <20180904184623.e4386b8e6b657b1b25e90c09@bidouilliste.com>
 <55579dd6-625d-e71b-1482-4592dccac665@gmail.com>
 <20180906115114.inc6dhqhy47obo25@flea>
 <CAGb2v65p0G83BVODsxxnXmiSCwuuwPFtY2k2ZV1F5xoFKrJjWQ@mail.gmail.com>
From:   Philipp Rossak <embed3d@gmail.com>
Message-ID: <dfbe9a71-ccab-2415-fe5b-6944df721bff@gmail.com>
Date:   Mon, 25 Feb 2019 21:37:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAGb2v65p0G83BVODsxxnXmiSCwuuwPFtY2k2ZV1F5xoFKrJjWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.02.19 08:54, Chen-Yu Tsai wrote:
> Sorry for resurrecting an old discussion, but since someone posted patches
> for H5 and H6, I thought we should resolve this. I'm working on patches to
> fix / replace the big-endian issue.
> 
> On Thu, Sep 6, 2018 at 7:51 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>>
>> On Thu, Sep 06, 2018 at 01:47:47PM +0200, Philipp Rossak wrote:
>>> On 04.09.2018 18:46, Emmanuel Vadot wrote:
>>>>> +                 /* Data cells */
>>>>> +                 thermal_calibration: calib@234 {
>>>>> +                         reg = <0x234 0x8>;
>>>>> +                 };
>>>>    You are declaring 8 bytes of calibration data but to my knowledge it's
>>>> only 2 bytes per sensor, so 2 bytes for H3.
>>>>    Am I missing something ?
>>>>
>>>>    Thanks,
>>>
>>> Emmanuel you are right, it is 2 bytes per Sensor and should be 2 bytes for
>>> H3, but the thermal calibration data field is on all chips 64 bit wide - so
>>> 8 bytes. So I'm reading here the complete calibration data field.
>>
>> Having one cell per channel would make more sense I guess.
> 
> Would it? The 2 32-bit words directly map onto the registers 0x74 / 0x78 in
> the THS. As far as the SID is concerned, their is just one consumer for this
> data, the thermal sensor. How the thermal sensor uses that data is really not
> its concern. And the thermal sensor is really just copying the data from the
> e-fuses into its registers. Nothing more.

Using 2 32-bit words for the THS would be also ok (from my perspective).
> 
> Furthermore, with the register access interface, the e-fuses are read/write
> 32 bits at a time. Seems to me it would make more sense to enforce a 32-bit
> word size, so cells should be multiples of 32 bits.
> 
For THS I'm ok with that.

> Regards
> ChenYu
> 
Regards,
Philipp
