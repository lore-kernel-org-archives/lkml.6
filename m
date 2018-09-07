Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC51C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9202083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JXZmSLgC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9202083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbeIHAP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:15:58 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:33132 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIHAP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:15:58 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 8A34810C0A42;
        Fri,  7 Sep 2018 12:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536348815; bh=PzUlSGH//yOBpKBGIgVJeNrGBlCWEUfGYr/VDaDvue8=;
        h=From:To:CC:Subject:Date:References:From;
        b=JXZmSLgCIjsVhcrsQs3mYgHzEDR1t5+XMfhUiE1kIVoqE8dSlbO04kIEV0n92VHeM
         KvNHa+YI4GPD4Cn7AWHVZLm5NnHqVStf/x3uU839x3fAm5vhjasiVO70EJvQGukS4I
         +m0C7wYTSlP162rwMwK+os8/ybfxCbYAlcS+vk25CdBYkfuTyJZT+yMPh+D2fqZDIf
         FhSDdIrlgFhQlnYm7U9cEQpyguSepevD3WUcsrQIAiRtkJ6Jz/qQpp/7GF3jpJg2oO
         zuuHTzWt/OXnGpvgCb6tcpF6Lub92Qgj85Tv6YHYuJ+DdnALSRv2SEYIP7AxqtO7fQ
         W2z4gMjBSoUNw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 69FDE3C4A;
        Fri,  7 Sep 2018 12:33:34 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0361.001; Fri, 7 Sep 2018 12:33:34 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Will Deacon <Will.Deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: [GIT PULL] ARC updates for 4.19-rc3
Thread-Topic: [GIT PULL] ARC updates for 4.19-rc3
Thread-Index: AQHURtehC33Olp/0qUqdyISDtJKTPw==
Date:   Fri, 7 Sep 2018 19:33:33 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B092C16@us01wembx1.internal.synopsys.com>
References: <4cb8dd19-a252-10c1-8dea-5479ced463fb@synopsys.com>
 <CA+55aFyQiPApQeMOP9EG8Km+Y-aUBwxXc_8bqRyeSVMSy0nF_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 12:15 PM, Linus Torvalds wrote:=0A=
> On Fri, Sep 7, 2018 at 11:21 AM Vineet Gupta <Vineet.Gupta1@synopsys.com>=
 wrote:=0A=
>>   git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc=
-4.19-rc3=0A=
> That "tags/arc-4.19-rc3" actually a real signed tag from you, but it=0A=
> doesn't point to any of your new work. In fact, it just points to my=0A=
> "Linux 4.15-rc1" commit from last year.=0A=
>=0A=
> Which is presumably also why your pull request didn't contain a diffstat.=
=0A=
>=0A=
> Hmm?=0A=
=0A=
Sorry my bad. I did glance at the truncated output and wondered if this was=
 some=0A=
git behavior chg.=0A=
But turns out I'd passed wrong branch to my script ! Now with right stuff. =
Thx.=0A=
=0A=
------>=0A=
The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3=
:=0A=
=0A=
  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)=0A=
=0A=
are available in the git repository at:=0A=
=0A=
  git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-4.=
19-rc3=0A=
=0A=
for you to fetch changes up to dd45210b6dd4f1512eafcc41774154ebb762360f:=0A=
=0A=
  ARC: don't check for HIGHMEM pages in arch_dma_alloc (2018-09-04 13:21:38=
 -0700)=0A=
=0A=
----------------------------------------------------------------=0A=
ARC updates for 4.19-rc3=0A=
=0A=
 - For for atomic_fetch_#op  [Will Deacon]=0A=
=0A=
 - Enabling per device IOC [Eugeniy Paltsev]=0A=
=0A=
 - Remove redundany gcc version checks [Masahiro Yamada]=0A=
=0A=
 - Miscll platform config/DT updates [Alexey Brodkin]=0A=
=0A=
----------------------------------------------------------------=0A=
Alexey Brodkin (3):=0A=
      ARC: configs: cleanup=0A=
      ARC: [plat-axs*/plat-hsdk]: Allow U-Boot to pass MAC-address to the k=
ernel=0A=
      ARC: [plat-axs*]: Enable SWAP=0A=
=0A=
Eugeniy Paltsev (5):=0A=
      ARC: cleanup show_faulting_vma()=0A=
      ARC: dma [IOC]: mark DMA devices connected as dma-coherent=0A=
      ARC: dma [IOC] Enable per device io coherency=0A=
      ARC: IOC: panic if both IOC and ZONE_HIGHMEM enabled=0A=
      ARC: don't check for HIGHMEM pages in arch_dma_alloc=0A=
=0A=
Masahiro Yamada (1):=0A=
      arc: remove redundant GCC version checks=0A=
=0A=
Vineet Gupta (1):=0A=
      ARC: sort Kconfig=0A=
=0A=
Will Deacon (1):=0A=
      ARC: atomics: unbork atomic_fetch_##op()=0A=
=0A=
 arch/arc/Kconfig                           | 10 ++--=0A=
 arch/arc/Makefile                          | 10 +---=0A=
 arch/arc/boot/dts/axc003.dtsi              | 26 ++++++++++=0A=
 arch/arc/boot/dts/axc003_idu.dtsi          | 26 ++++++++++=0A=
 arch/arc/boot/dts/axs10x_mb.dtsi           |  7 ++-=0A=
 arch/arc/boot/dts/hsdk.dts                 | 11 +++-=0A=
 arch/arc/configs/axs101_defconfig          |  3 --=0A=
 arch/arc/configs/axs103_defconfig          |  3 --=0A=
 arch/arc/configs/axs103_smp_defconfig      |  3 --=0A=
 arch/arc/configs/haps_hs_defconfig         |  2 -=0A=
 arch/arc/configs/haps_hs_smp_defconfig     |  2 -=0A=
 arch/arc/configs/hsdk_defconfig            |  1 -=0A=
 arch/arc/configs/nps_defconfig             |  1 -=0A=
 arch/arc/configs/nsim_700_defconfig        |  2 -=0A=
 arch/arc/configs/nsim_hs_defconfig         |  2 -=0A=
 arch/arc/configs/nsim_hs_smp_defconfig     |  2 -=0A=
 arch/arc/configs/nsimosci_defconfig        |  2 -=0A=
 arch/arc/configs/nsimosci_hs_defconfig     |  2 -=0A=
 arch/arc/configs/nsimosci_hs_smp_defconfig |  2 -=0A=
 arch/arc/configs/tb10x_defconfig           |  1 -=0A=
 arch/arc/configs/vdk_hs38_defconfig        |  2 -=0A=
 arch/arc/configs/vdk_hs38_smp_defconfig    |  1 -=0A=
 arch/arc/include/asm/atomic.h              |  2 +-=0A=
 arch/arc/include/asm/dma-mapping.h         | 13 +++++=0A=
 arch/arc/kernel/troubleshoot.c             | 13 ++---=0A=
 arch/arc/mm/cache.c                        | 36 +++++++------=0A=
 arch/arc/mm/dma.c                          | 82 +++++++++++++++-----------=
----=0A=
 27 files changed, 154 insertions(+), 113 deletions(-)=0A=
 create mode 100644 arch/arc/include/asm/dma-mapping.h=0A=
