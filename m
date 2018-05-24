Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906373-1527164312-2-3643891793952938659
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527164312; b=G5dy8bkmcVT2UKMVqoMq9MoXNzRvwitw0WVDsscpgmTrqlY5Gw
    VwNl9mKpm7XoYAeg3Wp5btccmdjTCez3vwbXFDgZD8u21d+BemJLoO5bR7FcLPaD
    RIlD0jWpMRj4O9EiOfQMftCj0AQJl14U5a9X6UaOzG4APyUhuNF53CH7G2KtCDKn
    lBluHK+HYx5KQTqBWKZvMl8QSNjljMJdSp468IftgEWLP5PRiQ+mWQAp3rwdTSrM
    4RHtHxhMQ28h8bBS1wrDGdZ8Ej/8eEuWsJsm2GrcQfUnk5RCQO9/8zaa5WyYat3T
    Dslck7fOi4RG3IjKjbTFkmm3K9m2VxUu2D0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164312; bh=YFu3fOZfk8FyxxOrTCvuBq3YNkwbNK
    6sxNJcwG2kt9E=; b=ILozSMc8/c9hyspkUPv8B/1mw2IW4ZmpyuEeBj4KLiRKzc
    WmJJEzoeiQi740rg8DeaZ4FZp/UYBTCBZWmxq3bLXs3LUhWng6riwjZrinKyGdV4
    0+nt8fNqMMWDFkHUJBnY4HiQlTwJ47n/Trbk3OTj9XQroVJCwwJMLBJVX3lX/sii
    JHS3awZY6z8FD06pi8eiiAr1K1z6KHeIgMZpbN/8ZP4jgbON1EkCe2+2jK1BxlkS
    L1wDfPm7soa60cbarz9ACK9AENpTX5cOPJVLnsBudKXsPF6viyOnnFzDsDk+8F4j
    XfX4isUClGKS1rmIKTLWzEp1wx34XaxWqrUxnyeQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=MZ7xRx8w x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=MZ7xRx8w x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC6d/LSc0rjzgXUbxQYXK4XggABVpnRoze2Nfl8Z1AWEea65/gqHoBq1HXAtvxGJ4fYXOI0BtBnIxPk2zXPHLZaehv3g18Cy0Mo81J6Wf/6FJYd0qOsZ
    lkSgjYy2oLtumkVP8z6ews2mhMboLssJdhKXUHvdHFN5tM+BaaSyyqZmkqIUyG0PElryGmyb4PpglJl85nCfzCyrK5oFaO4OEfD2UCaoVe1CyPGjiGcWHegi
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=TYBLyS7eAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=1EsaE_6oAAAA:8
    a=ag1SF4gXAAAA:8 a=kYNcxVwlaozHNDceCMsA:9 a=QEXdDO2ut3YA:10
    a=zvYvwCWiE4KgVXXeO06c:22 a=AjGcO6oz07-iQ99wixmX:22 a=3ZumFrijQQ-2J9H5h8ct:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966223AbeEXJlj (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966216AbeEXJld (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:41:33 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 3.18 18/45] lockd: lost rollback of set_grace_period() in lockd_down_net()
Date: Thu, 24 May 2018 11:38:26 +0200
Message-Id: <20180524093122.781930188@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
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

From: Vasily Averin <vvs@virtuozzo.com>

commit 3a2b19d1ee5633f76ae8a88da7bc039a5d1732aa upstream.

Commit efda760fe95ea ("lockd: fix lockd shutdown race") is incorrect,
it removes lockd_manager and disarm grace_period_end for init_net only.

If nfsd was started from another net namespace lockd_up_net() calls
set_grace_period() that adds lockd_manager into per-netns list
and queues grace_period_end delayed work.

These action should be reverted in lockd_down_net().
Otherwise it can lead to double list_add on after restart nfsd in netns,
and to use-after-free if non-disarmed delayed work will be executed after netns destroy.

Fixes: efda760fe95e ("lockd: fix lockd shutdown race")
Cc: stable@vger.kernel.org
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/lockd/svc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -271,6 +271,8 @@ static void lockd_down_net(struct svc_se
 	if (ln->nlmsvc_users) {
 		if (--ln->nlmsvc_users == 0) {
 			nlm_shutdown_hosts_net(net);
+			cancel_delayed_work_sync(&ln->grace_period_end);
+			locks_end_grace(&ln->lockd_manager);
 			svc_shutdown_net(serv, net);
 			dprintk("lockd_down_net: per-net data destroyed; net=%p\n", net);
 		}
