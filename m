Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564DAC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36EAE208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGjrSfs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36EAE208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeJEW1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:27:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37212 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbeJEW1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:27:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id az3-v6so7007158plb.4;
        Fri, 05 Oct 2018 08:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rzjfN5bTBDD6Bh1i9hwf9Bh7Ek/R8ImIGRqKIkynJ3g=;
        b=eGjrSfs6MZJ5DrWyTOBxXI4fBKKBRdDfIhLGP77LqGsLwI5K3IBEb9AGCn4VT3wEOT
         O2hQqJn0YInpD5IKA9fFtw0eVBrzvQ+d6V+FlVQmZXn0La6qtbUfx9G+GBPOVahMpYmB
         u2TkQSOLa+r7JC3jfOSJEXia3VfCtuHyQawLY/wWuVQLslqaBE228eb/VyfskYT5iNl9
         +nN7i2025K/0Qrbj89grDRHttCpNopcG++0cmIQTGyKlG5sjG0u8vfmQ0c7tDfzfJIFP
         jUTiqtJxXj5JlSPAciGq3uaJzYRs9gqWEa1Ppz/bVDZ02Sgsve7cacp9gXLHbURYZLtS
         v/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rzjfN5bTBDD6Bh1i9hwf9Bh7Ek/R8ImIGRqKIkynJ3g=;
        b=SyJPbwgEkP9kXzudwJM9LFyzy0WmZnX9PLIDa01lAIfYmTfbO/6SdnkPwFlpwoIF7t
         wo98OgxwHIyGiN6YnlxL+eEIMUQl/SOuic6w40WHzsNDufpv6p+bF72JGvQeY6ObG3vq
         eLAs5nLPrA3Ulhf6PiU8lPsGmEK5qeVn98M0BpBjjX9pvMuh2xOcPQBIoE8W2pI11+er
         vQh6SQfAE+0Dm1KI7hXR2Ed2ZNuoui33PpGsPnnTnru67R0GfRmxNQSwV/QMmMKpDeb9
         GLuJUzY6735Y7d2T+ppWeX+6spsfpQk+UzSuCoCxDy7ILxcEBe+eGltGfcLDfG6J15pB
         ELsg==
X-Gm-Message-State: ABuFfoiyMEL6iBSONxK940u+ESoRF8WlV+CkVGGcfS7Re6Fyr2myhKqw
        eYEEhx0BJ4VIFuXWI4ovu2g=
X-Google-Smtp-Source: ACcGV60loImV6ql/Tk+3BM+HYBqfUcJL1+skMfXv7o9r1i24SBjQbnHPR/3C0grRTB58vGTaJymR3w==
X-Received: by 2002:a17:902:7b83:: with SMTP id w3-v6mr12248043pll.285.1538753271271;
        Fri, 05 Oct 2018 08:27:51 -0700 (PDT)
Received: from debian ([27.62.30.14])
        by smtp.gmail.com with ESMTPSA id o76-v6sm10775658pfi.162.2018.10.05.08.27.50
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 08:27:50 -0700 (PDT)
Date:   Fri, 5 Oct 2018 20:57:48 +0530
From:   Shanthosh RK <shanthosh.rk@gmail.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net
Subject: [PATCH net] net: bpfilter: Fix type cast and pointer warnings
Message-ID: <20181005152748.gotzlu2lcvkeoogb@debian.domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following Sparse warnings:

net/bpfilter/bpfilter_kern.c:62:21: warning: cast removes address space
of expression
net/bpfilter/bpfilter_kern.c:101:49: warning: Using plain integer as
NULL pointer

Signed-off-by: Shanthosh RK <shanthosh.rk@gmail.com>
---
 net/bpfilter/bpfilter_kern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index f0fc182d3db7..b64e1649993b 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -59,7 +59,7 @@ static int __bpfilter_process_sockopt(struct sock *sk, int optname,
 	req.is_set = is_set;
 	req.pid = current->pid;
 	req.cmd = optname;
-	req.addr = (long)optval;
+	req.addr = (long __force __user)optval;
 	req.len = optlen;
 	mutex_lock(&bpfilter_lock);
 	if (!info.pid)
@@ -98,7 +98,7 @@ static int __init load_umh(void)
 	pr_info("Loaded bpfilter_umh pid %d\n", info.pid);
 
 	/* health check that usermode process started correctly */
-	if (__bpfilter_process_sockopt(NULL, 0, 0, 0, 0) != 0) {
+	if (__bpfilter_process_sockopt(NULL, 0, NULL, 0, 0) != 0) {
 		stop_umh();
 		return -EFAULT;
 	}
-- 
2.11.0

