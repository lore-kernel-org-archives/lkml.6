Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39013C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E972320818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHzAiQLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E972320818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbeKJDpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:45:52 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34340 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbeKJDpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:45:52 -0500
Received: by mail-lf1-f67.google.com with SMTP id p6so1980533lfc.1;
        Fri, 09 Nov 2018 10:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GGnEbAyK9auWmqFi1Z/x8rfbh8Ox4v9vUS53BOpSnr4=;
        b=iHzAiQLRYPp/fS6n7xyMDS5BwL3tXeJsRAuAXahfgrgva+syi/aPTUoLas6zWAsc0u
         FRZknBiLvqspM7wwIV0hqjPaA9fnR5lFt7c0Of5Rnz+iHW3Bp7gC3umNrpbNtyQXrjgB
         WynZZwH0+fOTNe+pYToS6LSQdXFsF4sygDUOr+xql1HdiSQCx2XHpewjg54VpTj9qt8N
         fV3nuj+JAH5kpB/NBExSfsTwNwqxReHWmsA2RsYRIrrD0H8ZfDG7U4flTcv00exIs41K
         ZztBICWdRmehsJJ3QNGV/3OE56bEj0IpltiNbysWjXYpIgEJz9JQ55f+0DBzTO+QGARQ
         fVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GGnEbAyK9auWmqFi1Z/x8rfbh8Ox4v9vUS53BOpSnr4=;
        b=OqSaiLzcATbX/eNj9eNUe9QNUcefB8R1QbBwbC2FW/r4EcoF/38n1UUCfZy2RQScqZ
         TeiHCw+ZJXgkIATJ1rt202M54bRIse5jdllo4z8P38w965oH/ZZ3TgBjEUFX+moedGsc
         5t9u/9l9Hb+hLvLz4pG8l22VHOlVRRQiUSq9MsBpkwK03ZLjKLjxs5Yzvql4X5cHJLOK
         /Y/DuW8yS8fYf+D3hFBkgRxBWENu04MFFSWXOvRUliq0Gz4Q+09DAwNpcjrByCUxCJHw
         Rh1ZAR6eeNJThR0BS8gXWi8pmSl0RCykMQ9GHy19U+vKJLFFRfYmbsdu7Zgots1EgZV7
         9kFg==
X-Gm-Message-State: AGRZ1gLSYhfYWweY1o4EGXssyrConqsT1EqGT3BBp3OJff+E8ikTvCE4
        R1UDbm6SU7iLy5WK5Iz9RSg=
X-Google-Smtp-Source: AJdET5fK/Z9Zsc/CAzGa+vMSa/J3h63OYXNFDZ/QEwLxQtprlA1F6LgGlZfm5leLODJDep5kenfQOw==
X-Received: by 2002:a19:2395:: with SMTP id j143mr5784568lfj.107.1541786649158;
        Fri, 09 Nov 2018 10:04:09 -0800 (PST)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id v64sm1482467lfa.48.2018.11.09.10.04.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 10:04:08 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id C414A4608DB; Fri,  9 Nov 2018 21:04:07 +0300 (MSK)
Date:   Fri, 9 Nov 2018 21:04:07 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] proc: fix and merge proc-self-map-file tests
Message-ID: <20181109180407.GO13195@uranus.lan>
References: <20181108111105.GC13195@uranus.lan>
 <20181109113036.21512-1-rafael.tinoco@linaro.org>
 <20181109114123.GK13195@uranus.lan>
 <1541763936.3280758.1571224480.76F1EF1C@webmail.messagingengine.com>
 <20181109114850.GL13195@uranus.lan>
 <1541764873.3286172.1571234624.727F6284@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541764873.3286172.1571234624.727F6284@webmail.messagingengine.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:01:13AM -0200, Rafael David Tinoco wrote:
> 
> Alright, I'm fixing membarrier_test before, so.. I guess we have a competition.. =o)

Rafael, Alexey, what about simply wrap the test code with x86 and extend later
with all archs which support zero address mapping?
---
 tools/testing/selftests/proc/proc-self-map-files-002.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

Index: linux-ml.git/tools/testing/selftests/proc/proc-self-map-files-002.c
===================================================================
--- linux-ml.git.orig/tools/testing/selftests/proc/proc-self-map-files-002.c
+++ linux-ml.git/tools/testing/selftests/proc/proc-self-map-files-002.c
@@ -23,6 +23,11 @@
 #include <sys/mman.h>
 #include <stdlib.h>
 
+/*
+ * Should run on archs which support zero address mapping.
+ */
+#if defined(__i386) || defined(__x86_64)
+
 static void pass(const char *fmt, unsigned long a, unsigned long b)
 {
 	char name[64];
@@ -83,3 +88,12 @@ int main(void)
 
 	return 0;
 }
+
+#else
+
+int main(void)
+{
+	return 0;
+}
+
+#endif
