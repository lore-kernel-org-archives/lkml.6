Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E18C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607B221527
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OG94iasw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607B221527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbeKVFnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbeKVFnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:43:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDAB0214F1;
        Wed, 21 Nov 2018 19:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827263;
        bh=xzqoUaIjuvpq7jxQMbf49PmwFpRJH+vpStbHDyPthQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OG94iasw0ejBzk6z3XmdKqtMGFrA5PuBcf3fbYySJFOxZXsCafGktkw+na3AsAWUD
         MQdlrTOowktYVy7qfqsbGp1G0a2tbwWeniYE718wxpw0NerJL43fgsx4eIOFMgGrLK
         DSV44L++Pt1iy0QnWBaonLF0dYnlMJb0fzXgGe20=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianwen Ji <jiji@redhat.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 35/42] sctp: fix strchange_flags name for Stream Change Event
Date:   Wed, 21 Nov 2018 20:06:11 +0100
Message-Id: <20181121183149.483112966@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit fd82d61ba142f0b83463e47064bf5460aac57b6e ]

As defined in rfc6525#section-6.1.3, SCTP_STREAM_CHANGE_DENIED
and SCTP_STREAM_CHANGE_FAILED should be used instead of
SCTP_ASSOC_CHANGE_DENIED and SCTP_ASSOC_CHANGE_FAILED.

To keep the compatibility, fix it by adding two macros.

Fixes: b444153fb5a6 ("sctp: add support for generating add stream change event notification")
Reported-by: Jianwen Ji <jiji@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/sctp.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/include/uapi/linux/sctp.h
+++ b/include/uapi/linux/sctp.h
@@ -568,6 +568,8 @@ struct sctp_assoc_reset_event {
 
 #define SCTP_ASSOC_CHANGE_DENIED	0x0004
 #define SCTP_ASSOC_CHANGE_FAILED	0x0008
+#define SCTP_STREAM_CHANGE_DENIED	SCTP_ASSOC_CHANGE_DENIED
+#define SCTP_STREAM_CHANGE_FAILED	SCTP_ASSOC_CHANGE_FAILED
 struct sctp_stream_change_event {
 	__u16 strchange_type;
 	__u16 strchange_flags;


