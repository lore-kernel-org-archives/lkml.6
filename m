Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90973C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7A3214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545082014;
	bh=iML32z7Npv/AvMYBSMJpUIMm4IiyRT58lgsv7SYvVR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fwhzsV7nFESnhfU1tzWW7TYxpacb7UGIQdSww/OFeJ4Pm/fHM4VYdaSe61I0++mT2
	 QeL/3w4xZELpfTQHX2n1QknuGFyxTCBWU6G6eSOJIoFTNq2K13Mu8Kpmnt3A7QmBcw
	 LR2ijd4Rw6OFH15GUTuQAU6NSZmpaxJscwkpx2rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbeLQV0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:26:53 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37631 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeLQV0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:26:53 -0500
Received: by mail-ot1-f67.google.com with SMTP id 40so13635291oth.4;
        Mon, 17 Dec 2018 13:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IsPYRmN2ohiuYijZ8MSpnBZggV+vxwnQddS15sgckdU=;
        b=dTSxKeLUo6G7H7cXFoMFC3DA25FjCE42yceiDp3bpZda+bpB5Z0ajCCfzkOuLupHlK
         hXv3x5qMGLav7KOA0wWPNnahnL4fPbUwSqjPb8gJUOXXtPxNfOytoC9fmOV4wqawrv78
         fgLQoKnVb0IE0aeKbbEaecOelvCLYMoJOClJZHnK2xI6PntE1N2NFrJVzHuQzB1jC5v1
         PACcPa4mwW/frs+BLHa+PlUGE2D6xfMYC0Ek7LpKIH0Tr/QXcWI0Fu4GWg03u7dyRWOE
         I0aDIS+u3poRu1BuTxCJT6j4vNvEI73JrRrr6+sVttp+DF27hXVuFiuOkIWF4JOz6HA3
         1+KQ==
X-Gm-Message-State: AA+aEWZ6aJXCZHa57PfD9iIaHptKSY5nNDeABXRO8qxrqqwX0PnSG3gM
        /ttg6yuErvNfQ8/3f1B1NA==
X-Google-Smtp-Source: AFSGD/VVTu9ZZffDFEdS18EmhoSyllhhBQd4CCD4j7Mjt2w3dAIaTA6Otq3n04wptY45A46S18C/0g==
X-Received: by 2002:a9d:2f64:: with SMTP id h91mr10670320otb.14.1545082012247;
        Mon, 17 Dec 2018 13:26:52 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id 4sm6877164otw.39.2018.12.17.13.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 13:26:51 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:26:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, mark.rutland@arm.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 1/3] dt-bindings: mtd: stm32_fmc2: add STM32 FMC2 NAND
 controller documentation
Message-ID: <20181217212650.GA20603@bogus>
References: <1544781488-18723-1-git-send-email-christophe.kerello@st.com>
 <1544781488-18723-2-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544781488-18723-2-git-send-email-christophe.kerello@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:58:06AM +0100, Christophe Kerello wrote:
> This patch adds the documentation of the device tree bindings for the STM32
> FMC2 NAND controller.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---
>  .../devicetree/bindings/mtd/stm32-fmc2-nand.txt    | 61 ++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/stm32-fmc2-nand.txt

Please add acks/reviewed-bys when posting new versions.

Rob
