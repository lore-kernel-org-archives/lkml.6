Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524838280-2-10866630135388516829
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
    1524838279; b=IPi/WnNpqahpL3TduR3x2vYfUrVpFhsaLKrW86KRhc3j99u2KO
    1YtZAKn1nB1ChNc7jfSGEIwi/Dj6+/lrzCzqFT9G+7mtdYuAzH3cWBUY80dBFThX
    ACIASZ9yGrthxLlvWdj8/ynG93JM1QSHdVc90yBpr5NkU6RYPXu69p1bdmx74PZt
    TJDxQhTPIG5fyGxrc03FXrDUyuYwH5hRkMJvyqqferho2iQCrzIRzCJgxzmGdwjp
    p2KOf3lg84wzqcPezhQGAfrezcrxfpX2gtiUuPTAGJUaZ4eDAbEgXtXevXFJr88I
    gv0e6XfivbSVLpM7dpi8e3qP9ylbWH7UVXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838279; bh=OxMBjHu5PtTyJG2FhMlc/snRm1go3D
    H61B2RYo5uuXU=; b=VcHq3s6fDFlUIkwgi/YN3nywuq6pyi/FRtuXwAFCmCpvaW
    e5WOHDTKaz+53Hi0VVfRMLNgxuqsE0yChLylQT3SfWDif79NkOByJ8yOV4pE5lGx
    PJAUpDKvvT9DJMtLCtre5i+M96LH+zakfw5VjMLsN8gHnoqLhk0SHkAL18EoF0/c
    JfWIms4VqfJ419Drw9vrC5KqTrUQ+YrghAR1Mb8bRuBbSQS6MEjpdfOZ2uX8HE0I
    HaccxcxSYqO9KjHk+OueQR3qrweS85qlDIvcTe/RI44gNws/bTwEm9NVK3waMSux
    QLKPS75nSpTOKJ977FPHF7t3FHjAT9HsDySDDOWQ==
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
X-CM-Envelope: MS4wfM3YpszwtkHvLEoBQ28SR5km2lZx+NlkZKGeMOIeRRY8sUCaTUFdqN+ldNkxdTDHuDU+t42fNyuBSahrN80NP9k06usUqunw0chaoVyqTOgxZD4amD2r
    Rg2Ch6nr40KsIQOwBp/98fJBXhhpHdUi/zsamrRAPxJdL2Hdz0fv4TSgLmqWxRlz4VUfDW83CgNfL+wx9pYwn6nSFZg1iVhBpCwQpbfOfiTOVY53QQ2wuVzR
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=CqTAwb2zOcPDmA0dTnEA:9 a=QEXdDO2ut3YA:10
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934750AbeD0OLN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934949AbeD0OLL (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:11:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A703218C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guillaume Nault <g.nault@alphalink.fr>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 43/81] l2tp: hold reference on tunnels printed in l2tp/tunnels debugfs file
Date: Fri, 27 Apr 2018 15:58:45 +0200
Message-Id: <20180427135745.648420918@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
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

From: Guillaume Nault <g.nault@alphalink.fr>


[ Upstream commit f726214d9b23e5fce8c11937577a289a3202498f ]

Use l2tp_tunnel_get_nth() instead of l2tp_tunnel_find_nth(), to be safe
against concurrent tunnel deletion.

Use the same mechanism as in l2tp_ppp.c for dropping the reference
taken by l2tp_tunnel_get_nth(). That is, drop the reference just
before looking up the next tunnel. In case of error, drop the last
accessed tunnel in l2tp_dfs_seq_stop().

That was the last use of l2tp_tunnel_find_nth().

Fixes: 0ad6614048cf ("l2tp: Add debugfs files for dumping l2tp debug info")
Signed-off-by: Guillaume Nault <g.nault@alphalink.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/l2tp/l2tp_core.c    |   20 --------------------
 net/l2tp/l2tp_core.h    |    1 -
 net/l2tp/l2tp_debugfs.c |   15 +++++++++++++--
 3 files changed, 13 insertions(+), 23 deletions(-)

--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -355,26 +355,6 @@ err_tlock:
 }
 EXPORT_SYMBOL_GPL(l2tp_session_register);
 
-struct l2tp_tunnel *l2tp_tunnel_find_nth(const struct net *net, int nth)
-{
-	struct l2tp_net *pn = l2tp_pernet(net);
-	struct l2tp_tunnel *tunnel;
-	int count = 0;
-
-	rcu_read_lock_bh();
-	list_for_each_entry_rcu(tunnel, &pn->l2tp_tunnel_list, list) {
-		if (++count > nth) {
-			rcu_read_unlock_bh();
-			return tunnel;
-		}
-	}
-
-	rcu_read_unlock_bh();
-
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(l2tp_tunnel_find_nth);
-
 /*****************************************************************************
  * Receive data handling
  *****************************************************************************/
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -222,7 +222,6 @@ struct l2tp_session *l2tp_session_get(co
 struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth);
 struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 						const char *ifname);
-struct l2tp_tunnel *l2tp_tunnel_find_nth(const struct net *net, int nth);
 
 int l2tp_tunnel_create(struct net *net, int fd, int version, u32 tunnel_id,
 		       u32 peer_tunnel_id, struct l2tp_tunnel_cfg *cfg,
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -47,7 +47,11 @@ struct l2tp_dfs_seq_data {
 
 static void l2tp_dfs_next_tunnel(struct l2tp_dfs_seq_data *pd)
 {
-	pd->tunnel = l2tp_tunnel_find_nth(pd->net, pd->tunnel_idx);
+	/* Drop reference taken during previous invocation */
+	if (pd->tunnel)
+		l2tp_tunnel_dec_refcount(pd->tunnel);
+
+	pd->tunnel = l2tp_tunnel_get_nth(pd->net, pd->tunnel_idx);
 	pd->tunnel_idx++;
 }
 
@@ -96,7 +100,14 @@ static void *l2tp_dfs_seq_next(struct se
 
 static void l2tp_dfs_seq_stop(struct seq_file *p, void *v)
 {
-	/* nothing to do */
+	struct l2tp_dfs_seq_data *pd = v;
+
+	if (!pd || pd == SEQ_START_TOKEN)
+		return;
+
+	/* Drop reference taken by last invocation of l2tp_dfs_next_tunnel() */
+	if (pd->tunnel)
+		l2tp_tunnel_dec_refcount(pd->tunnel);
 }
 
 static void l2tp_dfs_seq_tunnel_show(struct seq_file *m, void *v)
