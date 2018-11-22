Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C26C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60DF520870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEACnIOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DF520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393233AbeKVTZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:25:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbeKVTZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:25:40 -0500
Received: from localhost (unknown [95.99.132.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2333220831;
        Thu, 22 Nov 2018 08:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542876430;
        bh=phiqRKFtxVvWuaXIZMuX/bSxSUiinIcvfUs9ZoSJ3Js=;
        h=Date:From:To:Cc:Subject:From;
        b=cEACnIOntLogOpOu43RE1CcPlC17pDcVKLRofVv+/yp3jZWuRnsHglS7GcaJpPXEj
         HMskqHRUCnam5B3Yo5Aws23r4vLt2sF/xI+nwswmOfxwNLZxY6FpO0nbapcNpfFdBu
         O9AvXJLtkYT8v4rN+318n5M+xzlE1w1i/S/EbGDw=
Date:   Thu, 22 Nov 2018 09:46:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 4.20-rc4
Message-ID: <20181122084602.GA22673@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-4.20-rc4

for you to fetch changes up to 544b03da39e2d7b4961d3163976ed4bfb1fac509:

  Documentation/security-bugs: Postpone fix publication in exceptional cases (2018-11-20 18:02:45 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 4.20-rc4

Here are some small char/misc driver fixes for issues that have been
reported.

Nothing major, highlights include:
	- gnss sync write fixes
	- uio oops fix
	- nvmem fixes
	- other minor fixes and some documentation/maintainers updates

Full details are in the shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Colin Ian King (1):
      test_firmware: fix error return getting clobbered

Dan Carpenter (1):
      uio: Fix an Oops on load

Dexuan Cui (1):
      Drivers: hv: kvp: Fix the recent regression caused by incorrect clean-up

Greg Kroah-Hartman (2):
      Merge tag 'gnss-4.20-rc3' of https://git.kernel.org/.../johan/gnss into char-misc-linus
      MAINTAINERS: Add Sasha as a stable branch maintainer

Gustavo A. R. Silva (1):
      drivers/misc/sgi-gru: fix Spectre v1 vulnerability

Johan Hovold (2):
      gnss: serial: fix synchronous write timeout
      gnss: sirf: fix synchronous write timeout

Nathan Chancellor (1):
      misc: atmel-ssc: Fix section annotation on atmel_ssc_get_driver_data

Srinivas Kandagatla (2):
      slimbus: ngd: remove unnecessary check
      nvmem: core: fix regression in of_nvmem_cell_get()

Will Deacon (1):
      Documentation/security-bugs: Postpone fix publication in exceptional cases

 Documentation/admin-guide/security-bugs.rst | 21 +++++++++++----------
 MAINTAINERS                                 |  1 +
 drivers/gnss/serial.c                       |  3 ++-
 drivers/gnss/sirf.c                         |  3 ++-
 drivers/hv/hv_kvp.c                         | 26 ++++++++++++++++++++++----
 drivers/misc/atmel-ssc.c                    |  2 +-
 drivers/misc/sgi-gru/grukdump.c             |  4 ++++
 drivers/nvmem/core.c                        | 10 ++++++----
 drivers/slimbus/qcom-ngd-ctrl.c             |  3 ---
 drivers/slimbus/slimbus.h                   |  6 ------
 drivers/uio/uio.c                           |  7 +++++--
 lib/test_firmware.c                         |  1 +
 12 files changed, 55 insertions(+), 32 deletions(-)
