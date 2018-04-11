Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479596-2-16724922998755222974
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
    1523479596; b=km8208tdlnF+Se+x6pfthBXv1R5dQUwAhprC2YE6Q/HhsaihYW
    WYkQLoiAAr/TDE96C0NYGytM1AjvU+JpMuSijs435bLIG7bS/87waHGvFx2fnbnG
    U2dqIh3QSZ1Py9kltY43asj8az5XjFO0bTnS5ZcztEc+8TfZbjGaf1bThQOCi3pV
    DY+AKixPZW+fEuqMNmwlIcIrr19jRJV8jthOdSERXNt4gUijPpwKdqhWO99ROzXU
    BR83iBmzCOuk06irEytGOVkJ0JN8d75+mAY1mDlMlCl0pXPU01X+RvUgB+F/FYOd
    xqs+s14WxgBtWHKiGTQ4QyBKOBYSX1ZLS9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479596; bh=C5YTH3QDuKJN5ejYIGLUQkZWKM/x4V
    f+0spy8Q38eVs=; b=elys0zJvFzpzTrBwpyDQOsYcxrUDuG08ba9cERrw1DQVso
    IaT99RvYJJppB3ly5MDiCYdzpI6R1tQNt1f6ctv+rFFO1TD55Htrzjoouotcfz0w
    TKsbSkCB4cxjmvbjDfcHkr6Dq5dOWiqkz6gd6lJhPW/9dz1qKIo7MAWB+Sv6Vs0o
    PDdaaS/oVkxUGMLR1YU22Z4CLvS+5CJfNWK0q/n+vtefLW9EJcXlRZASBYNxS6uj
    S4aTgKmC3769sP/MINTzTfmQLQAZ+6d51uOFxG9mCtv2WiKYeZXWRSdE9kNLrxB8
    MTLlqjO8wgmzJAITv6HyczbH0iTlzTXnpkoZ0FnA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfCKjrqXfGm+T64x0hgL7CbdX3VqMp0Ufq8+HmEbvl/y3/G4FcGbvRsG5ZEidG7QZ4rPflzkXzufZBD5g6BV1q1AwWQ7FAW2ue1mXNd4yQzYUo+8D7E3g
    xjvsET1A4NlAe1VLT3vJwwY/VdalSPaYqhRev1ID0776lfnGks3qWxTePTwVCukrrlU5Kbnmi3OcIiePy+c0tzIw2sGygydQbN9eewGPwiNFhgvgJQxnlkd3
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Iz6zksb9AAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=zU4_mlDSkNBmhn4WFdkA:9 a=QEXdDO2ut3YA:10 a=XZ76h3Q-ufMXbfGU90Ko:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756099AbeDKUqV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:46:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59048 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755758AbeDKSqo (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:46:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roman Kapl <roman.kapl@sysgo.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 076/190] net: move somaxconn init from sysctl code
Date: Wed, 11 Apr 2018 20:35:22 +0200
Message-Id: <20180411183554.904984841@linuxfoundation.org>
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

From: Roman Kapl <roman.kapl@sysgo.com>


[ Upstream commit 7c3f1875c66fbc19762760097cabc91849ea0bbb ]

The default value for somaxconn is set in sysctl_core_net_init(), but this
function is not called when kernel is configured without CONFIG_SYSCTL.

This results in the kernel not being able to accept TCP connections,
because the backlog has zero size. Usually, the user ends up with:
"TCP: request_sock_TCP: Possible SYN flooding on port 7. Dropping request.  Check SNMP counters."
If SYN cookies are not enabled the connection is rejected.

Before ef547f2ac16 (tcp: remove max_qlen_log), the effects were less
severe, because the backlog was always at least eight slots long.

Signed-off-by: Roman Kapl <roman.kapl@sysgo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/net_namespace.c   |   19 +++++++++++++++++++
 net/core/sysctl_net_core.c |    2 --
 2 files changed, 19 insertions(+), 2 deletions(-)

--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -310,6 +310,25 @@ out_undo:
 	goto out;
 }
 
+static int __net_init net_defaults_init_net(struct net *net)
+{
+	net->core.sysctl_somaxconn = SOMAXCONN;
+	return 0;
+}
+
+static struct pernet_operations net_defaults_ops = {
+	.init = net_defaults_init_net,
+};
+
+static __init int net_defaults_init(void)
+{
+	if (register_pernet_subsys(&net_defaults_ops))
+		panic("Cannot initialize net default settings");
+
+	return 0;
+}
+
+core_initcall(net_defaults_init);
 
 #ifdef CONFIG_NET_NS
 static struct kmem_cache *net_cachep;
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -429,8 +429,6 @@ static __net_init int sysctl_core_net_in
 {
 	struct ctl_table *tbl;
 
-	net->core.sysctl_somaxconn = SOMAXCONN;
-
 	tbl = netns_core_table;
 	if (!net_eq(net, &init_net)) {
 		tbl = kmemdup(tbl, sizeof(netns_core_table), GFP_KERNEL);
