Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90189C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDC12148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545944514;
	bh=Y4GOugBwhWonDxoH19LzI5jgWAjvjeNTZvWf90USwsw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PfE+T3tmQSFFX4UPSP6D27dKb+mMB7xegJ8Li+TQCtuRn9GwA65SfRZsu6HlcFiVC
	 qRAXE1HlZhqLJMZAeDrKa5g4qsDva4sY1QRqh7qmboM7V/v5zR65WRfiwFJqH/veJt
	 33rfT1IKay1l9RZ2g4tzsKYis0YjY7HEpskBpyqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbeL0VBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:01:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbeL0VBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:01:52 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F39D121907;
        Thu, 27 Dec 2018 21:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545944512;
        bh=Y4GOugBwhWonDxoH19LzI5jgWAjvjeNTZvWf90USwsw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KoyPxGWg9Hx+ClwtgxdI0pF59ghQQSzB7qBr0bkHgNpmzdZfxirQPCjOedEA5uLDL
         FRrp2azvq43bbIAITc8BbPZwBafJ6J0iHYcy1VyNqLo1GrtV3KhXzX06y0lTqddhGT
         s76BrsNYDgDk96/u+FxgGzQhlE0hRKqdwoIETviw=
Received: by mail-qt1-f182.google.com with SMTP id t33so21470658qtt.4;
        Thu, 27 Dec 2018 13:01:51 -0800 (PST)
X-Gm-Message-State: AJcUukcJvDmied3Y3vvIiUeU/2vSpws+Iu2kafKvRUo2sNqW2yZmLdlu
        c/M1w6CklRKhNY2BK3Kxl/uJpLPbikVkpMa7aQ==
X-Google-Smtp-Source: ALg8bN4M3Xqy+r6gdp6Pn0xk9/FlLMGkh2No+BfyI9khb1P85Nt7XFms0Znf8gD49Ezqh0We0OBo8fPF+vcxbG8J2zk=
X-Received: by 2002:aed:3ecf:: with SMTP id o15mr24181299qtf.26.1545944511155;
 Thu, 27 Dec 2018 13:01:51 -0800 (PST)
MIME-Version: 1.0
References: <1544445555-17325-1-git-send-email-pawell@cadence.com>
 <1544445555-17325-2-git-send-email-pawell@cadence.com> <20181220200111.GA27998@bogus>
 <BYAPR07MB4709910A6EE4B54BA455E713DDB90@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB4709910A6EE4B54BA455E713DDB90@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 27 Dec 2018 15:01:39 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLQ83f74kMRsRX=Bo+xwP05v+2dLQaPLVV3EU7k=QwvSQ@mail.gmail.com>
Message-ID: <CAL_JsqLQ83f74kMRsRX=Bo+xwP05v+2dLQaPLVV3EU7k=QwvSQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: add binding for USBSS-DRD controller.
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Pawel Jez <pjez@cadence.com>, Rahul Kumar <kurahul@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 4:24 PM Pawel Laszczak <pawell@cadence.com> wrote:
>
> Hi Rob,
>
> >On Mon, Dec 10, 2018 at 12:39:14PM +0000, Pawel Laszczak wrote:
> >> This patch aim at documenting USB related dt-bindings for the
> >> Cadence USBSS-DRD controller.
> >>
> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

[...]

> >> + - phys: reference to the USB PHY
> >> + - phy-names: name of the USB PHY, should be "cdns3,usbphy"
> >
> >Don't need -names when there is only one.
>
> But in the future probably we will need to add next phy version.
> So maybe it's better to leave this name ?

'-names' are for when there is more than one phy connected, not
different phy versions. For example, if you had separate phys for HS
and SS.

Rob
