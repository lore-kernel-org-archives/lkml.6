Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17592C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DC62087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWqXFMFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DC62087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbeJICAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbeJICAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:00:51 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9C2121479;
        Mon,  8 Oct 2018 18:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024464;
        bh=uvOq+f2qzFX1323DWiIvuvx9MkFv1TvdEkkWOe/vAx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWqXFMFB/OO2+eFyHxkVOre/YxhcXg8r0o7JsaZQoGN1Eo0e2+/vMQ/wwTH6Ku7i8
         KNV+bgvdGM3sFJKeFJZ1lGf7noY21LZJC3BhU1EmgCINwBuflh1Ww+Oin9raFdt3VX
         CZ0+S3nKxNxMkrM32QaillffMw6J9XZ4DIISM6Xo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 048/168] selftests: pmtu: maximum MTU for vti4 is 2^16-1-20
Date:   Mon,  8 Oct 2018 20:30:28 +0200
Message-Id: <20181008175621.882912284@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 902b5417f28d955cdb4898df6ffaab15f56c5cff ]

Since commit 82612de1c98e ("ip_tunnel: restore binding to ifaces with a
large mtu"), the maximum MTU for vti4 is based on IP_MAX_MTU instead of
the mysterious constant 0xFFF8.  This makes this selftest fail.

Fixes: 82612de1c98e ("ip_tunnel: restore binding to ifaces with a large mtu")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Acked-by: Stefano Brivio <sbrivio@redhat.com>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/pmtu.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -334,7 +334,7 @@ test_pmtu_vti4_link_add_mtu() {
 	fail=0
 
 	min=68
-	max=$((65528 - 20))
+	max=$((65535 - 20))
 	# Check invalid values first
 	for v in $((min - 1)) $((max + 1)); do
 		${ns_a} ip link add vti4_a mtu ${v} type vti local ${veth4_a_addr} remote ${veth4_b_addr} key 10 2>/dev/null


