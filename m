Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621D4C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2029321763
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2029321763
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbeHNMGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:06:06 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:47064 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeHNMGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:06:06 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MH9BC-1fbly40z9G-00Dqbw; Tue, 14 Aug 2018 11:19:30 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: rpc: mark ecard_devices_proc_show as __maybe_unused
Date:   Tue, 14 Aug 2018 11:18:46 +0200
Message-Id: <20180814091904.2186262-2-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814091904.2186262-1-arnd@arndb.de>
References: <20180814091904.2186262-1-arnd@arndb.de>
X-Provags-ID: V03:K1:TuvXcBZLzJWevm+NCljyFt6YA3ntRuhyHXRh9HbxkkRPYDpmi8D
 ozDN+oJLLiRPmlBS3LlPvCTgjN/aGMT4/Gap3JwaO8/lpeV+bRS4UhWexu5hlFDlxcr/Nme
 ljtCQqHxSBhRKMWZLZBOeEc9ZGAOkR5fI43snApIAGfbInsBs2RIu2XUC7H6StAZtNWXTZ2
 PvPx62ul5CcyRsxjE1TyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lmnb6dFe+hI=:HcVHHxtKV/sZg0qku12Ir+
 ooPhY71bWzWn6hHEb/45dv0k2WILH27HizedHc+zDDIglfifiAZVa+dilp2xGeNWuC95OnouT
 9MuoZzWIvOj42kjedVqq2omnZjaCtNpwg1mNJvFrUh40T8eXy2eYvJ08aZCX4rvrNybblPAXi
 nEGmF6slJ4Mmm6KASsRqBALsQCxkN+c3L/KEvQNZQOqho6DxAIoL4LkVHnKEk0hZs8gJVNKTx
 SRAiQXHYPuDdPnyo6UrBGm/aNxqHsQQiWk5j/uj+kWzOhmMdkZRvppm7WukOOoFwfkqdTcxko
 S5gyv2au3MUyjAu9cF/YeZ+MNDF18LDuRbb5VColGauAlRnQXswPcL82EEDejpnGWdI2wHOgj
 1TlwteSndlYm+L8yfLlFv6iIc4bK54sO7xZBOYAJUBHvEMaLectYjo3qfFLzRzVDbHDDBaVQh
 ITXxxH4MpNxDoQoHQ+gQxng54jH2lwcPHkeB7LcU4SRaasOTn85PDzIN5kcsB1lq9Y7Fux4KI
 vLA75qI1bKal1GNSxUB9hf99YcxES9d4rx0V/Ci4ttnyGAoWAY9hzbzF0VVOX6U2C7k9Qv7Oi
 chwhh0WWNVsEprdBnWtMkD+rICL++xslq36VCrneko70K5b1jihuVFKbsxRZUPY8tPd90iREF
 CjGH/xjqQ/S42IlKP6CpUzS8YI7/xGKBfVkqSUiUlCUPys8AVsXaf9oQFQlYd/O//V08=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new build error appeared with CONFIG_PROC_FS disabled:

arch/arm/mach-rpc/ecard.c:646:12: error: 'ecard_devices_proc_show' defined but not used [-Werror=unused-function]

This marks the function as __maybe_unused to let the compiler drop
it silently.

Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-rpc/ecard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 6fb51d49ad26..761a629f9e9d 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -643,7 +643,7 @@ static int ecard_prints(struct seq_file *m, ecard_t *ec)
 	return 0;
 }
 
-static int ecard_devices_proc_show(struct seq_file *m, void *v)
+static int __maybe_unused ecard_devices_proc_show(struct seq_file *m, void *v)
 {
 	ecard_t *ec = cards;
 
-- 
2.18.0

