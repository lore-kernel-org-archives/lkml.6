Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9EDC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA97023DE6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjSerDqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA97023DE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeFVGmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:42:39 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43947 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751243AbeFVGm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:42:29 -0400
Received: by mail-wr0-f195.google.com with SMTP id d2-v6so5473760wrm.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 23:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tDTb5yk+4TsWEinOG+0J6Iq/28XF3bjoltFznxl48IM=;
        b=bjSerDqmNKX/RtJeZQhuVJD83kvhkAXC7bd5eJMnAhwqWmqyFbY3Y7DVSa6eXBdJRz
         8TVxWWECjk/srRmhh9fIE8L8/BTSRjNWdgOEOwe0UA0ATdwRaHTPoQYiMjE/1UuRsmG2
         GdZsqmahCiBZAKBHIv+iEy/c7wpktt0gOihfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tDTb5yk+4TsWEinOG+0J6Iq/28XF3bjoltFznxl48IM=;
        b=OHyKv8qoGLB9AeqsOKxxs3Z8safRCckhDKfJsFMCKZkcJuqWRDp4vlFbc9b3hK5zCz
         3Lc4QD9fk0H02tqoLSgnPtmjSwtl/EHGsqLURzNz9lxOGf67FVucOnXKruTWwJ3qGiL5
         mPeSWJoGTPuHy2XzymjThS2uIFfmcDsxYN+iVo+oDi18w1mnuuPSHhYOgJlOOVpsYJ+e
         X6s0w5XSSV0y7fDd2dn+TlxoNcNjk2U3o56bx3ioEFlXcjsDUA8lErj6i3evSV4JCjt/
         bJln5w/Um5igyZEPDNrdc9mz/6PLXdyNqyYgVO+ToLVqMP3HXsy20UCjHlfz+niL3Gbu
         rWtA==
X-Gm-Message-State: APt69E0xyXCBOo0FbbVPREJVcVAwnPZNDcEvmCWfhNrxQl35lcEoizBm
        0tFcWif0zDUBDzj9pHAbS2MISg==
X-Google-Smtp-Source: ADUXVKI50VhvWqFHzTuNqz2f180LjCLir4lR6GlIwtNMfjMlfNfBLzU/MOKnMyiBanpZPXKFdnyUSw==
X-Received: by 2002:adf:a645:: with SMTP id k63-v6mr396461wrc.231.1529649748569;
        Thu, 21 Jun 2018 23:42:28 -0700 (PDT)
Received: from dogfood.home ([2a01:cb1d:112:6f00:d0d9:3abb:8cc4:581c])
        by smtp.gmail.com with ESMTPSA id h77-v6sm1627156wmd.9.2018.06.21.23.42.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 23:42:27 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     ard.biesheuvel@linaro.org, Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] efi/libstub/tpm: Initialize efi_physical_addr_t vars to zero for mixed mode
Date:   Fri, 22 Jun 2018 08:42:22 +0200
Message-Id: <20180622064222.11633-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180622064222.11633-1-ard.biesheuvel@linaro.org>
References: <20180622064222.11633-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

Commit 79832f0b5f71 ("efi/libstub/tpm: Initialize pointer variables to zero
for mixed mode") fixes a problem with the tpm code on mixed mode (64 bit
kernel on 32 bit UEFI), where 64-bit pointer variables are not fully
initialized by the 32-bit EFI code.

A similar problem applies to the efi_physical_addr_t variables which
are written by the get_event_log EFI call. Even though efi_physical_addr_t
is 64 bit everywhere it seems that some 32 bit UEFI implementations only
fill in the lower 32 bits when passed a pointer to an efi_physical_addr_t
to fill.

This commit initializes these to 0 to, to ensure the upper 32 bits are
0 in mixed mode. This fixes recent kernels sometimes hanging during
early boot on mixed mode UEFI systems.

Cc: <stable@vger.kernel.org> # v4.16+
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/tpm.c b/drivers/firmware/efi/libstub/tpm.c
index caa37a6dd9d4..a90b0b8fc69a 100644
--- a/drivers/firmware/efi/libstub/tpm.c
+++ b/drivers/firmware/efi/libstub/tpm.c
@@ -64,7 +64,7 @@ static void efi_retrieve_tpm2_eventlog_1_2(efi_system_table_t *sys_table_arg)
 	efi_guid_t tcg2_guid = EFI_TCG2_PROTOCOL_GUID;
 	efi_guid_t linux_eventlog_guid = LINUX_EFI_TPM_EVENT_LOG_GUID;
 	efi_status_t status;
-	efi_physical_addr_t log_location, log_last_entry;
+	efi_physical_addr_t log_location = 0, log_last_entry = 0;
 	struct linux_efi_tpm_eventlog *log_tbl = NULL;
 	unsigned long first_entry_addr, last_entry_addr;
 	size_t log_size, last_entry_size;
-- 
2.17.1

