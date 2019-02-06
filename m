Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5226C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712BE20821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U87xh9g7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbfBFPkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:40:41 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:57982 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730540AbfBFPkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:40:41 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190206154038epoutp04bb32264f23c515ff389e2f9f54cb33d5~A0JuerpNj1458414584epoutp04O
        for <linux-kernel@vger.kernel.org>; Wed,  6 Feb 2019 15:40:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190206154038epoutp04bb32264f23c515ff389e2f9f54cb33d5~A0JuerpNj1458414584epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549467638;
        bh=0Jck/3w7jJbPg7bdH//gM6dKMHh23tgrPpTn0jkACfg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=U87xh9g7hjr2MjqhvM6GleuEmiaGe3ZhTn0//O4qy1h6RNGIctVpXp1BZcaDhvWI8
         A7oxyS2BLS+MMTuN6jQMtzZYN0//2COxj4C+Qx2+qJ1cnTNfiiXAkLMR66u5IApUXA
         S2UbRRGE9Zwn8UUo7nZAjnIN7DwoYqhcBVdK17z0=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20190206154037epcas5p300e703361103e333805e317e1007733a~A0JtytwUF0140801408epcas5p3c;
        Wed,  6 Feb 2019 15:40:37 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B7.E3.04135.5FFFA5C5; Thu,  7 Feb 2019 00:40:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20190206154037epcas5p3e2f6d586bd0423ab2fb8b37861627884~A0JtEMMaj0125901259epcas5p3f;
        Wed,  6 Feb 2019 15:40:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190206154037epsmtrp23f425a2ae0494f0a183c0960b41db661~A0JtC420L1292812928epsmtrp2F;
        Wed,  6 Feb 2019 15:40:37 +0000 (GMT)
X-AuditID: b6c32a49-bc7ff70000001027-ba-5c5afff567a0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.1E.03971.4FFFA5C5; Thu,  7 Feb 2019 00:40:36 +0900 (KST)
Received: from [107.108.73.28] (unknown [107.108.73.28]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190206154034epsmtip1468718c430a23f8fc2a6a4144c2c770c~A0JrF07HJ1207012070epsmtip16;
        Wed,  6 Feb 2019 15:40:34 +0000 (GMT)
Subject: Re: [PATCH v3 5/5] Revert
 "scsi: ufs: disable vccq if it's not needed by UFS device"
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        SCSI <linux-scsi@vger.kernel.org>
From:   Alim Akhtar <alim.akhtar@samsung.com>
Message-ID: <64b97f5b-fac3-5348-7118-b5edc72901df@samsung.com>
Date:   Wed, 6 Feb 2019 20:53:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205194607.GH31919@minitux>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGee+9u15Hk9tUPGlfjKRU/EqDC4aJFFwx0P4JNUmHXlR0Uze1
        DwwMs/IzTXA5P9M0WlQoupY2/NaGGsnUxCxhWmmxFU0L0TC3W+R/v3Oe5+G85/BSuHhe4E6l
        yXM4hVyaISGFhHbI66jv+nZcfMDsSCCzbQhiVjdmSGa8z0IwNd83cOZrczliJtsHSKZoUYUx
        00spTFXfpANj7KknmdK3OpLRWidx5sboOsHMtb4gw5xY43QkW1cwRbDGinKMvfPUKmAXZl+S
        bFefFbHWzoPsrf5SLJqKE55M5jLS8jiFf2iiMFVjGXPIKgu5rKt5hAqQ0a8EURTQwTBtuFqC
        hJSY7kUwN16BSpDjTvEDwaIpnxd+ItC0PrELtsDSSjfGC3oEay0fSb4wIzCv6giby5lOgErN
        DGZjFzoARiaMhM2E0wUEmIof2k0k7QPvVV12k4gOhaVXbwQ2Jugj0L31nbSxKx0DQ+UWxHv2
        gqF22Z51pH2hUaWy93HaDeaXmzCeD8Fzcz3OP1XjANpf13g+DYWTOoxnZ/gy1uXAsztYLXqS
        v0U6lPUE8e18aGscJXg+Bf3T9YTNgtNe8KzHn5/kBOWbyxifFMHtm2Le7QmFlpm/SQ+oKi0V
        8MzCwNDU31N9w2Dx1yhWiQ6rdy2m3rWMetcy6v+TmxGhQfu4LKUshVOeyAqUc5f8lFKZMlee
        4peUKetE9h/nHaFD6tdnBxFNIckeUfR8XLxYIM1TXpENIqBwiYvI/GmnJUqWXrnKKTITFLkZ
        nHIQeVCExE3UcKDhgphOkeZw6RyXxSn+qRjl6F6A9seGDR+7zbiaO9LVka0h+SvxVkNNTHJU
        7KpJ905fd76ibeVi6tqHzIoH4ZXZ93uTVkdGzm31NJlEMKDql90Niyj23Wz5vO7TGHxc5bZS
        bdwYqNZH9WfHnCq8rq3GwxMX3LjIM+/1tb91w/eEi7VF2Y894zq7fPJH2yeWO4LlJgmhTJUG
        euMKpfQP2t0r6G0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7bCSnO6X/1ExBhM+W1j8P2ls8fLnVTaL
        0/vfsVhM+/CT2eL1gl5Gi7PLDrJZtN6fzmRx5XG6xcT9Z9ktLu+aw2bRfX0Hm8W2z2eZLVqO
        fWWxuLF4J5sDn8flK94esxsusnhc7utl8uhf95nV4861PWweW/Z/ZvT4vEnOo/1AN1MARxSX
        TUpqTmZZapG+XQJXxqp3x9kLeqwrdkxbydjAeFmvi5GTQ0LAROLxi61MXYxcHEICuxkluvf9
        YYdISEtc3zgByhaWWPnvOTtE0WtGidbTm5lAEsIC8RJ9TadYQWwRAQOJo2cus4AUMQs0sEjs
        mPqGGaLjPZPEoS+TGUGq2AS0Je5O3wLWzStgJ/H4xAWwbhYBFYmtfz6wgdiiAhESH5/ug6oR
        lDg58wkLiM0poCsxb/p0sDnMAmYS8zY/ZIawxSVuPZnPBGHLS2x/O4d5AqPQLCTts5C0zELS
        MgtJywJGllWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMGRqaW5g/HykvhDjAIcjEo8
        vAG3omKEWBPLiitzDzFKcDArifC+fQYU4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvs071ikkEB6
        YklqdmpqQWoRTJaJg1OqgXHytr1TDzs9+aQd22ysxHJ2wR4Bnu2dexU/FHsriZj+npy7qr66
        8q2Yv+LTWk2mS64GgbISHyY2rC3QSv/qbr0n1Nde/F8D1/b4QOEKmfrHDcmblE4a3tQLu7g8
        NPpy/c5L/VW/9qR6LZed83+C41OH3QZFwh8XN9+cGHGvQvPK5J/L5xWYSyqxFGckGmoxFxUn
        AgCd11HjyAIAAA==
X-CMS-MailID: 20190206154037epcas5p3e2f6d586bd0423ab2fb8b37861627884
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190204174549epcas4p4682667176f55101f69cc24cc455c9f3c
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
        <CGME20190204174549epcas4p4682667176f55101f69cc24cc455c9f3c@epcas4p4.samsung.com>
        <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
        <5f2a8378-1f22-6a52-356d-56d3b393ab1d@samsung.com>
        <20190205062720.GF31919@minitux>
        <b190a7f0-eec9-3e87-f9c7-4969e05590df@samsung.com>
        <20190205194607.GH31919@minitux>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/19 1:16 AM, Bjorn Andersson wrote:
> On Tue 05 Feb 02:52 PST 2019, Alim Akhtar wrote:
> 
>> Hi Bjorn,
>>
>> On 05/02/19 11:57 AM, Bjorn Andersson wrote:
>>> On Mon 04 Feb 20:58 PST 2019, Alim Akhtar wrote:
>>>
>>>> Hi Marc,
>>>>
>>>> On 04/02/19 11:12 PM, Marc Gonzalez wrote:
>>>>> This reverts commit 60f0187031c05e04cbadffb62f557d0ff3564490.
>>>>>
>>>>> Calling ufshcd_set_vccq_rail_unused hangs my system.
>>>>> It seems vccq is not *not* needed.
>>>>>
>>>>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>>>>> ---
>>>>
>>>> AFAIK Samsung and Toshiba UFS devices does not use VCCQ (this pin is
>>>> either floating or connected to Ground, at least on the devices that I
>>>> have worked on).
>>>
>>> But why does such system define a vccq-supply? If the system doesn't
>>> have a regulator connected to VCCQ, then the UFS driver shouldn't be
>>> told that there is one. And if VCCQ is optional the UFS driver should
>>> support the fact that this regulator might not be supplied (i.e. call
>>> regulator_get_optional() and handle the error indicating that the supply
>>> isn't specified).
>>>
>> As per JESD220C, chapter 6.1, it does says "VCCQ - Supply voltage used
>> typically for the memory controller and optionally for the PHY
>> interface, the memory IO, and any other internal very low voltage block"
>> And we have VCCQ2 - which serve the pretty much same purpose. The
>> voltage range for VCCQ and VCCQ2 are different, VCCQ has a lower voltage
>> suitable to some low voltage block inside UFS device. I think this is
>> design consideration which allow some vendor to use one less physical
>> pin may be. And also depends on the voltage requirements of some of the
>> internal circuit.
>>
> 
> This looks to me that you are required to have a VCCQ. But you said that
> you do not have a regulator supplying VCCQ on your board, and if that
> really is the case then you should not specify vccq-supply.
> 
> The patch Marc is reverting states that for devices that does not have
> VCCQ connected, some unrelated regulator should be assigned to the UFS
> driver so that it can turn it off.
> 
> 
> If you have a regulator connected to VCCQ then it should go in
> vccq-supply, if you have a regulator connected to VCCQ2 the is should go
> in vccq2-supply. If you don't have these pins connected then there
> shouldn't be any regulators specified here!
> 
Yes, that's correct, it should be like what you are suggesting, DT 
entries should match the board schematic.

> Regards,
> Bjorn
> 
>>
>>> Regards,
>>> Bjorn
>>>
>>>> You said your system hanged, I believe you have set UFS_DEVICE_NO_VCCQ
>>>> quirks, in that case VCCQ regulator should having been disabled.
>>>> So you mean your system hanged because vccq regulator got disabled?
>>>>
>>>>>     drivers/scsi/ufs/ufs.h    |  1 -
>>>>>     drivers/scsi/ufs/ufshcd.c | 59 +++------------------------------------
>>>>>     2 files changed, 4 insertions(+), 56 deletions(-)
>>>>>
>>>>> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
>>>>> index dd65fea07687..7da7318eb6a6 100644
>>>>> --- a/drivers/scsi/ufs/ufs.h
>>>>> +++ b/drivers/scsi/ufs/ufs.h
>>>>> @@ -514,7 +514,6 @@ struct ufs_vreg {
>>>>>     	struct regulator *reg;
>>>>>     	const char *name;
>>>>>     	bool enabled;
>>>>> -	bool unused;
>>>>>     	int min_uV;
>>>>>     	int max_uV;
>>>>>     	int min_uA;
>>>>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>>>>> index 9ba7671b84f8..8b9a01073d62 100644
>>>>> --- a/drivers/scsi/ufs/ufshcd.c
>>>>> +++ b/drivers/scsi/ufs/ufshcd.c
>>>>> @@ -245,7 +245,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba);
>>>>>     static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
>>>>>     				 bool skip_ref_clk);
>>>>>     static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on);
>>>>> -static int ufshcd_set_vccq_rail_unused(struct ufs_hba *hba, bool unused);
>>>>>     static int ufshcd_uic_hibern8_exit(struct ufs_hba *hba);
>>>>>     static int ufshcd_uic_hibern8_enter(struct ufs_hba *hba);
>>>>>     static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba);
>>>>> @@ -6819,11 +6818,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
>>>>>     	ufs_fixup_device_setup(hba, &card);
>>>>>     	ufshcd_tune_unipro_params(hba);
>>>>>     
>>>>> -	ret = ufshcd_set_vccq_rail_unused(hba,
>>>>> -		(hba->dev_quirks & UFS_DEVICE_NO_VCCQ) ? true : false);
>>>>> -	if (ret)
>>>>> -		goto out;
>>>>> -
>>>>>     	/* UFS device is also active now */
>>>>>     	ufshcd_set_ufs_dev_active(hba);
>>>>>     	ufshcd_force_reset_auto_bkops(hba);
>>>>> @@ -7007,24 +7001,13 @@ static int ufshcd_config_vreg_load(struct device *dev, struct ufs_vreg *vreg,
>>>>>     static inline int ufshcd_config_vreg_lpm(struct ufs_hba *hba,
>>>>>     					 struct ufs_vreg *vreg)
>>>>>     {
>>>>> -	if (!vreg)
>>>>> -		return 0;
>>>>> -	else if (vreg->unused)
>>>>> -		return 0;
>>>>> -	else
>>>>> -		return ufshcd_config_vreg_load(hba->dev, vreg,
>>>>> -					       UFS_VREG_LPM_LOAD_UA);
>>>>> +	return ufshcd_config_vreg_load(hba->dev, vreg, UFS_VREG_LPM_LOAD_UA);
>>>>>     }
>>>>>     
>>>>>     static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
>>>>>     					 struct ufs_vreg *vreg)
>>>>>     {
>>>>> -	if (!vreg)
>>>>> -		return 0;
>>>>> -	else if (vreg->unused)
>>>>> -		return 0;
>>>>> -	else
>>>>> -		return ufshcd_config_vreg_load(hba->dev, vreg, vreg->max_uA);
>>>>> +	return ufshcd_config_vreg_load(hba->dev, vreg, vreg->max_uA);
>>>>>     }
>>>>>     
>>>>>     static int ufshcd_config_vreg(struct device *dev,
>>>>> @@ -7062,9 +7045,7 @@ static int ufshcd_enable_vreg(struct device *dev, struct ufs_vreg *vreg)
>>>>>     {
>>>>>     	int ret = 0;
>>>>>     
>>>>> -	if (!vreg)
>>>>> -		goto out;
>>>>> -	else if (vreg->enabled || vreg->unused)
>>>>> +	if (!vreg || vreg->enabled)
>>>>>     		goto out;
>>>>>     
>>>>>     	ret = ufshcd_config_vreg(dev, vreg, true);
>>>>> @@ -7084,9 +7065,7 @@ static int ufshcd_disable_vreg(struct device *dev, struct ufs_vreg *vreg)
>>>>>     {
>>>>>     	int ret = 0;
>>>>>     
>>>>> -	if (!vreg)
>>>>> -		goto out;
>>>>> -	else if (!vreg->enabled || vreg->unused)
>>>>> +	if (!vreg || !vreg->enabled)
>>>>>     		goto out;
>>>>>     
>>>>>     	ret = regulator_disable(vreg->reg);
>>>>> @@ -7192,36 +7171,6 @@ static int ufshcd_init_hba_vreg(struct ufs_hba *hba)
>>>>>     	return 0;
>>>>>     }
>>>>>     
>>>>> -static int ufshcd_set_vccq_rail_unused(struct ufs_hba *hba, bool unused)
>>>>> -{
>>>>> -	int ret = 0;
>>>>> -	struct ufs_vreg_info *info = &hba->vreg_info;
>>>>> -
>>>>> -	if (!info)
>>>>> -		goto out;
>>>>> -	else if (!info->vccq)
>>>>> -		goto out;
>>>>> -
>>>>> -	if (unused) {
>>>>> -		/* shut off the rail here */
>>>>> -		ret = ufshcd_toggle_vreg(hba->dev, info->vccq, false);
>>>>> -		/*
>>>>> -		 * Mark this rail as no longer used, so it doesn't get enabled
>>>>> -		 * later by mistake
>>>>> -		 */
>>>>> -		if (!ret)
>>>>> -			info->vccq->unused = true;
>>>>> -	} else {
>>>>> -		/*
>>>>> -		 * rail should have been already enabled hence just make sure
>>>>> -		 * that unused flag is cleared.
>>>>> -		 */
>>>>> -		info->vccq->unused = false;
>>>>> -	}
>>>>> -out:
>>>>> -	return ret;
>>>>> -}
>>>>> -
>>>>>     static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
>>>>>     					bool skip_ref_clk)
>>>>>     {
>>>>>
>>>
>>>
> 
> 
