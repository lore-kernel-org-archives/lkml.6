Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324461-2-18151799753241020390
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324461; b=atwZ4R/ChjrsA7ZWkzPxrjSUE+HVtk6FDv+ZS3W9rP7UEFa
    DrUkxRh2g8b9GqzLJwMjxV6jP+r/v3796okraLRlyBvC+2wuo7zQfCcBOid4aXAo
    lXutGvTcHlzkikDIKTtgOKEzngsKME7Fks7KurwTL0Or9GNxuteAYLhs0A3EGqwc
    iSBNdWCQDijtKN/tX4NJLaolKN1oUPWRfNzEBOIWV1f9Miisk4kJ4GT/12WQhunL
    k9BhnqMj0n/P+kR7u8H20zkvJeF4itn7Oe8yWMNhkAJJJDBhLsyLMRrHKM/LDsQu
    UtTSrWQcNu6ieMjRCqNSllrfBzdHcbqj2TdFm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324461; bh=Z2hgdlhgVJFB+3esPc8
    7kb2g+aS1skHDK/PizlAhn9U=; b=ic5Q9Ow3E2U79JHV68NLS/DzI1/PKFhktX6
    yVCC6+hAoti0npQxfOM1z+ZGUcGF49x0amDKCJktovPQWZnWtXFOoQ2Axm1EsiKW
    8VS2ibbzX/IA3tJn9DW6WST6vrTsoQ4dakZl6Fz/8GhBv7SX9NKOZkSRIFnDYu3Q
    pOLK7PFLWiHYNGGofVWuz9BrYr6p/N6Kjx+vINDMMqSxnQf1+VUKeEFJ4302g8XO
    C0Jaz1EHTwQhNB/SylE1E+dk8JgiBL0uKlBMlECEbyS7Yn8EathU6ErGYfuCTFOi
    d0G/7+sSmw47H1SwE9yKLgpbrwXEOnR1NgxoCvg/OT1tAsCjw8g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbeBKErV (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:47:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41836 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752849AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Dave Jones" <davej@codemonkey.org.uk>,
        "Anna Schumaker" <Anna.Schumaker@Netapp.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.483168562@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 091/136] NFS: Avoid RCU usage in tracepoints
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

commit 3944369db701f075092357b511fd9f5755771585 upstream.

There isn't an obvious way to acquire and release the RCU lock during a
tracepoint, so we can't use the rpc_peeraddr2str() function here.
Instead, rely on the client's cl_hostname, which should have similar
enough information without needing an rcu_dereference().

Reported-by: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
[bwh: Backported to 3.16: Drop changes in
 nfs4_inode{,_stateid}_callback_event()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/nfs/nfs4trace.h | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -201,17 +201,13 @@ DECLARE_EVENT_CLASS(nfs4_clientid_event,
 		TP_ARGS(clp, error),
 
 		TP_STRUCT__entry(
-			__string(dstaddr,
-				rpc_peeraddr2str(clp->cl_rpcclient,
-					RPC_DISPLAY_ADDR))
+			__string(dstaddr, clp->cl_hostname)
 			__field(int, error)
 		),
 
 		TP_fast_assign(
 			__entry->error = error;
-			__assign_str(dstaddr,
-				rpc_peeraddr2str(clp->cl_rpcclient,
-						RPC_DISPLAY_ADDR));
+			__assign_str(dstaddr, clp->cl_hostname);
 		),
 
 		TP_printk(
