Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB014C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11ACE20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRysfJg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11ACE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeJWJlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:41:39 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43926 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWJlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:41:39 -0400
Received: by mail-qt1-f193.google.com with SMTP id q41-v6so48717578qtq.10;
        Mon, 22 Oct 2018 18:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=8/8INH84dIZzXD9t1cfNjZHLAxNXXeBy6HCUhD39Vk4=;
        b=RRysfJg4oCtUMcUR4ATcTXH/GMpDTWfBaSwgKzdYEzUNwNrbjWf0vlklTAjfWd9tra
         v0HlFRCgVZGk6W6EWZbWaAlTP9UvTUVM0oFmvVy8h5694lqvqZwlxS41UYlCbrl3KU9j
         ZkrbRbbUJrcTx0ry++3B4trCU7rus2IE37iXQEgG9xjdDGnNTd/tstD7GMU3Rgl5A0XN
         UkPZh0EiS+rVjCKAn12u3ufwr9uhzlAeqipEkPZ9t1r9Qb3kHJgwX/X1UapIQwniFQ/l
         3/C+F2BJdn1ottaBZqdFjCls62RouauctcF74HEckpkr2xoHaw9o62QsykRoa7emVT86
         UxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=8/8INH84dIZzXD9t1cfNjZHLAxNXXeBy6HCUhD39Vk4=;
        b=TaEMVhXLxFqqq+EJutaxt/b0hUT6FaUkp7WNCL5Sny+jcsNQJFe3krORwMQ2qNL2VB
         Ht55DRKxW7uaMsEcbPecTcRSBUZWVQwYWDtWJznXKud48ntmPeVQ68sPVAARTiApc13g
         g1n9PjOTUSkpKmN5MPYzg/qCNZFSun4+nfJ0hQ5CoOgNfKtAk2dcqWPSOEvZJLWFioGb
         2LZqLiNZ7oc89Z8GQvjQIZpL5ExFvLB7ayHXX2lbjdRQFxZ1VPA75ecYQIvVkuWpqJjA
         crWYxr4h4yq174NtxEOviCYpDkf/Aei56XBuVEmrE62UX/+aVgz3+sY8MbqdBGJDJlfq
         LTOg==
X-Gm-Message-State: ABuFfojU4MTR57/2rQiNl2u9R9G2xvck/1HJIVW8v5AaWGfPW+aO+bhU
        tbNL8+8KxPqasOQY7edgtcQ=
X-Google-Smtp-Source: AJdET5cRTcaMiRjLOirfoourjak+xIcbVG+gOBbcn/fq55FEkGMqcXwG1KMzrxFI+ypj55wqDYSIZg==
X-Received: by 2002:ac8:3fb7:: with SMTP id d52-v6mr10667111qtk.46.1540257637071;
        Mon, 22 Oct 2018 18:20:37 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id s21-v6sm7575288qth.11.2018.10.22.18.20.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 18:20:36 -0700 (PDT)
Date:   Mon, 22 Oct 2018 22:20:31 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Changes style to look more like list iteration.
Message-ID: <20181023012031.GA6920@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes the code in order to make it looks more like its a list iteration.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---

It's a remainer from a patch from the -Wshadow patchset.
Since it doesn't really belongs to that patchset anymore, 
I decided to release it just as a code refactor for
file2alias.c

I fixed it after Koike's suggestion (&&!dup added)

IMHO it reads better this way, and no drastic change has been made.

Thanks.

---
 scripts/mod/file2alias.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 3015c0bdecb2..b957279c4117 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -650,26 +650,26 @@ static void do_pnp_card_entries(void *symval, unsigned long size,
 
 	device_id_check(mod->name, "pnp", size, id_size, symval);
 	DEF_FIELD_ADDR(symval, pnp_card_device_id, devs);
-	typeof(devs) devs_last;
+	DEF_FIELD_ADDR_VAR(symval, pnp_card_device_id, devs, devs_aux);
 
 	for (i = 0; i < count; i++) {
 		unsigned int j;
-		devs_last = devs + i * id_size;
+		devs_aux = devs + i * id_size;
 
 		for (j = 0; j < PNP_MAX_DEVICES; j++) {
-			const char *id = (char *)(*devs_last)[j].id;
+			const char *id = (char *)(*devs_aux)[j].id;
 			int j2;
 			int dup = 0;
 
 			if (!id[0])
 				break;
 
-			/* find duplicate, already added value */
-			while ((devs_last -= id_size) >= devs && !dup) {
+			/* find duplicate on previous devs*/
+			while ((devs_aux -= id_size) >= devs && !dup) {
 
 				for (j2 = 0; j2 < PNP_MAX_DEVICES; j2++) {
 					const char *id2 =
-						(char *)(*devs_last)[j2].id;
+						(char *)(*devs_aux)[j2].id;
 
 					if (!id2[0])
 						break;
-- 
2.19.1

