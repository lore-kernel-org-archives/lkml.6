Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35505C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1883206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pCUZAAQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1883206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbeIMOkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:40:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35637 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbeIMOkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:40:24 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180913093144euoutp015110dc260a39f83f77e241a9ebe2ccab~T678-CIZr1846818468euoutp01f
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 09:31:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180913093144euoutp015110dc260a39f83f77e241a9ebe2ccab~T678-CIZr1846818468euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536831104;
        bh=zSwIA1/iz4YSPkoGRU9yEwAB6hVZ9L4vgiVgJbPB2dc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pCUZAAQEfZlNzdt4rl30g3Tts5YV7lNWZf+a0UCRAi9Gq8mjNxP9IkojWwnbCdH2L
         3gFOSCmzDc1JZ+mRoaFrcs4nqH3gPz4mHJfnRMjtYfxpBoGNmclLSACRm4GlfpFoJW
         HA0Q1l+zioV6E6VgFD7uB3ZpD33bEqJMCn44M1V8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180913093144eucas1p22ea4c455172f4d7582b5cce6dd31bef4~T678jNi6m2855728557eucas1p2p;
        Thu, 13 Sep 2018 09:31:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6A.F1.04441.F7E2A9B5; Thu, 13
        Sep 2018 10:31:43 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180913093142eucas1p131c2ef771af3ee9fd7096f8a5ce673b5~T677eyaxO2985429854eucas1p1V;
        Thu, 13 Sep 2018 09:31:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180913093142eusmtrp2f29a6586cd2a27df085e945d71cc20c9~T677OF-Ua1714917149eusmtrp27;
        Thu, 13 Sep 2018 09:31:42 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-6d-5b9a2e7f0ab2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CC.C6.04128.E7E2A9B5; Thu, 13
        Sep 2018 10:31:42 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180913093142eusmtip1251acb069402b6906f7e6e97bdf441f2~T6766nS1h0989709897eusmtip1S;
        Thu, 13 Sep 2018 09:31:42 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] drm: bridge: document bridge attach/detach
 imbalance
To:     Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Vincent Abriou <vincent.abriou@st.com>
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Thu, 13 Sep 2018 11:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180806061910.29914-3-peda@axentia.se>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsWy7djP87r1erOiDSZ+0LToPXeSyeLK1/ds
        Fpd3zWGz2HtoPqPFmasHWBxYPaYdmM3usf3bA1aP+93HmTye/tjL7PF5k1wAaxSXTUpqTmZZ
        apG+XQJXxpdTZ5gL9nFU7Nx4lbWB8RNbFyMnh4SAicT89YuZuxi5OIQEVjBKPL+1gB3C+cIo
        sXDPBajMZ0aJs807WLsYOcBaTi0ShYgvZ5Q4s3gWG4TzllHi3YEmFpC5wgJBEpdWnWICsUUE
        7CWmXnsJZjML5El0PDwDtptNQFPi7+abYDaLgKrE+lOXmEFsUYEIiSMPFjKC2LwCghInZz4B
        m8kpYCpxcu4iqDnyEtvfzmGGsMUlbj2ZzwRyhITAPHaJ9qfHmUEu5RUokzhwJhXiTxeJta3P
        2SFsYYlXx7dA2TIS/3fOZ4Kw6yWaZl5hhpjTwShxYvFyaCBZSxw+fhHse2ago9fv0ocIO0o8
        ff+WHRIofBI33gpCnMMnMWnbdGaIMK9ER5sQRLWixP2zW5khbHGJpRe+sk1gVJqF5MlZSB6b
        heSxWQh7FzCyrGIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMNqf/Hf+0g/HrpaRDjAIc
        jEo8vDPUZ0YLsSaWFVfmHmKU4GBWEuF9zQ4U4k1JrKxKLcqPLyrNSS0+xCjNwaIkzsunlRYt
        JJCeWJKanZpakFoEk2Xi4JRqYPQ8KKjIxTBdTvnl/cOndixTMfT2cfdmYPReblMherjxasbB
        OtcrK+65t5+/k5B5T5jJQ/d1UlL9jrP2a2LMXf/4aLpb5useWSdy7J1eqETOQb5nKpwVQhNu
        fP1+VV3TYPWB1QXv9yvPZPg8af132yemJWmdbwXSN144e+hjXd0K+Wl5P3flqyuxFGckGmox
        FxUnAgBjUtZ1MgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsVy+t/xu7p1erOiDZ7fkLfoPXeSyeLK1/ds
        Fpd3zWGz2HtoPqPFmasHWBxYPaYdmM3usf3bA1aP+93HmTye/tjL7PF5k1wAa5SeTVF+aUmq
        QkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexpdTZ5gL9nFU7Nx4
        lbWB8RNbFyMHh4SAicSpRaJdjFwcQgJLGSWe3W5m6WLkBIqLS+ye/5YZwhaW+HOtiw2i6DWj
        xLHv+5hAEsICQRKXVp0Cs0UE7CWmXnsJZjML5En8v9YK1bCZUWLdoulgk9gENCX+br7JBmLz
        CthJHHj+G6yBRUBVYv2pS2A1ogIREquXv2CFqBGUODnzCdhFnAKmEifnLoJaoC7xZx5EPbOA
        vMT2t3OgbHGJW0/mM01gFJqFpH0WkpZZSFpmIWlZwMiyilEktbQ4Nz232EivODG3uDQvXS85
        P3cTIzDCth37uWUHY9e74EOMAhyMSjy8L5RmRguxJpYVV+YeYpTgYFYS4X3NDhTiTUmsrEot
        yo8vKs1JLT7EaAr03ERmKdHkfGD055XEG5oamltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0t
        SC2C6WPi4JRqYDykzhz8uq1r3rZFzUUmckZFn52Nzyv+29dWef+w7rq3+347fVp1K7zeXrxp
        90wHzbWxH6Ktv2iGufU37s5+vHujut2UD/57Ul+21Mraa8zw4zjJP/Oa14SQpB+Om45J6fXo
        7juZ47L3oYGRrrxp+OPz3ltar269piciILZfY56HqchPpTvhPUosxRmJhlrMRcWJACepWt3G
        AgAA
Message-Id: <20180913093142eucas1p131c2ef771af3ee9fd7096f8a5ce673b5~T677eyaxO2985429854eucas1p1V@eucas1p1.samsung.com>
X-CMS-MailID: 20180913093142eucas1p131c2ef771af3ee9fd7096f8a5ce673b5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180806082220epcas4p383c3ee1b2ea8def665621ef82dba68d0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180806082220epcas4p383c3ee1b2ea8def665621ef82dba68d0
References: <20180806061910.29914-1-peda@axentia.se>
        <CGME20180806082220epcas4p383c3ee1b2ea8def665621ef82dba68d0@epcas4p3.samsung.com>
        <20180806061910.29914-3-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.08.2018 08:19, Peter Rosin wrote:
> Since 4a878c03d562 ("drm: bridge: Detach bridge from encoder at encoder
> cleanup time"), it is generally no longer correct to detach bridges from
> encoders manually. Document that.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/drm_bridge.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 1638bfe9627c..ba7025041e46 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -104,6 +104,10 @@ EXPORT_SYMBOL(drm_bridge_remove);
>   * If non-NULL the previous bridge must be already attached by a call to this
>   * function.
>   *
> + * Note that bridges attached to encoders are auto-detached during encoder
> + * cleanup in drm_encoder_cleanup(), so drm_bridge_attach() should generally
> + * *not* be balanced with a drm_bridge_detach() in driver code.
> + *
>   * RETURNS:
>   * Zero on success, error code on failure
>   */

Pushed to drm-misc-next.

--
Regards
Andrzej

