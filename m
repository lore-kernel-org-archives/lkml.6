Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405585-2-11327269663442445408
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405584; b=roMkJaKAUbyMfYh7+Pf7Eh37Mv93aVHZXeZxCWnxw2hsTMfVxd
    T+wdyeqcozRxSE1TAABtIFWkt4Kt7aFlFrvxKLWWvF58z+1DJIrm0o8rXZ0j7br6
    zbEVLTap/3lwZNn0596olf6zJvz/MOe2DHZlJNWsgZh023KJr+69tKO8+OHHDQoK
    O6er8dQ9dPNO8S9jmEn+hKos2HAFtoJq/yxsleJ6gl3DoKIBuMCVJamVX+ZlmMO1
    RFDGOln9uegiNfedWNDXK4L7Uu+YWkFUXpJXrgnnCJSPScIVAMVM0fxn/YdLDFL+
    8IyHPGiHchI3WiKerU7FJ6oWrfLSwiIdJqUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405584; bh=/6P+7WLsm4Mn8/ZVgkfROoPkanEoeN
    wXWGm3sFPLD6w=; b=FiCCcmdndNFYUZLSBIJLDsjxt49l2qoJIgSUmyZ9CD4GOr
    78/5LVGrVus1yq9jZ+xm9d08L8Z/lZ2b3y2LVS8UEmicSh1B7YTD3v2YtV/bFQnr
    C7ebbbzkhWo3nmTdy9f9NMnOl0AMxWqlsphVrwO6MEz8MbcD6ZKzkzwm80ZFkddY
    OdYwJWrBSrX1YEvdYNTmpxBtwovJNKWX3BJ1uGiKfPkc2gD4p0r02VCu5LqWRM0b
    bM1VCmBALIBnZJSDWOy1bMCGS0HS/3bkL/GyQp1iJyeyAS+u1KYTmLnv9ut0e1SR
    E8JM45iLCvobgud990fAmYQrK/08t9PQ/gCaoc7Q==
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
X-CM-Envelope: MS4wfAeIHTo1TNJHgT05y2kGZ5jvTUDHKNJ1IZ6+lNf9VCjR+JKchtjoQk26TvblU+b/Vw4AgrsCBcyUTayy29mCwZzQiMwGxUxXJU9NPHyvgTH/JLk9bCQ9
    BhF4bWGufSkSV3MQJ7YuzF7EgTBkK3q+nM07NPaqW8bE8d9TIIVhZlP6Q5bJcDIqPtk6lDwsBdICGKrXChw4BB9mDfwr33SLyJyiT07aV5SCTN2R8NHZ5UCI
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=JF9118EUAAAA:8 a=dqWlGzSaAAAA:8 a=CbDCq_QkAAAA:8
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8 a=_UIcoAmd-uVM5XpjbfMA:9
    a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=xVlTc564ipvMDusKsbsT:22
    a=zQxbTC3D8LPejNAg5Fck:22 a=1qrBK16LubpBFNPVNq2M:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754386AbeDVN7i (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:59:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46950 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754362AbeDVN7f (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:59:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        Steve Wise <swise@opengridcomputing.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.16 116/196] drivers/infiniband/core/verbs.c: fix build with gcc-4.4.4
Date: Sun, 22 Apr 2018 15:52:16 +0200
Message-Id: <20180422135110.252389476@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Morton <akpm@linux-foundation.org>

commit 6ee687735e745eafae9e6b93d1ea70bc52e7ad07 upstream.

gcc-4.4.4 has issues with initialization of anonymous unions.

drivers/infiniband/core/verbs.c: In function '__ib_drain_sq':
drivers/infiniband/core/verbs.c:2204: error: unknown field 'wr_cqe' specified in initializer
drivers/infiniband/core/verbs.c:2204: warning: initialization makes integer from pointer without a cast

Work around this.

Fixes: a1ae7d0345edd5 ("RDMA/core: Avoid that ib_drain_qp() triggers an out-of-bounds stack access")
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Steve Wise <swise@opengridcomputing.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/verbs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -2197,8 +2197,9 @@ static void __ib_drain_sq(struct ib_qp *
 	struct ib_send_wr *bad_swr;
 	struct ib_rdma_wr swr = {
 		.wr = {
+			.next = NULL,
+			{ .wr_cqe	= &sdrain.cqe, },
 			.opcode	= IB_WR_RDMA_WRITE,
-			.wr_cqe	= &sdrain.cqe,
 		},
 	};
 	int ret;
