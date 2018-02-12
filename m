Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbeBLPlI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:41:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:59108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753438AbeBLPlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:41:07 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E8921785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x224tpDKiFpakSnMMBvQvutzh9QwC1XcE++Gn/S3aBFQ5MHG2ctvj8Zov1YJVHR1oJdCPDCfUE5I5TzwxVj43Ojc=
MIME-Version: 1.0
In-Reply-To: <1518446590-16800-10-git-send-email-patrice.chotard@st.com>
References: <1518446590-16800-1-git-send-email-patrice.chotard@st.com> <1518446590-16800-10-git-send-email-patrice.chotard@st.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 12 Feb 2018 09:40:44 -0600
X-Gmail-Original-Message-ID: <CABGGiszvx=Nyeq+KTt9uHGwSabxsJuEfvG01H4NyrBtB40atoA@mail.gmail.com>
Message-ID: <CABGGiszvx=Nyeq+KTt9uHGwSabxsJuEfvG01H4NyrBtB40atoA@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] ARM: dts: STi: Add fake reg property for sound
 related nodes
To: patrice.chotard@st.com
Cc: Mark Rutland <mark.rutland@arm.com>, linux@armlinux.org.uk,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 8:43 AM,  <patrice.chotard@st.com> wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Add fake reg property to sound, simple-audio-card, dai-link and
> sti_sasg_codec nodes, this allows to fix the following warning
> when compiling dtb with W=1 option:
>
> arch/arm/boot/dts/stih407-b2120.dtb: Warning (unit_address_vs_reg):
> Node /soc/sound/simple-audio-card,dai-link@0 has a unit name, but no reg property
> arch/arm/boot/dts/stih407-b2120.dtb: Warning (unit_address_vs_reg):
> Node /soc/sound/simple-audio-card,dai-link@1 has a unit name, but no reg property
> arch/arm/boot/dts/stih407-b2120.dtb: Warning (unit_address_vs_reg):
> Node /soc/sound/simple-audio-card,dai-link@2 has a unit name, but no reg property
> arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
> Node /soc/sti-sasg-codec missing or empty reg/ranges property
>
> arch/arm/boot/dts/stih410-b2120.dtb: Warning (unit_address_vs_reg):
> Node /soc/sound/simple-audio-card,dai-link@0 has a unit name, but no reg property
> arch/arm/boot/dts/stih410-b2120.dtb: Warning (unit_address_vs_reg):
> Node /soc/sound/simple-audio-card,dai-link@1 has a unit name, but no reg property
> arch/arm/boot/dts/stih410-b2120.dtb: Warning (unit_address_vs_reg):
> Node /soc/sound/simple-audio-card,dai-link@2 has a unit name, but no reg property
> arch/arm/boot/dts/stih407-b2120.dtb: Warning (simple_bus_reg):
> Node /soc/sound missing or empty reg/ranges property
> arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
> Node /soc/sti-sasg-codec missing or empty reg/ranges property
>
> arch/arm/boot/dts/stih410-b2260.dtb: Warning (unit_address_vs_reg):
> Node /soc/sound/simple-audio-card,dai-link@0 has a unit name, but no reg property
> arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
> Node /soc/sti-sasg-codec missing or empty reg/ranges property
> arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
> Node /soc/sound missing or empty reg/ranges property
>
> arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
> Node /soc/sti-sasg-codec missing or empty reg/ranges property
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>
> v2: _ add a fake reg property to node without reg property.
>
>  arch/arm/boot/dts/stih407-family.dtsi |  3 ++-
>  arch/arm/boot/dts/stih410-b2260.dts   |  5 +++--
>  arch/arm/boot/dts/stihxxx-b2120.dtsi  | 11 ++++++-----
>  3 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> index 5df827b00eb6..df1a3f1dc5a7 100644
> --- a/arch/arm/boot/dts/stih407-family.dtsi
> +++ b/arch/arm/boot/dts/stih407-family.dtsi
> @@ -894,8 +894,9 @@
>                         status = "disabled";
>                 };
>
> -               sti_sasg_codec: sti-sasg-codec {
> +               sti_sasg_codec: sti-sasg-codec@0 {
>                         compatible = "st,stih407-sas-codec";
> +                       reg = <0 0>;
>                         #sound-dai-cells = <1>;
>                         status = "disabled";
>                         st,syscfg = <&syscfg_core>;

This should probably be a child of syscfg to fix this. And if this
block has a dedicated set of registers, then use reg to define those
(even though regmap/syscon doesn't need it).

> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index 8bcd58118dba..03d05a98b7fc 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -181,12 +181,13 @@
>                         status = "okay";
>                 };
>
> -               sound {
> +               sound: sound@0 {

I'd move this up to top level.

Rob
