Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523482011-2-16573603806845473168
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
    1523482011; b=sK0eyREb5o/tvzq8XfEqNAdzyjSVoFzq0rllW2S4KHTUPMUIpH
    zKEx7HazmYJ7ons5kXeTZYriwab5RkjM4h92p9rQ5Uh9KKnEaL47idcEzxe591/G
    i+bPyVLU6yR6eTXtwGPcGEUzc8N1Z890Q8gDbPHtYTjhwP/9Ucdi+FAuRLyPtbxS
    68wV9XZm9YAlLI68nh6QftIhAU0ry1W2XTVCg7OMhg5D5kRmZY5gyRb27k5Iw3+s
    s1sMOWK0aVSXjFQouoWGtJZnXjxlYenJ/w694DCLmAUe5l38E026/HXB2RrjsIqZ
    TjQ+UsiqX0VpSoZOF4ziN4CiKXGWt6U6XOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523482011; bh=mvKVCjYHe/nJ3jqq6C8Z1WmlTgsT71
    z/iUwVC6HScl4=; b=fNYTa+q8xmFkV6LlQysQf10vQs+sZv0PggFt366uBA2vbA
    4ZWCQ9sMxhtf7jOLaWsRrjINf2rzxhqUnF6CJ1I3OPUPQSAgkovhjOcOLcEDYzLG
    Xx2SJN308S53hnKQ4x0dZE7YTAUWPOdSg1kKq81SVjBsvfsICBP3E+072dCtrnoL
    F1tN3PD6aLeGpvGrcXvDZjymN5C7vq99oc4PpKuBqKEn6hreM2YrIJZaW70zNSYt
    Ucon3sqLFi2vEsSsIJi0j8ICAr50xwNTvfjeHNE3nyD9gC7j6WVQbODTa2Rrs/C4
    fANxoKPgZiUYczvGhILpB+QT+vvfISPs+lPew3XA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfE1QTMDOLM3TCKfHEi5xOqXxsA3xMADRLcSh/sT+Qw8hDynUy+ts17Dcb2i8hpe+lyWnNERlXKLvyVAFDQA+AM6SeLNLkWw7Gz9T3/sUrx8hq9HexwDF
    TRmhVZrz/Ycn3PL8dPIpEItUsMA5XhgRGxT4TikYvLrL7yJnxbsU3FYROjHY+Ap03+GWgcuQOofAn631kiJeiD7wJCm2+ACelbAB11Knrz8eAtGuOly66Vq4
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=Kk4NNm4glTtnsDsmpQMA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbeDKV0O (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:26:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55302 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754016AbeDKSiR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:38:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Jeffery <djeffery@redhat.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 008/121] lockd: fix lockd shutdown race
Date: Wed, 11 Apr 2018 20:35:11 +0200
Message-Id: <20180411183456.733325116@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "J. Bruce Fields" <bfields@redhat.com>


[ Upstream commit efda760fe95ea15291853c8fa9235c32d319cd98 ]

As reported by David Jeffery: "a signal was sent to lockd while lockd
was shutting down from a request to stop nfs.  The signal causes lockd
to call restart_grace() which puts the lockd_net structure on the grace
list.  If this signal is received at the wrong time, it will occur after
lockd_down_net() has called locks_end_grace() but before
lockd_down_net() stops the lockd thread.  This leads to lockd putting
the lockd_net structure back on the grace list, then exiting without
anything removing it from the list."

So, perform the final locks_end_grace() from the the lockd thread; this
ensures it's serialized with respect to restart_grace().

Reported-by: David Jeffery <djeffery@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/lockd/svc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -129,6 +129,8 @@ lockd(void *vrqstp)
 {
 	int		err = 0;
 	struct svc_rqst *rqstp = vrqstp;
+	struct net *net = &init_net;
+	struct lockd_net *ln = net_generic(net, lockd_net_id);
 
 	/* try_to_freeze() is called from svc_recv() */
 	set_freezable();
@@ -173,6 +175,8 @@ lockd(void *vrqstp)
 	if (nlmsvc_ops)
 		nlmsvc_invalidate_all();
 	nlm_shutdown_hosts();
+	cancel_delayed_work_sync(&ln->grace_period_end);
+	locks_end_grace(&ln->lockd_manager);
 	return 0;
 }
 
@@ -267,8 +271,6 @@ static void lockd_down_net(struct svc_se
 	if (ln->nlmsvc_users) {
 		if (--ln->nlmsvc_users == 0) {
 			nlm_shutdown_hosts_net(net);
-			cancel_delayed_work_sync(&ln->grace_period_end);
-			locks_end_grace(&ln->lockd_manager);
 			svc_shutdown_net(serv, net);
 			dprintk("lockd_down_net: per-net data destroyed; net=%p\n", net);
 		}
