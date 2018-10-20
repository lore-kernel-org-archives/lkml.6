Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04832ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB37214C3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 00:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UtH5/yFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CB37214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJTIYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 04:24:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48888 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbeJTIYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 04:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FHdaXDegKovCiIPUClRUj3K+U2Dx7QSn81MXOuwniEs=; b=UtH5/yFr6OoZH9ly+vX9gKWEjm
        Q8t6f1xHV4sfoBrESmXFjQo83gJsezN4amyr5RyhoErJ+DxJ60PH6qzZrtze6sIEqOaVyOcjllGKu
        +OfGOL1mHTByeAWpQ2xUVReD+ylQzlSaUp8hCcNohSbSrqS8O/N/vLrTKe1aDikKNcxPZNj/DB7jG
        Eo/GN+l6XGYyvZiPgTiRJk638dywM6vo/zP87/K48OXy3o5JPcA3nxjdEvDTSyfzSuYuCVuZXfegb
        GHEIoANL796Lu9KnuyAeX7CcNbs20IBSHLTkO8qjpUGYHeKKbSJqUB2uwgd82RV7HH2E6GIsgY5Z0
        9Y+y6Gsw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDewB-0001O9-1s; Sat, 20 Oct 2018 00:16:18 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Jason Baron <jbaron@akamai.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: dynamic-debug: fix wildcard description
Message-ID: <74834e33-3876-9eeb-5139-903bd412059a@infradead.org>
Date:   Fri, 19 Oct 2018 17:16:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix grammar about wildcards and insert a space between sentences.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/admin-guide/dynamic-debug-howto.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- lnx-419-rc8.orig/Documentation/admin-guide/dynamic-debug-howto.rst
+++ lnx-419-rc8/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -110,8 +110,8 @@ If your query set is big, you can batch
 
   ~# cat query-batch-file > <debugfs>/dynamic_debug/control
 
-A another way is to use wildcard. The match rule support ``*`` (matches
-zero or more characters) and ``?`` (matches exactly one character).For
+A another way is to use wildcards. The match rule supports ``*`` (matches
+zero or more characters) and ``?`` (matches exactly one character). For
 example, you can match all usb drivers::
 
   ~# echo "file drivers/usb/* +p" > <debugfs>/dynamic_debug/control


