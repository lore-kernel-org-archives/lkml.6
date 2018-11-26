Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26200C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DF52089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="h22Gf0Z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DF52089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbeKZVvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:51:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeKZVvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:51:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7880721104;
        Mon, 26 Nov 2018 10:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229854;
        bh=fGJlNs97dD1s4gO+Oc2LEBYtEXEMDKPFXjJLEAtGydw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h22Gf0Z5LWWzWZ9mQKL7y13QT5wjtFHweqSn6RWkRMp9B0F7FLO7HW4PbGPwixU6z
         AF+d1VbFtTqBJFp3AOXrOz293LIyBRxFOGW/bEdO+scr2Ry0ad+d+cqZl+HfTVAkIl
         qVnKhC8+4u/Z9BdLcl72+iwG1T9CUecIIozlv1wE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 26/46] SUNRPC: drop pointless static qualifier in xdr_get_next_encode_buffer()
Date:   Mon, 26 Nov 2018 11:51:15 +0100
Message-Id: <20181126105048.654017055@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 025911a5f4e36955498ed50806ad1b02f0f76288 ]

There is no need to have the '__be32 *p' variable static since new value
always be assigned before use it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xdr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 1b38fc486351..69846c6574ef 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -512,7 +512,7 @@ EXPORT_SYMBOL_GPL(xdr_commit_encode);
 static __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
 		size_t nbytes)
 {
-	static __be32 *p;
+	__be32 *p;
 	int space_left;
 	int frag1bytes, frag2bytes;
 
-- 
2.17.1



