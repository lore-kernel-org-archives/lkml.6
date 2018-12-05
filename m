Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A95C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AAA214F1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ1Jmuoj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AAA214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbeLEJxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:53:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:60088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727700AbeLEJxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:53:30 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79A8A20989;
        Wed,  5 Dec 2018 09:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003609;
        bh=Di3/nT3zB/O77ocqYzOgoB6uHS8ykZIOQPiURKuH/bE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NQ1JmuojuRvgj+/q7dp4rYqGPcVtwLYpQClLd1FGdjlPZbbf5cPShgldWFkQslszC
         0+GnKAAYnS7kPooM1zw9dDnReYt/3QNQ8chz8zYyNI/mk32HXnvcVPUnFUyPFzjGhn
         Elz+VpbdqEk0RRjpEKp/EdzYALQRPV37T/941MqE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yi Wang <wang.yi59@zte.com.cn>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 18/33] KVM: x86: fix empty-body warnings
Date:   Wed,  5 Dec 2018 04:51:16 -0500
Message-Id: <20181205095131.7685-18-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095131.7685-1-sashal@kernel.org>
References: <20181205095131.7685-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Wang <wang.yi59@zte.com.cn>

[ Upstream commit 354cb410d87314e2eda344feea84809e4261570a ]

We get the following warnings about empty statements when building
with 'W=1':

arch/x86/kvm/lapic.c:632:53: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
arch/x86/kvm/lapic.c:1907:42: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
arch/x86/kvm/lapic.c:1936:65: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
arch/x86/kvm/lapic.c:1975:44: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

Rework the debug helper macro to get rid of these warnings.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/lapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index a1afd80a68aa..3c70f6c76d3a 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -56,7 +56,7 @@
 #define APIC_BUS_CYCLE_NS 1
 
 /* #define apic_debug(fmt,arg...) printk(KERN_WARNING fmt,##arg) */
-#define apic_debug(fmt, arg...)
+#define apic_debug(fmt, arg...) do {} while (0)
 
 #define APIC_LVT_NUM			6
 /* 14 is the version for Xeon and Pentium 8.4.8*/
-- 
2.17.1

