Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA210C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C02320658
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAlxm47z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C02320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJOMnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:43:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43444 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbeJOMnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:43:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id p24-v6so9022142pff.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 21:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wEB5n2pIsC88JPVQEtyIf4qtUd76bmXhXSAgCVIz+Wk=;
        b=fAlxm47zViaoQsenAnZ7Nud51yLGuoRvIq8n/WhTz7Nlf4SuavLSe5jqvLryN3+AbL
         XNZ4RPKeHs21pbDy9Qt3IeqLnDtwB8aq9XQM0K8w5YDIOk0LEKme2WQiYaOyxXqQl/2Z
         ZkUiZc2M5E65DjrHEQ1gOETxrRl06WbSPW1gtBn3uh35YVgYvRFVjdc0Hkvpp5fKFtCf
         TcDEOWRtIWoNQ1G4Qbp0BEzhZM1p1sgi5JBR1/GhIrMx3RWU8mXWB5Jk9yYcUt86aXfa
         zvxc3GxSY51oVzMm/1jakJeUpQjch6raWMIM2kZwuOy2LZDoV4aBe7XIFrdiRLRgf7Xd
         e60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wEB5n2pIsC88JPVQEtyIf4qtUd76bmXhXSAgCVIz+Wk=;
        b=QTQ1nF0mCNKc3di0/24dgofNM6ZRdMPzffSCDqORLCKGooxsPWFcJNv7aU+Nqvqh/Y
         DF2r+qfRB/QX8VnhmxQXADCscav7nOzBdJ+wOSF6i5xfCpri9g1KoRg6LHumlqZw6dl6
         jrygyK3bS2Y/hJYnLr2KUdtiRt+hublUMYC9fMdOUaS6jUqU2ccmsrigCBiFk+6hxAfG
         L25w2JrTEwl/MjtDk6xaab09HSMIW9ZRH5cPKhNeBPoTT0Y9ZlonA9dLTUXHpIURuusM
         aAC06/o4eQKDjj5Df8Ha/F212og5GG75wkUCadCNAf/fPNdiEGutzUxXpPuz0xJ6amwv
         eM5A==
X-Gm-Message-State: ABuFfog0ENSpT6NUBwOt9UVKV4Y2uU5hKcughQvusmncOZc+dCQ9jE7U
        nAXoEcJs46sgK90VunDEgEA=
X-Google-Smtp-Source: ACcGV60AJNf0bEpQxz1hfmB84+AqHLSZCJ8gcdQEhNY2AnXY79SCu0Or1IzOQi0UXrj9JhUj+DmQSA==
X-Received: by 2002:a62:507:: with SMTP id 7-v6mr16090233pff.80.1539579599152;
        Sun, 14 Oct 2018 21:59:59 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p62-v6sm12244698pfp.111.2018.10.14.21.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 21:59:58 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Ewalt <nicholasewalt@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 04/11] staging: gasket: page_table: remove unnecessary PTE status set to free
Date:   Sun, 14 Oct 2018 21:59:20 -0700
Message-Id: <20181015045927.156790-5-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181015045927.156790-1-toddpoynor@gmail.com>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Ewalt <nicholasewalt@google.com>

Remove unnecessary ptes[i].status update in gasket_perform_unmapping.
The vaaue will be cleared in the following memset.

Signed-off-by: Nick Ewalt <nicholasewalt@google.com>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 985a3a93499d5..d2e115d2dba30 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -623,7 +623,6 @@ static void gasket_perform_unmapping(struct gasket_page_table *pg_tbl,
 			if (gasket_release_page(ptes[i].page))
 				--pg_tbl->num_active_pages;
 		}
-		ptes[i].status = PTE_FREE;
 
 		/* and clear the PTE. */
 		memset(&ptes[i], 0, sizeof(struct gasket_page_table_entry));
-- 
2.19.0.605.g01d371f741-goog

