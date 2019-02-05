Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6C6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D41A20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VLtvA7jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfBELJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:09:57 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:54954 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBELJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:09:57 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190205110955epoutp01e4b81607fdd36ee5876d9bd8253d8289~Ac0ELkjzB0137701377epoutp01g
        for <linux-kernel@vger.kernel.org>; Tue,  5 Feb 2019 11:09:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190205110955epoutp01e4b81607fdd36ee5876d9bd8253d8289~Ac0ELkjzB0137701377epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549364995;
        bh=9HG2bDwBjJ/U7vrxxJKAjtgOCHUEoMzy7ds+1I5ZPHQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VLtvA7jnbGEobdoAj+fFJwFHQUgjkxC5xNvqqjALHKZLj7IMddfMOUSP6yrTiN/XY
         GTC9MHZ9Hj5MU21jwdsrsQr4So+v+4noVP+3rweD8M694Q7ktx/MvAv1h8kTpMnbof
         PISvT0DIWpo0+bNlxBfX6niPWW+8Tif8nXm5Tn3I=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20190205110954epcas5p1fa5f9b0dc9d1e18df7585c7107ab48fa~Ac0DmvRVM2086720867epcas5p1m;
        Tue,  5 Feb 2019 11:09:54 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.93.04136.20F695C5; Tue,  5 Feb 2019 20:09:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20190205110953epcas5p3a58cc6ed4dc722ba5951c14d213ec792~Ac0DNj3on0472604726epcas5p3U;
        Tue,  5 Feb 2019 11:09:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190205110953epsmtrp2a24ab201f0a759a87e78ce6bbe4c50a9~Ac0DMb-vO1199011990epsmtrp2I;
        Tue,  5 Feb 2019 11:09:53 +0000 (GMT)
X-AuditID: b6c32a4b-497ff70000001028-b5-5c596f025c11
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.50.03601.10F695C5; Tue,  5 Feb 2019 20:09:53 +0900 (KST)
Received: from [107.108.73.28] (unknown [107.108.73.28]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190205110951epsmtip2f91728c93141380aa52e047b0991491f~Ac0BVca5D2147521475epsmtip2b;
        Tue,  5 Feb 2019 11:09:51 +0000 (GMT)
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
Message-ID: <b190a7f0-eec9-3e87-f9c7-4969e05590df@samsung.com>
Date:   Tue, 5 Feb 2019 16:22:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205062720.GF31919@minitux>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTURjGOffe3V2ni9usfLMPY6Q0Iz/S6hJhIf1xw5X9FWqCrbqp6HTt
        ZrVKEPp2TYsgy48STCXBD2zZWo3VLL+VZGphZpSmZGTSKjWTynuK/O/3nPd5zstzOAypeiXz
        Z1IzjgjGDF26mlZQDY0azToiMz4xrNK5hPvVGsF9mO6luXbnOMVdm5gmuY+lFsR1VjyhubNv
        CgiuZyiZu+LslHNuezHNmV/YaK7B00lyZ5q+UdzLsgf0tgW8uyeGL8rppnh3noXg82s8Mn6g
        7xHNW50exHvqV/LnH5uJ3UyCYstBIT31qGAMjdqnSPlaJDcMhR1/0TJJ5qDqoFzkxQAbCSVj
        uWQuUjAq9iGChvqLMiy+IKi2T8ux+I7geq3rj2CkSIV1MT53IDDXOCgsPiEoGegj5u71ZZPg
        clWvxIvYMHjW4ZZMJJtDwbuLldTcgGbXwusCq2RSslFwZ6pOYopdDc8nZmVzvJiNg0bLOMKe
        hdB6Y1jKerHrYGQqV/KQrB/0D98iMAfA/U/FUiFgq+TQdr6IxE23g2124i/7wlizVY7ZHzzj
        DhpXS4NL9gh8fArKbzZRmLfC455ias5CshqotYfiVQvAMjNM4KQSLpxTYXcgnB7v/ZtcBlfM
        ZhlmHp40dtP4rQoIsHQ00pfRqsJ5zQrntSmc16bw/+ZSRFWhpYJB1CcL4gZDRIZwLETU6cWs
        jOSQA5n6eiR9ueAYG6rv0roQyyC1j3IqMi5RJdMdFU16FwKGVC9Stu2MT1QpD+pMJwRjZpIx
        K10QXWgZQ6n9lCUrSvaq2GTdESFNEAyC8d+UYLz8c9CupdljphvedU2e/PeKqaj2pjpfxSaq
        7Nr2tsHgz3HrR3+Grgje01Ue8IDJuqddG97/Y03AVVV2bMuOoIF92kMRh0d9vJujJzcvH4lM
        eO0wvRcftmhdpqc+twjHrmJNYLih3KKlT25Q62eCYutst4XomHjfpK68jW/7BvtbjXf3R6sp
        MUUXHkwaRd1vMIcRfm4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSvC5jfmSMwc/VFhb/TxpbvPx5lc3i
        9P53LBbTPvxktni9oJfR4uyyg2wWrfenM1lceZxuMXH/WXaLy7vmsFl0X9/BZrHt81lmi5Zj
        X1ksbizeyebA53H5irfH7IaLLB6X+3qZPPrXfWb1uHNtD5vHlv2fGT0+b5LzaD/QzRTAEcVl
        k5Kak1mWWqRvl8CV8WU2e8Fjg4rrJ74zNzCuVeti5OCQEDCRWLZFtIuRi0NIYDejRNv+eyxd
        jJxAcWmJ6xsnsEPYwhIr/z1nhyh6zSixfd8zNpCEsEC8RF/TKVYQW0TAQOLomcssIEXMAg0s
        EjumvmEGSQgJTGeS6P5SD2KzCWhL3J2+hQnE5hWwk1j5YwOYzSKgInHhw1+wQaICERIfn+6D
        qhGUODnzCdhFnAK6Es9+dIHVMAuYSczb/JAZwhaXuPVkPhOELS+x/e0c5gmMQrOQtM9C0jIL
        ScssJC0LGFlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEx6SW1g7GEyfiDzEKcDAq
        8fD+MImIEWJNLCuuzD3EKMHBrCTCe8o3MkaINyWxsiq1KD++qDQntfgQozQHi5I4r3z+sUgh
        gfTEktTs1NSC1CKYLBMHp1QDY7eLT7/5nFmTn/183Gz24F+ZIncMD2+p85KSO6sZhf7c+PKl
        7XT+3aeNb7pffz7ObvBYcLZLbnPerucfXq+3045XPJ/39R7Lrabkpe9zwkpXuPuqnZ29olyq
        Rc9facE3tluCeStfeVTpdObplgY2rGPK27HkQ8D0Oe8lE5Ylbs85+FTncX7RRiWW4oxEQy3m
        ouJEAPATxB3FAgAA
X-CMS-MailID: 20190205110953epcas5p3a58cc6ed4dc722ba5951c14d213ec792
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190204174549epcas4p4682667176f55101f69cc24cc455c9f3c
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
        <CGME20190204174549epcas4p4682667176f55101f69cc24cc455c9f3c@epcas4p4.samsung.com>
        <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
        <5f2a8378-1f22-6a52-356d-56d3b393ab1d@samsung.com>
        <20190205062720.GF31919@minitux>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 05/02/19 11:57 AM, Bjorn Andersson wrote:
> On Mon 04 Feb 20:58 PST 2019, Alim Akhtar wrote:
> 
>> Hi Marc,
>>
>> On 04/02/19 11:12 PM, Marc Gonzalez wrote:
>>> This reverts commit 60f0187031c05e04cbadffb62f557d0ff3564490.
>>>
>>> Calling ufshcd_set_vccq_rail_unused hangs my system.
>>> It seems vccq is not *not* needed.
>>>
>>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
>>> ---
>>
>> AFAIK Samsung and Toshiba UFS devices does not use VCCQ (this pin is
>> either floating or connected to Ground, at least on the devices that I
>> have worked on).
> 
> But why does such system define a vccq-supply? If the system doesn't
> have a regulator connected to VCCQ, then the UFS driver shouldn't be
> told that there is one. And if VCCQ is optional the UFS driver should
> support the fact that this regulator might not be supplied (i.e. call
> regulator_get_optional() and handle the error indicating that the supply
> isn't specified).
> 
As per JESD220C, chapter 6.1, it does says "VCCQ - Supply voltage used 
typically for the memory controller and optionally for the PHY 
interface, the memory IO, and any other internal very low voltage block"
And we have VCCQ2 - which serve the pretty much same purpose. The 
voltage range for VCCQ and VCCQ2 are different, VCCQ has a lower voltage 
suitable to some low voltage block inside UFS device. I think this is 
design consideration which allow some vendor to use one less physical 
pin may be. And also depends on the voltage requirements of some of the 
internal circuit.


> Regards,
> Bjorn
> 
>> You said your system hanged, I believe you have set UFS_DEVICE_NO_VCCQ
>> quirks, in that case VCCQ regulator should having been disabled.
>> So you mean your system hanged because vccq regulator got disabled?
>>
>>>    drivers/scsi/ufs/ufs.h    |  1 -
>>>    drivers/scsi/ufs/ufshcd.c | 59 +++------------------------------------
>>>    2 files changed, 4 insertions(+), 56 deletions(-)
>>>
>>> diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
>>> index dd65fea07687..7da7318eb6a6 100644
>>> --- a/drivers/scsi/ufs/ufs.h
>>> +++ b/drivers/scsi/ufs/ufs.h
>>> @@ -514,7 +514,6 @@ struct ufs_vreg {
>>>    	struct regulator *reg;
>>>    	const char *name;
>>>    	bool enabled;
>>> -	bool unused;
>>>    	int min_uV;
>>>    	int max_uV;
>>>    	int min_uA;
>>> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
>>> index 9ba7671b84f8..8b9a01073d62 100644
>>> --- a/drivers/scsi/ufs/ufshcd.c
>>> +++ b/drivers/scsi/ufs/ufshcd.c
>>> @@ -245,7 +245,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba);
>>>    static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
>>>    				 bool skip_ref_clk);
>>>    static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on);
>>> -static int ufshcd_set_vccq_rail_unused(struct ufs_hba *hba, bool unused);
>>>    static int ufshcd_uic_hibern8_exit(struct ufs_hba *hba);
>>>    static int ufshcd_uic_hibern8_enter(struct ufs_hba *hba);
>>>    static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba);
>>> @@ -6819,11 +6818,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
>>>    	ufs_fixup_device_setup(hba, &card);
>>>    	ufshcd_tune_unipro_params(hba);
>>>    
>>> -	ret = ufshcd_set_vccq_rail_unused(hba,
>>> -		(hba->dev_quirks & UFS_DEVICE_NO_VCCQ) ? true : false);
>>> -	if (ret)
>>> -		goto out;
>>> -
>>>    	/* UFS device is also active now */
>>>    	ufshcd_set_ufs_dev_active(hba);
>>>    	ufshcd_force_reset_auto_bkops(hba);
>>> @@ -7007,24 +7001,13 @@ static int ufshcd_config_vreg_load(struct device *dev, struct ufs_vreg *vreg,
>>>    static inline int ufshcd_config_vreg_lpm(struct ufs_hba *hba,
>>>    					 struct ufs_vreg *vreg)
>>>    {
>>> -	if (!vreg)
>>> -		return 0;
>>> -	else if (vreg->unused)
>>> -		return 0;
>>> -	else
>>> -		return ufshcd_config_vreg_load(hba->dev, vreg,
>>> -					       UFS_VREG_LPM_LOAD_UA);
>>> +	return ufshcd_config_vreg_load(hba->dev, vreg, UFS_VREG_LPM_LOAD_UA);
>>>    }
>>>    
>>>    static inline int ufshcd_config_vreg_hpm(struct ufs_hba *hba,
>>>    					 struct ufs_vreg *vreg)
>>>    {
>>> -	if (!vreg)
>>> -		return 0;
>>> -	else if (vreg->unused)
>>> -		return 0;
>>> -	else
>>> -		return ufshcd_config_vreg_load(hba->dev, vreg, vreg->max_uA);
>>> +	return ufshcd_config_vreg_load(hba->dev, vreg, vreg->max_uA);
>>>    }
>>>    
>>>    static int ufshcd_config_vreg(struct device *dev,
>>> @@ -7062,9 +7045,7 @@ static int ufshcd_enable_vreg(struct device *dev, struct ufs_vreg *vreg)
>>>    {
>>>    	int ret = 0;
>>>    
>>> -	if (!vreg)
>>> -		goto out;
>>> -	else if (vreg->enabled || vreg->unused)
>>> +	if (!vreg || vreg->enabled)
>>>    		goto out;
>>>    
>>>    	ret = ufshcd_config_vreg(dev, vreg, true);
>>> @@ -7084,9 +7065,7 @@ static int ufshcd_disable_vreg(struct device *dev, struct ufs_vreg *vreg)
>>>    {
>>>    	int ret = 0;
>>>    
>>> -	if (!vreg)
>>> -		goto out;
>>> -	else if (!vreg->enabled || vreg->unused)
>>> +	if (!vreg || !vreg->enabled)
>>>    		goto out;
>>>    
>>>    	ret = regulator_disable(vreg->reg);
>>> @@ -7192,36 +7171,6 @@ static int ufshcd_init_hba_vreg(struct ufs_hba *hba)
>>>    	return 0;
>>>    }
>>>    
>>> -static int ufshcd_set_vccq_rail_unused(struct ufs_hba *hba, bool unused)
>>> -{
>>> -	int ret = 0;
>>> -	struct ufs_vreg_info *info = &hba->vreg_info;
>>> -
>>> -	if (!info)
>>> -		goto out;
>>> -	else if (!info->vccq)
>>> -		goto out;
>>> -
>>> -	if (unused) {
>>> -		/* shut off the rail here */
>>> -		ret = ufshcd_toggle_vreg(hba->dev, info->vccq, false);
>>> -		/*
>>> -		 * Mark this rail as no longer used, so it doesn't get enabled
>>> -		 * later by mistake
>>> -		 */
>>> -		if (!ret)
>>> -			info->vccq->unused = true;
>>> -	} else {
>>> -		/*
>>> -		 * rail should have been already enabled hence just make sure
>>> -		 * that unused flag is cleared.
>>> -		 */
>>> -		info->vccq->unused = false;
>>> -	}
>>> -out:
>>> -	return ret;
>>> -}
>>> -
>>>    static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
>>>    					bool skip_ref_clk)
>>>    {
>>>
> 
> 
