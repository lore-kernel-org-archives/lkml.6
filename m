Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBA1C282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577EF2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="nwnQIA7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfBFAL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:26 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41980 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfBFALX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id p15so195815edy.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CMsPM4V0UcM/Br+3Z7vRn/TleS1sO57Q6aT4z0QMKiY=;
        b=nwnQIA7LqbiBtvw0xLU1TgECk67p4bOhpbi+3dfZXJsbosyG7U0tqsWxHqD2OE74IJ
         cLtDL7F9MWyCYs9QFUJTJf8CE9TtuY7gDD027Xs8sY5T/ykXCjXFF/NSKsjWtTzuGlTG
         Mgde0DXeeIjsfI2CrLV/J1vJfP4dywWHfJ8FXG6fZjj/6AI599fLfCfq6FZJ9xgt+Yw3
         6uUNEO+Rmyo4U1aRT6zrNYyMBm3CQxAgOCdlFzjSmrxnGF6pYvqp/U15FX+mBJYG0AFl
         tmaC7vQe2WUVql/wJYsfZ1tpICprnqFCRmy+3m90wn9RO7p5qhsqTmqZPHiPcZml4vMr
         AaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMsPM4V0UcM/Br+3Z7vRn/TleS1sO57Q6aT4z0QMKiY=;
        b=QY6RcLPJ57eh2WxGAhzemvs1d+Q7KSjhPH3OsFMna7FLL86o2zKro1AJTZL036yyWX
         5uakUEqipqvYvnNa19qoGorFnMit0kaHfcsEgVbtNzFN9CA1wm/obbhUKgrAxH3rUPLJ
         d7IIZxjH98AQtIBJxcHyZ0Ar3Kzz3v8dVNi3KbUUrxfV8c9XNus6rLgeAOlBxWpCscZq
         RZ+ERShZmKb4V7C/NdN7pCiv4lYD69qlETMlQ/t95Eet6X/CVdNGJ8s5NyoZfv/IFGB3
         BAlB1sJCWphTeJKWOZaOLuxKgYLT/9rPGXxcfiCtqT5jE38KnxsEg87di67L/TnyNZj6
         w4TA==
X-Gm-Message-State: AHQUAuYUslA5Dm8BNezKuMfa6Xxiu4B3caeSzQrv/pQuUUM7FUhlGUBC
        HZ24/RliaTYk0H8MdO/+DVbLXznrfFk=
X-Google-Smtp-Source: AHgI3Ia0aGZRLMRGTOWP56gip3Co0Pkcp415IcTQIjFB5y0NXQHZuXVjMd3v4UytU2b65gdF35vzlQ==
X-Received: by 2002:a17:906:7252:: with SMTP id n18-v6mr5379073ejk.192.1549411881546;
        Tue, 05 Feb 2019 16:11:21 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:20 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 09/32] x86/vdso2c: Correct err messages on file opening
Date:   Wed,  6 Feb 2019 00:10:43 +0000
Message-Id: <20190206001107.16488-10-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

err() message in main() is misleading: it should print `outfilename`,
which is argv[3], not argv[2].

Correct error messages to be more precise about what failed and for
which file.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 8e470b018512..26d7177c119e 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -187,7 +187,7 @@ static void map_input(const char *name, void **addr, size_t *len, int prot)
 
 	int fd = open(name, O_RDONLY);
 	if (fd == -1)
-		err(1, "%s", name);
+		err(1, "open(%s)", name);
 
 	tmp_len = lseek(fd, 0, SEEK_END);
 	if (tmp_len == (off_t)-1)
@@ -240,7 +240,7 @@ int main(int argc, char **argv)
 	outfilename = argv[3];
 	outfile = fopen(outfilename, "w");
 	if (!outfile)
-		err(1, "%s", argv[2]);
+		err(1, "fopen(%s)", outfilename);
 
 	go(raw_addr, raw_len, stripped_addr, stripped_len, outfile, name);
 
-- 
2.20.1

