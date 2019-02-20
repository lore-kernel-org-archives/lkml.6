Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121B2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D726920C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550669630;
	bh=q+uXsa+PqEQd6PETRf6Wmpahx238+Gu3Bou97z5f0hM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=un4AMUgbRvJwZoseDzYPX5WGDaTIPchrxjWI1JDBgp6+QMZtPEwWb+ffLbgoPL0wW
	 nm+FlpOuldJ+kpV/s3ZOCKSLF2ZV6/i/DKpPfE+j77HRIB8CGZ5WzVwVtXKc8hKa+g
	 BiO0UmK1qtmC9Mm4V/QjYsEo6fsnaAIvneSElgsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfBTNdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:33:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfBTNds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:33:48 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA88120C01;
        Wed, 20 Feb 2019 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550669627;
        bh=q+uXsa+PqEQd6PETRf6Wmpahx238+Gu3Bou97z5f0hM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CChcZxGISMK/IavizcfUdxzQE5FUKsOWdW6LmD8RdygyQex3A9aWbl0Rk84FEm8LN
         vV1HR68pnJlqBI55TuOTEETbL/mb6m4BgtgXzr2vdQ2/jOamCZp/c0ju6qT5JCjdDV
         EpRnc5ZuwzPKDH8ohAnXIzOzZsY2Xb9hXNcaZCpY=
Received: by mail-qt1-f176.google.com with SMTP id b8so27073945qtr.9;
        Wed, 20 Feb 2019 05:33:47 -0800 (PST)
X-Gm-Message-State: AHQUAub/BlyoIgrJgy4nNhe09upnHa1t7ZLyUYXC9sSG7gFdxbdJ43W2
        M4tk909a3ZEQSe40YBWG6+faLdnBShJtGyrZBQ==
X-Google-Smtp-Source: AHgI3IY+piLFFNDJGG5O+6N9zvc3xOFz32YoBd1q2JLclT/yG8io879Da0ELpzXWW287DJoin1NsJ03iynhLCIq3htY=
X-Received: by 2002:a0c:ecc5:: with SMTP id o5mr26036439qvq.106.1550669626898;
 Wed, 20 Feb 2019 05:33:46 -0800 (PST)
MIME-Version: 1.0
References: <1550648622-10541-1-git-send-email-sugaya.taichi@socionext.com>
In-Reply-To: <1550648622-10541-1-git-send-email-sugaya.taichi@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 20 Feb 2019 07:33:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK-8iBaF92GpXdoZwBEaT_mQAjO_4URR9iPJqAiy=YW=w@mail.gmail.com>
Message-ID: <CAL_JsqK-8iBaF92GpXdoZwBEaT_mQAjO_4URR9iPJqAiy=YW=w@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] dt-bindings: Add documentation for Milbeaut SoCs
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        soc@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 1:43 AM Sugaya Taichi
<sugaya.taichi@socionext.com> wrote:
>
> This adds a DT binding documentation for the M10V and its evaluation
> board.
>
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../bindings/arm/socionext/milbeaut.yaml           | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml b/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
> new file mode 100644
> index 0000000..522396f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/socionext/milbeaut.yaml
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/milbeaut.yaml#
> +$schema: http://devicetree.org/meta-schemas/milbeaut.yaml#

This line is wrong. All DT schema should be:
http://devicetree.org/meta-schemas/core.yaml#

> +
> +title: Milbeaut platforms device tree bindings
> +
> +maintainers:
> +  - Taichi Sugaya <sugaya.taichi@socionext.com>
> +  - Takao Orito <orito.takao@socionext.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - socionext,milbeaut-m10v-evb
> +          - const: socionext,sc2000a
> +...
> --
> 1.9.1
>
