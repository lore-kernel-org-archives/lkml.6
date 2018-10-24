Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B71C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1365D20651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 04:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rk2/LpXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1365D20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeJXMaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 08:30:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41772 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbeJXMaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 08:30:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id g13-v6so2322438qke.8;
        Tue, 23 Oct 2018 21:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5D1hZGQn79sjYuJIciSxWCUSa1H94oaAOohqbOYmnPw=;
        b=rk2/LpXUFkJOz5u8T5qtI3WGt7M0UqyEdeCO6AqwqA2l9OgE6D/qMPvqXT5ygU6ovC
         EQIPoDQQId/5ttOA2mB2SHH6/wUh8JGL5wHxQjSWnLNXbTC3rbmsXSvMn0AHTvA+2D4v
         PyuyANFcglMLRu2xVe4/eAxUT8q3LuBpkC0xSjDnJe+YNU0YOhXVDrLlSOF6/pmCXw4U
         5CX4OCZcaOrlP3gagcPO5Dji7IAOH4Wibgvkngl1riFZ70VrEwqA2HfETDC9ZNz2yKF0
         59MPNrPT6zV0NO+aaRZbFf2H0gLdHyCi3pgwBRGQIyNXx09pshyF0ZOwbiG1ATCcm62N
         RK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5D1hZGQn79sjYuJIciSxWCUSa1H94oaAOohqbOYmnPw=;
        b=jJQLe6srftnqp5ERDSqvbyFfhqoHHyXNcsTgiUwg5xoo3ewj9NQcgFctb00Lxj1H3S
         4AwHEc4RytySo47B0TfiF2IpOgj7F4PEGC+G5ZQ3NPrO9xtGE7UyCX0zEkKqgaxmx4Wl
         KN6AG+YwEOXPRTzvGM7AK9NO5jSbzw+ZfO54ed+93adnaFrAqyLMfQQ9Rk7JNKKXI295
         uWVRFmv3IYR/gEJe9PiICMmBYjxJeFhMB///p6hDAhc1PmGa1WK0fjOmpsN8NGkDeeL2
         5xInC1/nl7uqA0IorDNFyjenyrLG9PSsOuqEXRKzAdOUr5QONphBiatc9Qo+UvOloWoW
         UeSQ==
X-Gm-Message-State: AGRZ1gI3xg+1JirhSoEQOPiCHlLn3Sq+egTkjVby2nbC7MAUBZX7y3Jr
        dhrkLQ6Q8bhES0sFH+gnd88=
X-Google-Smtp-Source: AJdET5dtzI20RY5+5wDbK6LXaPfnMfyJRanYbTIip+/rOfOukxeBUq+TzGueS0GxbbrLoxdQ3ZupUA==
X-Received: by 2002:ae9:e313:: with SMTP id v19-v6mr856863qkf.318.1540353856686;
        Tue, 23 Oct 2018 21:04:16 -0700 (PDT)
Received: from localhost.localdomain ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id e195-v6sm3229126qka.2.2018.10.23.21.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 21:04:16 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Leonardo Bras <leobras.c@gmail.com>,
        Borislav Petkov <bp@alien8.de>, David.Laight@aculab.com,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] Creates macro to avoid variable shadowing
Date:   Wed, 24 Oct 2018 01:03:52 -0300
Message-Id: <20181024040354.24879-4-leobras.c@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181024040354.24879-1-leobras.c@gmail.com>
References: <20181024040354.24879-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creates DEF_FIELD_ADDR_VAR as a more generic version of the DEF_FIELD_ADD
macro, allowing usage of a variable name other than the struct element name.
Also, sets DEF_FIELD_ADDR as a specific usage of DEF_FILD_ADDR_VAR in which
the var name is the same as the struct element name.
Then, makes use of DEF_FIELD_ADDR_VAR to create a variable of another name,
in order to avoid variable shadowing.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 scripts/mod/file2alias.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 7be43697ff84..ed468313ddeb 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -95,12 +95,20 @@ extern struct devtable *__start___devtable[], *__stop___devtable[];
  */
 #define DEF_FIELD(m, devid, f) \
 	typeof(((struct devid *)0)->f) f = TO_NATIVE(*(typeof(f) *)((m) + OFF_##devid##_##f))
+
+/* Define a variable v that holds the address of field f of struct devid
+ * based at address m.  Due to the way typeof works, for a field of type
+ * T[N] the variable has type T(*)[N], _not_ T*.
+ */
+#define DEF_FIELD_ADDR_VAR(m, devid, f, v) \
+	typeof(((struct devid *)0)->f) *v = ((m) + OFF_##devid##_##f)
+
 /* Define a variable f that holds the address of field f of struct devid
  * based at address m.  Due to the way typeof works, for a field of type
  * T[N] the variable has type T(*)[N], _not_ T*.
  */
 #define DEF_FIELD_ADDR(m, devid, f) \
-	typeof(((struct devid *)0)->f) *f = ((m) + OFF_##devid##_##f)
+	DEF_FIELD_ADDR_VAR(m, devid, f, f)
 
 /* Add a table entry.  We test function type matches while we're here. */
 #define ADD_TO_DEVTABLE(device_id, type, function) \
@@ -644,7 +652,7 @@ static void do_pnp_card_entries(void *symval, unsigned long size,
 
 	for (i = 0; i < count; i++) {
 		unsigned int j;
-		DEF_FIELD_ADDR(symval + i*id_size, pnp_card_device_id, devs);
+		DEF_FIELD_ADDR(symval + i * id_size, pnp_card_device_id, devs);
 
 		for (j = 0; j < PNP_MAX_DEVICES; j++) {
 			const char *id = (char *)(*devs)[j].id;
@@ -656,10 +664,13 @@ static void do_pnp_card_entries(void *symval, unsigned long size,
 
 			/* find duplicate, already added value */
 			for (i2 = 0; i2 < i && !dup; i2++) {
-				DEF_FIELD_ADDR(symval + i2*id_size, pnp_card_device_id, devs);
+				DEF_FIELD_ADDR_VAR(symval + i2 * id_size,
+						   pnp_card_device_id,
+						   devs, devs_dup);
 
 				for (j2 = 0; j2 < PNP_MAX_DEVICES; j2++) {
-					const char *id2 = (char *)(*devs)[j2].id;
+					const char *id2 =
+						(char *)(*devs_dup)[j2].id;
 
 					if (!id2[0])
 						break;
-- 
2.19.1

