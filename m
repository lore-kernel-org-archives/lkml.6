Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D95C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE2520657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 20:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547582981;
	bh=ZutIKs+49MK4Q3v5mUfNkEPFJLd6wWf76ZR6dOQbyWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Ud78PTHyrtmRtEtp6/N+EJmkvG0hgxIF124FlGRiERDDLgqG4PHNNmbcDolxc+oG
	 hyeKoM3f97Vazi4zOu9/ETaUMGHNY8/uqw5QoVpf1csa8KAqVKfjngza2Zrb1rnTC8
	 tOsHacgTIkWIPEjjYHoVZiOolNVUQRhAfxn9N/eQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389739AbfAOUJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 15:09:39 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39443 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbfAOUJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 15:09:39 -0500
Received: by mail-oi1-f194.google.com with SMTP id i6so3160002oia.6;
        Tue, 15 Jan 2019 12:09:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=X2yI7e5P5cHlZreYokFubrfa8z2b0Exxs+RLSwtsMk4=;
        b=KokB/dU6hqr60X3w3PnqkKZCdFWFwWcflS6vXUNR/CoGaaW/+XqfFlGrzIlK1N9LtH
         p6P1AOKmuYXM/NtyBx8S4Rb/b3QcSOf3O/8fB4Ao9ZqaQc8AtuOSG2NikU6NNsjCbXBd
         +Ud33fNPF/2msntEm73yDvwHo0YTDCg8k1OwuldqnzI93Pb7JRj3utjbEr4O1m5dtbwD
         cWfY1W//jae03XsJda5YsXKYkuMLY4ojv5Qy7q1ny3YpPA5QHKFosQ65y9prJLBrsp9/
         BnnXR0yBlXLae9s1vSPzunUGO+9BlxGoe/PMsMZMq7YwXSkGUjuU/6Txy1PupFuIKb5i
         90Ww==
X-Gm-Message-State: AJcUukfLwaPiWONn8PpK5OUhVUPiF9s5KcFGZb/PD0nIpavp5fkMJCl0
        KvTgGkuSXOOI8qJg6Q6RxA==
X-Google-Smtp-Source: ALg8bN4Y3SYBnD3WyCGD3xjpwdQ7/1yRhPEHfzUscS9OtrUhphDtTpPcuYSgUQG+AvwD9nH4ie/64w==
X-Received: by 2002:aca:b6c3:: with SMTP id g186mr2963515oif.289.1547582978100;
        Tue, 15 Jan 2019 12:09:38 -0800 (PST)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id v68sm1893040oie.16.2019.01.15.12.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 12:09:37 -0800 (PST)
Date:   Tue, 15 Jan 2019 14:09:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Subject: Re: [PATCH shawn/for-next v4 1/2] dt-bindings: arm: Add Y Soft IOTA
  Draco, Hydra and Ursa boards
Message-ID: <20190115200936.GA28224@bogus>
References: <1547562139-64730-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1547562139-64730-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 14:22:44 +0000, =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= wrote:
> These are i.MX6DualLite/Solo based single board computers used
> in various Y Soft products.
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> ---
> Changes since v2:
>  - New patch
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
