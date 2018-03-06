Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbeCFCfJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 21:35:09 -0500
Received: from mail-yb0-f181.google.com ([209.85.213.181]:46038 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752480AbeCFCfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 21:35:08 -0500
X-Google-Smtp-Source: AG47ELv+6vp2Umyw72B7WRueTbIjyypn1UFy2TwpJTOcm1AFjaZxYZc3tVUs7mwpgFsReMMyW1GUqTurMGJUsM1jpOg=
MIME-Version: 1.0
In-Reply-To: <20180306120511.1b480c32@canb.auug.org.au>
References: <20180306120511.1b480c32@canb.auug.org.au>
From: Rob Herring <robherring2@gmail.com>
Date: Mon, 5 Mar 2018 20:34:46 -0600
Message-ID: <CAL_JsqL_BSY5Xr8xS+mz_k1eVVaScPZVDE4UpdnV-vQwKhKc+A@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the devicetree tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 7:05 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Rob,
>
> After merging the devicetree tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>
> arch/arm/boot/dts/imx51-digi-connectcore-jsk.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/arm/boot/dts/imx6dl-phytec-pbab01.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/arm/boot/dts/imx6ul-isiot-nand.dtb: Warning (sound_dai_property): /sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in node /soc/aips-bus@2100000/i2c@21a0000/codec@a or bad phandle (referred from sound-dai[0])
> arch/arm/boot/dts/imx6ul-geam.dtb: Warning (sound_dai_property): /sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in node /soc/aips-bus@2100000/i2c@21a0000/codec@a or bad phandle (referred from sound-dai[0])
> arch/arm/boot/dts/imx6ul-isiot-emmc.dtb: Warning (sound_dai_property): /sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in node /soc/aips-bus@2100000/i2c@21a0000/codec@a or bad phandle (referred from sound-dai[0])
> arch/arm/boot/dts/vf610m4-colibri.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/arm/boot/dts/rk3288-tinker.dtb: Warning (sound_dai_property): /sound/simple-audio-card,codec: Missing property '#sound-dai-cells' in node /hdmi@ff980000 or bad phandle (referred from sound-dai[0])
> arch/arm/boot/dts/stih410-b2120.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/arm/boot/dts/stih410-b2120.dtb: Warning (sound_dai_property): /soc/sound/simple-audio-card,dai-link@0/codec: Missing property '#sound-dai-cells' in node /soc/sti-display-subsystem/sti-hdmi@8d04000 or bad phandle (referred from sound-dai[0])
> arch/arm/boot/dts/stih407-b2120.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/arm/boot/dts/stih407-b2120.dtb: Warning (sound_dai_property): /soc/sound/simple-audio-card,dai-link@0/codec: Missing property '#sound-dai-cells' in node /soc/sti-display-subsystem/sti-hdmi@8d04000 or bad phandle (referred from sound-dai[0])
> arch/arm/boot/dts/stih410-b2260.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
> arch/arm/boot/dts/stih410-b2260.dtb: Warning (sound_dai_property): /soc/sound/simple-audio-card,dai-link@0/codec: Missing property '#sound-dai-cells' in node /soc/sti-display-subsystem/sti-hdmi@8d04000 or bad phandle (referred from sound-dai[0])
> arch/arm/boot/dts/stih418-b2199.dtb: Warning (chosen_node_stdout_path): /chosen:linux,stdout-path: Use 'stdout-path' instead
>
> Presumably introduced by commit
>
>   c0e8e5234671 ("scripts/dtc: Update to upstream version v1.4.6-9-gaadd0b65c987")

Yes. I've sent out patches for all these. Waiting for various
maintainers to pick them up.

Rob
