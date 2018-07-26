Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63940C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1960F2089A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ke2xrDyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1960F2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbeGZRyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730413AbeGZRyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:54:33 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6393F20891;
        Thu, 26 Jul 2018 16:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532623016;
        bh=PqDNAKN+cQcusHzcsjs4UnO8Vsgn10pv6kbdFcAKouk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Ke2xrDyEtRpN3+pip1PD5btWJEQ7/eS7x35mxtQtfxaySXhNpE5Nb7oSILJR6w6dN
         7PwQhlf+88qrkJqXjttAKJY3lAc8H0qn3KY2HYWweW9FY79Eo7ADA3bG1o4WBZV67d
         wc0Yn4VpiUk+CvlavFJmO66H8OmK4NT7AX6IVgOk=
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
In-Reply-To: <19376df2-fdd4-12e3-da4c-37106fffed19@xilinx.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1531857547-16652-1-git-send-email-jollys@xilinx.com>
 <2c3aad45-37ce-2446-4b90-bddb477286ed@xilinx.com>
 <CY1PR02MB2138E21A3FFBD5FEEAA7D6D4B8550@CY1PR02MB2138.namprd02.prod.outlook.com>
 <19376df2-fdd4-12e3-da4c-37106fffed19@xilinx.com>
Message-ID: <153262301567.48062.15432354725863055071@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v10 00/10] drivers: Introduce firmware dnd clock river for ZynqMP
 core
Date:   Thu, 26 Jul 2018 09:36:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Michal Simek (2018-07-25 02:51:14)
> On 24.7.2018 20:14, Jolly Shah wrote:
> >>>  create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
> >>>  create mode 100644 drivers/firmware/xilinx/zynqmp.c  create mode
> >>> 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
> >>>  create mode 100644 include/linux/firmware/xlnx-zynqmp.h
> >>>
> >>
> >> It looks pretty calm over the last several series that's why when I ge=
t an answer
> >> from Stephen or Mike I will take this series via my tree and arm-soc t=
ree.
> >>
> >> I have applied 01-08 here
> >>  https://github.com/Xilinx/linux-xlnx/commits/zynqmp/soc
> >>
> >> Thanks,
> >> Michal
> > =

> > =

> > Thanks for merging the patches. =

> > By mistake I added =E2=80=9CReviewed-by: Stephen Boyd sboyd@kernel.org=
=E2=80=9D for firmware bindings (Patch01).  Stephen had reviewed clock bind=
ings only.  Please suggest if I should send a new version with that fix.
> =

> I have fixed that in my branch and I have asked Shephen to look at clk
> over chat.
> =


I have some unresolved review comments on v9. I'll give reviewed-by when
that discussion is resolved.

