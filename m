Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932823AbeDXCsO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:48:14 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:51080 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932721AbeDXCsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:48:11 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180424024808epoutp0140c66075eb74e2b114b80d4715ef8bc5~oP1B9qY_81831818318epoutp01a
X-AuditID: b6c32a36-b6dff70000001027-c3-5ade9ae7d72d
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5ADE9AE6.9090601@samsung.com>
Date: Tue, 24 Apr 2018 11:48:06 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc: Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: Re: [PATCH 1/3] PM / devfreq: Actually support providing freq_table
In-reply-to: <20180424002016.9205-2-bjorn.andersson@linaro.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTURjGObt3916r1WmpHSaZ3YhQcu1uTW+l2Rc1yj+MkGJRdtGbrtxH
        u1MqiMpMY6W5PhSW2ZSiWFCh5aa2rFXYp4TDilKLxPVBWSlmgVTbrlF/nee85/e857wPh8Lk
        NYSCMphsvNXEFdLEBLz5TqIq+Z2zT6/yjSnYR+2DOOt2mNgnJZ9I1tH+hGQDrbUEO1xxF7BH
        nnsJ9kLHLwn76sBFgvXW72Hv//RiSyfqApUVEl2Ls5fU9Ty7Qeje+Jtw3beBl7iu8pob6IYb
        47NIPZ9WwHN5vDWBN+Wa8wym/HR67fqcFTnaFBWTzCxkU+kEE2fk0+mVmVnJqwyFoSfSCcVc
        YVGolMUJAj1/SZrVXGTjEwrMgi2d3sQwaiWjSlWq1aFVs3mRWhtCtvIF1Xa71DIcvevs8Wf4
        ftAP7YCiEFyAXI2sHUyg5NAL0KGqUVzcjAL0uemN1A6iIlDXWBspHrQBVB24jYcPZHAq+nGi
        Dw93wuBMdLdrR7iMwUR0ve3KON8L0E3PMSDySehq8BER1jicg0YfjEQ0Eaq3v38R0VPgLNT9
        oz/Cx8CNqOXs90ijaFgGUMlQDwhvMNgqQedd58jwzdNgJur8ZAkbomAGGjrtwcIMgr8JVFoz
        ND7CSvTuswOIehr62HGNFOePQ1330kW+HKByX924+SRAnc/7JKJBg4L1dok422Q0OHJUKppl
        6HCZXER06MsrHyHqZaj27VgkITnsACh4cG4ViHf+F5jzX2DO/wJzAcwNYnmLYMznBcaiVgqc
        USgy5StzzcZGEPmUSSle0NCZ6QeQAvQkmetnr14u5YqF3UY/QBRGR8t88X16uSyP272Ht5pz
        rEWFvOAH2lDeDkwRk2sOfXGTLYfRqjUaDbuASdEyDD1dNpD5WC+H+ZyN38HzFt761yehohT7
        AfhKXhE89TBgi1N5qtz71s27lNqzodPIdcsMW0bP1GIZzgzP0PLtFQ/c7jphOqUg9vY/bdh7
        mXz4Xfn6rXp1TLAhu/lmVf2BW13HgK+ndM62xR8cDwOawVlxa6pbPkw55bqYdb4sNraatf+S
        Zl+fsXan94vDEJzd7/WXZHcDjMaFAo5JwqwC9wd9RhpUqgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t9jAd3ns+5FGfQe5LI4vf8di8WqiXkW
        Z5vesFtM3H+W3eLyrjlsFp97jzBadF/fwWax/Pg/JovbjSvYLHYsrLI48XMHswO3x+W+XiaP
        nbPusnvcubaHzePBoc0sHh+f3mLx6NuyitHj8ya5APYoLpuU1JzMstQifbsEroxpXV2sBZ9F
        KuZPusbSwPhYoIuRk0NCwETi0p/d7F2MXBxCAjsZJR5fOsEKkuAVEJT4MfkeSxcjBwezgLzE
        kUvZIGFmAXWJSfMWMUPU32eUWL1lPTNEvZbEhmen2UBsFgFVie8nv4LZbEDx/S9ugNn8AooS
        V388ZgSZKSoQIdF9ohJkjohAB6PE7nNXWEAcZoFdTBIn1jaxgRQJC/hInHtTALHsOKPE74VT
        mUAGcQrYS3yavZ15AqPALCS3zkK4dRaSWxcwMq9ilEwtKM5Nzy02KjDMSy3XK07MLS7NS9dL
        zs/dxAiMkm2Htfp2MN5fEn+IUYCDUYmHd8HPu1FCrIllxZW5hxglOJiVRHj3yt2LEuJNSays
        Si3Kjy8qzUktPsQozcGiJM57O+9YpJBAemJJanZqakFqEUyWiYNTqoFRZXnwokKmvJSY+TZl
        UwTrC95srG0pyXJuYuBgWVwjuTEi7KPktpq9i7JWHl2pm/+iXuH8tBT+b4wnKn3Wufd2C1xZ
        8+3eU2PTv29n65S/T5i/uuP8n8mrK7d2fDujfvXL3HaP5fq1fc9VE9buKV7F/lbQhOlW97Up
        YXGGpytn7c0095NQnhaoxFKckWioxVxUnAgAWPhWjI4CAAA=
X-CMS-MailID: 20180424024807epcas1p1f85806e5a4b8258fb1912420df94ca1a
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180424002041epcas5p11439bec6de910c2a465c5cf3acb45a3b
X-RootMTR: 20180424002041epcas5p11439bec6de910c2a465c5cf3acb45a3b
References: <20180424002016.9205-1-bjorn.andersson@linaro.org>
        <CGME20180424002041epcas5p11439bec6de910c2a465c5cf3acb45a3b@epcas5p1.samsung.com>
        <20180424002016.9205-2-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 04월 24일 09:20, Bjorn Andersson wrote:
> The code in devfreq_add_device() handles the case where a freq_table is
> passed by the client, but then requests min and max frequences from
> the, in this case absent, opp tables.
> 
> Read the min and max frequencies from the frequency table, which has
> been built from the opp table if one exists, instead of querying the
> opp table.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> An alternative approach is to clarify in the devfreq code that it's not
> possible to pass a freq_table and then in patch 3 create an opp table for the
> device in runtime; although the error handling of this becomes non-trivial.
> 
> Transitioning the UFSHCD to use opp tables directly is hindered by the fact
> that the Qualcomm UFS hardware has two different clocks that needs to be
> running at different rates, so we would need a way to describe the two rates in
> the opp table. (And would force us to change the DT binding)
> 
>  drivers/devfreq/devfreq.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index fe2af6aa88fc..086ced50a13d 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -74,30 +74,16 @@ static struct devfreq *find_device_devfreq(struct device *dev)
>  
>  static unsigned long find_available_min_freq(struct devfreq *devfreq)
>  {
> -	struct dev_pm_opp *opp;
> -	unsigned long min_freq = 0;
> -
> -	opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &min_freq);
> -	if (IS_ERR(opp))
> -		min_freq = 0;
> -	else
> -		dev_pm_opp_put(opp);
> +	struct devfreq_dev_profile *profile = devfreq->profile;
>  
> -	return min_freq;
> +	return profile->freq_table[0];

It is wrong. The thermal framework support the devfreq-cooling device
which uses the dev_pm_opp_enable/disable().

In order to find the correct available min frequency,
the devfreq have to use the OPP function instead of using the first entry
of the freq_table array.

>  }
>  
>  static unsigned long find_available_max_freq(struct devfreq *devfreq)
>  {
> -	struct dev_pm_opp *opp;
> -	unsigned long max_freq = ULONG_MAX;
> -
> -	opp = dev_pm_opp_find_freq_floor(devfreq->dev.parent, &max_freq);
> -	if (IS_ERR(opp))
> -		max_freq = 0;
> -	else
> -		dev_pm_opp_put(opp);
> +	struct devfreq_dev_profile *profile = devfreq->profile;
>  
> -	return max_freq;
> +	return profile->freq_table[profile->max_state - 1];
>  }

ditto.

>  
>  /**
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
