Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AA1C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D242075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lvt/u5C5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D242075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756143AbeFSH0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:26:09 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54406 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755663AbeFSH0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:26:06 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180619072604euoutp02903c34a862ee50ac7cc7ba2683899eb7~5fvrh0xFo1926819268euoutp02q
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 07:26:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180619072604euoutp02903c34a862ee50ac7cc7ba2683899eb7~5fvrh0xFo1926819268euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529393164;
        bh=KPRxaA7S2ciUdTlu87+nDhSRqWRzsTiJAKkBuab3oMc=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=lvt/u5C5tkUnrj7rwGKhh2sHgD67pxkV/1VF99a/ymKOrN4vfv0jghQbQ5v+WV8Wx
         yUMfm3JN2YcC7qKONZQgWk3WXHGQ1hF1zv7AMi2ZIS4IhKG3UgJGAQQv+rWpVB7Eyt
         I4ctKya14e5kacngLOY+vp173cQ2KanpeOLvBd8c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180619072602eucas1p29b27da9d6c9849b010e09a950e327e56~5fvp1FYPP0159601596eucas1p2-;
        Tue, 19 Jun 2018 07:26:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4A.60.17380.A00B82B5; Tue, 19
        Jun 2018 08:26:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180619072601eucas1p27e2b081429ed54e6df8a5794ef0f150b~5fvopvw1v0712907129eucas1p2R;
        Tue, 19 Jun 2018 07:26:01 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180619072601eusmtrp292819ad28dce54e2b1aa89f2172c43e5~5fvoZTsu52626626266eusmtrp2V;
        Tue, 19 Jun 2018 07:26:01 +0000 (GMT)
X-AuditID: cbfec7f4-b4fc79c0000043e4-de-5b28b00a5b65
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 4A.0E.04178.900B82B5; Tue, 19
        Jun 2018 08:26:01 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180619072600eusmtip236a0ea8c8004e6e00a0c52f0e0176592~5fvn7b_Yu3261632616eusmtip2C;
        Tue, 19 Jun 2018 07:26:00 +0000 (GMT)
Subject: Re: [PATCH 2/2] arm64: dts: exynos: Remove unneeded DSI and DECON
 address/size cells in Exynos5433
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Tue, 19 Jun 2018 09:25:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618174216.24801-2-krzk@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHeXb3creaXKfiYVrhIFpFWlFwyYiiiH2K6EviIL3q9SXdlE0t
        C9OUdFnqMkRdokGpsXyZc9NaqDCtWTmnJqahJc2CTC2nQiu1Nq+S337nnP85z/8PD46JOjli
        PEmZTquUVIqEK2C3v3IPHBAYpPKDNS6M/FF/F5G1vQMcstT5HSMdDgOPNDpHOeQ7SzWXrHR0
        scim3kkeWfd+iEXe6uzlkd8W+tgnt8kaaxqRzKi/zZW1Pc6RlZj0SLZo3HmeEyk4HkenJGXS
        qrAT0YLEL9p5LG1CdHXeXYVykcWnCPFxII5Apc3KLkICXEQ8QbA2McNjiiUEpsf9G5NFBPbW
        +6zNlXLHmw1VAwJteyHGFHMIfg6+4HpVfoQChktsHC/7ExUYFLtTvcwl9sJq2/i6hk3shunG
        ep6XA4gIaNW6MC8LCV94XTXN9jKfOApfVzrWNRixC/LNDzCGA+HDdC3L+zAQVh6MTNk9R3HP
        ciZ8HiAZp2fAUPwHMewHMzYTj+Fg+Pu8diNNDuRVjWDMHQ2CvkcNXGYQDj22IY73JuYx3WIJ
        Y9qnwLxcuN4GwgfG5nwZOz5Q1l6BMW0haApEjDoEPtnNGMOBUDe4vHFcBpp7nSwtCtFtCazb
        ElK3JaTuv4eHiK1HgXSGWpFAqw8r6SuhakqhzlAmhMamKozI86nertmWniHLSowVETiSbBdK
        W/bIRRwqU52lsCLAMYm/0FwnlYuEcVTWNVqVGqXKSKHVVhSEsyWBwkvSG5EiIoFKp5NpOo1W
        bU5ZOF+ci6RFxt/9H8t5s5Onu1W1jslzVufa2IKGjosXdwz9Ch6J7XffDOEvutwr5SAodVS3
        NpdcCNI2ddnrjdZsWVRZTczsrN48fmxFdUfR7ReemucqqjMEXI5fxfp2TFBtugLT1Oh1+dOw
        sz2D2S/z5ZP7L+qGfZ3RhRENyWKO29IsYasTqUP7MJWa+geTKlHWUAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7qcGzSiDU5eYbZ4v6yH0WL+kXOs
        Fv2PXzNbnD+/gd1i0+NrrBaXd81hs5hxfh+Txdojd9ktll6/yGTRuvcIu8XLjydYHLg91sxb
        w+ixaVUnm8fmJfUefVtWMXp83iQXwBqlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl/F0wjvmgjtCFe9+zmRsYNzF18XIySEhYCIx9fwp9i5GLg4h
        gaWMEisOzGKHSIhL7J7/lhnCFpb4c62LDaLoNaPEh7tPWEESwgK5Epf6jrOCJEQEZjJLzJ+7
        kgWiajOjRN/eV2DtbAKaEn8332QDsXkF7CRWNuxiBLFZBFQlnqxZBrZOVCBComneGnaIGkGJ
        kzOfsIDYnAKmEs/+bAeLMwuoS/yZd4kZwpaXaN46G8oWl7j1ZD7TBEbBWUjaZyFpmYWkZRaS
        lgWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzEC43DbsZ+bdzBe2hh8iFGAg1GJh7dho3q0
        EGtiWXFl7iFGCQ5mJRHerUs1ooV4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5gi8kriDU0N
        zS0sDc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MIrnyv90zElLOvdjuex87v/m
        tzbUZzIpHspU2NTmF+4fvi9r07+T72fIFB4/Ns2S2Urss/s8zy0O0jPUuty+XeaKMXR7f/Q7
        59yQd9OKObqLXb5K92rMeliwSMrP71Ptr8u3zzFruq8ILjj8Tsh23nnnZYKi67KF7eblrZyQ
        xVO8KPjS7JfFZ5RYijMSDbWYi4oTAb8T6yPZAgAA
Message-Id: <20180619072601eucas1p27e2b081429ed54e6df8a5794ef0f150b~5fvopvw1v0712907129eucas1p2R@eucas1p2.samsung.com>
X-CMS-MailID: 20180619072601eucas1p27e2b081429ed54e6df8a5794ef0f150b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180618174318epcas1p4a79e7e7328d3b604efc3084e323421d7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180618174318epcas1p4a79e7e7328d3b604efc3084e323421d7
References: <20180618174216.24801-1-krzk@kernel.org>
        <CGME20180618174318epcas1p4a79e7e7328d3b604efc3084e323421d7@epcas1p4.samsung.com>
        <20180618174216.24801-2-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.06.2018 19:42, Krzysztof Kozlowski wrote:
> The decon, decon_tv and dsi nodes have only one child port so
> address/size mappings are not necessary.  This fixes DTC warnings like:
>
>     Warning (graph_child_address): /soc/decon@13800000/ports:
>         graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

DECON nodes according to documentation have only one port so it is OK.
DSI has two ports, but since on all Exynos platforms DSI panels/bridges
are subnodes of ExynosDSI the 2nd port is not used.
So if there will be a platform with DSI panel/bridge controlled via I2C,
it should be reverted., but this is theoretical problem.



>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej


> ---
>  arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi |  6 +-----
>  arch/arm64/boot/dts/exynos/exynos5433.dtsi            | 12 ++----------
>  2 files changed, 3 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> index a1e3194b7483..0a15ee513f5c 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
> @@ -321,11 +321,7 @@
>  	status = "okay";
>  
>  	ports {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		port@0 {
> -			reg = <0>;
> +		port {
>  			tv_to_hdmi: endpoint {
>  				remote-endpoint = <&hdmi_to_tv>;
>  			};
> diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> index 3a9b4c4b9c63..e4367fd39120 100644
> --- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
> @@ -850,11 +850,7 @@
>  			iommu-names = "m0", "m1";
>  
>  			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> +				port {
>  					decon_to_mic: endpoint {
>  						remote-endpoint =
>  							<&mic_to_decon>;
> @@ -914,11 +910,7 @@
>  			#size-cells = <0>;
>  
>  			ports {
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -
> -				port@0 {
> -					reg = <0>;
> +				port {
>  					dsi_to_mic: endpoint {
>  						remote-endpoint = <&mic_to_dsi>;
>  					};


