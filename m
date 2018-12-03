Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E497C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051342087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jo0Xn6yB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051342087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeLCRtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:49:01 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47613 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeLCRtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:49:01 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181203174857euoutp02a1933e08a65af419a291b037612b6385~s4_NA32pX1012110121euoutp02u
        for <linux-kernel@vger.kernel.org>; Mon,  3 Dec 2018 17:48:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181203174857euoutp02a1933e08a65af419a291b037612b6385~s4_NA32pX1012110121euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543859337;
        bh=mOmZh3Z/m/kJ3Yd/yIjuwdALOmvNaT4nyk+GK7Xb6js=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jo0Xn6yBUtn1I6F8jxdePOUHJRXyXvf9N/XKH5N2LiLtoIVxqRzwFHBpZ2ZwRodYZ
         B9OvuWyNVBNeGJs/BGRlPUCJ8x+oaZ/p7Fr86Gtbu5qwzdrap0j8495kyv+5GAEXid
         aea8enb8BqFvWU1VVPabX81Xmu9S2WnoD89y+e28=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181203174855eucas1p106747a52af5b1d5dc66c90037d344f4a~s4_LR_NhN1176411764eucas1p1L;
        Mon,  3 Dec 2018 17:48:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 30.37.04294.78C650C5; Mon,  3
        Dec 2018 17:48:55 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181203174854eucas1p1698fc72786a5ead752c25b67b465f592~s4_KlMbjS1176011760eucas1p1L;
        Mon,  3 Dec 2018 17:48:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181203174854eusmtrp1224141bf793d15b5de4fb4aac1a13eba~s4_KViv_a1122611226eusmtrp1Z;
        Mon,  3 Dec 2018 17:48:54 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-fb-5c056c87d5e9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7C.E7.04284.68C650C5; Mon,  3
        Dec 2018 17:48:54 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181203174853eusmtip1ea8b34ad9fddccd27b045795cd35eab8~s4_JeKBw73123231232eusmtip1V;
        Mon,  3 Dec 2018 17:48:53 +0000 (GMT)
Subject: Re: [PATCH v2 5/5] arm: dts: exynos4: opp-suspend in DMC and
 leftbus
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com,
        rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <fed94fcf-74f4-a6e4-1405-12fb67ed5c9f@partner.samsung.com>
Date:   Mon, 3 Dec 2018 18:48:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181203172251.GA15124@kozik-lap>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwUWRSGvVV1qwpiM0WLcgJmTDqauERQ0XgTl4iaSY0vTiY+uGCkhRIM
        NEIXuEdRIw2MSKs4YIviGrHZpFlFEMESQiM2rUHc0HFwF9QIDuOGQ1lthrfvnPOfe/4/uTyt
        z2UD+PVxiZI5zhhrYL2ZyqaPrqmWWBw2rb7KjzRUTCKlOSWYVJX+g0ln/3NM8pQbmOw5XcKS
        63+YSGb3a5q4XBc40ra7hyO2rDqKOLpvY3KrJpclfRkKIjmuyxQpUro4crbTTZH7u/JZ0uW8
        NrTfehOTvXUKR1IK3mHS0/6QWeAvVl6qxGLh8UIkHk12M6I18z0ST9e+pESHPY0V648VcmLZ
        mZ3iYBMnlndYGHF/uR2J+QUDnNjn+Pk33UrvuZFS7PqNkjl4frh3dNYVFxOvjNncetKKk9E1
        33TkxYMwE+pvptHpyJvXC/kIMl89pbSiH0HG5wzPpA/B28xa/GNl4OEJz+AcgsOlDUgrehHc
        +fSaTUc8P0pYCs+6x6sLfsIk6Pw6gFUNLRQzUOPsRKqGFYKg2p6ganTCL5BRXE+pzAjjoeXx
        30jl0cJySH1UwGoaX2g58oRR2UsIhlNt7d/7tOAP957kURqPg6re3O/mQHjAg3v3AKO5XgwX
        nVmsxqPgVXM5p/FYaD20z6ORoS3V7tFsB0tLtUczB642u7HqmR4KU1ITrCIIoXDwWaiGPnCn
        11dz4AMHK7Npra2D1BS99sZEKN/XTmk8Bs4V/slZkcE2LJdtWBbbsCy2/8+eQIwd+UtJsilK
        kmfESZuCZKNJToqLCorYYHKgoT/bOtjcX41qvqxtRAKPDCN1OQtxmB4bN8pbTI0IeNrgp4tP
        YML0ukjjlq2SecMac1KsJDeiQJ4x+Ou2jfhrlV6IMiZKMZIUL5l/TCneKyAZWT7/tEr6trKo
        492ypQ7p6cXSgHn4QG1EXUL2rLcTdzQom8I7/h09J+9bd0eaUwldcmTFnrLz49jBkK7QAz5f
        A13LQt5Y8IcJiY8Xle1fkXYoZut9xdqkRBa9qL2+esTeHTFyz2SfqJDFFb9Kdy/luJ2zs60h
        Bcbfm3cFrouukxtTjk8xMHK0cfpk2iwb/wPbcZVqrwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRiGfc/3osFxar5YVq76YdBs6txrlERQnH4IYUWhlo08zHAfujMj
        C3IVaa1MrX7oXGof0lqmOWtKpqYtpcymRjMKxVLRMqOyHFFarhH474L7vnh44GZwiYMMYw7p
        jLxBp9JIqUVE91zX4Lp8DZm6/tb0CtR+PxLVl9aRqLF+hkQD38dJVOl6QaJT1+so9PycFhWN
        TOLI7b5Lo56Tn2hkudyCIceIh0QvH1gpNF3oAqjU3YqhO65BGlUP9GHo7QkbhQafPZn3u/tJ
        dLrFRaP8219I9Kl3iNgcyjmbnSRXU1EDuHJTH8EVF30D3PWHHzDOYT9LcW1Xamiu4UYeN9dJ
        c/deFRDchXt2wNlue2lu2rF8hzhZttGgzzHyKzP0gnGTNEWOomXyeCSLjo2XyWOU+zZEK6RR
        CRvTec2hw7whKuGALOPyIzeR5VpypPtqMWkCTwLNQMRANhZ6h6pwM1jESNhqAL3nx3B/sARe
        bG2k/RwEf3vMlL80CeDsTBnlC4LYRPh4zPOvFMxGwoFZL+kr4WwtAYc7m2m/cRKDntmvmBkw
        DMXKYJM92yeI2W2wsLYN8zHBroZP370HPg5h98KeD7XA3wmET8tGCR+L2Ch4raf332GcjYMV
        De9wP4fCN6OVmJ9XwMYpK14MJJYFumWBYlmgWBYoVYCwg2A+R9CqtYJcJqi0Qo5OLTuo1zrA
        /F6cnT8bmkB//c4OwDJAulhcuoVMlZCqw0KutgNABpcGi7OyiVSJOF2Ve5Q36NMMORpe6ACK
        +edK8LCQg/r59emMaXKFXIni5coYZUwckoaK3etzkyWsWmXkM3k+izf89zBGFGYCWaJeoeqX
        ZHf1Yz1WPt6bNzGTGMGF3tze9nmq5utrq+lmQFFXYlnz+HGzInyYWNMa8KNknzicC7ga4fpz
        adhaAI89mNhauColOeJ7vj2uz65opz7uFyXtYTMjnRcnL4U02EaWLdWY4dszy4cYm73ctqsk
        Kd/TUucdE3HquFhWSggZKvla3CCo/gIReISaRQMAAA==
X-CMS-MailID: 20181203174854eucas1p1698fc72786a5ead752c25b67b465f592
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181203143135eucas1p165fe6183ae90de7906f9683cb41ff4c1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181203143135eucas1p165fe6183ae90de7906f9683cb41ff4c1
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143135eucas1p165fe6183ae90de7906f9683cb41ff4c1@eucas1p1.samsung.com>
        <1543847475-7600-6-git-send-email-l.luba@partner.samsung.com>
        <20181203172251.GA15124@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 12/3/18 6:22 PM, Krzysztof Kozlowski wrote:
> On Mon, Dec 03, 2018 at 03:31:15PM +0100, Lukasz Luba wrote:
>> Mark the state for devfreq device while entring suspend/resume process.
>>
>> The patch is based on earlier work by Tobias Jakobi.
>>
>> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   arch/arm/boot/dts/exynos4210.dtsi | 2 ++
>>   arch/arm/boot/dts/exynos4412.dtsi | 2 ++
>>   2 files changed, 4 insertions(+)
> 
> Thanks, applied with some minor commit msg changes. In general, please
> take care about title prefix (git log --oneline
> arch/arm/boot/dts/exynos*) and always explain why you are doing this.
Thank you that you have applied and for the hint.

> You just mentioned "what" but that is pretty obvious by looking at
> commit contents. The commit msg should answer why these should be marked
> as opp-suspend and why these values were chosen.
> 
> The cover letter just briefly describes "issue with devfreq devices' frequency
> during suspend/resume"... but what issue?
In the cover letter there is sentence:
'The suspending device has now chance to set proper
state when the system is going for suspend. This phase is the right place
to set needed frequences for the next resume process.'
Generally speaking, there is a need of setting the right
frequency/voltage, because we need that frequency during resume,
i.e. for booting CPUs (which are poked earlier during resume than the 
buses in this design).

Regards,
Lukasz


> 
> Best regards,
> Krzysztof
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
>> -- 
>> 2.7.4
>>
> 
> 
