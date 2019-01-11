Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7430C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857B220878
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547228654;
	bh=O/HUrYYxLFFTdVRLBprksuW+5WBvx8+afTff2Pkw+Ko=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=O6+FZLhvYEqmDpqH544dc3n7hGkE7JNAir9NnjpKS0F2+oV+v2dHgCwvCJ4LGGm9w
	 mtYAUlMGKOyOK4LUAeD/Ckt6CM01qzekeRdN/gqwPKvNS/72gfTWsxXdr1oDxE9pnO
	 xjLVQyqh55zXYSQ685kXc4IJujj6svHGmzxIBj9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732568AbfAKRoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 12:44:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731396AbfAKRoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 12:44:12 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 673B120874;
        Fri, 11 Jan 2019 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547228651;
        bh=O/HUrYYxLFFTdVRLBprksuW+5WBvx8+afTff2Pkw+Ko=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=r/HDcVsog+ppED98B7hQP4QzFFMYdbnlmzeSKDMREW6XSNk0jlkKTfYJNLeM2uP8R
         uh4gsSn7cSNRoSAORr0hS64W0gRoYI+VIlKnat+x9HBTTUBp8284+12GGaAXpanWpz
         z6S9TqQKGIiaw/LSSw14TiayIOUvPk2uPQ+MRlqM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: clock: Convert fixed-clock binding to json-schema
User-Agent: alot/0.8
In-Reply-To: <20190110221903.3990-4-robh@kernel.org>
References: <20190110221903.3990-4-robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Message-ID: <154722865051.169631.16957443589975628047@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 09:44:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2019-01-10 14:19:01)
> Convert the fixed-clock binding to DT schema format using json-schema.
>=20

Any pointer to the full schema?

> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
[...]
> diff --git a/Documentation/devicetree/bindings/clock/fixed-clock.yaml b/D=
ocumentation/devicetree/bindings/clock/fixed-clock.yaml
> new file mode 100644
> index 000000000000..8b5628463b90
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/fixed-clock.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Binding for simple fixed-rate clock sources.

Why does title have a full stop?

> +
> +maintainers:
> +  - Michael Turquette <mturquette@baylibre.com>
> +  - Stephen Boyd <sboyd@kernel.org>
> +
> +properties:
> +  compatible:
> +    const: fixed-clock
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-frequency: true

Why doesn't this need the $ref: /schemas/types.yaml#/... thing?

> +  clock-accuracy:
> +    description: accuracy of clock in ppb (parts per billion).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  clock-output-names:
> +    maxItems: 1

Is there a schema for strings?

> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clock-frequency
> +
> +additionalProperties: false

Does this always have to be specified even if it's false?

> +
> +examples:
> +  - |
> +    clock {
> +      compatible =3D "fixed-clock";
> +      #clock-cells =3D <0>;
> +      clock-frequency =3D <1000000000>;
> +      clock-accuracy =3D <100>;
> +    };
> +...
>=20

Is the triple dot part of the schema?

