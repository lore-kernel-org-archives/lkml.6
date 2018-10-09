Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D227EECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C30A214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nanometrics.ca header.i=@nanometrics.ca header.b="MtsFXtl9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C30A214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nanometrics.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeJJAt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:49:29 -0400
Received: from mail-it1-f174.google.com ([209.85.166.174]:36928 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJJAt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:49:28 -0400
Received: by mail-it1-f174.google.com with SMTP id e74-v6so3928017ita.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 10:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanometrics.ca; s=google;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=46CS8BnLz44Na4ecEMVYlapes34LPL9XvwCGT1TI3xE=;
        b=MtsFXtl9PSeUy28cAGp7qjbtAadZ8/F9bZlYFhuZhyyNOYj0BWbz+XBJGLPzpvyaYr
         Fm161/V4Idfo+Kx8sMn5bNATJH4mbR58SFRqukwcaJQktlkUvduseVoSBd5ca6RluUrb
         X3fumUlQwSS2yJeEK0YRJu3Nx7TQKHhFKE6XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=46CS8BnLz44Na4ecEMVYlapes34LPL9XvwCGT1TI3xE=;
        b=iy+mUWQc5xiqwdEz5Qhy4Wpkv30QkpFW1houc/SjZWRAk9UZyzyh+c+Sp3YzQfs3Ks
         /bBBWNZppUlpMp9YobfTDsAu9A/kJFN/mJ1pWlkJLFIAhiz5fmdJx7kvMOJrU2cdtfKp
         k+6K+Ddaec0gCs5XDWwlYmt0ove46u/fApfiZAs01Dyf0WntnArWiYrPaUjzNapHB3PF
         xlDxH/g9JTBawtnrxFI2ugbF/WC0LzXYjxXGBDWtgbsRTwPns9nmFK/oaEJ69uJ3GNtJ
         9sq4XiKnoFgyXBA5wcCcL26OyGcoKEuL398fZjhLu7aO0cUbEjUkiu8Q5RTuC3e2sxR6
         Niww==
X-Gm-Message-State: ABuFfohRALHVbm9CFcd3COAwkPgAa2wRkoXg3bwPNTdMg8Xcebj+kAoZ
        XmiMpU6OGEtWQ7kpYQjPNFwos2g9r2rWDj3CqJ1nXdYoDjPPqYxTI+DrXDfPOcSAGOKXnqSlwuu
        snCsquEYE9lfTzpN/
MIME-Version: 1.0
X-Google-Smtp-Source: ACcGV61VLVvah/KMPMDi11j3RlEvzPHQovlU+iNZHhVfJ1h1NvUdUMk1W0Ro5oIJjZZvqbRFK5Qjvw==
X-Received: by 2002:a24:448:: with SMTP id 69-v6mr2222440itb.156.1539106285410;
        Tue, 09 Oct 2018 10:31:25 -0700 (PDT)
Received: from jamesnuss-kubuntu.nanometrics.ca ([72.142.127.130])
        by smtp.gmail.com with ESMTPSA id c24-v6sm6321018iod.44.2018.10.09.10.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 Oct 2018 10:31:24 -0700 (PDT)
From:   James Nuss <jamesnuss@nanometrics.ca>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] mmc-utils: interpret DEVICE_VERSION when printing extcsd
Date:   Tue,  9 Oct 2018 13:31:07 -0400
Message-Id: <f3e073c1088ac17d0d749cb095e1adda8edda00b.1539103468.git.jamesnuss@nanometrics.ca>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1539103468.git.jamesnuss@nanometrics.ca>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
In-Reply-To: <cover.1539103468.git.jamesnuss@nanometrics.ca>
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DEVICE_VERSION is a 2-byte field

Print the individual byte values in hex

Signed-off-by: James Nuss <jamesnuss@nanometrics.ca>
---
 mmc.h      | 2 ++
 mmc_cmds.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/mmc.h b/mmc.h
index 86e209a..f25869e 100644
--- a/mmc.h
+++ b/mmc.h
@@ -59,6 +59,8 @@
 #define EXT_CSD_OPTIMAL_READ_SIZE	266	/* RO */
 #define EXT_CSD_OPTIMAL_WRITE_SIZE	265	/* RO */
 #define EXT_CSD_OPTIMAL_TRIM_UNIT_SIZE	264	/* RO */
+#define EXT_CSD_DEVICE_VERSION_1	263	/* RO */
+#define EXT_CSD_DEVICE_VERSION_0	262	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION_7	261	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION_6	260	/* RO */
 #define EXT_CSD_FIRMWARE_VERSION_5	259	/* RO */
diff --git a/mmc_cmds.c b/mmc_cmds.c
index 45aa4c0..756aa2f 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1758,6 +1758,9 @@ int do_read_extcsd(int nargs, char **argv)
 	}
 
 	if (ext_csd_rev >= 7) {
+		printf("Device Version: 0x%02x%02x\n",
+			ext_csd[EXT_CSD_DEVICE_VERSION_1],
+			ext_csd[EXT_CSD_DEVICE_VERSION_0]);
 		printf("Firmware Version: 0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
 			ext_csd[EXT_CSD_FIRMWARE_VERSION_7],
 			ext_csd[EXT_CSD_FIRMWARE_VERSION_6],
-- 
2.7.4


-- 
This message is intended exclusively for the individual or entity to which 
it is addressed. This communication may contain information that is 
proprietary, privileged, confidential or otherwise legally exempt from 
disclosure. If you are not the named addressee, or have been inadvertently 
and erroneously referenced in the address line, you are not authorized to 
read, print, retain, copy or disseminate this message or any part of it. If 
you have received this message in error, please notify the sender 
immediately by e-mail and delete all copies of the message.
