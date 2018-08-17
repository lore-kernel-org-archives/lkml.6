Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459ABC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FA8218A7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFRV48vZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FA8218A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeHQQJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbeHQQJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:09:14 -0400
Received: from localhost (unknown [171.76.73.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9CC62188F;
        Fri, 17 Aug 2018 13:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534511153;
        bh=Mer1fNyfkPXxhPjM5eezEEzDlss7VWpw0Vb/9FNb1bs=;
        h=Date:From:To:Cc:Subject:From;
        b=gFRV48vZtexbqVcXj/ukrVNbnGNA2SMdVl5vrXAHYCCM9cING9AWB9XRPMNjvJac0
         tvs2GOebvJBlVMdp9DHyp8Zp2LBGVzKSVNZecmzZkQASEk2b7+Xu9hsSve2CojzfSt
         j0XTbfkVFWlHcWhz2ZKj1VIP9jL1oZyYNMfa1Jv8=
Date:   Fri, 17 Aug 2018 18:35:43 +0530
From:   Vinod <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: dmaengine updates for v4.19-rc1
Message-ID: <20180817130543.GG3687@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull to receive dmaengine contributions for v4.19-rc1.

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.infradead.org/users/vkoul/slave-dma.git tags/dmaengine-4.19-rc1

for you to fetch changes up to 3257d86182cc27eda83d6854787256641f7c574b:

  Merge branch 'topic/pl330' into for-linus (2018-08-17 18:00:29 +0530)

----------------------------------------------------------------
DMAengine updates for v4.19-rc1

This round brings couple of framework changes, a new driver and usual driver
updates:
 - New managed helper for dmaengine framework registration
 - Split dmaengine pause capability to pause and resume and allow drivers to
   report that individually
 - Update dma_request_chan_by_mask() to handle deferred probing
 - Move imx-sdma to use virt-dma
 - New driver for Actions Semi Owl family S900 controller
 - Minor updates to intel, renesas, mv_xor, pl330 etc

----------------------------------------------------------------
Andy Shevchenko (2):
      dmaengine: hsu: Support dmaengine_terminate_sync()
      dmaengine: idma64: Support dmaengine_terminate_sync()

Benjamin Gaignard (1):
      dmaengine: stm32: replace "%p" with "%pK"

Dave Jiang (1):
      dmaengine: ioatdma: set the completion address register after channel=
 reset

Geert Uytterhoeven (1):
      dmaengine: rcar-dmac: Disable interrupts while stopping channels

Gustavo A. R. Silva (1):
      dmaengine: nbpfaxi: Mark expected switch fall-through

Hanna Hawa (6):
      dmaengine: mv_xor_v2: explicitly freeup irq
      dmaengine: mv_xor_v2: kill the tasklets upon exit
      dmaengine: mv_xor_v2: convert callback to helper function
      dmaengine: mv_xor_v2: move unmap to before callback
      dmaengine: mv_xor_v2: enable COMPILE_TEST
      dmaengine: mv_xor_v2: use {lower,upper}_32_bits to configure HW descr=
iptor address

Hiroyuki Yokoyama (1):
      dmaengine: rcar-dmac: Document R8A77990 bindings

Huang Shijie (2):
      dmaengine: add a new helper dmaenginem_async_device_register
      dmaengine: mic_x100_dma: use the new helper to simplify the code

John Keeping (1):
      dmaengine: pl330: fix irq race with terminate_all

Kees Cook (1):
      dmaengine: ste_dma40: Remove VLA usage

Kuninori Morimoto (3):
      dmaengine: rcar-dmac: don't use DMAC error interrupt
      dmaengine: rcar-dmac: convert to SPDX identifiers
      dmaengine: rcar-dmac: clear channel register when error

Kyle Spiers (1):
      async_pq: Remove VLA usage

Manivannan Sadhasivam (2):
      dt-bindings: dmaengine: Add binding for Actions Semi Owl SoCs
      dmaengine: Add Actions Semi Owl family S900 DMA driver

Marek Szyprowski (1):
      dmaengine: add support for reporting pause and resume separately

Peter Ujfalusi (1):
      dmaengine: dma_request_chan_by_mask() to handle deferred probing

Radhey Shyam Pandey (2):
      dt-bindings: dmaengine: xilinx_dma: Add VDMA vertical flip property
      dmaengine: xilinx_dma: Enable VDMA S2MM vertical flip support

Robin Gong (8):
      dmaengine: imx-sdma: add virt-dma support
      dmaengine: imx-sdma: remove useless 'lock' and 'enabled' in 'struct s=
dma_channel'
      dmaengine: imx-sdma: remove the maximum limitation for bd numbers
      dmaengine: imx-sdma: add sdma_transfer_init to decrease code overlap
      dmaengine: imx-sdma: alloclate bd memory from dma pool
      dmaengine: imx-sdma: add missing structure description
      dmaengine: imx-sdma: add SDMA_BD_MAX_CNT to replace '0xffff'
      dmaengine: imx-sdma: add memcpy interface

Sascha Hauer (1):
      dmaengine: imx-sdma: factor out a struct sdma_desc from struct sdma_c=
hannel

Vinod Koul (17):
      dmaengine: imx-sdma: Fix some typos
      dmaengine: imx-sdma: Use GFP_NOWAIT for dma allocations
      dmaengine: imx-sdma: remove unused variable
      dmaengine: pl330: Mark expected switch fall-through
      dmaengine: pl330: remove set but unused variable
      dmaengine: Revert "dmaengine: mv_xor_v2: enable COMPILE_TEST"
      Merge branch 'topic/async_tx' into for-linus
      Merge branch 'topic/intel' into for-linus
      Merge branch 'topic/ioat' into for-linus
      Merge branch 'topic/mv_xor' into for-linus
      Merge branch 'topic/nbpfaxi' into for-linus
      Merge branch 'topic/owl' into for-linus
      Merge branch 'topic/renesas' into for-linus
      Merge branch 'topic/ste' into for-linus
      Merge branch 'topic/xilinx' into for-linus
      Merge branch 'topic/imx' into for-linus
      Merge branch 'topic/pl330' into for-linus

Yoshihiro Shimoda (4):
      dmaengine: sh: rcar-dmac: avoid to write CHCR.TE to 1 if TCR is set t=
o 0
      dmaengine: sh: rcar-dmac: add a new function to clear CHCR.DE with ba=
rrier
      dmaengine: sh: rcar-dmac: Add dma_pause operation
      dmaengine: sh: rcar-dmac: Should not stop the DMAC by rcar_dmac_sync_=
tcr()

 Documentation/devicetree/bindings/dma/owl-dma.txt  |  47 +
 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   1 +
 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |   2 +
 Documentation/driver-model/devres.txt              |   1 +
 crypto/async_tx/async_pq.c                         |  10 +-
 crypto/async_tx/raid6test.c                        |   4 +-
 drivers/dma/Kconfig                                |   9 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/dmaengine.c                            |  53 +-
 drivers/dma/hsu/hsu.c                              |   8 +
 drivers/dma/idma64.c                               |   8 +
 drivers/dma/imx-sdma.c                             | 578 +++++++-----
 drivers/dma/ioat/dma.c                             |   6 +
 drivers/dma/mic_x100_dma.c                         |   8 +-
 drivers/dma/mv_xor_v2.c                            |  16 +-
 drivers/dma/nbpfaxi.c                              |   1 +
 drivers/dma/owl-dma.c                              | 971 +++++++++++++++++=
++++
 drivers/dma/pl330.c                                |  12 +-
 drivers/dma/sh/rcar-dmac.c                         | 112 +--
 drivers/dma/ste_dma40.c                            |  15 +-
 drivers/dma/stm32-dma.c                            |   4 +-
 drivers/dma/stm32-mdma.c                           |   8 +-
 drivers/dma/xilinx/xilinx_dma.c                    |  22 +
 include/linux/dma/xilinx_dma.h                     |   2 +
 include/linux/dmaengine.h                          |   6 +-
 sound/soc/soc-generic-dmaengine-pcm.c              |   2 +-
 26 files changed, 1600 insertions(+), 307 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
 create mode 100644 drivers/dma/owl-dma.c

Thanks
--=20
~Vinod

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbdsgnAAoJEHwUBw8lI4NHmcAQAJNJ8isAvxSMI4o6rO0/VfY4
hIc4BxeWrTe4TfBiTVeN83aM+4NtW8Y4PzZQEOE6dbzNeJe+QA3gw4ZcDHb6AB/7
NO1H25AZ1Lef+ircCMjci5C/A4FUoHsmC6BX5tOBEnKBxKcLtg+mq0XqMSzDKYI8
BbVE03yyUqTaGURcAgqDRErU9Ob3Iy3nWNBQ3dfnW5XXKbHXb2oQ0BXmATPZ3sD2
3dmRCpQVkD1PyIRYXB1+28RxJWqEV4M+K7LswTZ54pYgEkpTUXBmiu4dWuqVHra0
jgVz+f/1RT7dZnzXOU7G2VkJ3jqcdn+kqzZi0udOKK189nTyHsbQw/p6tOgR8rRA
S5UKYrm/ebY36/vgCFY1w+bwzUUkiXUT8bswa/X1S47ZN/PIJ9VMoqSB0XFijDyR
nmcqrtMPvHB8f3frzLk00OQ+gbZD3Mo9itbJr/YZSQpNb7bDrNT2QnS5UGpNnWKk
L6mj3+fAhwFnSiWUCDHq6ZAZOAvbYN5b3GJcI77lg+WFPTaCBaezqPaDfuaUn5YD
UyEXkG8Tv67H9Y136y+XdSHRlX324jZMqY1Zlcbs7n/t9CB1or9ayoQ3l9cwWuwu
w3DpbztN+HSy46RZLJx3ibiGt+t7MZlGvQRHcznANqGfgTramz9i9IVHukd6Wpug
bpz7+b3I5kRVz/VBTj/T
=hG9K
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
