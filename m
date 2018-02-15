Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2241641-1518720410-2-14568679442867393989
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720409; b=Tl/5tJVeVHOBtoKMjZFf4dyVdZRev7f7oDTBT9jH1pthG6s
    3PBMjGwLSQtWHceEILXFFXc0jBlimG9sDlQrUNtZZuloxDYE5dos4zltEYlOHGTS
    ETvHboqgyfMhrJChz/1qY2hfLgw65WBrevfhWCfZVLwxVglDATCXfffO1PofzX9F
    4L+PFx1ETO0BA/4RaieH1xfO2YN/WE1WoGPjOiyDPu+wZ64gAEh/mg+h7Rk23DBe
    WYTuUO4Is+H1I++sDM9ZtYcWoc22rRH9fMutx/MP4SqM4ADapeoVdeqdieHn6fQI
    LimxzskJ/85/2W/zZgq1mG5Jv9qwn+kDU7FcigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720409; bh=2+7gX1VjT01cU+crkoxF/Xf/Iv
    qrrpm1pD62+KrHBEs=; b=dzIkmgdDUKqu7uxUc8Mj4XMKM67KhaLNnezVLG2DBn
    du5o2b2Ki4aTHEWnvSq7DXuYy/JelLiCqyWHTOdEKTusBhBYJL1XfWMsCr930NCK
    xwdpFm3vguCwyY3pnVVO0mkfNFXfCkztJ+JTI7kFRbLlWlpjw1BRUCxpjCvKDZJs
    pJgEs1cpdf+t6BHHIrPY4z6T+EGnrirTlHl6mbRH9bRxKTac5AAGUlpBmlGBGSNw
    PXHq/+wqTldfqk3rdi0LfTdNAVs1kSKBAHkmnsHM0s5rtBXt/R5rfEQh/Ob5Q1VM
    NFliASQmjEVqywTGoomkisCZUbYbI+084MJbHYLs5DAA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162397AbeBOSqp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:46:45 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162398AbeBOPWY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:22:24 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yang Shunyong <shunyong.yang@hxt-semitech.com>,
        Adam Wallis <awallis@codeaurora.org>,
        Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4.4 043/108] dmaengine: dmatest: fix container_of member in dmatest_callback
Date: Thu, 15 Feb 2018 16:16:40 +0100
Message-Id: <20180215151228.442042794@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Shunyong <shunyong.yang@hxt-semitech.com>

commit 66b3bd2356e0a1531c71a3dcf96944621e25c17c upstream.

The type of arg passed to dmatest_callback is struct dmatest_done.
It refers to test_done in struct dmatest_thread, not done_wait.

Fixes: 6f6a23a213be ("dmaengine: dmatest: move callback wait ...")
Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>
Acked-by: Adam Wallis <awallis@codeaurora.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/dmatest.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -329,7 +329,7 @@ static void dmatest_callback(void *arg)
 {
 	struct dmatest_done *done = arg;
 	struct dmatest_thread *thread =
-		container_of(arg, struct dmatest_thread, done_wait);
+		container_of(done, struct dmatest_thread, test_done);
 	if (!thread->done) {
 		done->done = true;
 		wake_up_all(done->wait);
