Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F55BC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECC520675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="liDWXINg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbfAPV31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:29:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43105 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfAPV30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:29:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so3668357pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 13:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:subject:user-agent
         :in-reply-to:references:cc:to:message-id:from:date;
        bh=EH7F+dVcJha4LEKxS3/EvAsrocfL7SIXMCxxyiJdoRk=;
        b=liDWXINg0EpU9NRy7J3GYh/yGTRiPYoEUeKP7LrPGlYpp9ySi/AIwD2XfLbbTc6RSk
         5sJ3ay4tPUEutdbQYM7ZdVE1/HiwlKlHJ1MmdcVC0Sed3a3PyC5CPzViqR2kwjiWboNw
         U7ezaojZ480O+4BBou9SGHbJsff4W2TmiA/To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:subject
         :user-agent:in-reply-to:references:cc:to:message-id:from:date;
        bh=EH7F+dVcJha4LEKxS3/EvAsrocfL7SIXMCxxyiJdoRk=;
        b=Wg6Fned5+kq8H/PfCwci4DB/7qudsPOUsyBDTNyY4wBidwpEej0m4QmkqalT9SI/pm
         goQgWR7MTrUDQL7nnftk7O8kjZ6wjFmTKYNAxGEaw4vJIBxmfcEhGD4BbW9CxKhXM7cf
         COEJT4A420NGzdVyjeRALARIHeZWZ6/doynEcc4qG60cRWPaPvtpxP4A7ZvwxIGqreaQ
         LQOX8US9Zua/iVEB3/moxumc43MDGrTYb4wcvp3CFaO4FA+c29KaUqn1qGcxKlipMsDl
         K1xgoVnFY7QqaXJeBs3KdW5f3BKKYPIijmkQkoneC87pTuLuFhpCRKs/r3+2CHjcevaz
         kw7g==
X-Gm-Message-State: AJcUukc53SBYybltOtxy3xBb1MQdwJIon7DvHPHrKp3yB5O5rZz4O044
        5z4fS4WmNG0RG+EA/h3qEPzorw==
X-Google-Smtp-Source: ALg8bN561A5Bk4WZHHX8/BKss0LRMBpODvsOZtSTFJWVp8qfohz8sPohlvcgwkoq0t2/FKDn1ga4Bg==
X-Received: by 2002:a63:e302:: with SMTP id f2mr10904195pgh.320.1547674166258;
        Wed, 16 Jan 2019 13:29:26 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u69sm10345551pfj.116.2019.01.16.13.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 13:29:25 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/8] dt-bindings: phy: qcom-ufs: Add resets property
User-Agent: alot/0.8
In-Reply-To: <20190111230129.127037-3-evgreen@chromium.org>
References: <20190111230129.127037-1-evgreen@chromium.org> <20190111230129.127037-3-evgreen@chromium.org>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
To:     Andy Gross <andy.gross@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Message-ID: <154767416474.169631.9323736638860679135@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
Date:   Wed, 16 Jan 2019 13:29:24 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Evan Green (2019-01-11 15:01:23)
> diff --git a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt b/Documen=
tation/devicetree/bindings/ufs/ufs-qcom.txt
> index 21d9a93db2e97..985f5e99ab332 100644
> --- a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
> @@ -29,6 +29,7 @@ Optional properties:
>  - vdda-pll-max-microamp : specifies max. load that can be drawn from pll=
 supply
>  - vddp-ref-clk-supply   : phandle to UFS device ref_clk pad power supply
>  - vddp-ref-clk-max-microamp : specifies max. load that can be drawn from=
 this supply
> +- resets : specifies the PHY reset in the UFS controller

Nitpick: Can you also add it to the example?

