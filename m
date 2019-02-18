Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B36AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22E52089F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 00:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="obNtQILq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfBRAiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 19:38:08 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:36133 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbfBRAiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 19:38:08 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190218003806epoutp016e5d1a74b528b2a76ecb6f4e6473f9f8~ETlIcAZjT1614516145epoutp01Y
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 00:38:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190218003806epoutp016e5d1a74b528b2a76ecb6f4e6473f9f8~ETlIcAZjT1614516145epoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550450286;
        bh=7nj3ocltjNFOOTdf7p8rvZIU0Ljng0ibyFWeJV8weoE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=obNtQILqqr4mlvWhNQFk+k7trPw1Mk+a37iqzhQ9TyVBkNbhVpysIA5qz7glxhjOZ
         858DaOYAY6Qz/HlJgIQcCeUSO51D0wxeYvh3/dLF9VcGtWoYBb8KEM4G63bXmxi2tC
         Dh31hMHinL6z/AosBq3lh+p9T6lWTGfePleVT9ok=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190218003803epcas1p28a1bec16e815efd09d0e6faf8116fa12~ETlGISyYU2120821208epcas1p2F;
        Mon, 18 Feb 2019 00:38:03 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.BA.04206.B6EF96C5; Mon, 18 Feb 2019 09:38:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190218003803epcas1p49ca0f5950bc44d66e6fc0d66120949d4~ETlFvV1z-0314903149epcas1p4e;
        Mon, 18 Feb 2019 00:38:03 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190218003803epsmtrp1b28ce2981cedff89a6ebc7a143c1b71b~ETlFt5I9R0257102571epsmtrp1C;
        Mon, 18 Feb 2019 00:38:03 +0000 (GMT)
X-AuditID: b6c32a39-d7dff7000000106e-fb-5c69fe6b11bf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.45.03601.B6EF96C5; Mon, 18 Feb 2019 09:38:03 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190218003803epsmtip242bb766effc067fb63f7f56d6cfdf01b~ETlFfSwAC2560825608epsmtip2f;
        Mon, 18 Feb 2019 00:38:03 +0000 (GMT)
Subject: Re: [PATCH 3/3] PM / devfreq: tegra: remove unneeded variable
To:     Yangtao Li <tiny.windzz@gmail.com>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, heiko@sntech.de,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <7fe8f9ba-ffcc-55ed-38b0-f37538257c1b@samsung.com>
Date:   Mon, 18 Feb 2019 09:38:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190216151826.11584-4-tiny.windzz@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaUwTURD2dbfbBa2uVXTEqLjEGIlY1lpcRIgJiDXyAyNGMSS40k2p9Mpu
        SxRJPEMFqUeMRqvInXhEiVgvIlZRJJXgGbzQeGAUkSCiEo3xaHcx8u/7Zr6Zed+890hM4yci
        SbPNyQs2zkIT4fiFG7O0sfm/zdlxv3q07J83H5XsDm81zrZv61WxDV2PlOzDxqME+8VzE7ED
        r/5gbMlXL8F2bj1OsD8aj+Fs+c+9xKKRhsveFyrDudrNBs/2PsKw23cSGS4+OoYZvjRMzSDW
        5C/M4zkjL0Txtly70WwzJdHLVuSk5Ojj45hYJoGdT0fZOCufRKemZ8SmmS3B49FRBZzFFQxl
        cKJIa5MXCnaXk4/Ks4vOJJp3GC2OBMcckbOKLptpTq7duoCJi5urDwrX5uf1PPUiR2f4hs+e
        MnwLekqWIpIEah5cK11bisJJDXUJQduPq5hMBhAEnjwgZDKI4HVla5CESRX1tb1DiSYE7V87
        FDL5hOCAuwaFVOOoNLjjvqcKJcZTlQjOlByQCEbVIShvGsBDKoKKAX/3E6nvGGo6dHzvkqrV
        VDK4d5/HQhinZkBVd7ukiaBWww1P35BmLAQOv5X6hFGJ0NTxTtJj1ER49rZCIeNpsP38EckR
        UPtV0HLKj8kmUuH9x/dIxuOgp9WnknEkfNhTPIQ3wYnATUIu3onA57+nlBM68NftV4T2h1Gz
        oL5RKw8bDX3fypTyWtWws1gjq6Ph4asXChlPghp3ydAeDXCopQbfi6Z7h9nxDrPgHWbB+39Y
        JcJPogm8Q7SaeJFx6IffdwOSHm9MwiV06056M6JIRI9S9xeYszVKrkDcaG1GQGL0eHX1YDCk
        NnIbC3nBniO4LLzYjPTBbe/DIiNy7cGvYHPmMPq5Op2OncfE6xmGnqiuX5SSraFMnJPP53kH
        L/yrU5BhkVtQ3acquztx+WNTvXCwe1M/njXzdth1fX80uz5xRPjs0xGZ31tO5VZXTFlcWPw8
        Nl63xDei3bbqSve5ilThflLRs20Vu+jJ61rVAaGwvDelK+ARBH9zW+fSpQ8yla1nsjLTFu+q
        NLb57l8f0J6NLlKv1BUlj7zrdxHLx2QRP9MHy17SuJjHMTGYIHJ/AWkAe4jSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvG72v8wYg833+S3+P3rNatEyaxGL
        xdmmN+wWmx5fY7W4vGsOm8Xn3iOMFp8e/Ge26Pwyi83iduMKNoufu+axWMz9PYHNgdtj56y7
        7B6bl9R79Da/Y/Po27KK0WP7tXnMHp83yQWwRXHZpKTmZJalFunbJXBlvLo5i7HgNlfFx94e
        lgbGmxxdjJwcEgImEuuXvGHrYuTiEBLYzShx++Y+NoiEpMS0i0eZuxg5gGxhicOHiyFq3jJK
        TDt1iQmkRljATeJc+wV2kISIwAJGib8fX7CCJJgFljJK7H/DCtGxn1Fi672TYFPZBLQk9r+4
        AWbzCyhKXP3xmBHE5hWwk2jv28oMYrMIqEosfHEWrEZUIELi49N9TBA1ghInZz5hAbE5Bawl
        9l59xgyxTF3iz7xLULa4xK0n85kgbHmJ5q2zmScwCs9C0j4LScssJC2zkLQsYGRZxSiZWlCc
        m55bbFhglJdarlecmFtcmpeul5yfu4kRHIFaWjsYT5yIP8QowMGoxMP7oSwzRog1say4MvcQ
        owQHs5II76JvQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2CyTByc
        Ug2MjhaGsx54/m132mLu+Ejj8U5Bw30Tfuw7xp3Wcuu6l9NxOau41+xnl/BekvMK+zJzxufZ
        PyXOFzxcOq/h46lzBRu5//l/5zlU8PitAeeWCs+s+V3ascfaUi8Wbzmq+mb26/06x8/de+n8
        cdWiOM2zs192NxeuqlGsW54kp7NTefePauGO7Ko+PSWW4oxEQy3mouJEACdxfKy8AgAA
X-CMS-MailID: 20190218003803epcas1p49ca0f5950bc44d66e6fc0d66120949d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190216151918epcas1p25c2971b063cc66981fda6a67a8276585
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
        <CGME20190216151918epcas1p25c2971b063cc66981fda6a67a8276585@epcas1p2.samsung.com>
        <20190216151826.11584-4-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 2. 17. 오전 12:18, Yangtao Li wrote:
> This variable is not used after initialization, so
> remove it. And in order to unify the code style,
> move the location where the dev_get_drvdata is called
> by the way.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
> index c59d2eee5d30..c89ba7b834ff 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -573,10 +573,7 @@ static int tegra_governor_get_target(struct devfreq *devfreq,
>  static int tegra_governor_event_handler(struct devfreq *devfreq,
>  					unsigned int event, void *data)
>  {
> -	struct tegra_devfreq *tegra;
> -	int ret = 0;
> -
> -	tegra = dev_get_drvdata(devfreq->dev.parent);
> +	struct tegra_devfreq *tegra = dev_get_drvdata(devfreq->dev.parent);
>  
>  	switch (event) {
>  	case DEVFREQ_GOV_START:
> @@ -600,7 +597,7 @@ static int tegra_governor_event_handler(struct devfreq *devfreq,
>  		break;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static struct devfreq_governor tegra_devfreq_governor = {
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
