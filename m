Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A149ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352CA2081D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmpKzSFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 352CA2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeKIBNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:13:55 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44080 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeKIBNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:13:55 -0500
Received: by mail-oi1-f195.google.com with SMTP id p82-v6so1348236oih.11;
        Thu, 08 Nov 2018 07:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIIq8YdxEOmO1yeq6rWalOX+XMaJ2bcVeyQc3aF6qio=;
        b=NmpKzSFyQWIg6oCuAexeVk97tAJD9ZtN9gB4RY38MMmukMcaPmKux+HQGz+QXV4Tw8
         nvuBrT6iayIVXPCwLQa7wY2kUXWBmhshSPekKEHZbLRX9OrG28GVIo1iY3pv6i+c/QGv
         k5+heGWh8Q9EXzNbkwtC7YDoIyecIvRXEfSsLETuECtAI0R+WFdF0ciwt6+L8DfxFJmf
         O9SqfPUAlh9cDio3l11uPbfVUqVq57LnArKnWUUUaiO2xTH5JygD92pD2+qJV+CztKZL
         EJKAzsMH9nFSc3f/t7pFfYEy1C4kd97t06VGGf0Yn5C/c6T8cv6tOm/6Ev9FG78espjO
         erjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIIq8YdxEOmO1yeq6rWalOX+XMaJ2bcVeyQc3aF6qio=;
        b=HutsbgGLRvUC31wAV3qja4igS4ox8GqMFekQTpTsotH9rUgLIzp97vm3ChlL8OvvKz
         FSizMESQXCALf0wvpt1bG3W95sadSGzLCR0kGFOqS7FqeGYvNZaUnnHo1yi0AOgfRws2
         OpTfNH5u/hKmqeOfNdY5dlSUR+rvq8ksa4skoR02AmyQzl6OHsZh0nKJzfIvfIqKjoZA
         U01Jqa6uYtRiyO0IbyLdYeXFPi8L9KjA1XkAl/6A50832T7Vz8GrIxgh4AjuN7kUl+n2
         hBtZcn+o3lwdbQ12qnSXPb5hIc3WizNnOrtntTwhKYjx/dR01FrjmHDXuasC2+/9CKbE
         Uo9g==
X-Gm-Message-State: AGRZ1gKhiMMl2D0CH/hcC3xkPGdzFyC5LBGJ71xiMgTrAFOjAvwmDzMi
        762yj7bEl8WQhA2vGZWzSpeZGqmUGJBSCDiD234=
X-Google-Smtp-Source: AJdET5cCUjSh+UAPT8YdFMx7W8phpuRQBQZNURE/u/3mjN6YvmRkPaLEgeRf/Wy0ZENGEawNsETLMsojOp2AdrqDxTc=
X-Received: by 2002:aca:5b08:: with SMTP id p8-v6mr3010944oib.261.1541691471589;
 Thu, 08 Nov 2018 07:37:51 -0800 (PST)
MIME-Version: 1.0
References: <1541567625-11812-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5AL03yy6Vj_eC=h7scSDnuja1G8rsWER+r7w3FEVaceDg@mail.gmail.com>
 <DB3PR0402MB3916B318947B803BC5ADF4A6F5C50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAOMZO5DiTbEsVXTCfE8fJ=4+yU4oXR1gex7Bj-k=FowKHWJaxw@mail.gmail.com> <DB3PR0402MB3916B027A9C724D349C7969EF5C50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916B027A9C724D349C7969EF5C50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 8 Nov 2018 13:37:43 -0200
Message-ID: <CAOMZO5CPZKqJdTPzZDw=19HW_YCg_JGvLpw9i3iKsi+EJF-yNg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx7d-sdb: add rev-a board support
To:     Yongcai Huang <anson.huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Thu, Nov 8, 2018 at 12:30 AM Anson Huang <anson.huang@nxp.com> wrote:

> Thanks for pointing out this issue, I made a mistake when doing the search in git repo..
> So, if we have to assert a GPIO, there is no common way in pinctrl driver? Have to
> do it in driver itself? Like this case, we have to assert the GPIO in fec driver?

You could pass "phy-supply" property  and model it as gpio controlled regulator.
