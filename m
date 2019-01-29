Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D664CC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C6020881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763522;
	bh=bJoUrgmvPFS9RVPFAwLguPKEzonW6Gj9KsE6LAS9yRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xh1R08LKaHyc6DDd4ISNVGS8Y/4w7cBxb35arMVqB/D7VhkuaN8pfv6fMuiK+MLuz
	 1KRtt2Jfj32FCTOscDN42saYkCH+NpQN2Rw0kEr4OWwuFjDv0TOfHzXOlisEkravmO
	 csoyKMDOwpWWyFrwTLSZq/fWbiAaCH2GzeaHSbWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfA2LmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:42:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:59698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729954AbfA2LmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:42:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28D9B20882;
        Tue, 29 Jan 2019 11:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762125;
        bh=bJoUrgmvPFS9RVPFAwLguPKEzonW6Gj9KsE6LAS9yRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TnKl6DU+L64nWuzVcCSSlqcVrKONgHLqBN/pQWq2XPYp227wAnRoItTPS39klvNE0
         R2X2BpTEzfRzomTtn5kj8kQdKFgia8BZ2AYqyx/zKWedClndR/EiTM5QG8LEcf7MHi
         LIV5xXbrihSWS5nCmPM5nflo6JhShoz8IMdiHXNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.20 117/117] ide: fix a typo in the settings proc file name
Date:   Tue, 29 Jan 2019 12:36:08 +0100
Message-Id: <20190129113213.179994225@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

From: Christoph Hellwig <hch@lst.de>

commit f8ff6c732d35904d773043f979b844ef330c701b upstream.

Fixes: ec7d9c9ce8 ("ide: replace ->proc_fops with ->proc_show")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/ide/ide-proc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -544,7 +544,7 @@ void ide_proc_port_register_devices(ide_
 		drive->proc = proc_mkdir(drive->name, parent);
 		if (drive->proc) {
 			ide_add_proc_entries(drive->proc, generic_drive_entries, drive);
-			proc_create_data("setting", S_IFREG|S_IRUSR|S_IWUSR,
+			proc_create_data("settings", S_IFREG|S_IRUSR|S_IWUSR,
 					drive->proc, &ide_settings_proc_fops,
 					drive);
 		}


