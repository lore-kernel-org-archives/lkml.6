Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40597C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04AB720672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgGZrhsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04AB720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeLEMRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:17:02 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39451 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeLEMRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:17:02 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so14539085otl.6;
        Wed, 05 Dec 2018 04:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7F4jQAxIjA2RYWh6EUzGOSX9EbmUsbYMsDcO2KLINs=;
        b=VgGZrhsRVeU/6A2RcMbQhweMi79hFv2fFfUHRuKNz6j7KN3HtD6nKu9jodsY1wYA5b
         W1ymYB5/UJzMCTwZNn+ySu2GPMr/yQcMAXIojGt+mFktzRl9tH/UEAOY7i4Obp/7HCdQ
         Q9MXuvKiznQY6Fdkm/A4fxYHT3blxITf0/roCwI4WO+sKwWEjiSOFroU+mjrT6B0O1Eo
         jjJi+aM5qsbUJth2Bv9Ni4fHMA/ztiTpHpOsC534VX/ZkCXbgat4A54xoQvont48An+V
         YigLk7K2zD5kcHGbPCy0fLNlpSW72Iw8IvSkTkeYXWYkREBqWbyZJcILy496HCFZ2ZKf
         /HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7F4jQAxIjA2RYWh6EUzGOSX9EbmUsbYMsDcO2KLINs=;
        b=c2qSe48k+YgOblMLpIvqwa89IuMd1ccnOeyPZAHxlEa86s9AJpF9updzGwj6rMmDhB
         wyExC8oNXJIF9KtKyN+61EyvVi/GloBz5wvQdgz5KPYevRFk8CS39lFKSgfhRjYlKuu+
         msNA7enjJ9eJ0wn5PKAY2BL9WOaSbJCvgVkDQOue8/HRLBHnJUfzH5YhP0SgvcMrlmAp
         /q4gf+y54BRZ4PFyj5vgpCod02tn6/V96C+GiGe779iWKpKXGOD4yuVCDMEp2AzCfZ9C
         P9fbTjRhYkQTtiIk+ma9I+6LdIpV4S7+QZO/nfASUo7A0WO2Ola4ITCe2i4hvq8paGOX
         J0Sw==
X-Gm-Message-State: AA+aEWaq6wW3jmaJJ0M3S6Gy52qP6MtMA2xyeY1QgAFSmfxHgp0iLIVx
        nVmBWvhpaFxH8ha25B94L70FFucBzt/fthBcYTM=
X-Google-Smtp-Source: AFSGD/Vl+mXhnfICGBdS/GcvSRiJEIFuEHs/maZbKOrzhjjL8KexX3YYDBSUtcN7yyVqYD/1mZ4goGBEky93+maNYhE=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr16537778otp.225.1544012221012;
 Wed, 05 Dec 2018 04:17:01 -0800 (PST)
MIME-Version: 1.0
References: <1544001240-18622-1-git-send-email-Anson.Huang@nxp.com> <1544001240-18622-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1544001240-18622-2-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 5 Dec 2018 10:17:05 -0200
Message-ID: <CAOMZO5AC5eACNK8n1Q6iSmah-Myv3sKka253JGRmSg3cMYKqEA@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: imx6qdl-sabresd: add magnetometer sensor support
To:     Yongcai Huang <anson.huang@nxp.com>
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
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 7:20 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Add magnetometer sensor mag3110 support on i2c3 bus.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
