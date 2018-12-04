Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52651C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B3C20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B59GUeRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3B3C20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeLDEj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 23:39:56 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:21087 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeLDEj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 23:39:56 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181204043950epoutp01606f64eac8b6135d5033c0840b1f6a79~tB2gI20eR1222212222epoutp01I;
        Tue,  4 Dec 2018 04:39:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181204043950epoutp01606f64eac8b6135d5033c0840b1f6a79~tB2gI20eR1222212222epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1543898390;
        bh=FStVKS8Y+vrU/6MdfWAaEVGW8zwAeikhlhRYJ4rjjaY=;
        h=Date:From:To:Cc:Subject:In-reply-to:References:From;
        b=B59GUeRjjCYK5G+AsiVnVIvwkekWxQLaIUIyJawPxPuuZqM8zw3lxruPR3t9mZdxh
         hMqZSD9ooSURPjuewEUm2ZUPDkY6aj92YvtGiR6A4zfFKizFuXs2QB26wF3f+B4pSh
         Tyf9ITmGtnjf+iz1+KgZX3PIUpzx1g7qWudQHwt8=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181204043947epcas1p28327d1824343c3b03104d1b55ec51907~tB2cwdzjz2636026360epcas1p2J;
        Tue,  4 Dec 2018 04:39:47 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.9C.04146.215060C5; Tue,  4 Dec 2018 13:39:46 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181204043946epcas1p130439f684c1137c352588bff19927815~tB2cDgM1A2960229602epcas1p17;
        Tue,  4 Dec 2018 04:39:46 +0000 (GMT)
X-AuditID: b6c32a38-177ff70000001032-50-5c060512249b
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id B4.EF.03601.115060C5; Tue,  4 Dec
        2018 13:39:46 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Received: from [10.113.63.77] by mmp2.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PJ700CC03M96J10@mmp2.samsung.com>; Tue, 04 Dec 2018 13:39:45 +0900 (KST)
Message-id: <5C060511.8020802@samsung.com>
Date:   Tue, 04 Dec 2018 13:39:45 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     tjakobi@math.uni-bielefeld.de, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, rjw@rjwysocki.net, len.brown@intel.com,
        pavel@ucw.cz, gregkh@linuxfoundation.org, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Subject: Re: [PATCH v2 1/5] devfreq: refactor set_target frequency function
In-reply-to: <1543847475-7600-2-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJsWRmVeSWpSXmKPExsWy7bCmga4QK1uMwefVehYHt2pabJyxntVi
        +8ZvrBbzj5xjtWhevJ7N4kx3rkX/49fMFufPb2C3ONv0ht3iVoOMxawpe5ksNj2+xmpxedcc
        NovPvUcYLWac38dksfbIXXaLpdcvMlncblzBZnH31FGgGacvsVq07j3CbtG2+gOrxZsL91gc
        xD227d7G6rFm3hpGj9kNF1k8JvR/YvRYvOclk8emVZ1sHvvnrmH32Lyk3uPfMXaPg+/2MHls
        udrO4tG3ZRWjx4rV39k9Pm+SC+CLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpfSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgWaBX
        nJhbXJqXrpecn2tlaGBgZApUmJCdMWfvHLaCFTIV3Vfa2BoYO8S7GDk5JARMJPr372bsYuTi
        EBLYwSgx7/oCZgjnO6PE/y07mWCqOqY8g0psYJR4/HgVI0iCV0BQ4sfkeyxdjBwczALyEkcu
        ZYOEmQU0JV58mcQCUX+XUWJV32uoei2J84dXsIPYLAKqEl8nHWIBsdmA4vtf3GADsfkFFCWu
        /ngMVi8qECGxc/43dpBBIgLnGSXW7NzDBOIwC7QyS/z7sAWsQ1jAW2JJy1uwSZwCXhK7H58D
        Wy0h8JNd4vW9B6wQP7hI7D60gR3CFpZ4dXwLO8jZEgLSEpeO2kLUtzNKfHnRzArhTGCU+HBq
        MzQAjCWeLexigniOT+Ld1x5WiGZeiY42IYgSD4mrX3eCHQT28+XtFRMYZWchhdIsRCjNQgql
        BYzMqxjFUguKc9NTiw0LTJDjbxMjOLFrWexg3HPO5xCjAAejEg/vDCfWGCHWxLLiytxDjBIc
        zEoivAWFLDFCvCmJlVWpRfnxRaU5qcWHGE2BgTyRWUo0OR+YdfJK4g1NjYyNjS1MDM1MDQ2V
        xHmfSM2NFhJITyxJzU5NLUgtgulj4uCUamA8JnZsO6NrlZmH1yLLZRw79ukd/SLxwDjjTvYM
        mWW5ovlTb71/n+WvxfCrtyHR78vKhBKG9g4u8Xs597dYhx+dbytZeLA/RvbZiln3a5/vKGdX
        yn9f2f1rz/+zbu+/VDucFs+0exKVveTphS/C53ZuyXQyET474+Aex4IwuaRIKQk99cCZZWlK
        LMUZiYZazEXFiQAEweNLAgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02RXUhTYRzGe3c+Xa6Oy/B1mdUgRCPN6OIlpKSbjvMm6KIswUY7qOnm3HGm
        Xugsv8WvGiHLL3DVUtP8mqFOcy6NLJerZSQqOKgkk1AqE7Q8jbC7H//n4Xke+NOY1I3L6GRN
        BqfTKFPlpBif2PT4HZUSZPyxIasYjfSGos7aDgL1df4gUKNjkkA3mztI9LJcjao8XzDkdD6m
        0KsbSxT6YAhCJqNNhLo87wj0pr+ORKsVDoBqnUMi9MgxS6F701MiNJNvIdHsi2dbGRMuAhXa
        HBQqav1GoKXXc3h0AGsdsBJsW0MbYO8apnC2umoFsM2DiyK2q6WUZIfr2yi225zHbo5R7Mjy
        oIjtcRfjbGVPC2AtrT8pdrUr+NyuS+IoFZeanMnpIk5dESfV2epIrSUoq/xtEWkAJQFlwIeG
        zAlYYvyIlQExLWXaAaxxLQNBkDB+cO32HF4GaBpjDkCHK8WLIdBoVHvt8wAujv/GvPYw6By1
        UALjzGH4/ZYdF5jcug9/fk8KvJs5BN1rHiDk7GUuwvLn2UKOP+MEcKSylBA8GFOIwYWiawLv
        YWKhueAr7i2bBbChuONvmQ+jgAOeSbwaMKb/ppq2p5q2pzYBrAUEclpenajmj2sjNdz1cF6p
        5vWaxPCraeousPVs62hY5RMwb06wA4YGcl9J7RkiXkooM/lstR1AGpP7S7TpeLxUolJm53C6
        tASdPpXj7WAfjcsDJDOasTgpk6jM4FI4Tsvp/qki2kdmAEzauPnB6U+2et61f+dIY57ePzNi
        5sjw5Zrc/BiV2WqdLihdcc/FaUP6fdnlUHGCgj9voZ8qotp/pVfMy2wPF7JimlRuzf2N4Bz7
        2Y2JOtednhBFp7n7YP14kL4wcAclqemW95FUoYTrHY0PUdkq12M5GdmUe+GkrH49WifH+SRl
        ZBim45V/ACZ7Na3oAgAA
X-CMS-MailID: 20181204043946epcas1p130439f684c1137c352588bff19927815
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5
References: <1543847475-7600-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181203143129eucas1p2955b6becc60ee57110cbc52f6e4f60c5@eucas1p2.samsung.com>
        <1543847475-7600-2-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On 2018년 12월 03일 23:31, Lukasz Luba wrote:
> The refactoring is needed for the new client in devfreq: suspend.
> To avoid code duplication, move it to the new local function
> devfreq_set_target.
> 
> The patch is based on earlier work by Tobias Jakobi.

As I already commented, Please remove it. You already mentioned it on cover-letter.
If you want to contain the contribution history of Tobias, you might better
to add 'Signed-off-by' or others.

> 
> Suggested-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 62 +++++++++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 1414130..a9fd61b 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -285,6 +285,40 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>  	return 0;
>  }
>  
> +static int devfreq_set_target(struct devfreq *devfreq, unsigned long new_freq,
> +			      u32 flags)
> +{
> +	struct devfreq_freqs freqs;
> +	unsigned long cur_freq;
> +	int err = 0;
> +
> +	if (devfreq->profile->get_cur_freq)
> +		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
> +	else
> +		cur_freq = devfreq->previous_freq;
> +
> +	freqs.old = cur_freq;
> +	freqs.new = new_freq;
> +	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
> +
> +	err = devfreq->profile->target(devfreq->dev.parent, &new_freq, flags);
> +	if (err) {
> +		freqs.new = cur_freq;
> +		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> +		return err;
> +	}
> +
> +	freqs.new = new_freq;
> +	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> +
> +	if (devfreq_update_status(devfreq, new_freq))
> +		dev_err(&devfreq->dev,
> +			"Couldn't update frequency transition information.\n");
> +
> +	devfreq->previous_freq = new_freq;
> +	return err;
> +}
> +
>  /* Load monitoring helper functions for governors use */
>  
>  /**
> @@ -296,8 +330,7 @@ static int devfreq_notify_transition(struct devfreq *devfreq,
>   */
>  int update_devfreq(struct devfreq *devfreq)
>  {
> -	struct devfreq_freqs freqs;
> -	unsigned long freq, cur_freq, min_freq, max_freq;
> +	unsigned long freq, min_freq, max_freq;
>  	int err = 0;
>  	u32 flags = 0;
>  
> @@ -333,31 +366,8 @@ int update_devfreq(struct devfreq *devfreq)
>  		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>  	}
>  
> -	if (devfreq->profile->get_cur_freq)
> -		devfreq->profile->get_cur_freq(devfreq->dev.parent, &cur_freq);
> -	else
> -		cur_freq = devfreq->previous_freq;
> -
> -	freqs.old = cur_freq;
> -	freqs.new = freq;
> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_PRECHANGE);
> +	return devfreq_set_target(devfreq, freq, flags);
>  
> -	err = devfreq->profile->target(devfreq->dev.parent, &freq, flags);
> -	if (err) {
> -		freqs.new = cur_freq;
> -		devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> -		return err;
> -	}
> -
> -	freqs.new = freq;
> -	devfreq_notify_transition(devfreq, &freqs, DEVFREQ_POSTCHANGE);
> -
> -	if (devfreq_update_status(devfreq, freq))
> -		dev_err(&devfreq->dev,
> -			"Couldn't update frequency transition information.\n");
> -
> -	devfreq->previous_freq = freq;
> -	return err;
>  }
>  EXPORT_SYMBOL(update_devfreq);
>  
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
