Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id aDCHC4TGGFt8SAAAmS7hNA
	; Thu, 07 Jun 2018 05:45:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 12857608BA; Thu,  7 Jun 2018 05:45:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OxKNhtMB"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7641E601C3;
	Thu,  7 Jun 2018 05:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7641E601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752553AbeFGFph (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:45:37 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41897 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbeFGFpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:45:35 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180607054532euoutp02978bd60489e7b06e29ce667e94ec7da2~1yoezRQC-2663826638euoutp020
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 05:45:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180607054532euoutp02978bd60489e7b06e29ce667e94ec7da2~1yoezRQC-2663826638euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528350332;
        bh=P5FgA8rJEpmX1TGK20WN9BH5aZ/qVQwKivgVb7kBgTA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OxKNhtMBMvKKH2/GmdCaycoDdfogibki9crIS7LmyucRXUDfaXhVxYHCoS3v8Gyu5
         FeR09GJA53d6COjBpv00PiIDY91HjTDBrxh7Wa9dKEabU/JC9IPD57nmtZNFqSpyx/
         vIDBv8ZiqU5e/8P/IGZBXdFnMucm7G69NkyViNgE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180607054531eucas1p2fa5287cfc0ae1e338ddecb55fabea631~1yod950XP2924329243eucas1p2v;
        Thu,  7 Jun 2018 05:45:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A5.54.10409.B76C81B5; Thu,  7
        Jun 2018 06:45:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180607054530eucas1p2678c5763e1cf27f090aa007eb6b19399~1yoc6wQOZ2924329243eucas1p2u;
        Thu,  7 Jun 2018 05:45:30 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180607054530eusmtrp13482ac7c99df702225118abc6d55c3a2~1yocsNjYq1665516655eusmtrp1B;
        Thu,  7 Jun 2018 05:45:30 +0000 (GMT)
X-AuditID: cbfec7f5-b45ff700000028a9-83-5b18c67b09e2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CD.8F.04183.A76C81B5; Thu,  7
        Jun 2018 06:45:30 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180607054530eusmtip1e24c33c648467762b0e965a0c0e4a693~1yocTdcWA1649916499eusmtip1l;
        Thu,  7 Jun 2018 05:45:30 +0000 (GMT)
Subject: Re: [PATCH 1/3] drm/bridge: Move the struct drm_bridge member
 kerneldoc inline.
To: Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Date: Thu, 7 Jun 2018 07:45:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606190431.1833-1-eric@anholt.net>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djP87rVxySiDRofylk0dbxltbjy9T2b
        xYHGy4wWnROXsFtc3jWHzYHVo+n9MTaPy329TB6zO2ayetzvPs7k8XmTXABrFJdNSmpOZllq
        kb5dAlfG+5k/mAsO8ld0fFvO0sA4i6eLkZNDQsBE4nvbTbYuRi4OIYEVjBJvl85ih3C+MEoc
        7V0AlfnMKHHjzG12mJZFe54wQiSWM0rsfPSKGcJ5yyjx9d8FVpAqYYEoiUkbjrOAJEQEljBK
        XGp4CZZgFlCQ+HVvE5jNJqAp8XczyHZODhYBFYkt+96BrRAViJDYOOETM4jNKyAocXLmExYQ
        mxNodevkt2wQc+QlmrfOZoawxSVuPZnPBLJMQmAZu8TkF4+YIJrLJL793wx1t4vE+W33mCBs
        YYlXx7dAxWUkTk/uYYGw6yWaZl5hhhjUwShxYvFyNoiEtcTh4xeBruYA2qYpsX6XPkTYUeL/
        3WY2kLCEAJ/EjbeCEPfwSUzaNp0ZIswr0dEmBFGtKHH/7FZmCFtcYumFr2wTGJVmIflyFpLP
        ZiH5bBbC3gWMLKsYxVNLi3PTU4uN81LL9YoTc4tL89L1kvNzNzECU87pf8e/7mDc9yfpEKMA
        B6MSD2/DffFoIdbEsuLK3EOMEhzMSiK8iZfEooV4UxIrq1KL8uOLSnNSiw8xSnOwKInzxmnU
        RQkJpCeWpGanphakFsFkmTg4pRoYV7Sb8uS9/tC3WqIx/8zVviNdkjsaM7dpewgeauH82c7e
        1mNar+23Mm+Pxc1pCwRXt0rfrN3+LuL0YqugXaEZVWphSaLuD0+xb7Wc5JD3+FLjnBKT9p9S
        stteqW9/Yj5HOCko8uSUqL32X7IOK/z4tGnRy03zkiT9IqRnNJhd/RWwsMDWYP0aJZbijERD
        Leai4kQA7loT9TUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsVy+t/xu7pVxySiDZqfClk0dbxltbjy9T2b
        xYHGy4wWnROXsFtc3jWHzYHVo+n9MTaPy329TB6zO2ayetzvPs7k8XmTXABrlJ5NUX5pSapC
        Rn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G+5k/mAsO8ld0fFvO
        0sA4i6eLkZNDQsBEYtGeJ4xdjFwcQgJLGSU2HtzADpEQl9g9/y0zhC0s8edaFxtE0WtGiXt/
        u1hBEsICURKTNhxnAUmICCxhlFjR3MEEkmAWUJD4dW8TK0RHO6PE6kdHGEESbAKaEn8332QD
        sXkF7CSOv/zLAmKzCKhIbNn3Dmy1qECERNO8NewQNYISJ2c+AavhBLq1dfJbNogF6hJ/5l1i
        hrDlJZq3zoayxSVuPZnPNIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0
        veT83E2MwCjbduznlh2MXe+CDzEKcDAq8fDeeCgeLcSaWFZcmXuIUYKDWUmEN/GSWLQQb0pi
        ZVVqUX58UWlOavEhRlOg5yYyS4km5wMTQF5JvKGpobmFpaG5sbmxmYWSOO95g8ooIYH0xJLU
        7NTUgtQimD4mDk6pBsYLrJIWx3ZNUyvVSyi/GntOfN/O1fPeR1u77F4gtfSp2LzyFOVTCVyi
        YfJX7q5L3LDB5Z3dlkT2tCM9H+e2bX92673SqUW/tHb+8RQunVtzL3qp3YqX5pq70k3Oahtr
        hZkkXyhmf7Po5VXfU7JLPUUP16sv8SyYmdOyorUzavYKCZHlTFVTlDcqsRRnJBpqMRcVJwIA
        8UWUccgCAAA=
Message-Id: <20180607054530eucas1p2678c5763e1cf27f090aa007eb6b19399~1yoc6wQOZ2924329243eucas1p2u@eucas1p2.samsung.com>
X-CMS-MailID: 20180607054530eucas1p2678c5763e1cf27f090aa007eb6b19399
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180606190438epcas1p223d6d831b809736dcec00261438c2f41
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180606190438epcas1p223d6d831b809736dcec00261438c2f41
References: <CGME20180606190438epcas1p223d6d831b809736dcec00261438c2f41@epcas1p2.samsung.com>
        <20180606190431.1833-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.06.2018 21:04, Eric Anholt wrote:
> This makes it more likely that the docs stay updated with the code.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej
> ---
>  include/drm/drm_bridge.h | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 70131ab57e8f..bd850747ce54 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -270,27 +270,29 @@ struct drm_bridge_timings {
>  
>  /**
>   * struct drm_bridge - central DRM bridge control structure
> - * @dev: DRM device this bridge belongs to
> - * @encoder: encoder to which this bridge is connected
> - * @next: the next bridge in the encoder chain
> - * @of_node: device node pointer to the bridge
> - * @list: to keep track of all added bridges
> - * @timings: the timing specification for the bridge, if any (may
> - * be NULL)
> - * @funcs: control functions
> - * @driver_private: pointer to the bridge driver's internal context
>   */
>  struct drm_bridge {
> +	/** @dev: DRM device this bridge belongs to */
>  	struct drm_device *dev;
> +	/** @encoder: encoder to which this bridge is connected */
>  	struct drm_encoder *encoder;
> +	/** @next: the next bridge in the encoder chain */
>  	struct drm_bridge *next;
>  #ifdef CONFIG_OF
> +	/** @of_node: device node pointer to the bridge */
>  	struct device_node *of_node;
>  #endif
> +	/** @list: to keep track of all added bridges */
>  	struct list_head list;
> +	/**
> +	 * @timings:
> +	 *
> +	 * the timing specification for the bridge, if any (may be NULL)
> +	 */
>  	const struct drm_bridge_timings *timings;
> -
> +	/** @funcs: control functions */
>  	const struct drm_bridge_funcs *funcs;
> +	/** @driver_private: pointer to the bridge driver's internal context */
>  	void *driver_private;
>  };
>  
