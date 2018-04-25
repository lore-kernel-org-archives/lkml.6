Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-558212-1524653800-2-11581236009199337070
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653799; b=tGiMZxQOZhQWLBTX3ZGTsWCpyPrcpVEwZlLNBJSHxYROmzY8r8
    rMluJhZWr0jcYiHJE7DpNjPpItJkm8QmLiBYYF14hKUF6CL71nQ3NqUmllWjbnEH
    dAI3EAG88pW4Pgcwg4//tBqHhIqpF4JrKd1S5RBBCuk6Ux316KAM6fZ5L5CI2Ndv
    js2Z+7wIfRyaJQuP3jq299hbz2KSyGpj0ylvafURmILRKU1nj+KpVXx+qrp1R3LH
    2+QLuRsXR7VHI/wMHfqQHVuLlHuXJC9Ep4W4ljlPohL/DeWd24X6+YH5BJ3CnPZa
    EE2QwKHVofLVX0AGuBKK2XrinOK0gSxf0myg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653799; bh=ThT/87tuWdmG9X0OvXBzGGtb+A1TqC
    iJz777DjkUg24=; b=CpHvvx6WYkPzLo04azfxfCbhQLLkC31FAZMTSmFN3LVCzy
    sR0yQQgr+Bsziq1Nv4CkLqJswiGP0T7rV24cYMT4RUuqm3M3Uciyer6fy+XJsyYV
    mYB5Fuy+3vSmz4xyt4vEbv1n61zFDq7kvy8OqximJmdNQlCZ22glywNpzni41sHY
    JSxQ0l5HJHQ23L41Mg5R/vb+C0fyWnUw8Qf41b0gT3AVSN4+jVsfm6dmL6Qhw6ET
    4j+qdi2l1njYBcDK06Zr91XbwtZrmumv285mNnU2+ADTRCVq6dAbhi1zIdsTZNRq
    Z46jSvCcQTT6dE0mPMVsd8U7LbrQ9ur5D6eR9MIA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfNtLemeJVbJQFm/WEyv128ZmqSiQrxhMojt8OTIChzg8j8cOaB3z7rXxQxCtSggRBHv8/q7YNY/6ETmpURgOcxoi6EB+GEmDcLMQIudq4av9a7ITzdCe
    3WENUCxKGByugrOAl60SPmbihWnuTpyRMklbufkxxnW7pwKnI1TtQkHnbLSn/zsNUCBsAqxHGBzs+DD3gmolhwP9lVhemEUIoI4R1aBYM0Sqe2a3ue1JEv0F
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=CbDCq_QkAAAA:8 a=20KFwNOVAAAA:8 a=J1Y8HTJGAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=EePCTitOv4r-aG-WyjYA:9
    a=DDakg8MTcSrILi8y:21 a=qNgExSQH1o6pFfiA:21 a=QEXdDO2ut3YA:10
    a=1qrBK16LubpBFNPVNq2M:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754041AbeDYKnM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:43:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52844 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754178AbeDYKnI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:43:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guanglei Li <guanglei.li@oracle.com>,
        Honglei Wang <honglei.wang@oracle.com>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Yanjun Zhu <yanjun.zhu@oracle.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 142/183] RDS: IB: Fix null pointer issue
Date: Wed, 25 Apr 2018 12:36:02 +0200
Message-Id: <20180425103248.257601277@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guanglei Li <guanglei.li@oracle.com>


[ Upstream commit 2c0aa08631b86a4678dbc93b9caa5248014b4458 ]

Scenario:
1. Port down and do fail over
2. Ap do rds_bind syscall

PID: 47039  TASK: ffff89887e2fe640  CPU: 47  COMMAND: "kworker/u:6"
 #0 [ffff898e35f159f0] machine_kexec at ffffffff8103abf9
 #1 [ffff898e35f15a60] crash_kexec at ffffffff810b96e3
 #2 [ffff898e35f15b30] oops_end at ffffffff8150f518
 #3 [ffff898e35f15b60] no_context at ffffffff8104854c
 #4 [ffff898e35f15ba0] __bad_area_nosemaphore at ffffffff81048675
 #5 [ffff898e35f15bf0] bad_area_nosemaphore at ffffffff810487d3
 #6 [ffff898e35f15c00] do_page_fault at ffffffff815120b8
 #7 [ffff898e35f15d10] page_fault at ffffffff8150ea95
    [exception RIP: unknown or invalid address]
    RIP: 0000000000000000  RSP: ffff898e35f15dc8  RFLAGS: 00010282
    RAX: 00000000fffffffe  RBX: ffff889b77f6fc00  RCX:ffffffff81c99d88
    RDX: 0000000000000000  RSI: ffff896019ee08e8  RDI:ffff889b77f6fc00
    RBP: ffff898e35f15df0   R8: ffff896019ee08c8  R9:0000000000000000
    R10: 0000000000000400  R11: 0000000000000000  R12:ffff896019ee08c0
    R13: ffff889b77f6fe68  R14: ffffffff81c99d80  R15: ffffffffa022a1e0
    ORIG_RAX: ffffffffffffffff  CS: 0010 SS: 0018
 #8 [ffff898e35f15dc8] cma_ndev_work_handler at ffffffffa022a228 [rdma_cm]
 #9 [ffff898e35f15df8] process_one_work at ffffffff8108a7c6
 #10 [ffff898e35f15e58] worker_thread at ffffffff8108bda0
 #11 [ffff898e35f15ee8] kthread at ffffffff81090fe6

PID: 45659  TASK: ffff880d313d2500  CPU: 31  COMMAND: "oracle_45659_ap"
 #0 [ffff881024ccfc98] __schedule at ffffffff8150bac4
 #1 [ffff881024ccfd40] schedule at ffffffff8150c2cf
 #2 [ffff881024ccfd50] __mutex_lock_slowpath at ffffffff8150cee7
 #3 [ffff881024ccfdc0] mutex_lock at ffffffff8150cdeb
 #4 [ffff881024ccfde0] rdma_destroy_id at ffffffffa022a027 [rdma_cm]
 #5 [ffff881024ccfe10] rds_ib_laddr_check at ffffffffa0357857 [rds_rdma]
 #6 [ffff881024ccfe50] rds_trans_get_preferred at ffffffffa0324c2a [rds]
 #7 [ffff881024ccfe80] rds_bind at ffffffffa031d690 [rds]
 #8 [ffff881024ccfeb0] sys_bind at ffffffff8142a670

PID: 45659                          PID: 47039
rds_ib_laddr_check
  /* create id_priv with a null event_handler */
  rdma_create_id
  rdma_bind_addr
    cma_acquire_dev
      /* add id_priv to cma_dev->id_list */
      cma_attach_to_dev
                                    cma_ndev_work_handler
                                      /* event_hanlder is null */
                                      id_priv->id.event_handler

Signed-off-by: Guanglei Li <guanglei.li@oracle.com>
Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
Reviewed-by: Junxiao Bi <junxiao.bi@oracle.com>
Reviewed-by: Yanjun Zhu <yanjun.zhu@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Acked-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rds/ib.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/rds/ib.c
+++ b/net/rds/ib.c
@@ -346,7 +346,8 @@ static int rds_ib_laddr_check(struct net
 	/* Create a CMA ID and try to bind it. This catches both
 	 * IB and iWARP capable NICs.
 	 */
-	cm_id = rdma_create_id(&init_net, NULL, NULL, RDMA_PS_TCP, IB_QPT_RC);
+	cm_id = rdma_create_id(&init_net, rds_rdma_cm_event_handler,
+			       NULL, RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(cm_id))
 		return PTR_ERR(cm_id);
 
