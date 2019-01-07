Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A1DC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07C320651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865527;
	bh=3j8WX9AeQQqVEKIxAp26mJym4chyk6f88+AWf53TsSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rNsczo2Ann7PzL8eazHibWsvYcajhWtlrd3AfIqmjQQPJ/ceBn/2JmXJagKnULB6V
	 AEuN3yRagRRu55CwaHA7Bp88iVfvu+3t6FAS7k3PaWLgDhTPyK+5QFVNHG0rWrbqwM
	 2Rtw2+EPPIcMgU7Q0zaLcnX64G9VCq71U0DiCK1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfAGMwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:52:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:41842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727215AbfAGMwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:52:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D4220651;
        Mon,  7 Jan 2019 12:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865524;
        bh=3j8WX9AeQQqVEKIxAp26mJym4chyk6f88+AWf53TsSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QIFLbVtZhVC8dcS2KStV5BctPKZmZ/NdFJX154zxwoPpf9CDjvpoHHfF0mlVcEY88
         cgTzclawPIX5cwZyiHgvvb1BXccUkuM4Sv5sO2QN9P4JZNzGQ6qBY6VU4suY2+IuVP
         6Dwu4eHvnQGgMACJm7oeFXQDiY380qOndhHaO1Zs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Patrick Dreyer <Patrick.Dreyer@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.19 089/170] Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G
Date:   Mon,  7 Jan 2019 13:31:56 +0100
Message-Id: <20190107104503.519371352@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrick Dreyer <Patrick@Dreyer.name>

commit 7db54c89f0b30a101584e09d3729144e6170059d upstream.

This adds ELAN0501 to the ACPI table to support Elan touchpad found in ASUS
Aspire F5-573G.

Signed-off-by: Patrick Dreyer <Patrick.Dreyer@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elan_i2c_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1336,6 +1336,7 @@ MODULE_DEVICE_TABLE(i2c, elan_id);
 static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0000", 0 },
 	{ "ELAN0100", 0 },
+	{ "ELAN0501", 0 },
 	{ "ELAN0600", 0 },
 	{ "ELAN0602", 0 },
 	{ "ELAN0605", 0 },


