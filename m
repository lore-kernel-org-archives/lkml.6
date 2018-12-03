Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1102EC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA49C208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0rdoKOrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA49C208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeLCQBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:01:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbeLCQBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:01:43 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D8020881;
        Mon,  3 Dec 2018 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543852897;
        bh=gNTy8+yF8ndcLmyH9AcvmuMjGq0H+Pbnq5F+jJ5bCcs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0rdoKOrHzqj6lOG5MDcCWYaGqV0eI+rG88xIksPzWFuUDHeCtXelfgNDPxO/EXlR+
         UVHrU9z4pr2pMHkI4DP3Tg5/QH5s/0txmKCG0+hKQ16DgjA0o0MIkTR8BM9rBUqk7z
         EWOTO7cNmQ6HKA0jYA3PZDHwX+OwtkHHB/bI73vA=
Received: by mail-qk1-f175.google.com with SMTP id m5so7601130qka.9;
        Mon, 03 Dec 2018 08:01:37 -0800 (PST)
X-Gm-Message-State: AA+aEWZNQn1G1HYNhPCyCZx7vkHhCKg2rL5l2BjxskR4sTsNbX8sfqBV
        Mjzhdvjl4Q9WeCC5ocTE8bWg/iT/9StTzPRyaQ==
X-Google-Smtp-Source: AFSGD/Wv039ltwptAfmD3rrwFoC2c8J583FG0AwdruQ+BiXT7GNHXZEI2gK7KyNZZlOKuzzF27ctFhvvvpsyfnApz00=
X-Received: by 2002:a37:5686:: with SMTP id k128mr14440409qkb.29.1543852896490;
 Mon, 03 Dec 2018 08:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20181027095820.40056-1-chenyu56@huawei.com> <20181027095820.40056-2-chenyu56@huawei.com>
 <20181112160241.GA14074@bogus> <9fce6a58-d986-25e4-1791-ba375e4f075e@huawei.com>
In-Reply-To: <9fce6a58-d986-25e4-1791-ba375e4f075e@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 3 Dec 2018 10:01:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKObFGdf5tPdv=Ss2ZWCPBgimbEUn72rkR2+L7uRbAirg@mail.gmail.com>
Message-ID: <CAL_JsqKObFGdf5tPdv=Ss2ZWCPBgimbEUn72rkR2+L7uRbAirg@mail.gmail.com>
Subject: Re: [PATCH 01/10] dt-bindings: usb: add support for dwc3 controller
 on HiSilicon SoCs
To:     Chen Yu <chenyu56@huawei.com>
Cc:     Wangbinghui <wangbinghui@hisilicon.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>, kongfei@hisilicon.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 8:29 PM Chen Yu <chenyu56@huawei.com> wrote:
>
> Hi,
>
> On 2018/11/13 0:02, Rob Herring wrote:
> > On Sat, Oct 27, 2018 at 05:58:11PM +0800, Yu Chen wrote:
> >> This patch adds binding descriptions to support the dwc3 controller
> >> on HiSilicon SoCs and boards like the HiKey960.
> >>
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: John Stultz <john.stultz@linaro.org>
> >> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> >> ---
> >>  .../devicetree/bindings/usb/dwc3-hisi.txt          | 53 +++++++++++++=
+++++++++
> >>  1 file changed, 53 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/usb/dwc3-hisi.tx=
t
> >>
> >> diff --git a/Documentation/devicetree/bindings/usb/dwc3-hisi.txt b/Doc=
umentation/devicetree/bindings/usb/dwc3-hisi.txt
> >> new file mode 100644
> >> index 000000000000..e715e7b1c324
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/usb/dwc3-hisi.txt
> >> @@ -0,0 +1,53 @@
> >> +HiSilicon DWC3 USB SoC controller
> >> +
> >> +This file documents the parameters for the dwc3-hisi driver.
> >> +
> >> +Required properties:
> >> +- compatible:       should be "hisilicon,hi3660-dwc3"
> >> +- clocks:   A list of phandle + clock-specifier pairs for the
> >> +            clocks listed in clock-names
> >> +- clock-names:      Specify clock names
> >> +- resets:   list of phandle and reset specifier pairs.
> >> +
> >> +Sub-nodes:
> >> +The dwc3 core should be added as subnode to HiSilicon DWC3 as shown i=
n the
> >> +example below. The DT binding details of dwc3 can be found in:
> >> +Documentation/devicetree/bindings/usb/dwc3.txt
> >
> > If you only have clocks and resets and no glue registers, then you
> > don't need a sub-node. Just make the controller one node.
> >
>
> In dwc3 glue driver=EF=BC=8Cthe controller driver usually probed by call =
of_platform_populate
> which will search the child node of glue driver.
> The code of function of_platform_populate is as below:
>
>         for_each_child_of_node(root, child) {
>                  rc =3D of_platform_bus_create(child, matches, lookup, pa=
rent, true);
>                  if (rc) {
>                          of_node_put(child);
>                          break;
>                  }
>          }
>
> So I think the controller node should be a sub-node.

It was done that way, but has changed. See commit fe8abf332b8f ("usb:
dwc3: support clocks and resets for DWC3 core").

Rob
