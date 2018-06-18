Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEA8C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EDAE2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SBQW4Y/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EDAE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933639AbeFRLYD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:24:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55942 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933381AbeFRLYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:24:01 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180618112359euoutp027c2b3e36895a56ece80e7ab18db286bb~5PWIDFii01527315273euoutp02Y
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:23:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180618112359euoutp027c2b3e36895a56ece80e7ab18db286bb~5PWIDFii01527315273euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529321039;
        bh=9c9/5ZNXvpS3tkPo7PtPJ3I27GUnayLGZK26wPgDu9w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SBQW4Y/7mmB5K6wL9kUFmVWQBSzqcogt4qAOVNPKH0vNWKUgQRbdveurYOacgHg3h
         47CES1DqaPuWRoGMqjOtmb6xcPiKBTRvyFdd6TWfOO+s/qjsYjdPlTtgyhJvvy7DCq
         IabjmumpLOQWOHa4bFgxdfcXa0SXq32Vpi+pBI8g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180618112357eucas1p1a7d96f43c102686a00e1e4f6ba595409~5PWGblDwJ2566625666eucas1p1n;
        Mon, 18 Jun 2018 11:23:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 21.B1.05700.D46972B5; Mon, 18
        Jun 2018 12:23:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180618112356eucas1p1096192ad9dc12c84a3a4beda554b7c44~5PWFYOHzV2540325403eucas1p1m;
        Mon, 18 Jun 2018 11:23:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180618112356eusmtrp29dc969e7381a74ce5f705cbbc866dee5~5PWFIdYIp1653716537eusmtrp2Q;
        Mon, 18 Jun 2018 11:23:56 +0000 (GMT)
X-AuditID: cbfec7f2-1dbff70000011644-be-5b27964df3b8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 68.B0.04178.C46972B5; Mon, 18
        Jun 2018 12:23:56 +0100 (BST)
Received: from [106.120.51.25] (unknown [106.120.51.25]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180618112355eusmtip15153e5f6a65deb02705ab439635f1cf4~5PWESyoNV1931819318eusmtip1h;
        Mon, 18 Jun 2018 11:23:55 +0000 (GMT)
Subject: Re: [PATCH v2 07/10] dt-bindings: tc358754: add DT bindings
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Maciej Purski <m.purski@samsung.com>
Date:   Mon, 18 Jun 2018 13:23:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180531040211.GA23051@rob-hp-laptop>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUxTURCGc+7WS7XkUFBG3GINsqgs6sNJMMbt4T5I1MiDEQUrXJHYIvYC
        CkalmGjRgAsuUI1ABIUGRNYCLonQQACFIAhK2BQXVKqJiMYYRdqLkbfv/PPPzD/J4Wm1kfPi
        Y+MSREOcVqfhlExN08/2laFXfcKDvtiXkr677SzJaG+hSJrJzpLy7DKW5NqmtO6JLxy5NHSB
        IaODnQw5P/KJJh0d9xTkadqYgqRfLFCQipEelnTV3+BIdscjipTaBhSksLeTIpMPahUkO+sD
        R37W32TWewglN0uQ0JWZQQl15gGFcN2UwwoVlnROsH4fZoWhc82UUFlwUsissiBhvGLRNuUu
        5dpoURebJBoC1+1VHqiq+cXGGz2ONhW8Y1JRFj6LXHjAayCvPUNxFil5NS5CUPnYNv34hqDl
        Rz/jcKnxOALbS99/HWP1Rko23UGQn2dl5YcdQV9vD3K43PFmaBp86GQPvAR+nb7qNNF4goWc
        /sapHTzPYX8oORPpQAZ7Q2612mGfg3dC/pW3zlYVdoOWnDfOEC54NXS31jl1GntC35tcSubF
        YLXfoB3jAdfy8Pxa+XRzEpQNZ3Fy6s1QXfyZktkdPjZXKWReAJN1udP6MSj+cIeRB6Ui+DbQ
        RcuFEGhs7mQdQWnsB2X1gQ4EvAEqP3MyusILu5scxxUu1VyjZVkFptNqeYYGRrN/Ty8CKGx5
        zV5AGvOMI80zDjPPOMz8f20eYizIU0yU9DGiFBwnHgmQtHopMS4mIOqQvgJNfcy2P81fa9HE
        s30NCPNIM1s1nLksXM1qk6RkfQMCntZ4qHwW+ISrVdHa5BTRcCjSkKgTpQY0n2c0nqoI3xO7
        1DhGmyAeFMV40fCvSvEuXqkoOXAYzfP2DZrsehSmCpnI61yV7hVx/3bPrbL5xSkrTVs37MAb
        9XtOWXzX2L9qdZ7u4wluT9eWVr+P9Nt/ZdOs3rFnC+eabFJjcd3HJ6Fbtl3eTlu8rN5FAW66
        40f7E1hjfJtLa2hp9/nDr7jnISwT1WbdjZf3GN8/SQsOy3GNSlmhYaQD2mB/2iBp/wJIqX15
        lAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec9lOy4HpznzdUTloAyj6fG21/BGVBykD0EYpZhNPajoNtnZ
        LOuDlw+lhrdE0SWuDxokXqd5mSUlolmpeEnR8G4XUfFDJsxrmyPw24//8//x8MBD4ZJyUkYl
        a/ScTqNKlQtExJeDgdnLN8s9o31aSmVopnGYRAXDgxjKyd0gUUtFE4lMfbZs4u+mAL2YLybQ
        77lRAhUtr+FoZKRZiIZy1oUor6RGiMzLkyQat1QJUMVID4Ya+maFqHZqFEOH7zqFqKJ0VYCs
        lmoiXMrWV9cDdrywAGO7jLNC9mVuJcma6/IEbMf2AsnOPx/A2NaaTLawrQ6wf8xnbomiFME6
        rUHPnUvS8voQeTSDfBVMEFL4+gcpGD9lzBXfALl3aHACl5qczum8Qx8oktrad8m0bOmj/pqf
        RBYopfOBEwVpf7huycbygYiS0LUATk58EjgGEA7NH5IOdoF7k/kCR2kNQPPH/aOBC30N9s+9
        B3aW0h5w92k5aS/htJWEzYOLhMPYAXCxesu2g6IEtBesfxZrF8R0KGyq+oDbY4I+D01vJfbY
        lb4L896YCEflJBysXDliJ9oPTnzuOtqF04GwunURd7AbnFkxYQ4+Czs2qvBiIDEe043HFOMx
        xXhMeQWIOiDlDLw6Uc0zCl6l5g2aREW8Vm0Gtp9o77e2doKxltu9gKaA3Fm8UHghWkKq0vkM
        dS+AFC6Xij1Pe0ZLxAmqjMecThurM6RyfC8IsN1Wgstc47W2D9PoY5kARomCGKWf0i8Qyd3E
        Iz4ZURI6UaXnUjgujdP99zDKSZYFLrH+K51ZZQcm/hbRo2iMiHTeKIqzui+tjLp97RaFTD8U
        tU+X3Ld8c79eezWslsls+J6yvOSyBzJ/OC+Eyu65nnpijYzBumi35qATgRdFy+sHcVvjldPz
        mtfhRaKxKWonbNYjuEx8p3G9+YZ3qXroYMyZ2mRhgv+2fL87YvWXnOCTVIwXruNV/wB6oaQd
        KQMAAA==
Message-Id: <20180618112356eucas1p1096192ad9dc12c84a3a4beda554b7c44~5PWFYOHzV2540325403eucas1p1m@eucas1p1.samsung.com>
X-CMS-MailID: 20180618112356eucas1p1096192ad9dc12c84a3a4beda554b7c44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180530121627eucas1p1c8daf24d7c95e9e8b04a523d4662dfd9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530121627eucas1p1c8daf24d7c95e9e8b04a523d4662dfd9
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
        <CGME20180530121627eucas1p1c8daf24d7c95e9e8b04a523d4662dfd9@eucas1p1.samsung.com>
        <1527682561-1386-8-git-send-email-m.purski@samsung.com>
        <20180531040211.GA23051@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/31/2018 06:02 AM, Rob Herring wrote:
> On Wed, May 30, 2018 at 02:15:58PM +0200, Maciej Purski wrote:
>> From: Andrzej Hajda <a.hajda@samsung.com>
>>
>> The patch adds bindings to Toshiba DSI/LVDS bridge TC358764.
>> Bindings describe power supplies, reset gpio and video interfaces.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>> ---
>>   .../bindings/display/bridge/toshiba,tc358764.txt   | 37 ++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>> new file mode 100644
>> index 0000000..6eda14f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>> @@ -0,0 +1,37 @@
>> +TC358764 MIPI-DSI to LVDS panel bridge
>> +
>> +Required properties:
>> +  - compatible: "toshiba,tc358764"
>> +  - reg: the virtual channel number of a DSI peripheral
>> +  - vddc-supply: core voltage supply, 1.2V
>> +  - vddio-supply: I/O voltage supply, 1.8V or 3.3V
>> +  - vddlvds-supply: LVDS1/2 voltage supply, 3.3V
>> +  - reset-gpios: a GPIO spec for the reset pin
>> +
>> +The device node can contain zero to two 'port' child nodes, each with one
> 
> How would 0 ports be valid?
> 

I'll fix this. In my opinion the output LVDS port should be mandatory
and the input DSI port should be optional, as the bridge might be a DSI
child node. According to documentation, the bridge can also be I2C controlled.
In this case, it should contain a DSI input port and LVDS output port.


>> +child 'endpoint' node, according to the bindings defined in [1].
>> +The following are properties specific to those nodes.
>> +
>> +port:
>> +  - reg: (required) can be 0 for DSI port or 1 for LVDS port;
>> +
>> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
>> +
>> +Example:
>> +
>> +	bridge@0 {
>> +		reg = <0>;
>> +		compatible = "toshiba,tc358764";
>> +		vddc-supply = <&vcc_1v2_reg>;
>> +		vddio-supply = <&vcc_1v8_reg>;
>> +		vddlvds-supply = <&vcc_3v3_reg>;
>> +		reset-gpios = <&gpd1 6 GPIO_ACTIVE_LOW>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		port@1 {
>> +			reg = <1>;
>> +			lvds_ep: endpoint {
>> +				remote-endpoint = <&panel_ep>;
>> +			};
>> +		};
>> +	};
>> -- 
>> 2.7.4
>>
> 
> 
> 
