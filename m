Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932501AbeBLVpC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 16:45:02 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:27440 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932204AbeBLVo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 16:44:59 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180212214457epoutp047303edef54a07a9d5b868d521fc8606e~SsiVCgcTD1632616326epoutp04K
X-AuditID: b6c32a35-891ff70000001031-8e-5a820ad9599c
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A820ADA.8000403@samsung.com>
Date: Tue, 13 Feb 2018 06:44:58 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-clk@vger.kernel.org
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH 2/3] clk: exynos5433: Allow audio subsystem clock rate
 propagation
In-reply-to: <e0d88ac2-439b-8e6e-af32-310b53ca0693@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+e1ud1dpdVtpBwvTCwVKW97p8lqtB1mMMhhEIEqum15UdJvd
        u0n2R6k9pvPRQyGxl0H0MMR8ELrIalpWlNVG71oP6UFpD7Ra1B/du5vkf9/z5XO+nHM4BKat
        xGOIQruT4+1sMYVHKi/0J+h0TyIrs5J6P+FMR1O7iukcfqhivtUGVUzAewRnmu72KZi2gRdq
        5v6t1Uz/iFvFhG7XKFdEmL883qM2B+rrFOaukzvN9d2tyDzWGWtRZXFLCzg2j+PjOHuuI6/Q
        nm+i1m2wrrIaFyXROjqNSaXi7KyNM1HpGRbdmsJicRwqrpQtdomWhRUEauGypbzD5eTiChyC
        00Rl07RBTyel6g0Ggz4ledNig1FENnMFI7se4SUN0duqX3cpy1HbdA+KIIBMgYqjt3EPiiS0
        ZA+Cs2euY3LxE8Foxzl8gnJ/PauWtJa8iOBM41pJa8jpEGoIKj2IIDByLgz4iyQbIxPgw/hB
        pZwTRHD+1EEk84ngflKvkLSSnAeV+36F83HRv/zhcVhPI+PhQWg4zEeRmdB7/Idayp9JroVj
        5TopEyP9CJ59cSPJnyEyz+8kSngEuRz2vPUiiQEygMPrEf+/+dPBfzyAZD0DPg52hzOBnA3+
        ayaZdyNwXzqGyUUjgqFHQYXckAzvTngU8mZT4fP3WpXcrIGqvVoZMUPtjRalrFdCy81Ktbz8
        ewUMhlqx/Si2edK9mv/fq3nSvVoQ1oqiuRLBls8JdAmtF1ib4LLn63Mdtk4U/r9EYw9qHMrw
        IZJA1BRN1eGKLK2KLRXKbD4EBEbN1PzZJVqaPLZsO8c7rLyrmBN8yCie+wAWE5XrEL/Z7rTS
        KWlJKYsM4nel0TQ1S2OxpGdpyXzWyRVxXAnHT/QpiIiYchR9tDZqS4X3Hb/b87b9xr31dVvL
        XvFXvKMvk+cMD4yPmHdaqBO/bWNThjY/WAOpDb2RWy3qbaXN3zPm95027XajBTtyYmoC3uic
        GpNnyPXjkLU0Gwx9dcFQ4Zv+I00bjd+swz58sEoHnaM+qI6Pv/p5VgtbtKEdxnMyl4w91VBK
        oYClEzFeYP8Cj8+hZZUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsVy+t9jAd0bXE1RBl826FtsnLGe1WLT42us
        Fh977rFaXN41h81ixvl9TBZrj9xlt7h4ytXi8Jt2VosfZ7pZHDg93t9oZfe43NfL5LF5Sb1H
        35ZVjB6fN8kFsEZx2aSk5mSWpRbp2yVwZbxpvs5WMFmsovPhZpYGxrWCXYycHBICJhLtH1ay
        dzFycQgJ7GSUmLnvDwtIgldAUOLH5HtANgcHs4C8xJFL2RCmusSUKbkQ5Q8YJT6cf8IOUa4l
        0X6zjwnEZhFQlWjq/8kGYrMBxfe/uAFm8wsoSlz98ZgRZI6oQIRE94lKEFNEwEtiXoMuyEhm
        gUuMEqc37mMFiQsDldw5qwWx6jGTxJVf38DGcwrYS7Q+3cU4gVFgFpJDZyEcOgvh0AWMzKsY
        JVMLinPTc4uNCgzzUsv1ihNzi0vz0vWS83M3MQKDftthrb4djPeXxB9iFOBgVOLh7ZjdGCXE
        mlhWXJl7iFGCg1lJhPdPM1CINyWxsiq1KD++qDQntfgQozQHi5I47+28Y5FCAumJJanZqakF
        qUUwWSYOTqkGxslMWb2vdwht8YpqdusV4ZH47VTqdiz6+X73v0uK0yve3/mSX7Vjf99GS7ns
        paYpfffCTvifZY023Lnz7PHYwFUp5uqGp/avEu+Z/kx8x7Et1j/cdvz+cvX5xgWR+d+kTv5f
        WqO9qSLa9V6fr9AS9/fTtiqfKvHhymKV7D+ib/HtwidZhbWuVUosxRmJhlrMRcWJABWQtrB2
        AgAA
X-CMS-MailID: 20180212214456epcas1p252f0e02555e0fc1d8f311b35af2ea1cc
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180205142308epcas2p376f8656f7e421f8474938de788cea8db
X-RootMTR: 20180205142308epcas2p376f8656f7e421f8474938de788cea8db
References: <20180205142230.9755-1-s.nawrocki@samsung.com>
        <CGME20180205142308epcas2p376f8656f7e421f8474938de788cea8db@epcas2p3.samsung.com>
        <20180205142230.9755-2-s.nawrocki@samsung.com>
        <5A7929C1.8040706@samsung.com>
        <3fcfad37-4c8f-7375-b2c2-5154607aa47a@samsung.com>
        <5A7D4F92.100@samsung.com>
        <e0d88ac2-439b-8e6e-af32-310b53ca0693@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sylwester,

On 2018년 02월 12일 20:45, Sylwester Nawrocki wrote:
> Hi Chanwoo,
> 
> On 02/09/2018 08:36 AM, Chanwoo Choi wrote:
>> On 2018년 02월 08일 00:18, Sylwester Nawrocki wrote:
>>> On 02/06/2018 05:06 AM, Chanwoo Choi wrote:
>>>>>  drivers/clk/samsung/clk-exynos5433.c | 22 +++++++++++-----------
>>>>>  1 file changed, 11 insertions(+), 11 deletions(-)
>>>>>
>>>>> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
>>>>> index 74b70ddab4d6..d74361736e64 100644
>>>>> --- a/drivers/clk/samsung/clk-exynos5433.c
>>>>> +++ b/drivers/clk/samsung/clk-exynos5433.c
>>>>> @@ -246,14 +246,14 @@ static const struct samsung_fixed_rate_clock top_fixed_clks[] __initconst = {
>>>>>  
>>>>>  static const struct samsung_mux_clock top_mux_clks[] __initconst = {
>>>>>  	/* MUX_SEL_TOP0 */
>>>>> -	MUX(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
>>>>> -			4, 1),
>>>>> +	MUX_F(CLK_MOUT_AUD_PLL, "mout_aud_pll", mout_aud_pll_p, MUX_SEL_TOP0,
>>>>> +	      4, 1, CLK_SET_RATE_PARENT, 0),
>>>> If you add CLK_SET_RATE_PARENT to 'mout_aud_pll' and mout_aud_pll changes the rate,
>>>> fout_aud_pll's rate will be changed. But, fout_aud_pll is also the parent
>>>> of 'mout_aud_pll_user'. It might change the rate of children of mout_aud_pll_user.
>>>> mout_aud_pll_user would not want to change the parent's clock.
>>>>
>>>>     fout_aud_pll                          2            2   196608009          0 0  
>>>>        mout_aud_pll_user                  1            1   196608009          0 0  
>>>>        mout_aud_pll                       0            0   196608009          0 0  
>>> I'd say the range of changes is such that the consumers of the affected child 
>>> clocks can cope and could adjust to the changed frequencies. Those consumer 
>>> devices are all components/peripherals of the audio subsystem (LPASS) and, 
>>
>> The mout_aud_pll_user has the child clock of serial_3.
>> serial_3 was used for bluetooth on TM2. If you change the aud_pll
>> with CLK_SET_RATE_PARENT, it might affect the bluetooth operation.
>> The bluetooth is only used for transfering the data.
>>
>> Actually, I'm not sure that this patch might affect bluetooth operation or not.
> 
> You are right, the AUD PLL frequency adjustments would break the bluetooth's 
> operation. I double checked and in the downstream kernel only one AUD PLL 
> frequency can be set - 196608009. So I will drop this patch and add just
> a single PLL_36XX_RATE() entry for that frequency, the PMS values have been
> confirmed by the HW team. Only 48000/9600/192000 sample rates will then be 
> supported natively and others could be through software rate conversion.
> 

OK. Thanks for your check.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
