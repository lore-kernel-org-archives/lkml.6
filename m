Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB223C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECBC2081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECBC2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeKGVUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:20:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38949 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbeKGVUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:20:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id n21so3602439qtl.6;
        Wed, 07 Nov 2018 03:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yz3r6B51mmAR0uaX3+2PHQzT9rvnw1Gz7EDpGx/fUjc=;
        b=K4I5dn/T75A6e4np9wsBTyaPvtiF1LfHNd3YacVTXHuDHzqPAYSOnptt+0XeEWelz7
         QBKxiDqv9Mby14Ayn74/ya0DD7VG5WznK/abQH/Qn4M/DViVmfE7f+wT/N5ibNMRmiwB
         xjEN2ZafqWMG2AgasBxVX3CbbLyA7xrL6lTz8XRUDjkVKVD1KPRIaFosiJTgzg5ekuKn
         uQEIxU+r+Dr9sIDGuwSt7u7Sf3aSDUQil0VDXsjb6uJMyQVTYwIxxZ++fiW8GuJ3HXGT
         6KQOn5GEPdQ8DXFbWmjVBNP5fC1RONSKyNCr87Ed9om5oACvLNb0uH1LKykuIVmVoeKy
         sgcg==
X-Gm-Message-State: AGRZ1gKgzyvQwTTLmo9pq+O4M/Nd6dL+OHpfTV0BPKSD+ECJatN1w4ZU
        huvaOOZWnqgznjChT7XWWXyoVd99I6F5ibSpUEhJoQ==
X-Google-Smtp-Source: AJdET5dsqef4eyjZZjCZgpuY9aqXl0hQNXENFfrCyngy4VjsMMZ5tNqzYwdZ80SBxuaQ1brBQHqOvIRzpPx9hPlMfOI=
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr1318292qvr.115.1541591445359;
 Wed, 07 Nov 2018 03:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20181107003250.5832-1-elder@linaro.org> <20181107003250.5832-2-elder@linaro.org>
In-Reply-To: <20181107003250.5832-2-elder@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Nov 2018 12:50:29 +0100
Message-ID: <CAK8P3a1rXwADsgVJ4EAtV3u_qg840tfGnbKcyxuBXDB10sYi3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 01/12] dt-bindings: soc: qcom: add IPA bindings
To:     Alex Elder <elder@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Networking <netdev@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syadagir@codeaurora.org, mjavid@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 1:33 AM Alex Elder <elder@linaro.org> wrote:
>
> Add the binding definitions for the "qcom,ipa" and "qcom,rmnet-ipa"
> device tree nodes.
>
> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,ipa.txt | 136 ++++++++++++++++++
>  .../bindings/soc/qcom/qcom,rmnet-ipa.txt      |  15 ++
>  2 files changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt

I think this should go into bindings/net instead of bindings/soc, since it's
mostly about networking rather than a specific detail of managing the SoC
itself.

> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
> new file mode 100644
> index 000000000000..d4d3d37df029
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
> @@ -0,0 +1,136 @@
> +Qualcomm IPA (IP Accelerator) Driver
> +
> +This binding describes the Qualcomm IPA.  The IPA is capable of offloading
> +certain network processing tasks (e.g. filtering, routing, and NAT) from
> +the main processor.  The IPA currently serves only as a network interface,
> +providing access to an LTE network available via a modem.

That doesn't belong into the binding. Say what the hardware can do here,
not what a specific implementation of the driver does at this moment.
The binding should be written in an OS independent way after all.

> +- interrupts-extended:
> +       Specifies the IRQs used by the IPA.  Four cells are required,
> +       specifying: the IPA IRQ; the GSI IRQ; the clock query interrupt
> +       from the modem; and the "ready for stage 2 initialization"
> +       interrupt from the modem.  The first two are hardware IRQs; the
> +       third and fourth are SMP2P input interrupts.

You mean 'four interrupts', not 'four cells' -- each interrupt specifier
already consists of at least two cells (one for the phandle to the
irqchip, plus one or more cells to describe that interrupt).

> +- interconnects:
> +       Specifies the interconnects used by the IPA.  Three cells are
> +       required, specifying:  the path from the IPA to memory; from
> +       IPA to internal (SoC resident) memory; and between the AP
> +       subsystem and IPA for register access.

Same here and in the rest.

      Arnd
