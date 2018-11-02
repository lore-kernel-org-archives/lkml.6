Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8643FC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5582081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNfbpLCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5582081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727613AbeKBWQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:16:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbeKBWQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:16:59 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B81E020847;
        Fri,  2 Nov 2018 13:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541164191;
        bh=qMZ9pyvPPpltF8qgL0zVw3Rg77DcLSobc/0euP13IuA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YNfbpLCsCdgkYETVweEENx2a5g4v6uDlZI0ZuR5jKt1z6kq91OotgOiOfYRCOtwb1
         J035zvN6THkJOvhI36eG8c3LZag2Xw2fY0SMyu8Pq2QuiLv5jlKl/ddlqYlofPqk+t
         +Eh6xJR0U5sdMqrgTltaxid+bSJ24QNRt0TCcWXI=
Received: by mail-qk1-f174.google.com with SMTP id o125so2901695qkf.3;
        Fri, 02 Nov 2018 06:09:51 -0700 (PDT)
X-Gm-Message-State: AGRZ1gIds90/v2BkbqFTNr8VY2moMjAz662JQRF8OkKm5hbHiXWoMmND
        5dofMmsO6OZ4OZPKB5IOEsD2BKNABuN40WqHKg==
X-Google-Smtp-Source: AJdET5fPJYXS2sBya7lPKKnVQ5AnzKv0C8Klbp4k5H63CRRYLQnLTZmy2NOavro+b86ZqPrV/CPOAROUkwRKGIu7oAM=
X-Received: by 2002:a0c:9e05:: with SMTP id p5mr10685349qve.246.1541164190826;
 Fri, 02 Nov 2018 06:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <1541113468-22097-1-git-send-email-atish.patra@wdc.com> <1541113468-22097-2-git-send-email-atish.patra@wdc.com>
In-Reply-To: <1541113468-22097-2-git-send-email-atish.patra@wdc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 2 Nov 2018 08:09:39 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+wProNynprMjQnrz1jmbZT9TmmA-_=vPUxCEED_8xONg@mail.gmail.com>
Message-ID: <CAL_Jsq+wProNynprMjQnrz1jmbZT9TmmA-_=vPUxCEED_8xONg@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: topology: Add RISC-V cpu topology.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@infradead.org>, Damien.LeMoal@wdc.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, alankao@andestech.com,
        Zong Li <zong@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 6:04 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> Define a RISC-V cpu topology. This is based on cpu-map in ARM world.
> But it doesn't need a separate thread node for defining SMT systems.
> Multiple cpu phandle properties can be parsed to identify the sibling
> hardware threads. Moreover, we do not have cluster concept in RISC-V.
> So package is a better word choice than cluster for RISC-V.

There was a proposal to add package info for ARM recently. Not sure
what happened to that, but we don't need 2 different ways.

There's never going to be clusters for RISC-V? What prevents that?
Seems shortsighted to me.

>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  .../devicetree/bindings/riscv/topology.txt         | 154 +++++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/topology.txt
>
> diff --git a/Documentation/devicetree/bindings/riscv/topology.txt b/Documentation/devicetree/bindings/riscv/topology.txt
> new file mode 100644
> index 00000000..96039ed3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/topology.txt
> @@ -0,0 +1,154 @@
> +===========================================
> +RISC-V cpu topology binding description
> +===========================================
> +
> +===========================================
> +1 - Introduction
> +===========================================
> +
> +In a RISC-V system, the hierarchy of CPUs can be defined through following nodes that
> +are used to describe the layout of physical CPUs in the system:
> +
> +- packages
> +- core
> +
> +The cpu nodes (bindings defined in [1]) represent the devices that
> +correspond to physical CPUs and are to be mapped to the hierarchy levels.
> +Simultaneous multi-threading (SMT) systems can also represent their topology
> +by defining multiple cpu phandles inside core node. The details are explained
> +in paragraph 3.

I don't see a reason to do this differently than ARM. That said, I
don't think the thread part is in use on ARM, so it could possibly be
changed.

> +
> +The remainder of this document provides the topology bindings for ARM, based

for ARM?

> +on the Devicetree Specification, available from:
> +
> +https://www.devicetree.org/specifications/
> +
> +If not stated otherwise, whenever a reference to a cpu node phandle is made its
> +value must point to a cpu node compliant with the cpu node bindings as
> +documented in [1].
> +A topology description containing phandles to cpu nodes that are not compliant
> +with bindings standardized in [1] is therefore considered invalid.
> +
> +This cpu topology binding description is mostly based on the topology defined
> +in ARM [2].
> +===========================================
> +2 - cpu-topology node

cpu-map. Why change this?

What I would like to see is the ARM topology binding reworked to be
common or some good reasons why it doesn't work for RISC-V as-is.

Rob
