Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E97C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9798821848
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 16:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="EhR60JPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbeLXQaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 11:30:30 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:49088 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbeLXQa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 11:30:29 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id C42BFC12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 16:30:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bqeyQb18e8w8 for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 10:30:27 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 93EE6B5E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 10:30:27 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id i12so13797733ita.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 08:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uNbUeFfSrqBQ2BTzg6nlG6ILKKMJrGz3o7ZvBgnL6lY=;
        b=EhR60JPm2IfyisT4wiCVF8GrefK2eJSXYHKiHBRf867NxS4Ganu4u5uziCvYTOlw3U
         QS+t1Z6gj7LTJSP9V5nIVpP2hQgizvzZdnLg3cg+FXLHa1ptSjam3BI64hy8irjlCFiI
         jN7ScggyOmL+vLxrhh9uVIqy1bWAO/Bdp2ncDNCkdX5rL6fhyzIxh4pVmivYqWU95g+X
         O+ryScBpBOQmZ5FYNqB1upRRZA/zoNtU1jUh0N5E5isqi9Tkeur+HPHr8jjThWuGVn0q
         wYJjPzR6ux8yDyW2GuNGBLisj5ASu+uO+UsmGbASAMBLrQhP64mmFjwLBwqN/KNlClhP
         ztdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uNbUeFfSrqBQ2BTzg6nlG6ILKKMJrGz3o7ZvBgnL6lY=;
        b=gQof96jNH+Vr9y5xqP5SPdQ0Ukj4X9pgmRUDMhX2QcOJv37D4wE62ullc4gBql2Q/G
         WaiTW62g0QlMhmIiDcn1QI6/VvUkIsIZF35MhQksREG2VGBkBXUM6p4dHtmVhPcmijCp
         oqiN4yzMhcb91eiGVh+E1rVT0DsPg7hfHYxR1xzE/1oFyiKvXyICOefu2EC2qZhmIxYI
         ueT6iOZBblyOrPQ0C2yI7jvFLZhqfxMWxPQoBiqw0kGObJxP/cPtElq+zVeTmc52bYN9
         itpm0KkfmBC/lllUe+JGMgSDQdONmttTBev8U3Ij02m/qsGjV2Swk77P9yTE/WPbCCiM
         xvmw==
X-Gm-Message-State: AA+aEWZ15BHUdv4l6AVP1JDkhy5PYJXxCsA7DLL/nYv6iKbmnN2ciySX
        NAOfIyITyUL5pW+VH+H3rAusJpm9lVxZFioAY98NYY2OJhlLqDeqts8LZvhJV0F9Yji7OrkIExX
        5CO4E9E+BPmhintS+er3OyxkujmKU
X-Received: by 2002:a24:af0a:: with SMTP id t10mr9738782ite.159.1545669027065;
        Mon, 24 Dec 2018 08:30:27 -0800 (PST)
X-Google-Smtp-Source: AFSGD/Uok4bxt2k6hzQiz2a1qed/lGbzdAZKKkuDPuglmdMVUQC4NWkL3RlE8FT8J9qcczB/C74YuQ==
X-Received: by 2002:a24:af0a:: with SMTP id t10mr9738772ite.159.1545669026814;
        Mon, 24 Dec 2018 08:30:26 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id x99sm10493792ita.23.2018.12.24.08.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 08:30:26 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6/route: Add a missing check on proc_dointvec
Date:   Mon, 24 Dec 2018 10:30:17 -0600
Message-Id: <20181224163017.17362-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While flushing the cache via  ipv6_sysctl_rtcache_flush(), the call
to proc_dointvec() may fail. The fix adds a check that returns the
error, on failure.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/ipv6/route.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 059f0531f7c1..5ccdaa27ec53 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -5053,12 +5053,16 @@ int ipv6_sysctl_rtcache_flush(struct ctl_table *ctl, int write,
 {
 	struct net *net;
 	int delay;
+	int ret;
 	if (!write)
 		return -EINVAL;
 
 	net = (struct net *)ctl->extra1;
 	delay = net->ipv6.sysctl.flush_delay;
-	proc_dointvec(ctl, write, buffer, lenp, ppos);
+	ret = proc_dointvec(ctl, write, buffer, lenp, ppos);
+	if (ret)
+		return ret;
+
 	fib6_run_gc(delay <= 0 ? 0 : (unsigned long)delay, net, delay > 0);
 	return 0;
 }
-- 
2.17.1

