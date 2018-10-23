Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8971BC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB7A20651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSlBOavx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFB7A20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeJWJbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:31:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41941 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWJbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:31:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id l41-v6so48684758qtl.8;
        Mon, 22 Oct 2018 18:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=L46EcQJ+O0hl3e5uDfhzLkvgGNrA7UN6EpC8xsyT0FY=;
        b=CSlBOavx0UlhIrISkkDHA4kCNCT+CH/XOam/TlKnbL8/aBBNxuVlL9xBhZTJczWrro
         ytEuerpOzEPyItkG0b11HhcbCTUyXsMB4QUYMmmnNau6agHQx0HkF00oOni4SP8EkKmu
         Ot0hYh6HLcK4O3yT3bLvilXVpPByE5pcDJyV8OgiCX4kHYIwiB3yY0HxFLmB8+Qku277
         4kSik+hUeb0ETjSAgEEvgIB7BTHVKX2RMc6XTEw1efctoI6xj2AV8qKDy++iYYx8Bew1
         SapvDsYONr+dB99TNXSbb9ew8ZkmDOTQ1PFDup4A1RVHy31q/i4ew7T5aPcbjDdlyydl
         HPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=L46EcQJ+O0hl3e5uDfhzLkvgGNrA7UN6EpC8xsyT0FY=;
        b=YJObeGoxbTD+3BlZwz9LzeIzYxyAg8ofzgnHcwcQe/7KF/o/ukMuBp3xPVsxHxBlcM
         XCeSVTj8boY0hH0uR4nDnvBBomDvN7VIhSn4lUpn7lK3ayXkH3LW0NJ9PLkFbxpXJ+9L
         E3W0icrzA0kX8TS/mYJsAFZKsTC9F4x5dBeYVlURDyZJC1UOnh25HrlBAfs/7oxPF/Il
         F0scdBUks8X0+7EVI+sYgi4LHAm9KQIMGFja9weS1lTVNJhfrtJPbCau9N7JA1SUHyaR
         sgsHyTtE2thnbXqTYrvpAHll0j9kmfoICv8n6YTrFaXxbqr2ruZM2kVUMoiOjTyDQlN8
         t8ig==
X-Gm-Message-State: ABuFfohCgkaAteNaL3IoDxj/U2eqF86SVFaJsIaJKYKvaNkszdTBlNRn
        Ss2y6ux2L+uPbmgArTSyrLA=
X-Google-Smtp-Source: ACcGV63ynAj8tkskw8CjzxaP3UE/TxFFaWo9UI+H4PaQsj6pHTX9+lgsRO7UMkzHS9P/qCFeMkzv0Q==
X-Received: by 2002:aed:2d05:: with SMTP id h5-v6mr46169920qtd.291.1540257049425;
        Mon, 22 Oct 2018 18:10:49 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id c85-v6sm21153702qke.89.2018.10.22.18.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 18:10:49 -0700 (PDT)
Date:   Mon, 22 Oct 2018 22:10:42 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Borislav Petkov <bp@alien8.de>, David.Laight@aculab.com,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, helen@koikeco.de,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] Creates macro to avoid variable shadowing
Message-ID: <20181023011042.GA6582@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creates DEF_FIELD_ADDR_VAR as a more generic version of the DEF_FIELD_ADD
macro, allowing usage of a variable name other than the struct element name.
Also, sets DEF_FIELD_ADDR as a specific usage of DEF_FILD_ADDR_VAR in which
the var name is the same as the struct element name.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 scripts/mod/file2alias.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 7be43697ff84..3015c0bdecb2 100644
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
@@ -641,25 +649,27 @@ static void do_pnp_card_entries(void *symval, unsigned long size,
 	unsigned int i;
 
 	device_id_check(mod->name, "pnp", size, id_size, symval);
+	DEF_FIELD_ADDR(symval, pnp_card_device_id, devs);
+	typeof(devs) devs_last;
 
 	for (i = 0; i < count; i++) {
 		unsigned int j;
-		DEF_FIELD_ADDR(symval + i*id_size, pnp_card_device_id, devs);
+		devs_last = devs + i * id_size;
 
 		for (j = 0; j < PNP_MAX_DEVICES; j++) {
-			const char *id = (char *)(*devs)[j].id;
-			int i2, j2;
+			const char *id = (char *)(*devs_last)[j].id;
+			int j2;
 			int dup = 0;
 
 			if (!id[0])
 				break;
 
 			/* find duplicate, already added value */
-			for (i2 = 0; i2 < i && !dup; i2++) {
-				DEF_FIELD_ADDR(symval + i2*id_size, pnp_card_device_id, devs);
+			while ((devs_last -= id_size) >= devs && !dup) {
 
 				for (j2 = 0; j2 < PNP_MAX_DEVICES; j2++) {
-					const char *id2 = (char *)(*devs)[j2].id;
+					const char *id2 =
+						(char *)(*devs_last)[j2].id;
 
 					if (!id2[0])
 						break;
-- 
2.19.1

