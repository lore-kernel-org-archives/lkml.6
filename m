Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB90C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BB120827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmNy+eDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BB120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbeKGTc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:32:57 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41558 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeKGTc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:32:57 -0500
Received: by mail-ot1-f43.google.com with SMTP id c32so14239709otb.8;
        Wed, 07 Nov 2018 02:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeQ7BRNzLWGIhNymOcicRZ9ZkF92+N904/fYynWJtJs=;
        b=lmNy+eDtGHEOWQZcGs6qZgQzbelR4yD9ItFt+C5+dXPN85mhZGCLj7egNBrQk1bNZH
         zio5W7UD6zoYRZXrZh/0Ts6DdSYeQlqXBCYtC5KJxwvb+IZux8amI+X4NMHYmhAlNuyn
         cs94Gnzq+3vR9ucUQH/iUKgxTXN2T8GyFLE8dG3AKo1z3lxOJ2EqfLx1mGGAHVwoE5sg
         kgn1ZfTshNbKeu/HkrgGMBGUkMV5uU9yN4aHl4ecFwmq5Zdx9ytA9X3T3Xv+i349Npsr
         QHJdAg6kTf10wjgsGUqNT3i9v6Wu0j0JMb+/5TFrIhtqymL4BX9d9cUYvP8KwM090Dsy
         curQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeQ7BRNzLWGIhNymOcicRZ9ZkF92+N904/fYynWJtJs=;
        b=GrkhJx6AG2vwMmALPqIc9yR8E6UB/ArgRphjEeLoow3j5UOyXUSsneQlijL3lECd+l
         FGYDh82XmnN3aR9XQ4bvaVTMjz6yFO28B+0XTXR4Leix+LST1/Fch3MONS0IFBSWLPx9
         zkwDRYTj/jxRjWVYzk0GMsl2/mVLSdq+suk+jKTTRJfZfbbyRUsSV/6NQx3RbmA7eQ1L
         GYVhwVp3RLMr8+p3NHMZndmu8d13DXDlstwwW0wOP8rOJyhPN3fb0UggQ+0Ig8yJ09jx
         hUshKRXZ4MSemK2D3XJW7T3cOeOqQ0FWI1zd8hvpIyImK78unm5vwZAn3XT8mbVOk1fx
         k8QQ==
X-Gm-Message-State: AGRZ1gI0gFPVbS9CAIt0U5N+bNoUSrKeqN2idvpgABipgl+NO79A7s4k
        jTs1X6FcmfBYeY86HL8I8uxeaNd2TEvC5yGEU4E=
X-Google-Smtp-Source: AJdET5d7kYIIeseXcO+tUTV7pkzzHxLxaxAPu9Bblr890RxflbI+zqKEzJ6t90/Bhz+iU+t8roh/j9GzqUa01AkLhuc=
X-Received: by 2002:a9d:411:: with SMTP id 17mr628184otc.78.1541584999002;
 Wed, 07 Nov 2018 02:03:19 -0800 (PST)
MIME-Version: 1.0
References: <1541567625-11812-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1541567625-11812-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 7 Nov 2018 08:03:09 -0200
Message-ID: <CAOMZO5AL03yy6Vj_eC=h7scSDnuja1G8rsWER+r7w3FEVaceDg@mail.gmail.com>
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

On Wed, Nov 7, 2018 at 3:19 AM Anson Huang <anson.huang@nxp.com> wrote:

> +&fec2 {
> +       pinctrl-0 = <&pinctrl_enet2>;
> +       /delete-property/pinctrl-assert-gpios;

"pinctrl-assert-gpios" does not exist in mainline, so not sure why you
are deleting it.
