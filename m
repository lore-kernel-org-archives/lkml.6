Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69229C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BF920661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107577;
	bh=biqZa9E7+DYMNiPbZUwNpVukGDZcWsU6eSLkRLloIAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ew1n6Y40wb9kiVtIGMCt97/7BBrTCb+uwSkRrpBOz2/A4rJD5pa0vuQvK0r/m/Z+b
	 bPTR/vdsCmvOL6tZdnCJ8Assv4dReu2HTPpev3/TCCiNYcdfIs30gvjOvVK0yqXcvE
	 MIye7YXB1pUgMenDgrA0sVfnYgs2R5RLahXroPAo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30BF920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbeLFOqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:46:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731209AbeLFOqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 717832082B;
        Thu,  6 Dec 2018 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107570;
        bh=biqZa9E7+DYMNiPbZUwNpVukGDZcWsU6eSLkRLloIAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jPfSVOlSr4xx4cyEPVwPfFyHdDbd9oJoJYyD8wh89DxlBQABtyKXFwmzz/ctslTRS
         UjWQ/9WhUVbwa6K+WYC1f9k/P0NGMnxCwuU21DZD7HV4e1YqVAY4o4iz/h1CgnApbb
         zjYeVY457Xar9m0JimMW0rlWQddUqk6ELslkUQ/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Sage Weil <sage@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 056/101] libceph: weaken sizeof check in ceph_x_verify_authorizer_reply()
Date:   Thu,  6 Dec 2018 15:38:55 +0100
Message-Id: <20181206143014.801941330@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit f1d10e04637924f2b00a0fecdd2ca4565f5cfc3f upstream.

Allow for extending ceph_x_authorize_reply in the future.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Sage Weil <sage@redhat.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/auth_x.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -733,8 +733,10 @@ static int ceph_x_verify_authorizer_repl
 	ret = ceph_x_decrypt(&au->session_key, &p, p + CEPHX_AU_ENC_BUF_LEN);
 	if (ret < 0)
 		return ret;
-	if (ret != sizeof(*reply))
-		return -EPERM;
+	if (ret < sizeof(*reply)) {
+		pr_err("bad size %d for ceph_x_authorize_reply\n", ret);
+		return -EINVAL;
+	}
 
 	if (au->nonce + 1 != le64_to_cpu(reply->nonce_plus_one))
 		ret = -EPERM;


