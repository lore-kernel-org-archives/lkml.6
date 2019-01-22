Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09D2C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854EC2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115923;
	bh=DATvTix7nY2O37RxalDYKONsbRm3+nECmUfZrf3VXZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tucUNjvt8WPiSgRIbWu8boB0HsfPoraw707UpzMHHJNVPNEipgZu5UgwWzfcCm8q/
	 17DsJ4ycg07+iolEEtybbv2Z4UlStK090GE4rp3mQb0ULoJPRHeXX9WVSV4RP9874r
	 q4BDHDVvDMI4LQh5B1ZO3XUn5E6YFJMwUG9mdqqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbfAVAMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:12:02 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34408 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAVAMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:12:01 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so17080557otk.1;
        Mon, 21 Jan 2019 16:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uwOnljoybqlcghtAFqmFtkneMxMmhHr1OEvzcqjbGAk=;
        b=dZqiXUUpu4aSQjZgXN5U8ZTsEZcML035th0eFM12KFI+bSqsKnj1vcljX/mW4E9QC1
         8abVivofAVytw87bRv/Uhmg6+Sgj0N4KiDPFz87lCGmNaBaXglqkz8jt05SU5n2FbXOp
         GAp24Jb5j3dK6hrGyvcOua/Fz7gBdxsYReglGZXCTFgtVy51jMVcldPDNyhFliUwkaXB
         VdQy2boo+7IfHeO0FwapLnQf/LjtQVqLhkhAVX+oCC9V1hvgT2oPgNc9tzckPQS5dHHD
         JpiEKW+tjqDVP06JeBlfdpbMJORVF9H8F48cHh+Y3L9BRTrHC6nDvbsvg5fUGVhRJe8a
         q5wQ==
X-Gm-Message-State: AJcUukekW8j+u+k81h02fUdISMMTh9vR/vW85c7mnY5ov7cckgXnkK40
        OWAOMZYT50EXnCZKXYzVGg==
X-Google-Smtp-Source: ALg8bN5H1PCxu670A3uwImAFIF2xJ4Mo7y/5L8kYwqUli9tq3XaNcu70xLbw2xn8mQ+k4FsJ6Qau2w==
X-Received: by 2002:a9d:4c8b:: with SMTP id m11mr19629696otf.111.1548115920842;
        Mon, 21 Jan 2019 16:12:00 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y25sm5981283otk.50.2019.01.21.16.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 16:12:00 -0800 (PST)
Date:   Mon, 21 Jan 2019 18:11:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 06/11] MIPS: ath79: export switch MDIO reference clock
Message-ID: <20190122001159.GA29831@bogus>
References: <20190111142240.10908-1-o.rempel@pengutronix.de>
 <20190111142240.10908-7-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111142240.10908-7-o.rempel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 03:22:35PM +0100, Oleksij Rempel wrote:
> From: Felix Fietkau <nbd@nbd.name>
> 
> On AR934x, the MDIO reference clock can be configured to a fixed 100 MHz
> clock. If that feature is not used, it defaults to the main reference
> clock, like on all other SoC.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  arch/mips/ath79/clock.c               | 8 ++++++++

>  include/dt-bindings/clock/ath79-clk.h | 3 ++-

Acked-by: Rob Herring <robh@kernel.org>

>  2 files changed, 10 insertions(+), 1 deletion(-)
