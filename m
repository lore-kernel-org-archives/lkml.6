Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A028C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F0F2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 11:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B2ojaHyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F0F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405467AbeKVVnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:43:11 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:33809 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394429AbeKVVnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:43:11 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181122110416euoutp02b687241985e77557892c40b583050194~pbWuvznIG2689026890euoutp02R
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 11:04:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181122110416euoutp02b687241985e77557892c40b583050194~pbWuvznIG2689026890euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542884656;
        bh=GftZ+F38XTumm6J+6sBVBH5bC3uQ+5D1K5308OVxL4k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=B2ojaHykvIQ3+4s3OjxqZUn0/AQiAXP3x+5tlsypQzlMerVA5gRtRiV4ErIF9pf+H
         awgQiXF2Wl7tqzdr5MCpgeoss2p5C4ZrSRXgzMdWzRJwjaSawDTi8mMMlnKupW7b4D
         Vexybhry7NWS3jJCuh52QchpzokVTnOd3Ig7fHH0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181122110415eucas1p10b2ad80cccbb3b1c262a40889c4af455~pbWthHRpk1818918189eucas1p1j;
        Thu, 22 Nov 2018 11:04:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 14.AC.04806.E2D86FB5; Thu, 22
        Nov 2018 11:04:15 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181122110414eucas1p26fbfcebf705f7d2daf8c38817254d1d1~pbWssXi3b2164021640eucas1p2I;
        Thu, 22 Nov 2018 11:04:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181122110414eusmtrp149c182477c9056e9d97d4ab07998ab1b~pbWsorUAs1383613836eusmtrp1B;
        Thu, 22 Nov 2018 11:04:14 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-f7-5bf68d2ee407
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C3.1C.04128.E2D86FB5; Thu, 22
        Nov 2018 11:04:14 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181122110413eusmtip150ab34d1e22da3fd23ebad5f02697645~pbWryDu4J0720407204eusmtip1J;
        Thu, 22 Nov 2018 11:04:13 +0000 (GMT)
Subject: Re: [PATCH 6/6] arm: dts: exynos4: set opp-suspend for DMC and
 leftbus
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <985c35fb-d021-bbad-055b-af0618fa8c55@partner.samsung.com>
Date:   Thu, 22 Nov 2018 12:04:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5BF61DEB.5010403@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUzMcRz2vd9rcfp2XvosxnabeZtibL7GkJn9+MvLGM5w9NsVXXK/irym
        VOdULOa4vE2sXEec6zRU5LhR6tKuvCyZlxE1kSsNN67fmf57Ps/nefZ8nu++PKU6w0by8YnJ
        oiFRm6BmQ2nnw776KdF5PZqp9Y8RuVc+kVw/WcaQm9d7GNLy/QNDzrnqGZJZVMaSusN6cuTt
        Z4o0NFzjyJOMDo5YjlcqiP1tM0Oabp1mSXeeC5GTDVUKcsXVypFLLY0K8vJACUtaHz/46699
        ypCsShdHsku7GNLheUXPjxCct52MYDtrQ0JheiMtHD3yDQlFd9oVgt16iBWqz9g44cbF/YL/
        ISc4vDm0kO+wIqGktJcTuu1jlirXhs6JFRPiU0VD9NyNoXFdzV6UVBa+09JbRacjm9KEQnjA
        M6C7vYA2oVBehUsQfMqoCA7fEXR22oNDN4LWujrFP4vb85uVF8UIsn0eOrBQ4U4Ep3/HmBDP
        D8PLwOxJDWiG41oE1dU1/QYKZ1Hg73KwARGLo6DCuj3gVeJF0OG7SgUwjcdB9eUbTACPwKvB
        2FbKyppweHTqXX9WCJ4MbcZX/TyFI+DFu3MKGY+FzPJCKpAF+DUPb65ZaPnqhfArq5KT8TD4
        5HYE8WioPZYb1EjwxGhlZbwHch5VBDWz4b67kQncTOGJUHYrWqZjoC/f218F8FB41hkunzAU
        CpxmSqaVYMxWyeoJ4Mj1BJ9wJBTbTnBHkdoyoJhlQBnLgDKW/7nnEW1FEWKKpNeJ0vREcUeU
        pNVLKYm6qM3b9Hb099PW+t2+ClT1a1MNwjxSD1Gma3waFaNNldL0NQh4Sj1c2RTTo1EpY7Vp
        u0TDtg2GlARRqkGjeFododw96LVGhXXaZHGrKCaJhn9bBR8SmY7ytqxg95k/opyZ+7eW330f
        OWbOYn75PHPIXIuprb145wUjjC9oMTUsQZvzn/nzFn4p+Nxz826x3xnf7Fvs7UrTxc06fnC3
        t2/IlbCqcbYFPqo+ecG62JRUhvmaYV758/58LnPj4OnuJt/z1jBX1qoc95r32T/26qaso9cn
        5UarZvSqaSlOO20SZZC0fwBpiExrsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfO2Y7S6jhvr35IGwR2O3Pq9FVWFKSdD0FJgalELT2puTnd
        2SwjcKWmLUwt6TKtVSaY15qXSaWmTMXrLMsiUQuFFLWbpQUpOWbgt9/zPP/fAw88JCYyE95k
        UoqW1aQolGK+M9630j22i85fjPXvuShC7Y3b0NPbdQSyPF0k0Lufnwlksg4SKKusjo/6r6pQ
        weQshmy2JwI0cGlOgIzFLTxknhwh0PCzUj5ayLcCdNvWykM11jEBKn/3iodGL1bw0Vhv56rf
        95pAOS1WAbpc9Y1Ac0Pj+F5Ppul5E8FU36sGTIn+Fc4UFvwATNmLGR5jrrzCZ9ruVguY+keZ
        zEqXgGl4m4sz1xoqAVNRtSRgFsybDwtjaLlGrdOyvolqTrtbHCtFAbQ0FNEBQaG0NDDkeFiA
        TCzZI49nlUnprEay5ySd+G3kLUitczlnXGrF9aBaaABOJKSCYPfQMt8AnEkRVQ5g6eyowDHw
        gNdbLWvsCv+OGNZCswAOV93ADYAkXalIeGso3d53o/oALLb18uwFRuVgcGb+IXAYeh58OG4m
        7AafomFzZZp9q5CKgHO/ajE749RW2Pa4nrCzO3UMDszUAkfGBfbcmcLt7ETtgBN543w7Y1Qw
        vFf/CXOwJ/wwZeI52AdmNZZghUBkXKcb1ynGdYpxnXIf4JXAjdVxqgQVF0BzChWnS0mg49Qq
        M1j9l6auPw3NwPDlSAegSCDeIPSL/hUrIhTpXIaqA0ASE7sJh/ctxoqE8YqM86xGfUKjU7Jc
        B5CtHleEebvHqVe/L0V7QiqThqBQaUhgSGAwEnsKbf4ZMSIqQaFlk1k2ldX893ikk7ceXJgc
        M6VlJx/duPvQhLS/rKbKqg+7m5UdZCmyBJ6U0Yud703h8wPaeR/XmKaeck2u3/TZ8DfbXkYk
        tXQezPQnpvEnynIXsUSvjAjd754Y75XXJ69paF7ILt7kYfO9GXXqdHuv7sx0yQGv5Z1aufNH
        9kFUTNZvCxcuiYz+uuX7YK0Y5xIV0u2YhlP8A5Yc53xFAwAA
X-CMS-MailID: 20181122110414eucas1p26fbfcebf705f7d2daf8c38817254d1d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181121180208eucas1p11482a783ab1b1bceb8c9f6a1f50682c3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181121180208eucas1p11482a783ab1b1bceb8c9f6a1f50682c3
References: <1542823301-23563-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181121180208eucas1p11482a783ab1b1bceb8c9f6a1f50682c3@eucas1p1.samsung.com>
        <1542823301-23563-7-git-send-email-l.luba@partner.samsung.com>
        <5BF61DEB.5010403@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo Choi,

Thank you for the review of the patch set.
I will add your suggestions in v2 and add 'Reviewed-by' for the last to 
patches.

On 11/22/18 4:09 AM, Chanwoo Choi wrote:
> Hi,
> 
> On 2018년 11월 22일 03:01, Lukasz Luba wrote:
>> Mark the state for devfreq device while entring suspend/resume process.
>>
>> The patch draws on Tobias Jakobi's work posted ~2 years ago, who tried to
>> solve issue with devfreq device's frequency during suspend/resume.
>> During the discussion on LKML some corner cases and comments appeared
>> related to the design. This patch address them keeping in mind suggestions
>> from Chanwoo Choi.
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos4210.dtsi | 2 ++
>>   arch/arm/boot/dts/exynos4412.dtsi | 2 ++
>>   2 files changed, 4 insertions(+)
> 
> Looks good to me.
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> 
>>
>> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
>> index b6091c2..4429b72 100644
>> --- a/arch/arm/boot/dts/exynos4210.dtsi
>> +++ b/arch/arm/boot/dts/exynos4210.dtsi
>> @@ -298,6 +298,7 @@
>>   			opp-400000000 {
>>   				opp-hz = /bits/ 64 <400000000>;
>>   				opp-microvolt = <1150000>;
>> +				opp-suspend;
>>   			};
>>   		};
>>   
>> @@ -367,6 +368,7 @@
>>   			};
>>   			opp-200000000 {
>>   				opp-hz = /bits/ 64 <200000000>;
>> +				opp-suspend;
>>   			};
>>   		};
>>   	};
>> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
>> index 51f72f0..908c0c4 100644
>> --- a/arch/arm/boot/dts/exynos4412.dtsi
>> +++ b/arch/arm/boot/dts/exynos4412.dtsi
>> @@ -432,6 +432,7 @@
>>   			opp-400000000 {
>>   				opp-hz = /bits/ 64 <400000000>;
>>   				opp-microvolt = <1050000>;
>> +				opp-suspend;
>>   			};
>>   		};
>>   
>> @@ -520,6 +521,7 @@
>>   			opp-200000000 {
>>   				opp-hz = /bits/ 64 <200000000>;
>>   				opp-microvolt = <1000000>;
>> +				opp-suspend;
>>   			};
>>   		};
>>   
>>
> 
> 

Regards,
Lukasz Luba
