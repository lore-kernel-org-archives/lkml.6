Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeBLPT7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:19:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:51564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752667AbeBLPT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:19:58 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596DF217A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x226bEAiR9zGlesS5hjuOdNQZ4+5MOvvHv1v7uE4cBxhbZ1z9UFRH7UwyOOvsN8J6LM1f3OzjH08JZ7T+L/VY8TY=
MIME-Version: 1.0
In-Reply-To: <1518446590-16800-2-git-send-email-patrice.chotard@st.com>
References: <1518446590-16800-1-git-send-email-patrice.chotard@st.com> <1518446590-16800-2-git-send-email-patrice.chotard@st.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 12 Feb 2018 09:19:35 -0600
X-Gmail-Original-Message-ID: <CABGGiswMN1-CQi-guB5y5YFNLhKH3z58b_skxb_q+ZMm7+n1Nw@mail.gmail.com>
Message-ID: <CABGGiswMN1-CQi-guB5y5YFNLhKH3z58b_skxb_q+ZMm7+n1Nw@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] ARM: dts: STi: Fix bindings notation
To: patrice.chotard@st.com
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux@armlinux.org.uk,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 8:42 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Remove leading 0x and 0s from bindings notation
> Add missing unit-address and remove some which are useless.
>
> This allows to fix several warnings like :
>
> Warning (unit_address_vs_reg): Node XXXX has a reg or ranges property, but no unit name
> Warning (simple_bus_reg): Node XXXX simple-bus unit address format error, expected "123456"
> Warning (unit_address_vs_reg): Node XXXX has a unit name, but no reg property
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---

[...]

> diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> index a29090077fdf..53c6888d1fc0 100644
> --- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> @@ -45,7 +45,7 @@
>         };
>
>         soc {
> -               pin-controller-sbc {
> +               pin-controller-sbc@961f080 {

While you're here changing the node name, these all should be "pinctrl@..."

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
