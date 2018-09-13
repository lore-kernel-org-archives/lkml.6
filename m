Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AA6C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDABE20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 11:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZoZnWJUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDABE20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIMQdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 12:33:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46514 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbeIMQdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 12:33:00 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180913112358euoutp015465030412bba3d636c4864ac3485dde~T8d8FCGAv1248012480euoutp011
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 11:23:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180913112358euoutp015465030412bba3d636c4864ac3485dde~T8d8FCGAv1248012480euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536837838;
        bh=1ChjkkOinQrGYZU8tMVXveR2LOEbRnx+J/6AZdUb++I=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZoZnWJULimwbSUNTiYPIOXOeViBWbOX05cmijtB6LMSZUJ/OPAwF1JK+Q8ES12R7H
         Ym94iJ4+Bxt4IYFmkdKtFpzYDlPps4GSeWGh/N9QsAFMtEsdTEkTvDxv1LjIvx5WEM
         gAEXBs0LTU/ELWlfoetbK6tHnzyd99qY8TMB5Nyc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180913112356eucas1p2cf09b3d0ab6af17c2dec0d652aab4ca4~T8d7HExta2011920119eucas1p2k;
        Thu, 13 Sep 2018 11:23:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 86.F4.04294.CC84A9B5; Thu, 13
        Sep 2018 12:23:56 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180913112356eucas1p2039ad3b69dc569313998d4de4cc00ff9~T8d6UiuPU0109501095eucas1p2n;
        Thu, 13 Sep 2018 11:23:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180913112355eusmtrp15f3e6c5805fdae0f834872b12d00caa8~T8d6C547K2769927699eusmtrp1V;
        Thu, 13 Sep 2018 11:23:55 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-1b-5b9a48cca885
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 09.47.04284.BC84A9B5; Thu, 13
        Sep 2018 12:23:55 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180913112354eusmtip1b7d2a0ad21a706e9dbba15111485c453~T8d5N1kjd0565505655eusmtip1y;
        Thu, 13 Sep 2018 11:23:54 +0000 (GMT)
Subject: Re: [PATCH v3 4/5] dt-bindings: drm/bridge Document Cadence MHDP
 DPI/DP bridge bindings
To:     Damian Kos <dkos@cadence.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     pgaj@cadence.com, ltyrala@cadence.com, stelford@cadence.com,
        jartur@cadence.com, piotrs@cadence.com
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Thu, 13 Sep 2018 13:23:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535451894-2518-5-git-send-email-dkos@cadence.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGc+5XL9XCpaK8yqKxy7KJCNMYPTpjIDF6/hCDcUuM/WOrckEi
        LdgrODRKxbgUpIgYkRYpMmAK1i0DhVkREkZW+Vgj4JxfWJzNsiBV8SuiItoezfjvl+d5n/ec
        5+SIrLZamCNmmHbJZpMhUyeouZY/xr2L+ohD/+UrWyy2ebsZXGAN8Li6y8vjId8yfO35IwFf
        HHar8OQ/D3hcVbYPV/7VhnDh0ToVbrp/nceD7pMCfjI8yeJ/Xy/BNWMXOFz/dz+D228c5/AZ
        ZzPCv3a08/jQ5S4VHjrWhfCo34USZxGX04WI07WXuAofMGSwxMaQSqudJ02NhQJpfTHME2f3
        RuI77GFIc10+uVh2mSEe9y0VmXB0cKT1upMlT5vmpkRsUa9KlTMzcmVzwurv1Nvf/jzAZzdE
        fP8osNSCbNOLUJgI0lIo9l3ii5Ba1EpnELQU+JmgoZWeIXhcu48aTxEMVVYLRUgMJZ78t4nq
        pxGMjVk/pAMIfrx7lQumZ0hbYWzibMiIkhw8DExUhtKslAHlfTuDM4K0ACaabwpB5qTPwHe/
        mQ/yTGkzdA3XoCBrpEjotvtDO8OkRDg3cDiks9I8aA2cZClHwy1/NRM8C6Q7IrSVFzA0nAvd
        D+0M7bkGWu7ZeMozYMRzXkX5E+g9VsxRzocC+zWWLrIiuFJ7WqDGV/C7p5+nBRbAL+4EKidB
        zU2vir5KONwIRNL7hENZywmWyhqw/qCl0/PB9+cFlnI01F99LpQinWNKS8eUZo4pzRz/n3sK
        cY0oWs5RjOmyssQk745XDEYlx5Qevy3L2ITef9vet55nvyH3m62dSBKRbrqm4nO7XssbcpU8
        YycCkdVFaY4kOvRaTaohb49szvrWnJMpK50oRuR00Zrw2DS9Vko37JJ3yHK2bP7oMmLYHAtq
        WFxcXxs3nkDSqs6mxNhqe0Yikr4us6zbX1jFfPqFq2S850WbRpv/07gxuVdvWf9GzlvLzUxJ
        TfLL00bu9Uxm7982TSd7y1euSHUZKvZmRSWVzj6ukGW35ZKBuHMLN0gbl788cHB98sGImD2D
        aku/adM35+cdqmIjE/N3Ru4YvVOq45TthsWxrFkxvAMe1rafsgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHee7d3Yu5vM23BwurhZlBm/Ntj2E6/HQxgsooUcSWXlR0Tnan
        ZlFKJelES0vQqVNJLXWGbtR8SQURlyhGs7Qk0VJCm2IqiZEv6Vbgtx/nnN85HPhzcYGR8OAm
        p6lpVZo8Vch2YA1vm6fODFPaGN+2JjEqGh3C0L38JQLVDIwSaGo6CH34tcxGnTNdHLTzzUqg
        6tI7qPLjG4AKSuo5yDA7TqCxrio2Wp3ZwdH3P36obuUVCzVMvMdQ76cyFnqhMwLU3tdLoLye
        AQ6aejIA0OKcHsjcKL1ODyid/jalL7Bi1FhxEUZV5lcQlKG5gE2Z1mcISjd0iZouNGOUsT6H
        6iztwShz1ySH2tL2sSjTuA6n1gyeF52iRSEqZYaaPpakZNTnhDES5CeSBCORX0CwSOIvjT3r
        FygUh4Yk0KnJmbRKHHpdlLT90kKkNzndXF4KyAVFjhrA5UIyAK7OR2qAA1dANgD4Y7iD0ADe
        bt0ddtcs4XZ2hpvjGvYeC0grgA+74R47kzfgylYLsSe7kDoCjjxYYO01cDIZ1q1tcOxbhwDU
        mK02m036wC3jZxvzyVC4rrfYmEV6welZo+2yKxkFW57PE/aZQ3CoYs62lEfKYKulENgPeMNN
        nQW381FoWqr6x+5wcq4GewwE2n26dp+i3ado9ym1gNUMXOgMRpGoYCQiRq5gMtISRfFKhQHs
        Bub14G9jB7C0R/YDkguEjvx5YUWMgJBnMtmKfgC5uNCF/0imjRHwE+TZt2iVMk6VkUoz/SBw
        97kS3MM1XrkbvzR1nCRQIkXBEqm/1D8ICd3573yzowVkolxNp9B0Oq3672FcnkcuiPj5jOm7
        HJC9WrlZ5jZy1zOy2ByteYt5Jdd6f+E3loclDJ64JtNPhWf5pKfENp8/2ThxlVdQt1ntGK/k
        pS6U5tSGeUSdOngB5vccv2KZlYrPKmOJIwuHI+Kc875y7s+ZOjr7fcjwCOviRqRsOktcPqNc
        9+Q9bS1eSTyQP5vX1iBkMUlyyWlcxcj/Aiob7OpGAwAA
Message-Id: <20180913112356eucas1p2039ad3b69dc569313998d4de4cc00ff9~T8d6UiuPU0109501095eucas1p2n@eucas1p2.samsung.com>
X-CMS-MailID: 20180913112356eucas1p2039ad3b69dc569313998d4de4cc00ff9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180828102614epcas1p2a0c803cdbee886d731135bd596549a0b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180828102614epcas1p2a0c803cdbee886d731135bd596549a0b
References: <1535451894-2518-1-git-send-email-dkos@cadence.com>
        <CGME20180828102614epcas1p2a0c803cdbee886d731135bd596549a0b@epcas1p2.samsung.com>
        <1535451894-2518-5-git-send-email-dkos@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.08.2018 12:24, Damian Kos wrote:
> From: Quentin Schulz <quentin.schulz@bootlin.com>
>
> Signed-off-by: Damian Kos <dkos@cadence.com>

No commit message, no author's signoff.
--
Regards
Andrzej

> ---
>  .../bindings/display/bridge/cdns,mhdp.txt     | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
> new file mode 100644
> index 000000000000..f8334c520b98
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
> @@ -0,0 +1,43 @@
> +Cadence MHDP bridge
> +==========================
> +
> +The Cadence MHDP bridge is a DPI to DP bridge.
> +
> +Required properties:
> +- compatible: should be "cdns,mhdp8546",
> +- reg: physical base address and length of the controller's registers,
> +- clocks: DP bridge clock, it's used by the IP to know how to translate
> +	a number of clock cycles into a time (which is used to comply
> +	with DP standard timings and delays),
> +
> +Required subnodes:
> +- ports: Ports as described in Documentation/devictree/bindings/graph.txt
> +	Port 0 - input port representing the DP bridge input
> +	Port 1 - output port representing the DP bridge output
> +
> +Example:
> +
> +	mhdp: dp-bridge@f0fb000000 {
> +		compatible = "cdns,mhdp8546";
> +		reg = <0xf0 0xfb000000 0x0 0x1000000>;
> +		clocks = <&mhdp_clock>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				dp_bridge_input: endpoint {
> +					remote-endpoint = <&xxx_dpi_output>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				dp_bridge_output: endpoint {
> +					remote-endpoint = <&xxx_dp_connector_input>;
> +				};
> +			};
> +		};
> +	};


