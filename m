Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C191C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0122084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545351;
	bh=20fiXFHFqyO1gVSezecTyWr+KICkhc05e9KE8ov5ybg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wSKLPJdE3G4frEh5wHRVacdEKvY6EJtXNafAZnrMGGmUCmNR8/8iK3G/HBsG6WrU6
	 QTWvMO/vl3y7pweKIWlc3N/sucWUfPYLdZs7ilpYyNSeReWBEs3w5M/Vj7J8zJg5aS
	 X5UqKwGn/t3KmtwO2CpWNHdKinGmFySKcAeu1s8w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D0122084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeLKPoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:44:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:60638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbeLKPoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:44:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A3562087F;
        Tue, 11 Dec 2018 15:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543043;
        bh=20fiXFHFqyO1gVSezecTyWr+KICkhc05e9KE8ov5ybg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Hp0W3WTmqMOdl170Q9uGPGGpfFkUGbTa/5iLMQsA46KDxbIuKTh2xA+01pk9Ko5a
         dwEU9jpT7U8KzSarzGBAD/ZYTN/cUj9nPRY3cfGF6KmqSKaJ37HrMGEvuP1UUUxnU1
         7OVTHHADaFkgeBfexnMfxSZ6IEtsi9lWSCpxsLNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3.18 44/54] ALSA: hda: Add support for AMD Stoney Ridge
Date:   Tue, 11 Dec 2018 16:41:32 +0100
Message-Id: <20181211151548.534541861@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 3deef52ce10514ccdebba8e8ab85f9cebd0eb3f7 upstream.

It's similar to other AMD audio devices, it also supports D3, which can
save some power drain.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2092,6 +2092,10 @@ static const struct pci_device_id azx_id
 	/* AMD Hudson */
 	{ PCI_DEVICE(0x1022, 0x780d),
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
+	/* AMD Stoney */
+	{ PCI_DEVICE(0x1022, 0x157a),
+	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB |
+			 AZX_DCAPS_PM_RUNTIME },
 	/* AMD Raven */
 	{ PCI_DEVICE(0x1022, 0x15e3),
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB |


