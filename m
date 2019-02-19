Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE23FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBDF217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550586153;
	bh=q8IAGCGPndn6ZY5trkXqM325/UglqRESL1pRQffvHFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=voWNgnyFDHFvmPes5vVxHlgDjSLJk0DZT9eD49q2JC7/2UjfBnDMXCtpJQJX/EwUK
	 Nk/3BSGMnwb+V0J07bLEWqAzCdqb+3rqdXw5bUVK5hofnL9PajnhiIBF5XXAEavZWC
	 hmbCxs1xP9GlK3tzIM+s1P8bBwD3s2sHVX54Zwfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfBSOWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:22:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfBSOWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:22:31 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73508217D7;
        Tue, 19 Feb 2019 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550586150;
        bh=q8IAGCGPndn6ZY5trkXqM325/UglqRESL1pRQffvHFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KmcM1Dd84KcsRlcDgdZ4QwHYYE1qhMTT1efH5W8wH5aw+uKLUKoO1Vt93fW/oyPTh
         vJFsNbOuZ6UwFXNedX9N6w8ocPrG4HfEUtmE7RiHA6p5/m8sD6K8fANPyfwDDeOe47
         qPdaRDMhXRg9DEn2J2tAFOEeZ7xLDpUS0+YuiYWo=
Received: by mail-qk1-f182.google.com with SMTP id u188so12075832qkh.8;
        Tue, 19 Feb 2019 06:22:30 -0800 (PST)
X-Gm-Message-State: AHQUAub81tBk+/H1KBniiv6ExzxN9TomGG6UiqpMSDvAFXqGCLR/Htdp
        qszpMMz8l/muLiwGNTYRWiOJmrI4lOaUad6JkQ==
X-Google-Smtp-Source: AHgI3IYTyJnxRns0g1gZ2t2wP5yw4tkdD1LovA3cpdxHa/0Ns7CJyB5HOXdEip63CXPfYOAerscO84u+x+ZzGQdRttk=
X-Received: by 2002:a37:94d:: with SMTP id 74mr3980596qkj.79.1550586149646;
 Tue, 19 Feb 2019 06:22:29 -0800 (PST)
MIME-Version: 1.0
References: <20190218112310.17860-1-chenyu56@huawei.com> <20190218112310.17860-2-chenyu56@huawei.com>
 <20190218201824.GA23724@bogus> <a944cd27-f7d5-eece-1ef5-c7dc5dbc311b@huawei.com>
 <1550545405.2210.30.camel@mhfsdcap03>
In-Reply-To: <1550545405.2210.30.camel@mhfsdcap03>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 19 Feb 2019 08:22:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLaOj2FWgChMMUBrvtkXkgQ6v1QiYGMDMrYUdDq1zOs1Q@mail.gmail.com>
Message-ID: <CAL_JsqLaOj2FWgChMMUBrvtkXkgQ6v1QiYGMDMrYUdDq1zOs1Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] dt-bindings: phy: Add support for HiSilicon's
 hi3660 USB PHY
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Chen Yu <chenyu56@huawei.com>, liuyu712@hisilicon.com,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>, kongfei@hisilicon.com,
        wanghu17@hisilicon.com, butao@hisilicon.com, chenyao11@huawei.com,
        fangshengzhou@hisilicon.com,
        Li Pengcheng <lipengcheng8@huawei.com>,
        Song Xiaowei <songxiaowei@hisilicon.com>,
        Yiping Xu <xuyiping@hisilicon.com>, xuyoujun4@huawei.com,
        yudongbin@hisilicon.com, zangleigang <zangleigang@hisilicon.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Binghui Wang <wangbinghui@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 9:03 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Hi,
> On Tue, 2019-02-19 at 09:50 +0800, Chen Yu wrote:
> > Hi,
> >
> > On 2019/2/19 4:18, Rob Herring wrote:
> > > On Mon, Feb 18, 2019 at 07:23:01PM +0800, Yu Chen wrote:
> > >> This patch adds binding documentation for supporting the hi3660 usb
> > >> phy on boards like the HiKey960.
> > >>
> > >> Cc: Rob Herring <robh+dt@kernel.org>
> > >> Cc: Mark Rutland <mark.rutland@arm.com>
> > >> Cc: John Stultz <john.stultz@linaro.org>
> > >> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> > >> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> > >> ---
> > >> v1:
> > >> * Fix some format error as suggested by Rob.
> > >> v2:
> > >> * Change hi3660 usb PHY to hi3660 USB PHY
> > >> ---
> > >> ---
> > >>  .../devicetree/bindings/phy/phy-hi3660-usb3.txt     | 21 +++++++++++++++++++++
> > >>  1 file changed, 21 insertions(+)
> > >>  create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> > >> new file mode 100644
> > >> index 000000000000..f9a3d56cfdd2
> > >> --- /dev/null
> > >> +++ b/Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
> > >> @@ -0,0 +1,21 @@
> > >> +Hisilicon hi3660 USB PHY
> > >> +-----------------------
> > >> +
> > >> +Required properties:
> > >> +- compatible: should be "hisilicon,hi3660-usb-phy"
> > >> +- #phy-cells: must be 0
> > >> +- hisilicon,pericrg-syscon: phandle of syscon used to control phy.
> > >> +- hisilicon,pctrl-syscon: phandle of syscon used to control phy.
> > >> +- hisilicon,usb3-otg-bc-syscon: phandle of syscon used to control phy.
> > >> +- hisilicon,eye-diagram-param: parameter set for phy
> > >> +Refer to phy/phy-bindings.txt for the generic PHY binding properties
> > >> +
> > >> +Example:
> > >> +  usb-phy {
> > >> +          compatible = "hisilicon,hi3660-usb-phy";
> > >> +          #phy-cells = <0>;
> > >> +          hisilicon,pericrg-syscon = <&crg_ctrl>;
> > >> +          hisilicon,pctrl-syscon = <&pctrl>;
> > >> +          hisilicon,usb3-otg-bc-syscon = <&usb3_otg_bc>;
> > >
> > > Are most of the registers within one of these blocks? If so, make this
> > > node a child of that node.
> > I met a problem when I made this node a child of the syscon node,
> > the driver "phy-hi3660-usb3" was not probed.
> > Do you have any idea about how to make it probed when it is a child node?
> call of_platform_populate() in parent node's driver,
> but I don't know whether it's a standard way

It is. The other way is adding 'simple-mfd' compatible if there is no
driver for the parent.

Rob
