Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD33BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E84B217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550519615;
	bh=mpSRZLmfZdKt/d+Mtcf3Y6fSBpEKO1oxm02PGwyfcQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JNn1Zsm+bAvGPlF/n3DPfGlLw7YzzC1egGrxxlvsChm6XdxtGb4oz4F2doEy6ATtZ
	 Rk35DOtW6Yy+RoU//wsoN40t72C3SxLdS/9ITNwX64FqPIJSJ6O9x4nT3QWGVVjJrv
	 7hBp+sIm2xzknk8pM1bHY/f9N6a3/5DutOAwwPkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfBRTxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:53:33 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43335 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfBRTxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:53:33 -0500
Received: by mail-ot1-f65.google.com with SMTP id n71so30252332ota.10;
        Mon, 18 Feb 2019 11:53:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jlCn6jkU9IcrascAKbvn8O2rZxuEgNgJdsYgsK3IElI=;
        b=RxJqUMeTr5bsRjugTI5tsWwtO7ME9Fy0XUm6Y4CBbyfgwvNMohi4PGBafUIiyVE9Fc
         AiwY+w2kr2Qa+tl15cH8Xxft2vrPHXTN6fW8d0RIa12PUYncCyueHnCgt/L1VNI6jRFV
         31tyOhFe5zDrHt1ezXsAf7os6LSSnvfSmC6K5JNwsejOjAt5Z5rs7ZEpDX33fl71ao1H
         FUs+xJmhPDw8KvEFmDu/xLykDZUyqHkX79gJEnAnMJlhg/V96xJ46sg2VZzm92HmYrk2
         dtwxsVI+x3SN+uRP/kWB+OxU2FOqoPCD5khqvEKAWrJWw06jTeiBVD/3DMtas/bKco7r
         b9RQ==
X-Gm-Message-State: AHQUAuZ263t6AQjBHzwOfkHgSpGdm3cnu3A/an7h9DP6reBgnBtXDg7W
        n2rT3U+jN1peGIXmIvE+kw==
X-Google-Smtp-Source: AHgI3IbXfww3DGmS1wTGJkahwv30ASz3Kha7vmnPGZyuh+3CKl0nRO4gkvq47EYtC015ktvSNWYUeg==
X-Received: by 2002:a9d:7554:: with SMTP id b20mr14723858otl.32.1550519612296;
        Mon, 18 Feb 2019 11:53:32 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t77sm4388276oie.26.2019.02.18.11.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:53:31 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:53:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: Re: [PATCH v2 05/15] dt-bindings: timer: Add Milbeaut M10V timer
 description
Message-ID: <20190218195331.GA16665@bogus>
References: <1549628790-30960-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549628790-30960-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Feb 2019 21:26:30 +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut M10V timer.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../bindings/timer/socionext,milbeaut-timer.txt         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/socionext,milbeaut-timer.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
