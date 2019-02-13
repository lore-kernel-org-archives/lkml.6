Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15C9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBF0222D1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083881;
	bh=2lMALik6CTCnndN+UM1NkR9rR7FS/WVduLC4IMBRr2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AQdHwWkkgsu8cbaQT4NWsJ31n+5mWL337xIkMifI/HNW2uoifwUNhaMQ+IHVEyfEG
	 bBpSYoLhEc7G3zeoTcUKI2Wum0VoSnVU+4VnxwK3bv4L4EXCNLZGp1f8GwEdm+U3fe
	 bexGTdhx4gwAHsCcMjhByQr1wL7oBhr+MdkbdK4U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406095AbfBMSoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:44:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406066AbfBMSoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:44:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B185320835;
        Wed, 13 Feb 2019 18:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083454;
        bh=2lMALik6CTCnndN+UM1NkR9rR7FS/WVduLC4IMBRr2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=seFdFSe5bvhCAOs8MdNela2OGAJnGYAxygriJ7ObiFJsopzbvDMru+CitB/EQV6Du
         pn0WnzlZsysBkUfQPSQGrXyzEpOUREqgwifoZKfttWy/Vd6Km+vStUlnr0W/q5bLs3
         Hp48Hohn7ufD9vOvZZuDVv4mrgp/UXolTCUQ48mM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 05/44] libata: Add NOLPM quirk for SAMSUNG MZ7TE512HMHP-000L1 SSD
Date:   Wed, 13 Feb 2019 19:38:06 +0100
Message-Id: <20190213183652.102258783@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183651.648060257@linuxfoundation.org>
References: <20190213183651.648060257@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>

commit dd957493baa586f1431490f97f9c7c45eaf8ab10 upstream.

We've received a bugreport that using LPM with a SAMSUNG
MZ7TE512HMHP-000L1 SSD leads to system instability, we already have
a quirk for the MZ7TD256HAFV-000L9, which is also a Samsun EVO 840 /
PM851 OEM model, so it seems some of these models have a LPM issue.

This commits adds a NOLPM quirk for the model string from the new
bugeport, to avoid the reported stability issues.

Cc: stable@vger.kernel.org
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1571330
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ata/libata-core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4554,6 +4554,7 @@ static const struct ata_blacklist_entry
 	{ "SAMSUNG MZMPC128HBFU-000MV", "CXM14M1Q", ATA_HORKAGE_NOLPM, },
 	{ "SAMSUNG SSD PM830 mSATA *",  "CXM13D1Q", ATA_HORKAGE_NOLPM, },
 	{ "SAMSUNG MZ7TD256HAFV-000L9", NULL,       ATA_HORKAGE_NOLPM, },
+	{ "SAMSUNG MZ7TE512HMHP-000L1", "EXT06L0Q", ATA_HORKAGE_NOLPM, },
 
 	/* devices that don't properly handle queued TRIM commands */
 	{ "Micron_M500IT_*",		"MU01",	ATA_HORKAGE_NO_NCQ_TRIM |


