Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D5BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0970E2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e8OEGWf9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0970E2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbeITH23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:28:29 -0400
Received: from ozlabs.org ([203.11.71.1]:40985 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbeITH23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:28:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42G03W44bJz9sC2;
        Thu, 20 Sep 2018 11:47:35 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537408055;
        bh=rsCoLp/y5UZ52yic0aaGxs/6CTNCSH6TVnJ0LOExqOU=;
        h=Date:From:To:Cc:Subject:From;
        b=e8OEGWf94novspfiffx+VqrDRYpdqaR0LQVP8PFlxFotk+MYFzAmKxDDeolgodwtE
         j55Vx/LLMCBcDjyXDcShD9Zem0uy3gQdUM0RpO4D1Dub+0wDoDLOuPXfwZu26TcPjw
         Ic9ihd2PRnMJivGQ04m63wxsCwOQCI66jv46g+BmqrH6LNgW6bo3ymUFotubyexU52
         YfBT/8ADs+S8+KU3QQ3o141IeXR+c90LU5l2XVWegSZjwT4tgL89jTMc4ViwSLfdMf
         o/yfd9CsjnmtxreTchlnlmi3NOJ08ijEJIXNCFDxSNg6E186lV9q3YnsVA4NW/1kOg
         vvog0R3cBBlEA==
Date:   Thu, 20 Sep 2018 11:47:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build warnings after merge of the devicetree tree
Message-ID: <20180920114717.2ed5ae6f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cRa=sE58nMX7hRXtfR8OFj2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cRa=sE58nMX7hRXtfR8OFj2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

After merging the devicetree tree, today's linux-next build (arm
multi_v7_defconfig) produced these warnings:

arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dtb: Warning (spi_bus_bridge)=
: /axi@18000000/qspi@27200: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dtb: Warning (spi_bus_reg): F=
ailed prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/bcm958522er.dtb: Warning (spi_bus_bridge): /axi/qspi@2720=
0: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958522er.dtb: Warning (spi_bus_reg): Failed prerequisi=
te 'spi_bus_bridge'
arch/arm/boot/dts/bcm958525er.dtb: Warning (spi_bus_bridge): /axi/qspi@2720=
0: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958525er.dtb: Warning (spi_bus_reg): Failed prerequisi=
te 'spi_bus_bridge'
arch/arm/boot/dts/bcm958525xmc.dtb: Warning (spi_bus_bridge): /axi/qspi@272=
00: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958525xmc.dtb: Warning (spi_bus_reg): Failed prerequis=
ite 'spi_bus_bridge'
arch/arm/boot/dts/bcm958622hr.dtb: Warning (spi_bus_bridge): /axi/qspi@2720=
0: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958622hr.dtb: Warning (spi_bus_reg): Failed prerequisi=
te 'spi_bus_bridge'
arch/arm/boot/dts/bcm958623hr.dtb: Warning (spi_bus_bridge): /axi/qspi@2720=
0: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958623hr.dtb: Warning (spi_bus_reg): Failed prerequisi=
te 'spi_bus_bridge'
arch/arm/boot/dts/bcm958625hr.dtb: Warning (spi_bus_bridge): /axi/qspi@2720=
0: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958625hr.dtb: Warning (spi_bus_reg): Failed prerequisi=
te 'spi_bus_bridge'
arch/arm/boot/dts/bcm988312hr.dtb: Warning (spi_bus_bridge): /axi/qspi@2720=
0: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm988312hr.dtb: Warning (spi_bus_reg): Failed prerequisi=
te 'spi_bus_bridge'
arch/arm/boot/dts/bcm958625k.dtb: Warning (spi_bus_bridge): /axi/qspi@27200=
: node name for SPI buses should be 'spi'
arch/arm/boot/dts/bcm958625k.dtb: Warning (spi_bus_reg): Failed prerequisit=
e 'spi_bus_bridge'
arch/arm/boot/dts/keystone-k2g-evm.dtb: Warning (spi_bus_bridge): /soc@0/qs=
pi@2940000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/keystone-k2g-evm.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/keystone-k2g-ice.dtb: Warning (spi_bus_bridge): /soc@0/qs=
pi@2940000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/keystone-k2g-ice.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/imx50-evk.dtb: Warning (spi_bus_bridge): /soc/aips@600000=
00/cspi@63fc0000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/imx50-evk.dtb: Warning (spi_bus_reg): Failed prerequisite=
 'spi_bus_bridge'
arch/arm/boot/dts/imx51-babbage.dtb: Warning (spi_bus_bridge): /soc/aips@70=
000000/spba@70000000/ecspi@70010000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/imx51-babbage.dtb: Warning (spi_bus_reg): Failed prerequi=
site 'spi_bus_bridge'
arch/arm/boot/dts/imx51-digi-connectcore-jsk.dtb: Warning (spi_bus_bridge):=
 /soc/aips@70000000/spba@70000000/ecspi@70010000: node name for SPI buses s=
hould be 'spi'
arch/arm/boot/dts/imx51-digi-connectcore-jsk.dtb: Warning (spi_bus_reg): Fa=
iled prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dtb: Warning (spi_bus_br=
idge): /soc/aips@70000000/spba@70000000/ecspi@70010000: node name for SPI b=
uses should be 'spi'
arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dtb: Warning (spi_bus_re=
g): Failed prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx51-zii-rdu1.dtb: Warning (spi_bus_bridge): /soc/aips@7=
0000000/spba@70000000/ecspi@70010000: node name for SPI buses should be 'sp=
i'
arch/arm/boot/dts/imx51-zii-rdu1.dtb: Warning (spi_bus_reg): Failed prerequ=
isite 'spi_bus_bridge'
arch/arm/boot/dts/imx51-zii-scu2-mezz.dtb: Warning (spi_bus_bridge): /soc/a=
ips@70000000/spba@70000000/ecspi@70010000: node name for SPI buses should b=
e 'spi'
arch/arm/boot/dts/imx51-zii-scu2-mezz.dtb: Warning (spi_bus_reg): Failed pr=
erequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx51-zii-scu3-esb.dtb: Warning (spi_bus_bridge): /soc/ai=
ps@70000000/spba@70000000/ecspi@70010000: node name for SPI buses should be=
 'spi'
arch/arm/boot/dts/imx51-zii-scu3-esb.dtb: Warning (spi_bus_reg): Failed pre=
requisite 'spi_bus_bridge'
arch/arm/boot/dts/imx53-ppd.dtb: Warning (spi_bus_bridge): /soc/aips@500000=
00/spba@50000000/ecspi@50010000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/imx53-ppd.dtb: Warning (spi_bus_bridge): /soc/aips@600000=
00/ecspi@63fac000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/imx53-ppd.dtb: Warning (spi_bus_reg): Failed prerequisite=
 'spi_bus_bridge'
arch/arm/boot/dts/imx53-smd.dtb: Warning (spi_bus_bridge): /soc/aips@500000=
00/spba@50000000/ecspi@50010000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/imx53-smd.dtb: Warning (spi_bus_reg): Failed prerequisite=
 'spi_bus_bridge'
arch/arm/boot/dts/imx53-tx53-x03x.dtb: Warning (spi_bus_bridge): /soc/aips@=
50000000/spba@50000000/ecspi@50010000: node name for SPI buses should be 's=
pi'
arch/arm/boot/dts/imx53-tx53-x03x.dtb: Warning (spi_bus_reg): Failed prereq=
uisite 'spi_bus_bridge'
arch/arm/boot/dts/imx53-tx53-x13x.dtb: Warning (spi_bus_bridge): /soc/aips@=
50000000/spba@50000000/ecspi@50010000: node name for SPI buses should be 's=
pi'
arch/arm/boot/dts/imx53-tx53-x13x.dtb: Warning (spi_bus_reg): Failed prereq=
uisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-aristainetos_4.dtb: Warning (spi_bus_bridge): /soc=
/aips-bus@2000000/spba-bus@2000000/ecspi@2014000: node name for SPI buses s=
hould be 'spi'
arch/arm/boot/dts/imx6dl-aristainetos_4.dtb: Warning (spi_bus_reg): Failed =
prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (spi_bus_bridge): /soc=
/aips-bus@2000000/spba-bus@2000000/ecspi@2014000: node name for SPI buses s=
hould be 'spi'
arch/arm/boot/dts/imx6dl-aristainetos_7.dtb: Warning (spi_bus_reg): Failed =
prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-aristainetos2_4.dtb: Warning (spi_bus_bridge): /so=
c/aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses =
should be 'spi'
arch/arm/boot/dts/imx6dl-aristainetos2_4.dtb: Warning (spi_bus_bridge): /so=
c/aips-bus@2000000/spba-bus@2000000/ecspi@2014000: node name for SPI buses =
should be 'spi'
arch/arm/boot/dts/imx6dl-aristainetos2_4.dtb: Warning (spi_bus_reg): Failed=
 prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-aristainetos2_7.dtb: Warning (spi_bus_bridge): /so=
c/aips-bus@2000000/spba-bus@2000000/ecspi@2014000: node name for SPI buses =
should be 'spi'
arch/arm/boot/dts/imx6dl-aristainetos2_7.dtb: Warning (spi_bus_reg): Failed=
 prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtb: Warning (spi_bus_bridge): /so=
c/aips-bus@2000000/spba-bus@2000000/ecspi@2014000: node name for SPI buses =
should be 'spi'
arch/arm/boot/dts/imx6dl-colibri-eval-v3.dtb: Warning (spi_bus_reg): Failed=
 prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dtb: Warning (spi_bus_bridge): /soc/=
aips-bus@2000000/spba-bus@2000000/ecspi@2010000: node name for SPI buses sh=
ould be 'spi'
arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dtb: Warning (spi_bus_reg): Failed p=
rerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-nit6xlite.dtb: Warning (spi_bus_bridge): /soc/aips=
-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should=
 be 'spi'
arch/arm/boot/dts/imx6dl-nit6xlite.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-nitrogen6x.dtb: Warning (spi_bus_bridge): /soc/aip=
s-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses shoul=
d be 'spi'
arch/arm/boot/dts/imx6dl-nitrogen6x.dtb: Warning (spi_bus_reg): Failed prer=
equisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb: Warning (spi_bus_bridge)=
: /soc/aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI b=
uses should be 'spi'
arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb: Warning (spi_bus_reg): F=
ailed prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-phytec-pbab01.dtb: Warning (spi_bus_bridge): /soc/=
aips-bus@2000000/spba-bus@2000000/ecspi@2010000: node name for SPI buses sh=
ould be 'spi'
arch/arm/boot/dts/imx6dl-phytec-pbab01.dtb: Warning (spi_bus_reg): Failed p=
rerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-rex-basic.dtb: Warning (spi_bus_bridge): /soc/aips=
-bus@2000000/spba-bus@2000000/ecspi@2010000: node name for SPI buses should=
 be 'spi'
arch/arm/boot/dts/imx6dl-rex-basic.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-sabreauto.dtb: Warning (spi_bus_bridge): /soc/aips=
-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should=
 be 'spi'
arch/arm/boot/dts/imx6dl-sabreauto.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-sabrelite.dtb: Warning (spi_bus_bridge): /soc/aips=
-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should=
 be 'spi'
arch/arm/boot/dts/imx6dl-sabrelite.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-sabresd.dtb: Warning (spi_bus_bridge): /soc/aips-b=
us@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should b=
e 'spi'
arch/arm/boot/dts/imx6dl-sabresd.dtb: Warning (spi_bus_reg): Failed prerequ=
isite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-ts4900.dtb: Warning (spi_bus_bridge): /soc/aips-bu=
s@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should be=
 'spi'
arch/arm/boot/dts/imx6dl-ts4900.dtb: Warning (spi_bus_reg): Failed prerequi=
site 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-ts7970.dtb: Warning (spi_bus_bridge): /soc/aips-bu=
s@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should be=
 'spi'
arch/arm/boot/dts/imx6dl-ts7970.dtb: Warning (spi_bus_reg): Failed prerequi=
site 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-tx6dl-comtft.dtb: Warning (spi_bus_bridge): /soc/a=
ips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses sho=
uld be 'spi'
arch/arm/boot/dts/imx6dl-tx6dl-comtft.dtb: Warning (spi_bus_reg): Failed pr=
erequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-tx6s-8034.dtb: Warning (spi_bus_bridge): /soc/aips=
-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should=
 be 'spi'
arch/arm/boot/dts/imx6dl-tx6s-8034.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dtb: Warning (spi_bus_bridge): /soc/=
aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses sh=
ould be 'spi'
arch/arm/boot/dts/imx6dl-tx6s-8034-mb7.dtb: Warning (spi_bus_reg): Failed p=
rerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-tx6s-8035.dtb: Warning (spi_bus_bridge): /soc/aips=
-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should=
 be 'spi'
arch/arm/boot/dts/imx6dl-tx6s-8035.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dtb: Warning (spi_bus_bridge): /soc/=
aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses sh=
ould be 'spi'
arch/arm/boot/dts/imx6dl-tx6s-8035-mb7.dtb: Warning (spi_bus_reg): Failed p=
rerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-tx6u-801x.dtb: Warning (spi_bus_bridge): /soc/aips=
-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should=
 be 'spi'
arch/arm/boot/dts/imx6dl-tx6u-801x.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dtb: Warning (spi_bus_bridge): /soc/=
aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses sh=
ould be 'spi'
arch/arm/boot/dts/imx6dl-tx6u-80xx-mb7.dtb: Warning (spi_bus_reg): Failed p=
rerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dtb: Warning (spi_bus_bridge): /soc/=
aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses sh=
ould be 'spi'
arch/arm/boot/dts/imx6dl-tx6u-8033-mb7.dtb: Warning (spi_bus_reg): Failed p=
rerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-tx6u-8033.dtb: Warning (spi_bus_bridge): /soc/aips=
-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should=
 be 'spi'
arch/arm/boot/dts/imx6dl-tx6u-8033.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-tx6u-811x.dtb: Warning (spi_bus_bridge): /soc/aips=
-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should=
 be 'spi'
arch/arm/boot/dts/imx6dl-tx6u-811x.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dtb: Warning (spi_bus_bridge): /soc/=
aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses sh=
ould be 'spi'
arch/arm/boot/dts/imx6dl-tx6u-81xx-mb7.dtb: Warning (spi_bus_reg): Failed p=
rerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-b450v3.dtb: Warning (spi_bus_bridge): /soc/aips-bus=
@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should be =
'spi'
arch/arm/boot/dts/imx6q-b450v3.dtb: Warning (spi_bus_bridge): /soc/aips-bus=
@2000000/spba-bus@2000000/ecspi@2018000: node name for SPI buses should be =
'spi'
arch/arm/boot/dts/imx6q-b450v3.dtb: Warning (spi_bus_reg): Failed prerequis=
ite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-b850v3.dtb: Warning (spi_bus_bridge): /soc/aips-bus=
@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should be =
'spi'
arch/arm/boot/dts/imx6q-b850v3.dtb: Warning (spi_bus_bridge): /soc/aips-bus=
@2000000/spba-bus@2000000/ecspi@2018000: node name for SPI buses should be =
'spi'
arch/arm/boot/dts/imx6q-b850v3.dtb: Warning (spi_bus_reg): Failed prerequis=
ite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-b650v3.dtb: Warning (spi_bus_bridge): /soc/aips-bus=
@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should be =
'spi'
arch/arm/boot/dts/imx6q-b650v3.dtb: Warning (spi_bus_bridge): /soc/aips-bus=
@2000000/spba-bus@2000000/ecspi@2018000: node name for SPI buses should be =
'spi'
arch/arm/boot/dts/imx6q-b650v3.dtb: Warning (spi_bus_reg): Failed prerequis=
ite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-cm-fx6.dtb: Warning (spi_bus_bridge): /soc/aips-bus=
@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should be =
'spi'
arch/arm/boot/dts/imx6q-cm-fx6.dtb: Warning (spi_bus_reg): Failed prerequis=
ite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-dfi-fs700-m60.dtb: Warning (spi_bus_bridge): /soc/a=
ips-bus@2000000/spba-bus@2000000/ecspi@2010000: node name for SPI buses sho=
uld be 'spi'
arch/arm/boot/dts/imx6q-dfi-fs700-m60.dtb: Warning (spi_bus_reg): Failed pr=
erequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-dhcom-pdk2.dtb: Warning (spi_bus_bridge): /soc/aips=
-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should=
 be 'spi'
arch/arm/boot/dts/imx6q-dhcom-pdk2.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-dmo-edmqmx6.dtb: Warning (spi_bus_bridge): /soc/aip=
s-bus@2000000/spba-bus@2000000/ecspi@2018000: node name for SPI buses shoul=
d be 'spi'
arch/arm/boot/dts/imx6q-dmo-edmqmx6.dtb: Warning (spi_bus_reg): Failed prer=
equisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dtb: Warning (spi_bu=
s_bridge): /soc/aips-bus@2000000/spba-bus@2000000/ecspi@200c000: node name =
for SPI buses should be 'spi'
arch/arm/boot/dts/imx6q-display5-tianma-tm070-1280x768.dtb: Warning (spi_bu=
s_reg): Failed prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-dms-ba16.dtb: Warning (spi_bus_bridge): /soc/aips-b=
us@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should b=
e 'spi'
arch/arm/boot/dts/imx6q-dms-ba16.dtb: Warning (spi_bus_bridge): /soc/aips-b=
us@2000000/spba-bus@2000000/ecspi@2018000: node name for SPI buses should b=
e 'spi'
arch/arm/boot/dts/imx6q-dms-ba16.dtb: Warning (spi_bus_reg): Failed prerequ=
isite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-evi.dtb: Warning (spi_bus_bridge): /soc/aips-bus@20=
00000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should be 'sp=
i'
arch/arm/boot/dts/imx6q-evi.dtb: Warning (spi_bus_bridge): /soc/aips-bus@20=
00000/spba-bus@2000000/ecspi@2018000: node name for SPI buses should be 'sp=
i'
arch/arm/boot/dts/imx6q-evi.dtb: Warning (spi_bus_reg): Failed prerequisite=
 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-gw5400-a.dtb: Warning (spi_bus_bridge): /soc/aips-b=
us@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should b=
e 'spi'
arch/arm/boot/dts/imx6q-gw5400-a.dtb: Warning (spi_bus_reg): Failed prerequ=
isite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-marsboard.dtb: Warning (spi_bus_bridge): /soc/aips-=
bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should =
be 'spi'
arch/arm/boot/dts/imx6q-marsboard.dtb: Warning (spi_bus_reg): Failed prereq=
uisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-nitrogen6x.dtb: Warning (spi_bus_bridge): /soc/aips=
-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should=
 be 'spi'
arch/arm/boot/dts/imx6q-nitrogen6x.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-mccmon6.dtb: Warning (spi_bus_bridge): /soc/aips-bu=
s@2000000/spba-bus@2000000/ecspi@2010000: node name for SPI buses should be=
 'spi'
arch/arm/boot/dts/imx6q-mccmon6.dtb: Warning (spi_bus_reg): Failed prerequi=
site 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-nitrogen6_max.dtb: Warning (spi_bus_bridge): /soc/a=
ips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses sho=
uld be 'spi'
arch/arm/boot/dts/imx6q-nitrogen6_max.dtb: Warning (spi_bus_reg): Failed pr=
erequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-nitrogen6_som2.dtb: Warning (spi_bus_bridge): /soc/=
aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses sh=
ould be 'spi'
arch/arm/boot/dts/imx6q-nitrogen6_som2.dtb: Warning (spi_bus_reg): Failed p=
rerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb: Warning (spi_bus_bridge):=
 /soc/aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI bu=
ses should be 'spi'
arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb: Warning (spi_bus_reg): Fa=
iled prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb: Warning (spi_bus_bridge):=
 /soc/aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI bu=
ses should be 'spi'
arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb: Warning (spi_bus_reg): Fa=
iled prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-rex-pro.dtb: Warning (spi_bus_bridge): /soc/aips-bu=
s@2000000/spba-bus@2000000/ecspi@2010000: node name for SPI buses should be=
 'spi'
arch/arm/boot/dts/imx6q-rex-pro.dtb: Warning (spi_bus_reg): Failed prerequi=
site 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-phytec-pbab01.dtb: Warning (spi_bus_bridge): /soc/a=
ips-bus@2000000/spba-bus@2000000/ecspi@2010000: node name for SPI buses sho=
uld be 'spi'
arch/arm/boot/dts/imx6q-phytec-pbab01.dtb: Warning (spi_bus_reg): Failed pr=
erequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-sabreauto.dtb: Warning (spi_bus_bridge): /soc/aips-=
bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should =
be 'spi'
arch/arm/boot/dts/imx6q-sabreauto.dtb: Warning (spi_bus_reg): Failed prereq=
uisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-sabrelite.dtb: Warning (spi_bus_bridge): /soc/aips-=
bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should =
be 'spi'
arch/arm/boot/dts/imx6q-sabrelite.dtb: Warning (spi_bus_reg): Failed prereq=
uisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-sabresd.dtb: Warning (spi_bus_bridge): /soc/aips-bu=
s@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should be=
 'spi'
arch/arm/boot/dts/imx6q-sabresd.dtb: Warning (spi_bus_reg): Failed prerequi=
site 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-ts4900.dtb: Warning (spi_bus_bridge): /soc/aips-bus=
@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should be =
'spi'
arch/arm/boot/dts/imx6q-ts4900.dtb: Warning (spi_bus_reg): Failed prerequis=
ite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-ts7970.dtb: Warning (spi_bus_bridge): /soc/aips-bus=
@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should be =
'spi'
arch/arm/boot/dts/imx6q-ts7970.dtb: Warning (spi_bus_reg): Failed prerequis=
ite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-tx6q-1010.dtb: Warning (spi_bus_bridge): /soc/aips-=
bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should =
be 'spi'
arch/arm/boot/dts/imx6q-tx6q-1010.dtb: Warning (spi_bus_reg): Failed prereq=
uisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dtb: Warning (spi_bus_bridge): /so=
c/aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses =
should be 'spi'
arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dtb: Warning (spi_bus_reg): Failed=
 prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dtb: Warning (spi_bus_bridge): /so=
c/aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses =
should be 'spi'
arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dtb: Warning (spi_bus_reg): Failed=
 prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-tx6q-1020.dtb: Warning (spi_bus_bridge): /soc/aips-=
bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should =
be 'spi'
arch/arm/boot/dts/imx6q-tx6q-1020.dtb: Warning (spi_bus_reg): Failed prereq=
uisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-tx6q-1036.dtb: Warning (spi_bus_bridge): /soc/aips-=
bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should =
be 'spi'
arch/arm/boot/dts/imx6q-tx6q-1036.dtb: Warning (spi_bus_reg): Failed prereq=
uisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dtb: Warning (spi_bus_bridge): /soc/a=
ips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses sho=
uld be 'spi'
arch/arm/boot/dts/imx6q-tx6q-1036-mb7.dtb: Warning (spi_bus_reg): Failed pr=
erequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dtb: Warning (spi_bus_bridge): /soc/a=
ips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses sho=
uld be 'spi'
arch/arm/boot/dts/imx6q-tx6q-10x0-mb7.dtb: Warning (spi_bus_reg): Failed pr=
erequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-tx6q-1110.dtb: Warning (spi_bus_bridge): /soc/aips-=
bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should =
be 'spi'
arch/arm/boot/dts/imx6q-tx6q-1110.dtb: Warning (spi_bus_reg): Failed prereq=
uisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dtb: Warning (spi_bus_bridge): /soc/a=
ips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses sho=
uld be 'spi'
arch/arm/boot/dts/imx6q-tx6q-11x0-mb7.dtb: Warning (spi_bus_reg): Failed pr=
erequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-utilite-pro.dtb: Warning (spi_bus_bridge): /soc/aip=
s-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses shoul=
d be 'spi'
arch/arm/boot/dts/imx6q-utilite-pro.dtb: Warning (spi_bus_reg): Failed prer=
equisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6q-zii-rdu2.dtb: Warning (spi_bus_bridge): /soc/aips-b=
us@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should b=
e 'spi'
arch/arm/boot/dts/imx6q-zii-rdu2.dtb: Warning (spi_bus_reg): Failed prerequ=
isite 'spi_bus_bridge'
arch/arm/boot/dts/imx6qp-nitrogen6_max.dtb: Warning (spi_bus_bridge): /soc/=
aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses sh=
ould be 'spi'
arch/arm/boot/dts/imx6qp-nitrogen6_max.dtb: Warning (spi_bus_reg): Failed p=
rerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6qp-nitrogen6_som2.dtb: Warning (spi_bus_bridge): /soc=
/aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses s=
hould be 'spi'
arch/arm/boot/dts/imx6qp-nitrogen6_som2.dtb: Warning (spi_bus_reg): Failed =
prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb: Warning (spi_bus_bridge)=
: /soc/aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI b=
uses should be 'spi'
arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb: Warning (spi_bus_reg): F=
ailed prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6qp-sabreauto.dtb: Warning (spi_bus_bridge): /soc/aips=
-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should=
 be 'spi'
arch/arm/boot/dts/imx6qp-sabreauto.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6qp-sabresd.dtb: Warning (spi_bus_bridge): /soc/aips-b=
us@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should b=
e 'spi'
arch/arm/boot/dts/imx6qp-sabresd.dtb: Warning (spi_bus_reg): Failed prerequ=
isite 'spi_bus_bridge'
arch/arm/boot/dts/imx6qp-tx6qp-8037.dtb: Warning (spi_bus_bridge): /soc/aip=
s-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses shoul=
d be 'spi'
arch/arm/boot/dts/imx6qp-tx6qp-8037.dtb: Warning (spi_bus_reg): Failed prer=
equisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dtb: Warning (spi_bus_bridge): /soc=
/aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses s=
hould be 'spi'
arch/arm/boot/dts/imx6qp-tx6qp-8037-mb7.dtb: Warning (spi_bus_reg): Failed =
prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dtb: Warning (spi_bus_bridge): /soc=
/aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses s=
hould be 'spi'
arch/arm/boot/dts/imx6qp-tx6qp-8137-mb7.dtb: Warning (spi_bus_reg): Failed =
prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6qp-tx6qp-8137.dtb: Warning (spi_bus_bridge): /soc/aip=
s-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses shoul=
d be 'spi'
arch/arm/boot/dts/imx6qp-tx6qp-8137.dtb: Warning (spi_bus_reg): Failed prer=
equisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6qp-zii-rdu2.dtb: Warning (spi_bus_bridge): /soc/aips-=
bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should =
be 'spi'
arch/arm/boot/dts/imx6qp-zii-rdu2.dtb: Warning (spi_bus_reg): Failed prereq=
uisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6sl-evk.dtb: Warning (spi_bus_bridge): /soc/aips-bus@2=
000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses should be 's=
pi'
arch/arm/boot/dts/imx6sl-evk.dtb: Warning (spi_bus_reg): Failed prerequisit=
e 'spi_bus_bridge'
arch/arm/boot/dts/imx6sx-nitrogen6sx.dtb: Warning (spi_bus_bridge): /soc/ai=
ps-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses shou=
ld be 'spi'
arch/arm/boot/dts/imx6sx-nitrogen6sx.dtb: Warning (spi_bus_reg): Failed pre=
requisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6sx-sdb-reva.dtb: Warning (spi_bus_bridge): /soc/aips-=
bus@2100000/qspi@21e4000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/imx6sx-sdb-reva.dtb: Warning (spi_bus_reg): Failed prereq=
uisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6sx-sdb-sai.dtb: Warning (spi_bus_bridge): /soc/aips-b=
us@2100000/qspi@21e4000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/imx6sx-sdb-sai.dtb: Warning (spi_bus_reg): Failed prerequ=
isite 'spi_bus_bridge'
arch/arm/boot/dts/imx6sx-sdb.dtb: Warning (spi_bus_bridge): /soc/aips-bus@2=
100000/qspi@21e4000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/imx6sx-sdb.dtb: Warning (spi_bus_reg): Failed prerequisit=
e 'spi_bus_bridge'
arch/arm/boot/dts/imx6ul-14x14-evk.dtb: Warning (spi_bus_bridge): /soc/aips=
-bus@2100000/qspi@21e0000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/imx6ul-14x14-evk.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6ul-opos6uldev.dtb: Warning (spi_bus_bridge): /soc/aip=
s-bus@2000000/spba-bus@2000000/ecspi@2014000: node name for SPI buses shoul=
d be 'spi'
arch/arm/boot/dts/imx6ul-opos6uldev.dtb: Warning (spi_bus_reg): Failed prer=
equisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb: Warning (spi_bus_bridge): /soc/aip=
s-bus@2000000/spba-bus@2000000/ecspi@200c000: node name for SPI buses shoul=
d be 'spi'
arch/arm/boot/dts/imx6ul-tx6ul-0010.dtb: Warning (spi_bus_reg): Failed prer=
equisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb: Warning (spi_bus_bridge): /soc/aip=
s-bus@2000000/spba-bus@2000000/ecspi@200c000: node name for SPI buses shoul=
d be 'spi'
arch/arm/boot/dts/imx6ul-tx6ul-0011.dtb: Warning (spi_bus_reg): Failed prer=
equisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb: Warning (spi_bus_bridge): /so=
c/aips-bus@2000000/spba-bus@2000000/ecspi@200c000: node name for SPI buses =
should be 'spi'
arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dtb: Warning (spi_bus_reg): Failed=
 prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6ull-14x14-evk.dtb: Warning (spi_bus_bridge): /soc/aip=
s-bus@2100000/qspi@21e0000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/imx6ull-14x14-evk.dtb: Warning (spi_bus_reg): Failed prer=
equisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb: Warning (spi_bus_bridge): /s=
oc/aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI buses=
 should be 'spi'
arch/arm/boot/dts/imx6ull-colibri-eval-v3.dtb: Warning (spi_bus_reg): Faile=
d prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb: Warning (spi_bus_bridge=
): /soc/aips-bus@2000000/spba-bus@2000000/ecspi@2008000: node name for SPI =
buses should be 'spi'
arch/arm/boot/dts/imx6ull-colibri-wifi-eval-v3.dtb: Warning (spi_bus_reg): =
Failed prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dtb: Warning (spi_bus_bridge):=
 /soc/aips-bus@30800000/spba-bus@30800000/ecspi@30840000: node name for SPI=
 buses should be 'spi'
arch/arm/boot/dts/imx7d-colibri-emmc-eval-v3.dtb: Warning (spi_bus_reg): Fa=
iled prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx7d-colibri-eval-v3.dtb: Warning (spi_bus_bridge): /soc=
/aips-bus@30800000/spba-bus@30800000/ecspi@30840000: node name for SPI buse=
s should be 'spi'
arch/arm/boot/dts/imx7d-colibri-eval-v3.dtb: Warning (spi_bus_reg): Failed =
prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/imx7d-sdb-sht11.dtb: Warning (spi_bus_bridge): /soc/aips-=
bus@30800000/spba-bus@30800000/ecspi@30840000: node name for SPI buses shou=
ld be 'spi'
arch/arm/boot/dts/imx7d-sdb-sht11.dtb: Warning (spi_bus_reg): Failed prereq=
uisite 'spi_bus_bridge'
arch/arm/boot/dts/imx7d-sdb.dtb: Warning (spi_bus_bridge): /soc/aips-bus@30=
800000/spba-bus@30800000/ecspi@30840000: node name for SPI buses should be =
'spi'
arch/arm/boot/dts/imx7d-sdb.dtb: Warning (spi_bus_reg): Failed prerequisite=
 'spi_bus_bridge'
arch/arm/boot/dts/imx7s-colibri-eval-v3.dtb: Warning (spi_bus_bridge): /soc=
/aips-bus@30800000/spba-bus@30800000/ecspi@30840000: node name for SPI buse=
s should be 'spi'
arch/arm/boot/dts/imx7s-colibri-eval-v3.dtb: Warning (spi_bus_reg): Failed =
prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dtb: Warning (spi_bus_bridge): /soc=
/quadspi@1550000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dtb: Warning (spi_bus_reg): Failed =
prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/ls1021a-qds.dtb: Warning (spi_bus_bridge): /soc/dspi@2100=
000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/ls1021a-qds.dtb: Warning (spi_bus_reg): Failed prerequisi=
te 'spi_bus_bridge'
arch/arm/boot/dts/ls1021a-twr.dtb: Warning (spi_bus_bridge): /soc/dspi@2110=
000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/ls1021a-twr.dtb: Warning (spi_bus_reg): Failed prerequisi=
te 'spi_bus_bridge'
arch/arm/boot/dts/vf500-colibri-eval-v3.dtb: Warning (spi_bus_bridge): /soc=
/aips-bus@40000000/dspi1@4002d000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/vf500-colibri-eval-v3.dtb: Warning (spi_bus_reg): Failed =
prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/vf610-colibri-eval-v3.dtb: Warning (spi_bus_bridge): /soc=
/aips-bus@40000000/dspi1@4002d000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/vf610-colibri-eval-v3.dtb: Warning (spi_bus_reg): Failed =
prerequisite 'spi_bus_bridge'
arch/arm/boot/dts/vf610-twr.dtb: Warning (spi_bus_bridge): /soc/aips-bus@40=
000000/dspi0@4002c000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/vf610-twr.dtb: Warning (spi_bus_reg): Failed prerequisite=
 'spi_bus_bridge'
arch/arm/boot/dts/vf610-zii-cfu1.dtb: Warning (spi_bus_bridge): /soc/aips-b=
us@40000000/dspi1@4002d000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/vf610-zii-cfu1.dtb: Warning (spi_bus_reg): Failed prerequ=
isite 'spi_bus_bridge'
arch/arm/boot/dts/vf610-zii-dev-rev-c.dtb: Warning (spi_bus_bridge): /soc/a=
ips-bus@40000000/dspi0@4002c000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/vf610-zii-dev-rev-c.dtb: Warning (spi_bus_reg): Failed pr=
erequisite 'spi_bus_bridge'
arch/arm/boot/dts/vf610-zii-ssmb-spu3.dtb: Warning (spi_bus_bridge): /soc/a=
ips-bus@40000000/dspi1@4002d000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/vf610-zii-ssmb-spu3.dtb: Warning (spi_bus_reg): Failed pr=
erequisite 'spi_bus_bridge'
arch/arm/boot/dts/omap3-n9.dtb: Warning (i2c_bus_reg): /ocp@68000000/i2c@48=
060000/ak8975@0f: I2C bus unit address format error, expected "f"
arch/arm/boot/dts/am335x-boneblack.dtb: Warning (i2c_bus_reg): /ocp/i2c@44e=
0b000/tda19988: I2C bus unit address format error, expected "70"
arch/arm/boot/dts/am335x-boneblack-wireless.dtb: Warning (i2c_bus_reg): /oc=
p/i2c@44e0b000/tda19988: I2C bus unit address format error, expected "70"
arch/arm/boot/dts/am335x-pdu001.dtb: Warning (spi_bus_reg): /ocp/spi@481a00=
00/cfaf240320a032t: SPI bus unit address format error, expected "0"
arch/arm/boot/dts/am335x-sancloud-bbe.dtb: Warning (i2c_bus_reg): /ocp/i2c@=
44e0b000/tda19988: I2C bus unit address format error, expected "70"
arch/arm/boot/dts/am335x-osd3358-sm-red.dtb: Warning (i2c_bus_reg): /ocp/i2=
c@44e0b000/pressure@78: I2C bus unit address format error, expected "76"
arch/arm/boot/dts/am43x-epos-evm.dtb: Warning (spi_bus_bridge): /ocp@440000=
00/qspi@47900000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am43x-epos-evm.dtb: Warning (spi_bus_reg): Failed prerequ=
isite 'spi_bus_bridge'
arch/arm/boot/dts/am437x-idk-evm.dtb: Warning (spi_bus_bridge): /ocp@440000=
00/qspi@47900000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am437x-idk-evm.dtb: Warning (spi_bus_reg): Failed prerequ=
isite 'spi_bus_bridge'
arch/arm/boot/dts/am437x-sk-evm.dtb: Warning (spi_bus_bridge): /ocp@4400000=
0/qspi@47900000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am437x-sk-evm.dtb: Warning (spi_bus_reg): Failed prerequi=
site 'spi_bus_bridge'
arch/arm/boot/dts/am57xx-cl-som-am57x.dtb: Warning (spi_bus_bridge): /ocp/q=
spi@4b300000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am57xx-cl-som-am57x.dtb: Warning (spi_bus_reg): Failed pr=
erequisite 'spi_bus_bridge'
arch/arm/boot/dts/am57xx-sbc-am57x.dtb: Warning (spi_bus_bridge): /ocp/qspi=
@4b300000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am57xx-sbc-am57x.dtb: Warning (spi_bus_reg): Failed prere=
quisite 'spi_bus_bridge'
arch/arm/boot/dts/am571x-idk.dtb: Warning (spi_bus_bridge): /ocp/qspi@4b300=
000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am571x-idk.dtb: Warning (spi_bus_reg): Failed prerequisit=
e 'spi_bus_bridge'
arch/arm/boot/dts/am572x-idk.dtb: Warning (spi_bus_bridge): /ocp/qspi@4b300=
000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am572x-idk.dtb: Warning (spi_bus_reg): Failed prerequisit=
e 'spi_bus_bridge'
arch/arm/boot/dts/am574x-idk.dtb: Warning (spi_bus_bridge): /ocp/qspi@4b300=
000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/am574x-idk.dtb: Warning (spi_bus_reg): Failed prerequisit=
e 'spi_bus_bridge'
arch/arm/boot/dts/dra7-evm.dtb: Warning (spi_bus_bridge): /ocp/qspi@4b30000=
0: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dra7-evm.dtb: Warning (spi_bus_reg): Failed prerequisite =
'spi_bus_bridge'
arch/arm/boot/dts/dra72-evm.dtb: Warning (spi_bus_bridge): /ocp/qspi@4b3000=
00: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dra72-evm.dtb: Warning (spi_bus_reg): Failed prerequisite=
 'spi_bus_bridge'
arch/arm/boot/dts/dra72-evm-revc.dtb: Warning (spi_bus_bridge): /ocp/qspi@4=
b300000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dra72-evm-revc.dtb: Warning (spi_bus_reg): Failed prerequ=
isite 'spi_bus_bridge'
arch/arm/boot/dts/dra71-evm.dtb: Warning (spi_bus_bridge): /ocp/qspi@4b3000=
00: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dra71-evm.dtb: Warning (spi_bus_reg): Failed prerequisite=
 'spi_bus_bridge'
arch/arm/boot/dts/dra76-evm.dtb: Warning (spi_bus_bridge): /ocp/qspi@4b3000=
00: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dra76-evm.dtb: Warning (spi_bus_reg): Failed prerequisite=
 'spi_bus_bridge'
arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dtb: Warning (graph_endpoin=
t): /soc/mdp@5100000/ports/port@3/endpoint: graph connection to node '/soc/=
hdmi-tx@4a00000/ports/port@0/endpoint' is not bidirectional
arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dtb: Warning (i2c_bus_reg):=
 /soc/i2c@ffc04000/adxl345@0: I2C bus unit address format error, expected "=
53"
arch/arm/boot/dts/stm32mp157c-ev1.dtb: Warning (spi_bus_bridge): /soc/qspi@=
58003000: node name for SPI buses should be 'spi'
arch/arm/boot/dts/stm32mp157c-ev1.dtb: Warning (spi_bus_reg): Failed prereq=
uisite 'spi_bus_bridge'
arch/arm/boot/dts/zynq-zc702.dtb: Warning (i2c_bus_reg): /amba/i2c@e0004000=
/i2c-mux@74/i2c@7/hwmon@52: I2C bus unit address format error, expected "34"
arch/arm/boot/dts/zynq-zc702.dtb: Warning (i2c_bus_reg): /amba/i2c@e0004000=
/i2c-mux@74/i2c@7/hwmon@53: I2C bus unit address format error, expected "35"
arch/arm/boot/dts/zynq-zc702.dtb: Warning (i2c_bus_reg): /amba/i2c@e0004000=
/i2c-mux@74/i2c@7/hwmon@54: I2C bus unit address format error, expected "36"
arch/arm/boot/dts/zynq-zc770-xm010.dtb: Warning (spi_bus_reg): /amba/spi@e0=
007000/flash@0: SPI bus unit address format error, expected "1"
arch/arm/boot/dts/zynq-zc770-xm013.dtb: Warning (spi_bus_reg): /amba/spi@e0=
006000/eeprom@0: SPI bus unit address format error, expected "2"
arch/arm/boot/dts/dove-cubox.dtb: Warning (i2c_bus_reg): /i2c-mux/i2c@0/clo=
ck-generator: I2C bus unit address format error, expected "60"
arch/arm/boot/dts/dove-cubox.dtb: Warning (spi_bus_bridge): /mbus/internal-=
regs/spi-ctrl@10600: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dove-cubox.dtb: Warning (spi_bus_reg): Failed prerequisit=
e 'spi_bus_bridge'
arch/arm/boot/dts/dove-cubox-es.dtb: Warning (i2c_bus_reg): /i2c-mux/i2c@0/=
clock-generator: I2C bus unit address format error, expected "60"
arch/arm/boot/dts/dove-cubox-es.dtb: Warning (spi_bus_bridge): /mbus/intern=
al-regs/spi-ctrl@10600: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dove-cubox-es.dtb: Warning (spi_bus_reg): Failed prerequi=
site 'spi_bus_bridge'
arch/arm/boot/dts/dove-d2plug.dtb: Warning (spi_bus_bridge): /mbus/internal=
-regs/spi-ctrl@10600: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dove-d2plug.dtb: Warning (spi_bus_reg): Failed prerequisi=
te 'spi_bus_bridge'
arch/arm/boot/dts/dove-dove-db.dtb: Warning (spi_bus_bridge): /mbus/interna=
l-regs/spi-ctrl@10600: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dove-dove-db.dtb: Warning (spi_bus_reg): Failed prerequis=
ite 'spi_bus_bridge'
arch/arm/boot/dts/dove-d3plug.dtb: Warning (spi_bus_bridge): /mbus/internal=
-regs/spi-ctrl@10600: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dove-d3plug.dtb: Warning (spi_bus_reg): Failed prerequisi=
te 'spi_bus_bridge'
arch/arm/boot/dts/dove-sbc-a510.dtb: Warning (spi_bus_bridge): /mbus/intern=
al-regs/spi-ctrl@10600: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dove-sbc-a510.dtb: Warning (spi_bus_bridge): /mbus/intern=
al-regs/spi-ctrl@14600: node name for SPI buses should be 'spi'
arch/arm/boot/dts/dove-sbc-a510.dtb: Warning (spi_bus_reg): Failed prerequi=
site 'spi_bus_bridge'

Introduced by commit

  52786e7517a2 ("scripts/dtc: Update to upstream version v1.4.7-14-gc86da84=
d30e4")

--=20
Cheers,
Stephen Rothwell

--Sig_/cRa=sE58nMX7hRXtfR8OFj2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlui/CUACgkQAVBC80lX
0GwfJgf/X3q5l5nprEFGdVGoImYQUKqOu/wwF6niLzU6nLxgw4+vGbXMkwnVszQT
4ZEXFpL9B5xyyMnKSuu1k4Q0f7WNNSQOQqWuT2kyEknjbynyFYlrG1MjY77WYxpQ
gT+hnWyLnpXhCjE+R6foOU+5ChnPNbGpojy48c6G8X84z4gHZ7fv05IOugWJ5gSn
fbyLBBAd5gvhqjmJz7yBobqNwXjBx5cikIMduT+dJsUPqOPUNLDE0NyyV8XE79vt
xLCLzmccJ4ZJRSHfGViFERrFrRPOYRw8PFIf6PZJ49zOLufVwsAbH45fkj+aCo9s
dCv1rHLRitbBYguFbVkQs4ICpq5GLg==
=8N1i
-----END PGP SIGNATURE-----

--Sig_/cRa=sE58nMX7hRXtfR8OFj2--
