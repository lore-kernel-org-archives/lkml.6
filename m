Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523472636-2-12853199525071752675
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, URIBL_SBL 1.623, URIBL_SBL_A 0.1,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523472636; b=o0FZyLVmFISY8qIKabTc0eUD0a0E+f78Aig1MkEOZQZ+/tpwfs
    pDJOJj6P6VF8le25tLh3hG0MP8wM1VGaWAr1JuslVDbaXU4vJEQ0nDEXJZFof2Ka
    bh6UzD98Rze7XjzHij72Yc4uAHbHvsoJbny/L4ImAQmYGckEDjpwacyaNl8O03cX
    bTF1PmGVHc7N/ZD4e8Mjo+Oe8lZizg6zeqnp88Q6MqDuk4V05FlkAx82LX26wlfE
    npPlVkR1bFymGdySx+rur432kM3sINDyz3pWkHQifcTsx0l+WHcDdoKBVQAmP+sD
    0Inbxmld5fjtBRPmj6Ix90eGbA4/c9YploFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472636; bh=j9jtOQtAjy3341dblWU2MyLDbC9eis
    NiLVe5EUyzga4=; b=coc8xYjDaJLUqPW4lIv91km9FVjnHZsUggx98Jv9UEsVze
    o010JAbAnNaZM4v5RgisQzzZNPfhoAC7H0sNVa8jGca0Buj7JziE+GojtgMfVPkH
    47QSQQEnMjghUNfYC7l2/amJqS1Q6FrOVZh7LI0t2lhti1QtxF2/Youlok0Gxhmd
    2i5bjRpn0JlX74T0EveyUiuBpOw9jpp83JxyQCgJQg55MDgdTqGIs8lmiyTFqT1r
    w4p1MsgUl+JYC8FQ/JnN+OEcnEzrlPkg9LXhHCthacanBUgrPWWKT++ksT6AXNTx
    qQklY4+eGqMATp0bt9AeiEOEMNDh+bZ7JhNZhSGQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLGXFEpqXlpUszrAzt/gYbUA5d2AYWvmirh8NtSgRsB1YhTycDbsoM8Ig32rJqQbD3zwWr/KSi+6Pqvh8+Mm/fVC9m/hwmtJc/XIh+GXSkeUEajsC5/8
    +luiTid0J/iUQ6npQR1FSSaVl1acnW9JY/mtDJOeSwYEwm2IyJY9iau0rrD9HG2hzH8M+K4YduILBcMjfhtd6o1fbTQ4Cn2gnkhpZssYusHnXeKnG4I/mmxu
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1RTuLK3dAAAA:8 a=uTJJjIG0AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=Acn1Ri8CFVpV9zlsrzkA:9 a=QEXdDO2ut3YA:10 a=kRpfLKi8w9umh8uBmg1i:22
    a=Oxz5h5Y_mNNx07kSEfs-:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbeDKSuQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:50:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60704 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932599AbeDKSuN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:50:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tang Junhui <tang.junhui@zte.com.cn>,
        Michael Lyle <mlyle@lyle.org>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 149/190] bcache: stop writeback thread after detaching
Date: Wed, 11 Apr 2018 20:36:35 +0200
Message-Id: <20180411183601.340539326@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tang Junhui <tang.junhui@zte.com.cn>


[ Upstream commit 8d29c4426b9f8afaccf28de414fde8a722b35fdf ]

Currently, when a cached device detaching from cache, writeback thread is
not stopped, and writeback_rate_update work is not canceled. For example,
after the following command:
echo 1 >/sys/block/sdb/bcache/detach
you can still see the writeback thread. Then you attach the device to the
cache again, bcache will create another writeback thread, for example,
after below command:
echo  ba0fb5cd-658a-4533-9806-6ce166d883b9 > /sys/block/sdb/bcache/attach
then you will see 2 writeback threads.
This patch stops writeback thread and cancels writeback_rate_update work
when cached device detaching from cache.

Compare with patch v1, this v2 patch moves code down into the register
lock for safety in case of any future changes as Coly and Mike suggested.

[edit by mlyle: commit log spelling/formatting]

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/super.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -890,6 +890,12 @@ static void cached_dev_detach_finish(str
 
 	mutex_lock(&bch_register_lock);
 
+	cancel_delayed_work_sync(&dc->writeback_rate_update);
+	if (!IS_ERR_OR_NULL(dc->writeback_thread)) {
+		kthread_stop(dc->writeback_thread);
+		dc->writeback_thread = NULL;
+	}
+
 	memset(&dc->sb.set_uuid, 0, 16);
 	SET_BDEV_STATE(&dc->sb, BDEV_STATE_NONE);
 
