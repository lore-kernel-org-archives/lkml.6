Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F255CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F602245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0F602245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbeKMMJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 07:09:45 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43310 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeKMMJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 07:09:45 -0500
Received: by mail-pl1-f193.google.com with SMTP id g59-v6so5196216plb.10;
        Mon, 12 Nov 2018 18:13:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ANiopLbomRz7Rz54UA4elz9d4ObkTVwdrR924moDmpk=;
        b=gpdnmdlSPu7dluQBNdUibY9dbXihrmSMkcYDHWBvU4MfcC5uSEl6YYSPyHGWI2aLXq
         BV2wuoudCWZBrX8Lb78tfJHvdv4sWmnhZNAH7wkIkjPE5TGJOiQGKen/e6ue8mDbUz4U
         AyDg//cSJhmCPbis1Wvs8J3pVuDRpBpo4skfjqjGdUoHSNbl365KxrrMMzFPy8qB94ty
         MGCCVCgoUQhYqgwYs0cSI/f7jUcCuUceyCZw1Jya0iE48vkiErugNv82pSf465rAkai4
         crdalsrWZ5ffaoAr/u9feoeU9yH8We4y1x8WJm4VNysF00m8bX0qhl6dx763+truaB03
         JJAA==
X-Gm-Message-State: AGRZ1gLaK08D+E3dcFybQIHsAwBEiAP3t9s34oyP+olAWOqWx0WRs+zI
        emF8J8yBkwWwLOsv00CJZ/bjyVcwMlxH
X-Google-Smtp-Source: AJdET5flrjsxnZtocXuSwmJMwKDtybBEVEzGMYfN6cYLxYSgeoRCsl+xtcQ2i2e+7wJ0VoZDeP79VQ==
X-Received: by 2002:a17:902:3041:: with SMTP id u59-v6mr3285341plb.265.1542075230860;
        Mon, 12 Nov 2018 18:13:50 -0800 (PST)
Received: from localhost ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id i88-v6sm36615082pfi.66.2018.11.12.18.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 18:13:50 -0800 (PST)
Date:   Mon, 12 Nov 2018 20:13:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: hwlock: Document STM32 hwspinlock
 bindings
Message-ID: <20181113021349.GA9687@bogus>
References: <20181112152342.6561-1-benjamin.gaignard@st.com>
 <20181112152342.6561-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112152342.6561-2-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018 16:23:39 +0100, Benjamin Gaignard wrote:
> Add bindings for STM32 hardware spinlock device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 3 :
> - fix clock name in properties description
> version 2 :
> - change clock name from hwspinlock to hsem to be align with hardware
>   documentation
> 
>  .../bindings/hwlock/st,stm32-hwspinlock.txt        | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwlock/st,stm32-hwspinlock.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
