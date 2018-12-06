Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA35C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306D920878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544139208;
	bh=gZxZKWzS/CFBRJ5cx9gU4j7NTuSbfpHO6a+5reMvM/I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=14QxySNTKqSlmRzGlQZadjydYHd8luYwUtp5rHvZTYMMYktyZ5wfjgl9FlR6PNx7n
	 AE6a0+DTsyQzw6AFzcKpghq452lk8YFhV0DWSvHccZNqkcbUvYOhaDEuUsKw5uOR8U
	 l8Fupr139lGABpmb0gsRr52z27paQkVqS6wxoWIg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 306D920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbeLFXd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:34884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbeLFXd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:33:26 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBDA820878;
        Thu,  6 Dec 2018 23:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544139206;
        bh=gZxZKWzS/CFBRJ5cx9gU4j7NTuSbfpHO6a+5reMvM/I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z8R+GUK8HmCWPi80PyCnBiS2XVMwSALm+ygpr1Sb4NJTdT+RF6UcKTs2v8neW/MRT
         GVKK0yHT+VR4xT+Jnj9WY5GIJiNonv+56yeq2kJU6+i3PzYey5XM21Dg97lqWG/sfS
         vcqs/Q1VjdEmcMUYKwSYmLNeoqjLcLvuAey0TbrA=
Received: by mail-qk1-f179.google.com with SMTP id n12so1430634qkh.11;
        Thu, 06 Dec 2018 15:33:25 -0800 (PST)
X-Gm-Message-State: AA+aEWb7Gw/e9SzrVO09j3zhpHZHxzvavdNlnFigXfiu8QGUy95J6qME
        EMdtirHaCxpFGB+LLDH6s1pibe3bPWGApWRyIA==
X-Google-Smtp-Source: AFSGD/VAAUM4UeHiln1FkoZdLxs4GVSy23jQgIG4UQhXKT7qgvB21vJxN+mpR+mykRFVaL2JgzlKp+pHBoQKxo1/gxg=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr28723113qkg.147.1544139205175;
 Thu, 06 Dec 2018 15:33:25 -0800 (PST)
MIME-Version: 1.0
References: <20181203213223.16986-1-robh@kernel.org> <20181203213223.16986-19-robh@kernel.org>
 <20181206023140.GZ3987@dragon>
In-Reply-To: <20181206023140.GZ3987@dragon>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 6 Dec 2018 17:33:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
Message-ID: <CAL_JsqK5nBdk-MiuTPMxr9oXqXnLqeMU3vtZi6AnT9V35_W55A@mail.gmail.com>
Subject: Re: [PATCH v2 18/34] dt-bindings: arm: Convert FSL board/soc bindings
 to json-schema
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 8:32 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Dec 03, 2018 at 03:32:07PM -0600, Rob Herring wrote:
> > Convert Freescale SoC bindings to DT schema format using json-schema.
> >
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/armadeus.txt      |   6 -
> >  Documentation/devicetree/bindings/arm/bhf.txt |   6 -
> >  .../bindings/arm/compulab-boards.txt          |  25 --
> >  Documentation/devicetree/bindings/arm/fsl.txt | 229 ------------------
> >  .../devicetree/bindings/arm/fsl.yaml          | 214 ++++++++++++++++
>
> Rob,
>
> I do have any changes on bindings/arm/fsl.txt queued for 4.21 on my
> tree, so please send it via your tree.

What about:

c386f362957b dt-bindings: Add compatible string for LS1028A-QDS
3671cd57de06 dt-bindings: ls1012a: Add FRWY-LS1012A device tree binding

>
> Acked-by: Shawn Guo <shawnguo@kernel.org>
