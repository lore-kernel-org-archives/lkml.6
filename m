Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477877-2-14429256951240266335
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
    1523477877; b=G6IpwzcqagUlpft8p7tqYaGL2vcKzzWcWbWmb/U+71mgcrBpcI
    4WN6qtrRRVqQ141oMGZ40FzeR+4SyRo6u1rw/qEFWZOstblvlzYcMc3e/DsCNGky
    M++h9DPpetTQt46RaKPCQmzh0MBCDbbWEj/ptxdlY3Nigxa5LbFeW2UWXUZOsTcf
    7ghDPtLOSim5gdSpS1jKna6D8ZJxLq+14Qnuso6cwb7cT0WEB0f3JQyNAa0s96UP
    ONpC12ZXyu+TbcQ3yI2LqzVsp/CUXXRc0iSCRykQiHsZ3NpGlqGO97D48b2NuAGD
    1oZSK/FPQxNpK3Qb25jHRzPThSVWNbg2o8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477877; bh=PwMt18PmF9cyJ4y58XpYajmCI4kLmq
    pCM9BoaWR11HQ=; b=ZzFxU8qD91VIbKrY8w4c+Eggc+sB+geLQw2uZ/8Gq6fmpn
    QmUAkijfjiraWNQ2/ajQyQ8bm4PyJAn1rb+nkVYJmkVjPhnLBD1VudxEgfAKQcb8
    VXdWwhnmzOXdnbFHf3Eb41po6p40a2ORzLyz3aoKhOm+rok/ebeLZ3O15w1IwgOX
    PsEBszGbJApzN0YNtbhnn6jVHhzEC2kcx5r64LCNWRnW6KCWCRpXwQte5I/oEhc8
    sN5Ythdmuw4+YgzUSCHm/5s69QUJFXvDqj8wRWbzj+Dbd5FeVZvEsyC4+vUBpSOw
    9paW5nyYFQkwwKFJvn4flKhz6aRQwuEv/UhHuDTw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfNZYwpSewTtpNXOK3vdDNoS6tRL6wUicgb1az66PznLEEJ2p5fSBAaW0LfL96VQnQDT/WiamtnyM5FObgxYdkZ3P1ujNx8R0R69wDEt4bedxvQoLqIOD
    gB9mLQuxaErivneeT+EsPJhNqDH0QLEl8PmtJ7LESJKoF9IQc1Y2tgmQkEHhXXEqM/U9m+3NsnqO4rSQj7RjQXE7YhfketOu/iron+ttTsb1S7DBHak+vtvt
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=InJrZTXqAAAA:8 a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8 a=z11f-joXAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=rgNOMHsgKtPNWFo9ZzsA:9
    a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=QEXdDO2ut3YA:10 a=bo7r-k08vssA:10
    a=WwJ7OKCui7YMbFU4sWpb:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=HW01NMXGnYhBHl5J0OKi:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756377AbeDKURi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:17:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33500 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933122AbeDKSwm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:52:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andy Grover <agrover@redhat.com>,
        David Disseldorp <ddiss@suse.de>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 010/310] IB/srpt: Fix abort handling
Date: Wed, 11 Apr 2018 20:32:29 +0200
Message-Id: <20180411183622.749110565@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@sandisk.com>


[ Upstream commit 55d694275f41a1c0eef4ef49044ff29bc3999490 ]

Let the target core check the CMD_T_ABORTED flag instead of the SRP
target driver. Hence remove the transport_check_aborted_status()
call. Since state == SRPT_STATE_CMD_RSP_SENT is something that really
should not happen, do not try to recover if srpt_queue_response() is
called for an I/O context that is in that state. This patch is a bug
fix because the srpt_abort_cmd() call is misplaced - if that function
is called from srpt_queue_response() it should either be called
before the command state is changed or after the response has been
sent.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andy Grover <agrover@redhat.com>
Cc: David Disseldorp <ddiss@suse.de>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2292,12 +2292,8 @@ static void srpt_queue_response(struct s
 	}
 	spin_unlock_irqrestore(&ioctx->spinlock, flags);
 
-	if (unlikely(transport_check_aborted_status(&ioctx->cmd, false)
-		     || WARN_ON_ONCE(state == SRPT_STATE_CMD_RSP_SENT))) {
-		atomic_inc(&ch->req_lim_delta);
-		srpt_abort_cmd(ioctx);
+	if (unlikely(WARN_ON_ONCE(state == SRPT_STATE_CMD_RSP_SENT)))
 		return;
-	}
 
 	/* For read commands, transfer the data to the initiator. */
 	if (ioctx->cmd.data_direction == DMA_FROM_DEVICE &&
