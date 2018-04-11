Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477832-2-1340767738632697179
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477832; b=KAZItGQmlGax2SVPs1Yp7OW0qLfsT/S4zRXIRFr8MSAy7sup/x
    hQ5uG2shK8HzlXGYPhPk/AP5yRECXYDCDYfwPBlWssWT3TZSCP6DVB6v9S2+B2lv
    7jQZ8qw8VaHFWUuEdEp/+Z5IZUIudiPq1+XpAidDGqNzogRiEEoUXPCpgEwUSLyz
    OlJew2fLIVajH2pNLC2cndSbTgaA1GCayBeHEqpV9k+GsrCiKBpPIqvuodyZ3/pa
    CV2R8U2qeQZvXIIO0fHPvrV2tKjCyezuQbjVpYnt6d1J9YEbQIf9ilU9jgi5Wixs
    mPr7d36eLObpIsi1xStCkvIH1u0zY5VnnjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477832; bh=hkI7Vw6ZhbMZtXQskiqQyg5r65weoJ
    IId8rI9b+aEQE=; b=kLUK5vHL3I8hGJ3/SmmbUxXqHPlHga+v9tuJuaPQOLtrSY
    Ddbqp+EYHBvouaekfLOXABu9pQ5uZXjks14GFnEcxXeQz1ySeAGkaXyX4+iTfc7P
    p636j+aleTvEb6QuMxyrl7CCuOZJO9mcOGsctniPpbIiYfRKPi7Aog492Ow0Th5V
    NvBH2ZFl6p2whweBvFBhlVWEPpcRsWThWM5SokJtsyjcCaNrgBgTn0Rj+52tx8e7
    elSz1I5gM4arBgr8YiKkJ2b3Ei5X2ZmrNWXpiq/9zUgizfmfakYE5AomucPqCi0V
    8bcM7FN/714CH5sKcUs+3IIxE1se1krep5itqmLw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfJTvERKnp7PmT2BEdLqJX+jEADnicOD6ksQI1KKm4R/6GbeBN6QksOhcxSuusI6al9cqKHcywwL/GgjKoWFGNlMMMBkKFb3qq4xe/tFTaUZI/41WOOb6
    keG/5yBDbHkKjEOVgETFxEvOWCxTcjt0KOuOHC7QqID1pKB2k73iwmTYD2A+6zgJsTsGj98Ph/ADRDpTLFmco94zV/Bui4/UF0lJh4XZMzBL8h15PTIth98y
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=InJrZTXqAAAA:8 a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8 a=z11f-joXAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=5erOVBGf7h3aTwkjQJ0A:9 a=QEXdDO2ut3YA:10
    a=WwJ7OKCui7YMbFU4sWpb:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=HW01NMXGnYhBHl5J0OKi:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933143AbeDKSws (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:52:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33544 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933117AbeDKSwp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:52:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Disseldorp <ddiss@suse.de>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 011/310] IB/srpt: Avoid that aborting a command triggers a kernel warning
Date: Wed, 11 Apr 2018 20:32:30 +0200
Message-Id: <20180411183622.794995434@linuxfoundation.org>
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


[ Upstream commit bd2c52d733f126ff75f99c537a27655b2db07e28 ]

Avoid that the following warning is triggered:

WARNING: CPU: 10 PID: 166 at ../drivers/infiniband/ulp/srpt/ib_srpt.c:2674 srpt_release_cmd+0x139/0x140 [ib_srpt]
CPU: 10 PID: 166 Comm: kworker/u24:8 Not tainted 4.9.4-1-default #1
Workqueue: tmr-fileio target_tmr_work [target_core_mod]
Call Trace:
 [<ffffffffaa3c4f70>] dump_stack+0x63/0x83
 [<ffffffffaa0844eb>] __warn+0xcb/0xf0
 [<ffffffffaa0845dd>] warn_slowpath_null+0x1d/0x20
 [<ffffffffc06ba429>] srpt_release_cmd+0x139/0x140 [ib_srpt]
 [<ffffffffc06e4377>] target_release_cmd_kref+0xb7/0x120 [target_core_mod]
 [<ffffffffc06e4d7f>] target_put_sess_cmd+0x2f/0x60 [target_core_mod]
 [<ffffffffc06e15e0>] core_tmr_lun_reset+0x340/0x790 [target_core_mod]
 [<ffffffffc06e4816>] target_tmr_work+0xe6/0x140 [target_core_mod]
 [<ffffffffaa09e4d3>] process_one_work+0x1f3/0x4d0
 [<ffffffffaa09e7f8>] worker_thread+0x48/0x4e0
 [<ffffffffaa09e7b0>] ? process_one_work+0x4d0/0x4d0
 [<ffffffffaa0a46da>] kthread+0xca/0xe0
 [<ffffffffaa0a4610>] ? kthread_park+0x60/0x60
 [<ffffffffaa71b775>] ret_from_fork+0x25/0x30

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Disseldorp <ddiss@suse.de>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2666,7 +2666,8 @@ static void srpt_release_cmd(struct se_c
 	struct srpt_rdma_ch *ch = ioctx->ch;
 	unsigned long flags;
 
-	WARN_ON(ioctx->state != SRPT_STATE_DONE);
+	WARN_ON_ONCE(ioctx->state != SRPT_STATE_DONE &&
+		     !(ioctx->cmd.transport_state & CMD_T_ABORTED));
 
 	if (ioctx->n_rw_ctx) {
 		srpt_free_rw_ctxs(ch, ioctx);
