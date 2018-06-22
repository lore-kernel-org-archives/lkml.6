Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5F3C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B37523F26
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlNxpRNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B37523F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbeFVIoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:44:17 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39535 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeFVIoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:44:15 -0400
Received: by mail-wr0-f194.google.com with SMTP id b8-v6so417063wro.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=J4Ogy9Jp31n1iXG0Ya7/ZX+Pe48ZmetxozJW2yN2yqk=;
        b=JlNxpRNH+6BgYgE985WhQrxSubNdtt3gdRG0bmirJn6x3hdEOmmP9G+0RXyOefEt9F
         0HK5q4L2mJk0GJUcIEFEOLDvt8WSB6Yc6mDU4GbcgH9zI66FDwv2HCkVT80024I9I4Dp
         meFJeLa3vwxEmcQA/bSyTXqr6UlzJ+E2Ho/RauAFFcfYnB6udN0PZ/mDOhvrXvmY2/+W
         thqFOUGNISi9ZT/e54hlbqJPjpl2nIITWW1NjkH+oP3SMJdkUc9X2Wo6ySpj9ZdXxRo8
         PMSwa8vXOgDyLS//aZs24tXRNMTYHeC4OXooTg1y/dAaFAX/8ORqxMDRo5PhZee+jhzF
         YEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=J4Ogy9Jp31n1iXG0Ya7/ZX+Pe48ZmetxozJW2yN2yqk=;
        b=EYpz9NWRYZ0CWimOQdCFynF18IzLPFzcv0jnkJoi2MGu6bn0fgTtL3jz9Hm6tVzVuc
         58Zsshp5HuUQ8AXt3ZmDO3TRAe6nlKb1GIvBpLbzgJ2aPceA/ckCgj/e9QffT7y3O2Er
         pzMTX0FPFNAcx1WTXjsuOl+RcuAHoBfc0OzfjLfQrKYcFoNX12U1JhrwK3UCB6ZpS244
         lnQ8/Brm29AWgq0oWI3y7ppNsTwfdPim0li2EGksvmq4wMMydOQDPtq2zvCUDg7DZ1VW
         krxwvCNBeYYWeaP/JWSeodYqljFpunfAh+VeG9HK5TlSMuiwC8gbKhoiTdaPFhilR5tJ
         BSQA==
X-Gm-Message-State: APt69E2K0dTe8eP5SeHbyvyCwM+SqQjbwIsKsdkf2hqu0JyLUMnrNdiS
        70rvKhVxtXYHNm5tTsH6mA==
X-Google-Smtp-Source: ADUXVKLqVoJEb97ATNOmXkRJ9KRXEyLGKFEjLGql+bFAVru3SWcnhE5zH/f04POlGvkXucl1NRTy6g==
X-Received: by 2002:adf:ec89:: with SMTP id z9-v6mr818659wrn.160.1529657054585;
        Fri, 22 Jun 2018 01:44:14 -0700 (PDT)
Received: from sesnaco ([196.43.135.103])
        by smtp.gmail.com with ESMTPSA id f17-v6sm3552275wmc.2.2018.06.22.01.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 01:44:14 -0700 (PDT)
Date:   Fri, 22 Jun 2018 11:44:00 +0300
From:   Mawanda Henry <mawandahenrynaco@gmail.com>
To:     mawanda111@gmail.com
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        marc.zyngier@arm.com, tglx@linutronix.de, punit.agrawal@arm.com,
        peterz@infradead.org, arnd@arndb.de, robin.murphy@arm.com
Subject: [PATCH 2/4] drivers/bus: arm-cci: trailing white spaces
Message-ID: <20180622084400.GA9408@sesnaco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Erase white spaces to ease code readability and review

used: checkpatch.pl

Signed-off-by: Mawanda Henry <mawandahenrynaco@gmail.com>
---
 drivers/bus/arm-cci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index 74a2e0a..ab04201 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -235,8 +235,7 @@ static void notrace cci_port_control(unsigned int port, bool enable)
 	 * read loop to optimize power, since it might hide possibly
 	 * disruptive operations.
 	 */
-	while (readl_relaxed(cci_ctrl_base + CCI_CTRL_STATUS) & 0x1)
-			;
+	while (readl_relaxed(cci_ctrl_base + CCI_CTRL_STATUS) & 0x1);
 }
 
 /**
@@ -259,6 +258,7 @@ int notrace cci_disable_port_by_cpu(u64 mpidr)
 	int cpu;
 	bool is_valid;
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
+
 		is_valid = cpu_port_is_valid(&cpu_port[cpu]);
 		if (is_valid && cpu_port_match(&cpu_port[cpu], mpidr)) {
 			cci_port_control(cpu_port[cpu].port, false);
-- 
2.7.4

