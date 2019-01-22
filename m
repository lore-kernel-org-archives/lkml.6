Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AE9C37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DFA21736
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548116789;
	bh=Gh7go1e5noE0CalTmolaBORl2KpCGA1dFF+2Vg+mr3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2rI8KnqxAkomzB7xolO+O6cwiN67UGOeJNfrwtIQCX+/om8R0rWd5E+CxgXlaFHGd
	 BJIS0D+MQddp6qvmTlwJ7aiYEUEbWhuObUbXSAF01UVBZk0EPndDvyTyyDp+shqFYd
	 YhB3BU0MhY+gscMb9Tjb6ghWCCH7xiHvjeQdKP4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfAVA01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:26:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34218 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAVA01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:26:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id t5so17104020otk.1;
        Mon, 21 Jan 2019 16:26:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BRXxaem06/3zekgZE+01VbfJHLkyejV8w4CEcn0uUvA=;
        b=hj1uWw+msTNBpav70f+zdB41R2bCNAj2VQvNvRrJhJ6w1+vmC51GSXZlnS7M8LL2fb
         QEK8BnTHIdkdgTlUlFgvB/146qPob44KC29vVl+0t1jOtlr9MSR5li5klrV3gn7WU6Oh
         r+nHtDVd69tXm+Rt6KgnsiNJ7o8Br5cFkqdnIHCnBRHjH0XracPfkePfbM4Fz705NtQy
         vBlmVMgpsAaAxpL+jHUdOSSj8Zi/n2xsEcvOTGrt5W9wUhv9wv1umQCkQINDCNPP9JZ0
         /biFK8FvBo61NhGDManoQxacB5533yHD2paCAWKWfJuRMeADpW8I9/nHs7L3mPjold8R
         pPNA==
X-Gm-Message-State: AJcUukdA2r1JvnXPZuNK6K+ERQmTEU587NPdjpgL80fsoVvHeJg+HEqZ
        GGoq+ufgKtVIdUlIKKmOnPys0XvSEA==
X-Google-Smtp-Source: ALg8bN51vEeBhcTgMO5EoSf06sGeNsZ9a0brzvaSa0cI0jGxdBj08mlmtZ+h3qgN4MjH5Zfip71Tvg==
X-Received: by 2002:a05:6830:1689:: with SMTP id k9mr19326835otr.129.1548116786403;
        Mon, 21 Jan 2019 16:26:26 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x127sm6781305oia.20.2019.01.21.16.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 16:26:25 -0800 (PST)
Date:   Mon, 21 Jan 2019 18:26:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/8] dt-bindings: phy: qcom-ufs: Add resets property
Message-ID: <20190122002625.GA22073@bogus>
References: <20190111230129.127037-1-evgreen@chromium.org>
 <20190111230129.127037-3-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111230129.127037-3-evgreen@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 15:01:23 -0800, Evan Green wrote:
> Add a resets property to the PHY that represents the PHY reset
> register in the UFS controller itself. This better describes the
> complete specification of the PHY, and allows the PHY to perform
> its initialization in a single function, rather than relying on
> back-channel sequencing of initialization through the PHY framework.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
>  Documentation/devicetree/bindings/ufs/ufs-qcom.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
