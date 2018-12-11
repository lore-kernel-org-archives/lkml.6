Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCE2C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3181C2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543422;
	bh=yFYveQ5ZZO+lrHRWDdD4j5ArDDKo/qTlXrMRHEZVN9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=opALSIneb27a8JtrdeA0lHRftVN3MKl3U6OxEgzx77Tm21Ia/DKSLra/n4lood8qd
	 KM/oebPnCyUYg1mBQn01+TAM06H/rFdl8Q/lLEfKyeAwr+N/0JEr1JvW1w8VGbozID
	 +aJkPYe78DFH1T7RfaD+U94ZXI6308AWms5P41iw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3181C2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbeLKPuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:50:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729238AbeLKPuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:50:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B62DC2084E;
        Tue, 11 Dec 2018 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543417;
        bh=yFYveQ5ZZO+lrHRWDdD4j5ArDDKo/qTlXrMRHEZVN9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MB+U/lPLpUCwBH5Ejq0QaDiEhsYiSByV5lCblBjOkbpQ8t3055lCce6GHSalsT9vy
         ow9vm6kWhpCwcDqKJhtdDM6HxqvUcCPiGc/BgsyUvEhT+TaYFylYZyoA7cdOj0fcWF
         62xi3yO+F1ZE9FwKZs7WizXFc65x+zalsc1lWQIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 25/51] ALSA: hda: Add support for AMD Stoney Ridge
Date:   Tue, 11 Dec 2018 16:41:33 +0100
Message-Id: <20181211151615.672902027@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2352,6 +2352,10 @@ static const struct pci_device_id azx_id
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


