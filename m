Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE86AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF3A21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545145580;
	bh=fub2BOg0hcZeYxj6ITUuTim6hAW6UBoYpbwTUk06l2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vpKaBr8bHtfJ0iKVKk1uaqbYN3GfuH7qfV3miwwTg/xZANPwZckfq+n/9cAleb0TX
	 a2mOVSBEc42VQzz+fp1+TNCPXKF/zSBLcWQsHEOwJ6KcBWAx4zup17Ea2L1sT2iygT
	 LO/nBG4SlEOKSFEZPzExSUyrcp7IUN5nIxaqV+GM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeLRPGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:06:19 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45248 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeLRPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:06:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id y1so2146957oie.12;
        Tue, 18 Dec 2018 07:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hMK+igEy7KsEb+Om4FKItxt2mUoYGrZdXguXLnxgbpA=;
        b=Y6xcqOJRZbVVLsyb//UIub+hygzmph4kbTVjZwDEWWDYCCjQe2DtmaYHsPgF030Rvx
         v3c823j+JNjvkhwJ5yls6tW+H0Fl0B6MjZNDzA0Iam7HhO50sha+cWIQCCwb7oV5THgY
         5W7iMFSxIUQ0hzZAUAdz9in6MyB8BCfx6N/FxxvMddqjOtGDsqCVec6oNe35++rv3fgs
         LCqZ1ojxSYdmVlh0OM+GPrTD+/D410pAbVFnIZ+20eiHzLjUqQenBokPsMXorsx3Fzc2
         CzKawN1dAaI/3LltEa5DGgkcLJgxGrXYouqd7D7RLmxWEECg6W73wQW+BPrwvh/TsPHs
         EC2A==
X-Gm-Message-State: AA+aEWb9Zy47DdySGPzE1s44rR2AuKepNlHFtVLpZ2kZvNjOsSivM2Lm
        jKXJ7IezFsyKxlg/Y+zhSA==
X-Google-Smtp-Source: AFSGD/V3zLSMUXN/Y1bhpKJW33svgyTUvdk/HTt4B3v/LG+pAqYLHbzw9dCT2nkvcGXBWKKUeK8Mcg==
X-Received: by 2002:aca:e346:: with SMTP id a67mr8300426oih.81.1545145578505;
        Tue, 18 Dec 2018 07:06:18 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 62sm7567725otu.42.2018.12.18.07.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 07:06:17 -0800 (PST)
Date:   Tue, 18 Dec 2018 09:06:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: interrupt-controller: stm32:
 Document hwlock properties
Message-ID: <20181218150617.GA26851@bogus>
References: <20181217142215.17493-1-benjamin.gaignard@st.com>
 <20181217142215.17493-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181217142215.17493-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 15:22:13 +0100, Benjamin Gaignard wrote:
> Add hwlocks as optional property
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/interrupt-controller/st,stm32-exti.txt        | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
