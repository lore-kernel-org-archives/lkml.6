Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35DEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5D621905
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AIC1KuR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbeLTUZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:25:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44667 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbeLTUZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:25:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so1435112pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 12:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:user-agent:to:references:cc
         :from:in-reply-to:message-id:subject:date;
        bh=5A1rtr6uvNS9gRaZW6Zx1e/QNz0uhEIGNN/jz/p0Nsw=;
        b=AIC1KuR6vAQcQflDBXptCnSF+mxYgEOPI+k2JRBrWsiALq35/7tMNbRoGE1LurqpIU
         7cdrDoPOJE+2AROUTdJAtJcHO8G8DS4qkaTh12jEH8yHgnIqaxtdaEHeslzQwOGEqgIE
         ytQ/TBh7mjfaOz/p+Qgig7Zm7jr5GqT/Uh7wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :user-agent:to:references:cc:from:in-reply-to:message-id:subject
         :date;
        bh=5A1rtr6uvNS9gRaZW6Zx1e/QNz0uhEIGNN/jz/p0Nsw=;
        b=ZtYLhaDy9uPncEOacod+5x4+JIPeHmrTyAfDw4VM1fVWZKTp1trVmJ/aFlHeVEGgcA
         vqfVP4UIpd9/CvNnJwy5wU9MRQqVJXfUUNPxt0rOo7uV/2L+1JDCTiy8h2nsC0CJmOzC
         Oanvfe7A9wibR5UZGxoO73/WiJrnb5sZuY4fvHpTNzifr21Jclkhia7+ED3KvcueEclL
         MZQ8wgen2XYD3Ql0T2ZWG+hAD1iXa76yaFMDj4piW7/JBko7p8JfGyd3jqVwauc9qofa
         V/1AuGHkzSelLdiyJY3pWqTQ0c39z0UZCw2E1G272L7vV/ZQgZCOi975wAmvPsonQJQX
         bmow==
X-Gm-Message-State: AA+aEWZvU/ss2EPIZn6oTJpOVwAEO3QcYQ+qoKXnlN7KFTirFSrG/zYy
        N9qZCXJNwKPph4D4GGko8lg4rA==
X-Google-Smtp-Source: AFSGD/VAF+b52LV/UBknqm26vuV+RcXAX+qN2GqybCdrfItVwJpevcHcJaXzY02FeDaeoypgT6CKKg==
X-Received: by 2002:a62:ae04:: with SMTP id q4mr10839677pff.126.1545337512078;
        Thu, 20 Dec 2018 12:25:12 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r4sm50889046pgn.54.2018.12.20.12.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:25:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
User-Agent: alot/0.8
To:     gregkh@linuxfoundation.org, jorge.ramirez-ortiz@linaro.org,
        kishon@ti.com, mark.rutland@arm.com, robh+dt@kernel.org
References: <1544176558-7946-1-git-send-email-jorge.ramirez-ortiz@linaro.org> <1544176558-7946-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawn.guo@linaro.org,
        vkoul@kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <1544176558-7946-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <154533751009.79149.13940391507897650993@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH 1/2] dt-bindings: Add Qualcomm USB Super-Speed PHY bindings
Date:   Thu, 20 Dec 2018 12:25:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez-Ortiz (2018-12-07 01:55:57)
> +
> +- qcom,vdd-voltage-level:
> +    Value type: <prop-array>
> +    Definition: This is a list of three integer values <no min max> where
> +                each value corresponding to voltage corner in uV.

As far as I'm aware, this isn't how qcom's voltage corners are handled
or are going to be handled. Can't you hardcode it in the driver for now?

