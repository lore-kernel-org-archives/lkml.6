Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DABC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76E420867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UjJInEUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76E420867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbeIDAWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:22:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42096 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbeIDAWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=izU5rT4RDYgl1+GSg5Y32KJTdz2MUjHiZV2xHJZqnos=; b=UjJInEUXEkfV6QYELhMxFyPq2+
        eNBfPzivUmhh7dPIuS48t226VFslFLTS5ws5gdNmU9xu3uwyDtDOUoPKt7r2plkbivfb09krU0o6w
        pxX5urV8XQYhuHqhwvmAJV3q3yzfWLSQYgDPz9k2xQ7HMEyVLPpaamlRNEuVEN2PSvs3kmOw928ZC
        hHh6jM4SttpSG/oBChWGw92CwAggjhe+v7mvJDn+8voii54HLwAzfNnll0+Uo5bsYF7duyXBI6x2z
        Qay469ZeAqhE9HYgokfI6PnSAeWi30f8Hs3qV5m2RIc59K+BWc0Vo24+mR0UnaR+LWmpxdLJO/YMi
        Dg7RG6LA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fwv1I-00025h-4s; Mon, 03 Sep 2018 20:00:20 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Evgeniy Polyakov <zbr@ioremap.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] w1: fix kernel-doc notation warning for struct w1_family
Message-ID: <803b3a38-3e58-d185-4df2-144ffec629d6@infradead.org>
Date:   Mon, 3 Sep 2018 13:00:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc warning for missing struct member description:

../include/linux/w1.h:281: warning: Function parameter or member 'of_match_table' not described in 'w1_family'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Evgeniy Polyakov <zbr@ioremap.net>
---
 include/linux/w1.h |    1 +
 1 file changed, 1 insertion(+)

--- lnx-419-rc2.orig/include/linux/w1.h
+++ lnx-419-rc2/include/linux/w1.h
@@ -266,6 +266,7 @@ struct w1_family_ops {
  * @family_entry:	family linked list
  * @fid:		8 bit family identifier
  * @fops:		operations for this family
+ * @of_match_table:	Open Firmware device matching table
  * @refcnt:		reference counter
  */
 struct w1_family {


