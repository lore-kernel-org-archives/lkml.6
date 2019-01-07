Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6D6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2081820651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865387;
	bh=kBADKVTjnZGzIfO2yKK37CqF0iVtTjvOnURMG8Vi1CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W+5zj22divvL9pR6Lx+3s7pbPOSX8AYyc2QH5oDvhsdEULFiS/OBvCyJxe1gObvHQ
	 BXzrVRS3IZB3DxMRBJwQzY8/5gvqXFLIDiOoo/xeetsN3MMDyZpJIP+EZG6ep/a7d+
	 WMSbUfngUGWR3HBjssH0stcf2dveLOAZxuyaT+pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfAGMtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:49:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729343AbfAGMto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:49:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C495620651;
        Mon,  7 Jan 2019 12:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865383;
        bh=kBADKVTjnZGzIfO2yKK37CqF0iVtTjvOnURMG8Vi1CU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCa1RbBRYeyN6ogQ8Nds/N28Au2YethfVwFN7DLrYeL70TC009I8XVdly6/VDJVaF
         9v5He8dgPTTcJ7BJFuncv+nslDSE4Khczc51vrTKRCXh8oOClUY+8tSxKvxk4WWQ02
         HnbRLzUSViMAM6WD6tIDwTPx2bV2mDY66hDvAeCc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 074/170] ALSA: hda/realtek: Enable the headset mic auto detection for ASUS laptops
Date:   Mon,  7 Jan 2019 13:31:41 +0100
Message-Id: <20190107104501.750060133@linuxfoundation.org>
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

From: Jian-Hong Pan <jian-hong@endlessm.com>

commit 82b01149ec94d746867d7f9156c44d775d4d2d67 upstream.

The headset mic of ASUS laptops like UX533FD, UX433FN and UX333FA, whose
CODEC is Realtek ALC294 has jack auto detection feature. This patch
enables the feature.

Fixes: 4e051106730d ("ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294")
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6424,7 +6424,7 @@ static const struct hda_fixup alc269_fix
 	[ALC294_FIXUP_ASUS_HEADSET_MIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
-			{ 0x19, 0x01a1113c }, /* use as headset mic, without its own jack detect */
+			{ 0x19, 0x01a1103c }, /* use as headset mic */
 			{ }
 		},
 		.chained = true,


