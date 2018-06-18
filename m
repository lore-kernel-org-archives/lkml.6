Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71187C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B4320864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A9Ad/dZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B4320864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936335AbeFRLID (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:08:03 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50466 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936229AbeFRLH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:07:56 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180618110753euoutp027e46930bd34cf8e4d0795e6a62b2e8a4~5PID932Y50714007140euoutp02Y
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 11:07:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180618110753euoutp027e46930bd34cf8e4d0795e6a62b2e8a4~5PID932Y50714007140euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529320073;
        bh=PXmVvKEs+aINXQ5oBgyMUUtS09iCl3Jrr6+5ioTBaJg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=A9Ad/dZPVBQMJBD9cBjGmXGUD6QJ+KacFRIOGV8NzrZ8KkKZLtwxeSmrrTfInbP/5
         dWU7viWiUPEAlLLD6vRnW/u+is9srR9XXnWQA7arEzObUwqJFLrcpUc3iNp4i0R7SX
         zeqTklfwa5t8c+MZQAsdmC5POw3rGth6l4I+/33E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180618110750eucas1p1f7475438f738dc84f2ae83dbe1f87eea~5PIBa8w6m0282702827eucas1p1H;
        Mon, 18 Jun 2018 11:07:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 00.DC.10409.582972B5; Mon, 18
        Jun 2018 12:07:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180618110747eucas1p10c2b7eeb6cddaf1e598566fd8e18f92a~5PH-IUgeY2317323173eucas1p1m;
        Mon, 18 Jun 2018 11:07:47 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180618110747eusmtrp2b9ddce23f6ac93ec81a7fb7a0394705a~5PH_RmtbY1298512985eusmtrp2a;
        Mon, 18 Jun 2018 11:07:47 +0000 (GMT)
X-AuditID: cbfec7f5-b45ff700000028a9-a5-5b27928570a6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 26.AE.04178.282972B5; Mon, 18
        Jun 2018 12:07:47 +0100 (BST)
Received: from [106.120.51.25] (unknown [106.120.51.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180618110746eusmtip21caba208331d7b05232c1d390402cd9b~5PH9hKuaK1487614876eusmtip2L;
        Mon, 18 Jun 2018 11:07:46 +0000 (GMT)
Subject: Re: [PATCH v2 07/10] dt-bindings: tc358754: add DT bindings
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Maciej Purski <m.purski@samsung.com>
Date:   Mon, 18 Jun 2018 13:07:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6047372.VZe6FOdiCA@avalon>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec9tx9XsOC0fshvT1LKbFPF2ISr8cIqgiALJyFYdTNQpZ2k3
        qiVYZmrTCucSZ6FZZhfXvK2ScOIYlSZmi4FZy6RVKyo17GZux8hvv+f/3N7/w8uSypPMdDZZ
        c0AQNepUFSOnGtpHOhbmFEclLGm4EIZdtzpoXNDhIHB2rpfGdYbbNDa1jWnPhj4zuLhPT+F3
        L7sofO7NBxJ3dt6R4SfZH2X4TFGlDJvfPKdxt7WMwYbOFgLfbOuV4SpnF4FzHrTJsOG8h8Ej
        1nJqbQhfW16L+O7CAoJvNvbK+Eu5pTRvrjnD8I3Dr2i+76yd4O9WnuALLTWI/2aetUW+Q756
        n5CanCWIi9fslu9vHS2jM65OO/Tqh6hD2co8FMACtwxKPU4yD8lZJXcNQcGNt5QUDCLIdrlo
        KfiGQDdQMhaw/hbbyRBJr0bQ/LpqvMiLwOR+QfrmBnNx0P7yAfJxCIeh4EoJ8hWR3Gsa6vUD
        jG8Sw82H2tOJvhqKmwt15TbCx1O5eLh88a2/V8EFgaO0n/JxABcNtU69n0kuFFz9JkLi2dDo
        LfN7AK6JheH8+7TUnAU9NV8pyWgc/H5ympA4GN7bLTKJZ8Bos2lcPwrXPdWUNEiHYLC3m5QS
        q8Bm7/LbJ7l5cNu6WLrEOrj7iZEwEF54g6TnBEJxQwkpyQrIPTV+aRW8M/weXwRQ5XDTeqQy
        TjBpnGDMOMGY8f/aCkTVoFAhU5uWJGiXaoSDi7TqNG2mJmnR3vQ0Mxr7mI/+2IeaUMuvPa2I
        Y5FqsgIXRSYoaXWW9nBaKwKWVIUoomZEJSgV+9SHjwhieqKYmSpoW1EYS6lCFbuij+9Qcknq
        A0KKIGQI4r8swQZM16H20rB7nmpnhaVnhcz+PXwz92WlNbbPVhzjEE9cMm+dVP10dM6vyzmW
        rOMt4s8L4Qseu50jLTfjd3omPXRV5OlvbHk0lPHhfkThBo0ufv2XCLctavu2IrDFGfS7Ns1s
        mr3z2K2NsVNiGj8Gxgzn9+dbJ6fULzBFWja6HYYBb/PyrYMqSrtfHTufFLXqv7GIWuuUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMKsWRmVeSWpSXmKPExsVy+t/xe7rNk9SjDTotLG6tO8dq0XvuJJNF
        U8dbVouNM9azWsw/AhS78vU9m8Wk+xNYLF7cu8hi0f/4NbPF+fMb2C3ONr1ht+icuITdYtPj
        a6wWl3fNYbOYcX4fk8XaI3fZLZZev8hk0br3CLvFjMkv2Sx+7prH4iDisWbeGkaPy329TB47
        Z91l95jdMZPVY9OqTjaP7d8esHrc7z7O5LF5Sb1H35ZVjB6fN8kFcEXp2RTll5akKmTkF5fY
        KkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZRz6P4e1YJlYxYNfRQ2MTUJd
        jBwcEgImEocbRboYuTiEBJYySvTcvMnSxcgJFJeQOHv/PyuELSzx51oXG4gtJPCaUWLqbV8Q
        W1jAReLYvb2MILaIgIVE76LpjCCDmAUes0psO9PBDjH1PaPE7X9bmUC2sQloSaxpjwdp4BWw
        kzjXdoIJxGYRUJXYOO8wmC0qECHRuXI+C0SNoMTJmU/AbE4BDYk11yeA2cwCZhLzNj9khrDF
        JW49mc8EYctLbH87h3kCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ
        +bmbGIEJYtuxn5t3MF7aGHyIUYCDUYmH90GfWrQQa2JZcWXuIUYJDmYlEV51GfVoId6UxMqq
        1KL8+KLSnNTiQ4ymQM9NZJYSTc4HJq+8knhDU0NzC0tDc2NzYzMLJXHe8waVUUIC6Yklqdmp
        qQWpRTB9TBycUg2MtjJBE7n/ztBbfjmeYYfCvwkhrGccS7SWep61PnDgnZXXtjcvnsuvUmo+
        pKscU7XhStuD2E2J/Kt/qsk+nzT9u8t05iNF1xbEMu6LiO5b/K2HM1ZSlOfZp3dBckIpk87+
        ELT8FZd+x8jRd+L2ZYyMD7i+2Qm1N+sZa+ZXHBY/1v9ywo9XrzVPK7EUZyQaajEXFScCAD92
        m9ImAwAA
Message-Id: <20180618110747eucas1p10c2b7eeb6cddaf1e598566fd8e18f92a~5PH-IUgeY2317323173eucas1p1m@eucas1p1.samsung.com>
X-CMS-MailID: 20180618110747eucas1p10c2b7eeb6cddaf1e598566fd8e18f92a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180530121627eucas1p1c8daf24d7c95e9e8b04a523d4662dfd9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180530121627eucas1p1c8daf24d7c95e9e8b04a523d4662dfd9
References: <1527682561-1386-1-git-send-email-m.purski@samsung.com>
        <CGME20180530121627eucas1p1c8daf24d7c95e9e8b04a523d4662dfd9@eucas1p1.samsung.com>
        <1527682561-1386-8-git-send-email-m.purski@samsung.com>
        <6047372.VZe6FOdiCA@avalon>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/30/2018 02:36 PM, Laurent Pinchart wrote:
> Hi Maciej,
> 
> On Wednesday, 30 May 2018 15:15:58 EEST Maciej Purski wrote:
>> From: Andrzej Hajda <a.hajda@samsung.com>
>>
>> The patch adds bindings to Toshiba DSI/LVDS bridge TC358764.
>> Bindings describe power supplies, reset gpio and video interfaces.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>> ---
>>   .../bindings/display/bridge/toshiba,tc358764.txt   | 37 +++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>   create mode 100644
>> Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>>
>> diff --git
>> a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
>> b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt new
>> file mode 100644
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
>> +child 'endpoint' node, according to the bindings defined in [1].
>> +The following are properties specific to those nodes.
>> +
>> +port:
>> +  - reg: (required) can be 0 for DSI port or 1 for LVDS port;
>> +
>> +[1]: Documentation/devicetree/bindings/media/video-interfaces.txt
> 
> Could you please take the comments I made on v1 into account when you'll post
> v3 ?
> 

For now I'm going to stick with the old convention and make port 0 optional,
when the bridge is a DSI child and LVDS port 1 mandatory.

The current policy does not seem to have been changed. There's a quiet new binding,
which follows the old convention:
Documentation/devicetree/bindings/connector/usb-connector.txt

If you can find an example of new bindings, which follow your convention and you
convince Rob, then I'll be completely okay with it and I'll change it the way
you propose.


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
> 
> 

Best regards,

Maciej Purski
