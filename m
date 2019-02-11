Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B83EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD47222AC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900316;
	bh=XPq9tnauJO2O7snXEN3LE2xe4cpVSixs0PPoyTpdR1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JK5WmUd6yQ03PZnG5SDSfniT6IVER8zim+FFBgZiO7xWb8YFr7+52hAjmvnwo9TR8
	 3XV25kQUBMlDzlPl02+Ved86ae0iuVVE0pGunKwfo6E0WwvlrWpba8b2b+mgfWg8eo
	 w1ABOk9PF+z7Chvz45YwmMGwpqTDUlreGmpNshmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbfBKOhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:37:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731495AbfBKOhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:37:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C462081B;
        Mon, 11 Feb 2019 14:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895864;
        bh=XPq9tnauJO2O7snXEN3LE2xe4cpVSixs0PPoyTpdR1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ne6GTqChegBtm4NZ13QVG3oD/bdzYS/dEURk8PNuAjgmZXpYY31t/JGIHKwZcCO0P
         GUWP6nzp7a/MNzE9QfxdVuL0QNVYSHr3klUtXExcM5GvidjnCdH2dHGmGnrtt0pM90
         yiTbQidfhVScP6KeQwzrmPOnSkm/5T0K0rOyTyOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guan Yung Tseng <guan.yung.tseng@ni.com>,
        "KHUENY.Gerhard" <Gerhard.KHUENY@bachmann.info>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.20 349/352] serial: 8250_pci: Make PCI class test non fatal
Date:   Mon, 11 Feb 2019 15:19:36 +0100
Message-Id: <20190211141909.382962797@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit 824d17c57b0abbcb9128fb3f7327fae14761914b upstream.

As has been reported the National Instruments serial cards have broken
PCI class.

The commit 7d8905d06405

  ("serial: 8250_pci: Enable device after we check black list")

made the PCI class check mandatory for the case when device is listed in
a quirk list.

Make PCI class test non fatal to allow broken card be enumerated.

Fixes: 7d8905d06405 ("serial: 8250_pci: Enable device after we check black list")
Cc: stable <stable@vger.kernel.org>
Reported-by: Guan Yung Tseng <guan.yung.tseng@ni.com>
Tested-by: Guan Yung Tseng <guan.yung.tseng@ni.com>
Tested-by: KHUENY.Gerhard <Gerhard.KHUENY@bachmann.info>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_pci.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3420,6 +3420,11 @@ static int
 serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 {
 	int num_iomem, num_port, first_port = -1, i;
+	int rc;
+
+	rc = serial_pci_is_class_communication(dev);
+	if (rc)
+		return rc;
 
 	/*
 	 * Should we try to make guesses for multiport serial devices later?
@@ -3647,10 +3652,6 @@ pciserial_init_one(struct pci_dev *dev,
 
 	board = &pci_boards[ent->driver_data];
 
-	rc = serial_pci_is_class_communication(dev);
-	if (rc)
-		return rc;
-
 	rc = serial_pci_is_blacklisted(dev);
 	if (rc)
 		return rc;


