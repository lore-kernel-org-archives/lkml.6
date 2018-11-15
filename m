Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF228C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7883208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="j2Sa2dRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7883208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbeKOLCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:02:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41539 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeKOLB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 06:01:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id p16-v6so8603977plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 16:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ip/uN80nDQ2rMeqP2KZwDxVilnXEzfgwHZW13YfQmjs=;
        b=j2Sa2dRjswboj0LcLDh4go3/pdloMN38eZW73bFg/dhrUiPyGTbDZ/u62KW8m/8E36
         BPDNdlPupv7+t/nuRPZj3EUrhXNptkoM3PqGXebQwQMcPTiBwSzAolnFcChlV56mI2aQ
         I7O9B29HCgaZXeMd8CS4Wj236CIBICOUwE+1YKjVkBOW/BGN9UzT5XgydsRhI21Cv6Xy
         GgVFR4Vm577nfHRThqpZR4mODWxtwkAF1tDQp04OPZXye/U0DPD1DTWHLLAuaLXzh4GD
         1lXG/DHk7/7AqUCg2sXuPRwHQN5t+qK0IdxvIha9AJUYkoVrzYXQndyC9XSxiDF2RBN4
         1hkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ip/uN80nDQ2rMeqP2KZwDxVilnXEzfgwHZW13YfQmjs=;
        b=Odbfuu6jlNr8tpON7/43NR4oK881DmraIG3eQTaZzzkT9N3aPn+zLWw+yQfN1hQxrN
         IAwP2KdqSGyE4ib8Hf+HHVwOFZE9Gni2an6Gs9lFsy1JPTTLIUVswiOf1KoBIEXu54Cc
         WB+33lXG56rqVQaPaFdevx+vz6+l6zXLUDUNKGGiCkg0DcTaq47RcKyW/pO4Z4qL6xnB
         ycp4BvxpmwJXmiaqfOooD+7V++DSgb/+SpsL89DvQRVR/wg8Im9Nk+WLZLMCep9tL75n
         vlc1YxKrsGBPhlMOSQuuccZCiZa7H1hbFkf+9bWzXvGgAzLmtrjF9rnEWxUeKbhOnwa0
         trFg==
X-Gm-Message-State: AGRZ1gKeiZbxZSO3jSCz55mTKMxQGEG2DDJVg0HFOY3wnTp9jMO2txkv
        51elG6upwlTP56pwcrSoQ5WTmQ1iiy8=
X-Google-Smtp-Source: AJdET5cvpAvfn7v4C4e0bxmcTikaMbSny0594Xwgh8UPz58mFA1UbLBg6Sqo/MP2N5Z8h4fmUO7eiQ==
X-Received: by 2002:a17:902:2867:: with SMTP id e94-v6mr4145091plb.317.1542243383003;
        Wed, 14 Nov 2018 16:56:23 -0800 (PST)
Received: from viisi.sifive.com ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id m10-v6sm47343509pfg.180.2018.11.14.16.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 16:56:22 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 1/2] modpost: drop unused command line switches
Date:   Wed, 14 Nov 2018 16:56:01 -0800
Message-Id: <20181115005602.30746-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115005602.30746-1-paul.walmsley@sifive.com>
References: <20181115005602.30746-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop modpost command line switches that are no longer used by
makefile.modpost, upon request from Sam Ravnborg <sam@ravnborg.org>,
who wrote:

    modpost is not supposed to be used outside the kernel build. [...]
    I checked if there were any options supported by modpost that
    was not configurable in makefile.modpost.
    And I could see that the -M and -K options in getopt() was leftovers.
    The code that used these option was was dropped in:
    commit a8773769d1a1 ("Kbuild: clear marker out of modpost")

    Could you add a patch that delete these on top of what you already have.

https://lore.kernel.org/lkml/20181020140835.GA3351@ravnborg.org/

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0d998c54564d..85bd93c63180 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2416,7 +2416,7 @@ int main(int argc, char **argv)
 	struct ext_sym_list *extsym_iter;
 	struct ext_sym_list *extsym_start = NULL;
 
-	while ((opt = getopt(argc, argv, "i:I:e:mnsST:o:awM:K:E")) != -1) {
+	while ((opt = getopt(argc, argv, "i:I:e:mnsST:o:awE")) != -1) {
 		switch (opt) {
 		case 'i':
 			kernel_read = optarg;
-- 
2.19.1

