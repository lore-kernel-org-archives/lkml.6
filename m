Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E37EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C762157F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTjfBffJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C762157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbeHBWwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731202AbeHBWwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:52:35 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5BE92154D;
        Thu,  2 Aug 2018 20:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533243583;
        bh=noqYZEMLP4sIKIWp45dLByOldN9fygUBxpDjQ4RjOTY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=iTjfBffJYO68vnrwCx0aPhwKthFtE2nLVyyl/3xBXtAkt58Zv4BGJE2ZkSwFRPgSQ
         szUL39MHF5Xc95P+lYCwmrtcMFEcIBSECGFr1h81Pbt2FZF+QdSga6dVQdtmD0EAWF
         mOCpuKyUR+PriO7iI1HXGMnJXkWMkeVIErlL2iHw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <e5448935-770a-5c14-438c-23a652b17822@xilinx.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
 <2c3aad45-37ce-2446-4b90-bddb477286ed@xilinx.com>
 <CY1PR02MB2138E21A3FFBD5FEEAA7D6D4B8550@CY1PR02MB2138.namprd02.prod.outlook.com>
 <19376df2-fdd4-12e3-da4c-37106fffed19@xilinx.com>
 <153262301567.48062.15432354725863055071@swboyd.mtv.corp.google.com>
 <e5448935-770a-5c14-438c-23a652b17822@xilinx.com>
Message-ID: <153324358299.10763.8724416723915219268@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v10 00/10] drivers: Introduce firmware dnd clock river for ZynqMP
 core
Date:   Thu, 02 Aug 2018 13:59:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michal Simek (2018-07-30 05:50:42)
> On 26.7.2018 18:36, Stephen Boyd wrote:
> > Quoting Michal Simek (2018-07-25 02:51:14)
> >> On 24.7.2018 20:14, Jolly Shah wrote:
> >>>>>  create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
> >>>>>  create mode 100644 drivers/firmware/xilinx/zynqmp.c  create mode
> >>>>> 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
> >>>>>  create mode 100644 include/linux/firmware/xlnx-zynqmp.h
> >>>>>
> >>>>
> >>>> It looks pretty calm over the last several series that's why when I =
get an answer
> >>>> from Stephen or Mike I will take this series via my tree and arm-soc=
 tree.
> >>>>
> >>>> I have applied 01-08 here
> >>>>  https://github.com/Xilinx/linux-xlnx/commits/zynqmp/soc
> >>>>
> >>>> Thanks,
> >>>> Michal
> >>>
> >>>
> >>> Thanks for merging the patches. =

> >>> By mistake I added =E2=80=9CReviewed-by: Stephen Boyd sboyd@kernel.or=
g=E2=80=9D for firmware bindings (Patch01).  Stephen had reviewed clock bin=
dings only.  Please suggest if I should send a new version with that fix.
> >>
> >> I have fixed that in my branch and I have asked Shephen to look at clk
> >> over chat.
> >>
> > =

> > I have some unresolved review comments on v9. I'll give reviewed-by when
> > that discussion is resolved.
> =

> ok. Do you want to take them via clk tree or via arm-soc tree?
> =


I'm fine for the clk patch to go via arm-soc if that makes it easier.

