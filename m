Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFFAC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7009D2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:59:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7009D2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeI0FOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:14:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36287 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0FOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:14:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id p125-v6so583179oic.3;
        Wed, 26 Sep 2018 15:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZL73f3BMOR8rsfVY4IU8JzooKkgjUhxP7qa44hUvji4=;
        b=d+Bg04ZNoYQXfnpqLt8uz7oCDXWBKTYKFKK2nPgJJH61hHqtUf02QRLGb774rL80pb
         i73TDjzvYmdgZAz74GPnUlP/qwzDqu+jy9zq3QJKcw3ia92TWTYkiVb2jyVCRELsByFE
         WpsWqgtXq9bXfsuQiLFaFBe7YlVa2MGTgVJAHatZ+UDeU/7oQTKE0EQcf+iEoCUGjyMJ
         DEANbzY1LZetpihbc/YWj65fsW2dYrBJE7g+T/9wCEa+NP+zqqf96fGurTyL7L8JpKtl
         gmntPV5H+9qBygFOeETooJtIBx53jLXm32y8GP2fpgZRx3I5xXtTEEhBr5VdIEweHeZP
         781A==
X-Gm-Message-State: ABuFfohNIxQDJ7ms04sqUhse2SGhwgkbX3GTLnfTRW795G4XXjaARQ1v
        bTv298MD0P1suKtEebtIFA==
X-Google-Smtp-Source: ACcGV62Iszy87DHvPHWd1ub5nyhlY4H5lDhwQy+LTpffa2jGRL9oBvX9LH/5g1Dr/+h1L2glcYKuSQ==
X-Received: by 2002:aca:3195:: with SMTP id x143-v6mr1970797oix.213.1538002756088;
        Wed, 26 Sep 2018 15:59:16 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l195-v6sm117180oib.17.2018.09.26.15.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 15:59:15 -0700 (PDT)
Date:   Wed, 26 Sep 2018 17:59:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: Re: [PATCH v2 3/7] dt-bindings: pinctrl: document the STMFX pinctrl
 bindings
Message-ID: <20180926225914.GA24913@bogus>
References: <1537363669-25991-1-git-send-email-amelie.delaunay@st.com>
 <1537363669-25991-4-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537363669-25991-4-git-send-email-amelie.delaunay@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018 15:27:45 +0200, Amelie Delaunay wrote:
> This patch adds documentation of device tree bindings for the
> STMicroelectronics Multi-Function eXpander (STMFX) GPIO expander.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-stmfx.txt  | 116 +++++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-stmfx.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
