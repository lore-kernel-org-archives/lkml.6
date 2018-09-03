Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C7FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992112077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 992112077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbeICV4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:56:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48028 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbeICV4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:56:49 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CBF3DD24;
        Mon,  3 Sep 2018 17:35:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Joe Perches <joe@perches.com>, Rob Herring <robh@kernel.org>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH 4.18 065/123] lib/vsprintf: Do not handle %pO[^F] as %px
Date:   Mon,  3 Sep 2018 18:56:49 +0200
Message-Id: <20180903165722.191405615@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 554ec508653688c21d9b8024af73a1ffaa0164b9 upstream.

This patch avoids that gcc reports the following when building with W=1:

lib/vsprintf.c:1941:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   switch (fmt[1]) {
   ^~~~~~

Fixes: 7b1924a1d930eb2 ("vsprintf: add printk specifier %px")
Link: http://lkml.kernel.org/r/20180806223421.11995-1-bart.vanassche@wdc.com
Cc: linux-kernel@vger.kernel.org
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Joe Perches <joe@perches.com>
Cc: Rob Herring <robh@kernel.org>
Cc: v4.15+ <stable@vger.kernel.org>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/vsprintf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1942,6 +1942,7 @@ char *pointer(const char *fmt, char *buf
 		case 'F':
 			return device_node_string(buf, end, ptr, spec, fmt + 1);
 		}
+		break;
 	case 'x':
 		return pointer_string(buf, end, ptr, spec);
 	}


