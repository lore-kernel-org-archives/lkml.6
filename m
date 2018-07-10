Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716C2C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1431520840
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="UZktuqrw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jpi6J2lV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1431520840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754635AbeGJA0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:26:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41019 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754535AbeGJAZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:25:58 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BF53A21B54;
        Mon,  9 Jul 2018 20:25:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 09 Jul 2018 20:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=TkVq0AmKornFngldN
        Nn2VRKSxvf+Ek+6V5wWzuv9D1k=; b=UZktuqrwJHUtFCzEaOk/FBVO6pEpWnxun
        Fc/K6UQyV7KXXxX03nj7MtefZ/3Y/Tv7y78c1chcCjthn823xqw5e3Qv9o8QVOHa
        p914GMuYra9BmnzwUOFM22G0Rsc9gsQRcrfkissUQ7RZq+ai6/D8neJTNQvPHlhT
        6cwcc8APF6CtL8777JL1QApTapIc3hyyrpbIrzSRW6GLg3UyXcWvbI7mnRNFWjlP
        /XVZx8tQuP5dS0n+2V/57JIvFDcAMtwsUjwSOM1ABLbfwSO2qtwcd0hZ2dCr5HMl
        ZoksORuj8Ab5lfvZnUPfX7YMk04//rbMfy+xvUO1uOUprLiH233Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=TkVq0AmKornFngldNNn2VRKSxvf+Ek+6V5wWzuv9D1k=; b=jpi6J2lV
        lnsm7PB4MlyUi2MQQEJxCmwXeK2HOM+bPS4ewiaIfmnZbmzABOzc+cIyQJdDfCo5
        oN+AeIn5k+G0uvt3PVZkLDVP1AZ7Uf45m6gul5zpPQdUIAFKwzeNmPgm/iI+zEP6
        gqMa80agAaAXy3IzYSj+wtRw8+rs2whufMyCo13dV0BthlP7nr2+hk80DOmBOMWg
        gYbqYWaqkcvU/vKUrsIpLcNi+tQ8L7SRkB7jIpudc1gKuQzmcjmFld01Pqb2PQGW
        7/LHkoyQ3GjtyGWbF00gUWggSWDAkrRkSBjxTee0B7XX4ESBps5kWXSHVMkFqcgV
        qTmx8RIWpFASUA==
X-ME-Proxy: <xmx:Ff1DW0lPUVIgRnWNiftCKOWSAPel6HQi1CzFUKpblJcUHhIITi6eVQ>
    <xmx:Ff1DWxyhAKf4KUYLtpxcTCd7EpPBHl7KLiwl-N-k1Rj9E8WLGvJ8fA>
    <xmx:Ff1DW6M-mmOae3If2Fv02BARZUM2y5Fiytc_hSoSMOgz0QoHCSTgpw>
    <xmx:Ff1DW9QIz7KL2KNg0hBJyXO9rG7KivgJ6xw9OkPta2UPK8WBxWUJuw>
    <xmx:Ff1DWwbtGfv70J4t6fOqyMSVtUt2e4EoDl5bJV76IeelfbfTX3Ss5w>
    <xmx:Ff1DWzlGcZOBhKU8yQCz74up1Smlav40X50vfokqTvT0tSaaLF_mJw>
X-ME-Sender: <xms:Ff1DWzl-o7wTCU0TK2FXQ-G-PkYDNc5wlbFremv7o45XuyRs38o00A>
Received: from localhost (ppp121-44-208-89.bras1.syd2.internode.on.net [121.44.208.89])
        by mail.messagingengine.com (Postfix) with ESMTPA id F25C1E45C9;
        Mon,  9 Jul 2018 20:25:56 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] random: Remove unnecessary cast
Date:   Tue, 10 Jul 2018 10:25:17 +1000
Message-Id: <20180710002519.5044-2-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710002519.5044-1-me@tobin.cc>
References: <20180710002519.5044-1-me@tobin.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we are casting an argument to the macro min_t().  This is
unnecessary since the macro already includes a cast.

Remove unnecessary cast from argument to macro min_t()

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/char/random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index d686aa2a129b..03bd13876901 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1736,7 +1736,7 @@ int __must_check get_random_bytes_arch(void *buf, int nbytes)
 	trace_get_random_bytes_arch(left, _RET_IP_);
 	while (left) {
 		unsigned long v;
-		int chunk = min_t(int, left, (int)sizeof(unsigned long));
+		int chunk = min_t(int, left, sizeof(unsigned long));
 
 		if (!arch_get_random_long(&v))
 			break;
-- 
2.17.1

