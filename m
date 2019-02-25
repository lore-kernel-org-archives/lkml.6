Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B02C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7DE217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 23:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551137665;
	bh=vGe6r/0WBaE1cGB96nF2TfV+q0InSUNHxlibt0RRWpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fxClmJ0ifwB35xxxZqRZ16pdT9GCZHKegij6eTH4OEISEqSsyK9SBRAftOq9DOoNW
	 dCONhgij6X3qxqAxKcrrc5vprV1iY/7QV0f4B2+V936xVjkwCsZk73GHS1FpfqgJDk
	 B3nvwhPTEppShC/y4+2cNm3fhxTV5sfpVshJYUfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfBYXeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 18:34:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41738 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfBYXeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 18:34:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id t7so9487028otk.8;
        Mon, 25 Feb 2019 15:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c8oXsqB5Ok0b8sjg6xpZA7ocOHV13pwA35hYb3aB/lQ=;
        b=hhWhrgtjiJ3Ha476Oawsa3E3W/CqdUyW9h9zG3Mz+ykQdFFoJS6HMLI440PZPsM/A3
         7bJaLTHzvjKowncBvR2M6v3qRsxqu4EluhdklmcMurRw8QmMLmAuI8tjg0LfeGccwAI8
         2jCt8LHcdqc7QEbqeFmQUwy47WRWEOrK5/Sr0hTMOMXZRjNV8ikzli9dLgrxkUEas5tw
         4gFAicA0HFw4e1yTYvQ6A+qAFsFmUXG/Z6pwzRTOHiOyV/SyaRNKrZvPOPXsflVeL7K9
         sEsfOlyJ6Vcpk7KYNIlQ14j9fef31ZXp1Sm/6/SJSofIILipcoILTL+kroCZvdeJMHqO
         Hrvw==
X-Gm-Message-State: AHQUAuaDg3OhYjqXtV7xvsXxhcBilLNrXO6TNkp2PNSoQ2eSMdD38bua
        ieHaSng3f3I5V0tKfUyNHw==
X-Google-Smtp-Source: AHgI3IZIJ+/D8oALeJhUOcHliMkrX0327Htu1KV198bXf3fS73jpvqRYeDwIgdC6zX7U0svoPK7xuA==
X-Received: by 2002:a9d:7094:: with SMTP id l20mr13547475otj.337.1551137663153;
        Mon, 25 Feb 2019 15:34:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e12sm4535547otr.1.2019.02.25.15.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:34:22 -0800 (PST)
Date:   Mon, 25 Feb 2019 17:34:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Carlo Caione <ccaione@baylibre.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: Re: [PATCH 1/3] dt-bindings: imx-ocotp: Add i.MX8MQ compatible
Message-ID: <20190225233422.GA27988@bogus>
References: <20190211165011.5114-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211165011.5114-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 17:50:09 +0100, Lucas Stach wrote:
> Add compatible for i.MX8MQ and add both i.MX7D/S and i.M8MQ
> to the description.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
