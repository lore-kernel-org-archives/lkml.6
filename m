Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479486-2-4140569658342859539
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
    1523479485; b=n5Becxu2C0cB3wb7pTSH+Z50C+bgd024Wfj4MiLPyPxq5ZwZp5
    k/CalwQjHktQnMaFcaAuTCB/Pa4UhfqvolyXkQUSl9FCFUXzCEJLvEa9CVuZmAfi
    pFaRMw1M/SEO4Z2rofUvwWfkR9h0fey0FjfGQE0K6NyNleetfB2ASHHtGjgiPySf
    XNiEQmmfAnAF3M5y+ccyTpdw1/6hZIaqComls+lq/ReKQYlg3jtlZ45jeEZXHjtb
    qArppDVeKx9DTOAXoS2nKbCl4hHpAFXzFIEVvmp3bfH8W8S8+rAS2sk9kM8EbJeJ
    ju8TzxXhbmtPN2HFahs8rGyLB8wssA4NhrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479485; bh=teuA3wQ4y4PAoOraZ7v2obFUOm0KZG
    cFl5g/tC1jYOU=; b=XY0e6TA9QY/VH+e8hrmt2HXHt8e/Prv3F2BNTlWKp/7Pt6
    C6Qff0ve/mQp5jUAO/a/so5hsr9dgT39Jpn8niFcDFdgK9Cnjjn5ty6XIf2ucXzB
    x4l1nYA4Pi5NpelaAvpC/iqhxvDMh7F18hgpoZ//9Oaa5xt3GiDr1EYJXvyyb806
    gGAiN4mqyGcgDwL7oYuLJFYcfhkBMIBKnMfuq1CKIuXOnKyJnJtNKVU5GdP7SPJs
    D/rmCfEQ9PDt2YuzQh1tcvVW9KGzQpk0xdUIEBipuzExR/+iM3B0926Cbpdg3g/b
    N0VTHktWmKzSynKNrJlkgJbIxwqMtvCjD8vh6/+A==
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
X-CM-Envelope: MS4wfEPM/kXToGLkZpPhQmNE+RSfLIxcJih0tE6yjvX69mBWIJbJTZtw7RHmJR9piJvgW5liL9Xvq3PoAeWrJ1M5Gp/uIvIwhcj/ZoD65SXzXoTaZsyOVz2i
    PetCER7wVYo/i8Z1tXJJ1CcEwnUMUHVu0WmqRiw5i+hk6VmswvBaH8xs6ICoKXgDQTZBLGEnWCz0ebVOTX2f7sWOYDUpy7ljFwdVFlOJ2p6sWG2lzfStBovS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=TOaSPq0KXyr3G-_O67wA:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755864AbeDKSrO (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:47:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59182 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755860AbeDKSrM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 085/190] rds; Reset rs->rs_bound_addr in rds_add_bound() failure path
Date: Wed, 11 Apr 2018 20:35:31 +0200
Message-Id: <20180411183555.591170084@linuxfoundation.org>
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

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>


[ Upstream commit 7ae0c649c47f1c5d2db8cee6dd75855970af1669 ]

If the rds_sock is not added to the bind_hash_table, we must
reset rs_bound_addr so that rds_remove_bound will not trip on
this rds_sock.

rds_add_bound() does a rds_sock_put() in this failure path, so
failing to reset rs_bound_addr will result in a socket refcount
bug, and will trigger a WARN_ON with the stack shown below when
the application subsequently tries to close the PF_RDS socket.

     WARNING: CPU: 20 PID: 19499 at net/rds/af_rds.c:496 \
		rds_sock_destruct+0x15/0x30 [rds]
       :
     __sk_destruct+0x21/0x190
     rds_remove_bound.part.13+0xb6/0x140 [rds]
     rds_release+0x71/0x120 [rds]
     sock_release+0x1a/0x70
     sock_close+0xe/0x20
     __fput+0xd5/0x210
     task_work_run+0x82/0xa0
     do_exit+0x2ce/0xb30
     ? syscall_trace_enter+0x1cc/0x2b0
     do_group_exit+0x39/0xa0
     SyS_exit_group+0x10/0x10
     do_syscall_64+0x61/0x1a0

Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rds/bind.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/rds/bind.c
+++ b/net/rds/bind.c
@@ -108,6 +108,7 @@ static int rds_add_bound(struct rds_sock
 			  rs, &addr, (int)ntohs(*port));
 			break;
 		} else {
+			rs->rs_bound_addr = 0;
 			rds_sock_put(rs);
 			ret = -ENOMEM;
 			break;
