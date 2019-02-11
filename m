Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7562FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C077222B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897438;
	bh=qeqi5773CNN56zaOuH8CTP9AeAVCFgC/MNboz8ODRKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ExJbrBYPmZa0hs2hgDu3f1TixstuHOVY+G8c31RG2dXNAGrrxkPHAIPhFsqlfRIDu
	 cOfIHPuBR1+MQrq6UXzw2LyTzlVV4X18OIz3YlC9X8Yza5+BsZmvCOpH/f/JC6uI+O
	 Kv4Jjs1mm87UqlmIw4coe2AavKl99LRIOl/AGGfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390725AbfBKPD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:03:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390720AbfBKPDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:03:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C72FD222A7;
        Mon, 11 Feb 2019 15:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897429;
        bh=qeqi5773CNN56zaOuH8CTP9AeAVCFgC/MNboz8ODRKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wH+uGULx8X/PdZKo27ABvHUeMcr4bAqzT5PtZo+fkTvQrzssA8igroZ4RLOW4948z
         ghJqCsSK++4qj9sO6HK4CIunb907ygYK5eGLQ5FuLqzGe+f8BUsUtYqCe97we8xN/m
         W75CCmMMgBBSTIHeUI5WIPUctijHvyJx0mvOYqCY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guan Yung Tseng <guan.yung.tseng@ni.com>,
        "KHUENY.Gerhard" <Gerhard.KHUENY@bachmann.info>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 201/205] serial: 8250_pci: Make PCI class test non fatal
Date:   Mon, 11 Feb 2019 15:19:59 +0100
Message-Id: <20190211141841.570503327@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3425,6 +3425,11 @@ static int
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
@@ -3652,10 +3657,6 @@ pciserial_init_one(struct pci_dev *dev,
 
 	board = &pci_boards[ent->driver_data];
 
-	rc = serial_pci_is_class_communication(dev);
-	if (rc)
-		return rc;
-
 	rc = serial_pci_is_blacklisted(dev);
 	if (rc)
 		return rc;


