Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3D5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F66D20989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545309523;
	bh=MBxCkgOtlZjmEldJv/we2wUCpOx01pWksGilAjOqG2o=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Du2rr51Eip+C4lfE33BNffT768o2xDUk6p8+poTYh7xQcJJAPMjblr9XKMGXD+WVG
	 YZwdih9WUyKnORCBXGVyNGmmxxY55BnckkXpK5tTKzTxpxHH/QrqcKU4c0FdW18IbF
	 +Nc4MI4/h96fPIIWJ5gVeDP6kl4ojUMog9fxeKXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbeLTMim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:38:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:41792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730500AbeLTMil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:38:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9656E20866;
        Thu, 20 Dec 2018 12:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545309521;
        bh=MBxCkgOtlZjmEldJv/we2wUCpOx01pWksGilAjOqG2o=;
        h=Date:From:To:Cc:Subject:From;
        b=IBlqDrt123Thxx3cdUaJEWi71KA6/4Hty8bH5gvVbnrhITM4mS7TD4/MtSMTtidKP
         pmlLArtBC8Te83CSCt0Tf1pqzOIadVOGlKh438DUl3vZm9FjawpeZBdjYtKFtuTKDl
         unfJnQZqQczIesfAy1iQE1DuB/qHw7SeCjE2uy+8=
Date:   Thu, 20 Dec 2018 13:38:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 4.20-rc8
Message-ID: <20181220123838.GA18210@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 40e020c129cfc991e8ab4736d2665351ffd1468d:

  Linux 4.20-rc6 (2018-12-09 15:31:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-4.20-rc8

for you to fetch changes up to 2419f30a4a4fcaa5f35111563b4c61f1b2b26841:

  USB: xhci: fix 'broken_suspend' placement in struct xchi_hcd (2018-12-17 16:01:02 +0100)

----------------------------------------------------------------
USB fixes and ids for 4.20-rc8

Here are some late xhci fixes for 4.20-rc8 as well as a few new device
ids for the option usb-serial driver.

The xhci fixes resolve some many-reported issues and all of these have
been in linux-next for a while with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-4.20-rc7' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Jörgen Storvist (4):
      USB: serial: option: add GosunCn ZTE WeLink ME3630
      USB: serial: option: add Simcom SIM7500/SIM7600 (MBIM mode)
      USB: serial: option: add Fibocom NL668 series
      USB: serial: option: add Telit LN940 series

Mathias Nyman (1):
      xhci: Don't prevent USB2 bus suspend in state check intended for USB3 only

Nicolas Saenz Julienne (1):
      USB: xhci: fix 'broken_suspend' placement in struct xchi_hcd

Tore Anderson (1):
      USB: serial: option: add HP lt4132

 drivers/usb/host/xhci-hub.c |  3 ++-
 drivers/usb/host/xhci.h     |  4 ++--
 drivers/usb/serial/option.c | 16 +++++++++++++++-
 3 files changed, 19 insertions(+), 4 deletions(-)
