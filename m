Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4E7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5610021903
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 21:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545342291;
	bh=g6clzsnP382YdW1/gis2TuR1oePdLM6HGUAGAEG56+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mjvcK8rnf/atg1xo42WOCi+1Dk2cV+OsMKbN9fOOxPYyPiQ8x88L9H0uqtp//jNu1
	 3CMuJTcIXQ06lqVQL4tyV7+uO1L3Ys9v14GNRK2tNWSw3eZrw5sC9xqIKmsG+aWRD6
	 UfgY9FhlkMTFhJnwkqUeDnu7twR/1IQGRXdIycIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390086AbeLTVou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:44:50 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44982 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbeLTVou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 16:44:50 -0500
Received: by mail-ot1-f67.google.com with SMTP id f18so3307371otl.11;
        Thu, 20 Dec 2018 13:44:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hcv/JvV5iX/nX3mmh3kLu2dwoKXyIo05K5vlBzK5ytM=;
        b=DO9SF+o3sFzpJVi9rA0upLz/b0Tctl/YVlcZdCHxQx1rCIyIwJqDaxOvBh6kz7vFRC
         LTxcJ7cIRru0u8DEb9AH2nYoaPkP9McPrro+L78b/IIda674oB1WEaCdSn8JyPEFcigV
         /2gi0Arl1dkIEv7FS0csXq0Jp9hCqi7dqCigZS3tIR2UGV624HSHFsFWNm2AHx21uRMV
         wp4CVY2IG+G9fEM4KYs0lAkVgSBE+yKZr5Rx7cTV5ilb8lR7PKEpeCRMpg2GenO8lFsY
         o8Gvs3P9raigHY68AUndCPAMPU2bSh3SamPVsVQfu7Qo10CEAH0cVY21bXCGC5/YXOjH
         BTYQ==
X-Gm-Message-State: AA+aEWZp3W4oio0f/tXkdWDPRoC2KMeLaFDh0ZkIZiGK2ORXfZgNfcmD
        ZYUSfgnGHa2ZGeG/GXiJRA==
X-Google-Smtp-Source: AFSGD/Vidh7Uj11FAIbu0nMgJaHNvlmUWXUUfleb0g+hFYPXfxprte7KTumuMKBNBNixWDmeUnnhBA==
X-Received: by 2002:a9d:2aa2:: with SMTP id e31mr17919017otb.246.1545342289382;
        Thu, 20 Dec 2018 13:44:49 -0800 (PST)
Received: from localhost ([2607:fb90:1cd6:97bd:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id i22sm10821952otp.7.2018.12.20.13.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 13:44:48 -0800 (PST)
Date:   Thu, 20 Dec 2018 15:44:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 2/3] dt-bindings: mailbox: Document
 armada-37xx-rwtm-mailbox binding
Message-ID: <20181220214447.GA18008@bogus>
References: <20181217153706.25873-1-marek.behun@nic.cz>
 <20181217153706.25873-2-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181217153706.25873-2-marek.behun@nic.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 04:37:05PM +0100, Marek Behún wrote:
> This adds device tree binding documentation for the rWTM BIU mailbox
> driver on the Armada 37xx SOC (EspressoBin, Turris Mox).
> 
> Signed-off-by: Marek Behún <marek.behun@nic.cz>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  .../mailbox/armada-37xx-rwtm-mailbox.txt         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/armada-37xx-rwtm-mailbox.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/armada-37xx-rwtm-mailbox.txt b/Documentation/devicetree/bindings/mailbox/armada-37xx-rwtm-mailbox.txt
> new file mode 100644
> index 000000000000..2d182d61eb3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/armada-37xx-rwtm-mailbox.txt
> @@ -0,0 +1,16 @@
> +* rWTM BIU Mailbox driver for Armada 37xx
> +
> +Required properties:
> +- compatible :	must be "marvell,armada-37xx-rwtm-mailbox"

Don't use wildcards in compatible strings.

> +- reg : 	physical base address of the mailbox and length of memory mapped

mixed space and tab.

> +		region
> +- interrupts:	the IRQ line for the mailbox
> +- #mbox-cells:	must be 1
> +
> +Example:
> +	rwtm: mailbox@b0000 {
> +		compatible = "marvell,armada-37xx-rwtm-mailbox";
> +		reg = <0xb0000 0x100>;
> +		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +		#mbox-cells = <1>;
> +	};
> -- 
> 2.18.1
> 
