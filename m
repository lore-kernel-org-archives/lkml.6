Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04214ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1621208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 18:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sElBP4Tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1621208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732452AbeGMSQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 14:16:21 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38653 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbeGMSQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 14:16:21 -0400
Received: by mail-oi0-f67.google.com with SMTP id v8-v6so63791714oie.5;
        Fri, 13 Jul 2018 11:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=s34nqmnxbjZ+suOXD+A8XJ7aJNuiH3D8IvPokhcN5aY=;
        b=sElBP4TxfopFqZzN3rn94WY9KiA0Ba4PNbNiLpc13APTXUcxZ2O7xQ8L9Fi/vsNbit
         /Nv0tAE8/6lWWFjRv9pG/2GvQMFaaZol0Cb4ond0sZRd2EQP/UIrbYIGEim2CB1L21u3
         FKfp2oUFoKKfG7QjCS8o/nmMesUU1UGsUh7fUAzWGT+FoT9PuSIDjoHlBsS70HG8MkCu
         01wJcFUjsC+G4uTd6V2kNqAUdigFitZ+ZVvPHMOXpa+jWiEDGDArnEVUbEmjeFzK7uLN
         9HSaSYE9EMjhZ4Aw5EqYXiH/vqaXc1o9QJ/MBi92gXyxgqLPQ/xot6NT2WdjFSYrd9Ye
         wpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=s34nqmnxbjZ+suOXD+A8XJ7aJNuiH3D8IvPokhcN5aY=;
        b=TNgj6oMmqW3DLB73pUQLNuv0miwEVefR1znaRswdX63Fyfoosl0RI+2nx7laNhU6Co
         hDWmdZGoknQvBaP/eSxo0Gt0c0QPObRtNuud3PuxBbAZFHCqrdKiFQx0L3NLmCqW3pS7
         F04xC8C+2yoIwx6Rdx26OGmot0DQ0yEOjAfGnwOMoZosL9A2JdynoHj4I14OdVuXSdk3
         56fs0oUOLmbUoAaje3Cz8EcCU+RmqQ6l0EIvA4iBrcKJRDJIWezXuqq8pm/futoMjeTj
         S450s2D79WaDbL3UfgJtlVlQ/ydE9fczKi5P+uLwU8SB7EjiR7tUT1Vqg/W48NfQ43nI
         btaQ==
X-Gm-Message-State: AOUpUlFypiIsms1ldrlmfYSGHOEBtqdp7WXv5p33bmwiQHGBKSyF3xDg
        SxFSRSERajZDkzPN6XPzjOOmgXFPUv2WUN4wyYA=
X-Google-Smtp-Source: AAOMgpeK/2pNOwn9iU1Ya0gt6muwRKx13UcK5aQVmi3UgBIJCK1DMrR9rz8kFFHPkJIcrGgxL7Vpjgr4hPDENLRWIVM=
X-Received: by 2002:aca:b3c5:: with SMTP id c188-v6mr8571849oif.9.1531504840575;
 Fri, 13 Jul 2018 11:00:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 11:00:40
 -0700 (PDT)
In-Reply-To: <1531468707-25737-2-git-send-email-Anson.Huang@nxp.com>
References: <1531468707-25737-1-git-send-email-Anson.Huang@nxp.com> <1531468707-25737-2-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Jul 2018 15:00:40 -0300
Message-ID: <CAOMZO5DFrBr=gC_qwFC4yHxT-KH5NMh56a8cL6F=T72XmzRMnQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: imx6sll-evk: correct lcd regulator GPIO pin
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 4:58 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> On i.MX6SLL EVK board, lcd regulator is controlled
> by GPIO4 IO03 using MX6SLL_PAD_KEY_ROW5__GPIO4_IO03 pin,
> NOT MX6SLL_PAD_ECSPI1_SCLK__GPIO4_IO08, correct it.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
