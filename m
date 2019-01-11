Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429A9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D9E2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217401;
	bh=vuxiJvPPK7ndhJoluYei49Nvqmmi7Dx+MQN9FId1+qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BvtW2eDvLjWlE4UCN4I+MoadPIzhMp1Z85Cf16axT9PGM+fcHK9ASofNvKhMGHn78
	 qujx2UbX7Qw4yrZHOyVM1itkHKrRsK1FlxamNn3solIonKt3xYB4cohliU5RWmABX4
	 4DVHfUEZzW79DTlUuDnOaJxk9bVFxHZWV7c6WaE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390457AbfAKOgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35855 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390435AbfAKOgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:38 -0500
Received: by mail-ot1-f67.google.com with SMTP id k98so13272127otk.3;
        Fri, 11 Jan 2019 06:36:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BDijiRVqZlvWlqdcV7FN4Lc/210bsUJyj4iSyX0GAYQ=;
        b=M+c3VLKDX8gE655qARhhpUz03iVlwCh7kIlMwWxn2iA8LM1t6/+KoAFlB7bPFQbJ5p
         sfkkd0nQbmyAgzaV8w/BpVJf4LRhD1iNSShhcRbNtcWeDsA8OSwg12DQwWgL/3+DfnAo
         KpOTVyr9hbw+CP3Nm1vZZ3tUPAhE2RI2/n1CcrcafY/d1ChiRTz2lbaouynNjrMpANgp
         HPiBq0Rh64sEWN/rkiQEGRV4/hUBzze3wmtJ4mLVAOe1X/Nxe3dDEU88+7bUX1yw32MO
         GPIDp0yAyRsEDNMPh+A0WlbtpePeI+2sATSL9u3x7Q7wwQHVTNJiN5GjqZsN6dkq/A20
         SRIA==
X-Gm-Message-State: AJcUukd5iANRo7zweZUvmJ8D46yg21EA1ni7LkKHMe3fVXYcAglt4I6U
        4778CR5dG0hgNc7iDhdTFw==
X-Google-Smtp-Source: ALg8bN4quM9coiLAgkORMDPr3KBCPvTuQMn5R2UotsF9Hwx6xjGnCe/We4P+QwjI4ow8W9agk4Xsmg==
X-Received: by 2002:a9d:4:: with SMTP id 4mr10321155ota.174.1547217396230;
        Fri, 11 Jan 2019 06:36:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c78sm57018411oig.30.2019.01.11.06.36.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:36:35 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:36:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75
 EC bindings
Message-ID: <20190111143635.GA21484@bogus>
References: <20190110175845.1203986-1-lkundrak@v3.sk>
 <20190110175845.1203986-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190110175845.1203986-2-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 18:58:36 +0100, Lubomir Rintel wrote:
> The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
> signals for handshaking. It needs to know when is the slave (Linux)
> side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
> controller node) and when does it wish to respond with a command (the
> cmd-gpio property).
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
> Changes since v1:
> - s/cmd-gpio/cmd-gpios/
> - s/ready-gpio/ready-gpios/ in the documentation paragraph
> - Remove status = "okay" from the example
> 
>  .../bindings/misc/olpc,xo1.75-ec.txt          | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
