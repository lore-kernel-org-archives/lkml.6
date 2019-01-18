Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F91C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED67120896
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXG6OU5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfARTqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:46:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38203 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbfARTqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:46:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so6522551pgc.5;
        Fri, 18 Jan 2019 11:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Kn29sLFMXx3G4CrCmatwvsd8auD+1fo4FY1+dUUayIU=;
        b=cXG6OU5JZ/QRmjJr9jZVLwtZ9mb7Rh6d0Mtsy0dWY30fWn4Jh9BLVNoe2XQI5Ol8IJ
         Bm5ZBual3CWro+n989N/Uyxbjwzd27o0TMSLXB90NOZMp6eW82XV63/2mm8sCxNSrmDV
         S8HVD7v/ohZOKU8BNIkDqTJch7JNm6Hv8on/lpjylgz8x3hQYmRm3rgSsHetDytjzXH0
         +6uYeqqpCnq03DPajvc8W5neWTxCZO6xiehvHp1btYXUwk+OW4RwGDWMp71qofpTsSR6
         SZgxBXB4tDYG6jb9ykvuocDSFhT04SC3Y4LJgDC5zK8ms9OQX3bsf8pruqUIgm68LDid
         MK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Kn29sLFMXx3G4CrCmatwvsd8auD+1fo4FY1+dUUayIU=;
        b=ZUjSrADwFnK5sWP7VMcS8M+78I2NdHXI7P8nXXgaXqzJZwfF6snMJmMTTEKQt66Uck
         ysqfk3hwtCK5bB8WMfXJF4XQzWPEgJ0FYtI8pBb2VuBzzdA/sNrTB+LCrX7GfkM3RczQ
         JNzGRuOl2TxrMzd0U5pCvG833QbsFk1ow/Oh8LERhX1Q3Ur2r3RV5PqHIBk0WFnkoX/x
         x9EpPb33z5kzFuyyf3/ONBf6hQOrKycNa31I2EPf8sBzMecMZfTPtEMWhJ8XBk18Ofld
         GsknzPC//Qx26iosTBaJQR4Cjj4OYnz8EPx2++lB1xrIyQopEhyTz3d+R2vhexgEmCk7
         0gHQ==
X-Gm-Message-State: AJcUuke7EdGCB0rL1kg++wJ7Mz/RJPy8xNhJxvGsdNwFoFo+Pt/pjZou
        6AAuE2iKnT4JN5NUdpDfyVs=
X-Google-Smtp-Source: ALg8bN6FVGRXVHCjPt/Qc84uE8i8UK0i5tZePHv+jOGKl+goE1w8A/klpO+Z2N5EkzkBzyk2ogr3FQ==
X-Received: by 2002:a63:c00b:: with SMTP id h11mr8606380pgg.429.1547840807517;
        Fri, 18 Jan 2019 11:46:47 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n186sm7010514pfn.137.2019.01.18.11.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 11:46:47 -0800 (PST)
Date:   Fri, 18 Jan 2019 11:46:42 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Cosmin Samoila <cosmin.samoila@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "viorel.suman@gmail.com" <viorel.suman@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v3 0/4] Add NXP AUDMIX device and machine drivers
Message-ID: <20190118194642.GA11798@Asurada-Nvidia.nvidia.com>
References: <1547729177-14317-1-git-send-email-viorel.suman@nxp.com>
 <20190117161804.GA5760@bogus>
 <1547817384.11482.33.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547817384.11482.33.camel@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 01:16:24PM +0000, Viorel Suman wrote:
> > > 1. Moved "dais" node from machine driver DTS node to device driver
> > > DTS node
> > >   as suggested by Rob.
> > That was not what I suggested. You still have a virtual node which
> > looks to me to be unnecessary.
> 
> To me removing virtual node implies that AUDMIX machine driver (imx-
> audmix.c + virtual node) shall be removed and machine driver code
> merged into device driver (fsl_audmix.c + device node) - please let me
> know if my understanding is wrong.

We could use a non-DT configuration right? From the driver logic,
DT just registers a device corresponding to the machine driver so
that it can probe(). We could register one in fsl_audmix instead.
Please refer to how fsl_ssi registers the sound card device. The
machine driver can get audmix_np from the parent device pointer,
and I think that's all you need.

Or maybe someone else would provide a better way. But it'd work.
