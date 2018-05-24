Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158443-2-9640575892316943076
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
    1527158442; b=YhBfehw/sMlAV3tSXrIbjH9R+7x7nGTF6SvDiMGUS70kozWhk7
    DsxNtROTWWCA/ebwkvrg/mSZJT3LJkfcoSvSnwaBGCb00J/JX0/pYvWYKktjpzsw
    V+O0f59Bv75B7xvmh/vUDq2pG9/8pvwPAK84xiabjW4G2PUEKyOEwZ+fulZrVjNX
    e5lVXa4H3zgAzuohro1DMba+slBO8cYNiWgq22Hcr7mEIqxNzj3yr97F9wprbIj6
    2AqwjBl2gcGw0M6/l7ewv61jugyjvkWB25v5mQ65ZpemJVdMcmGNPbRQbwjeUN50
    eaJ5jwS0k3cHgVjeIgRZ3w9bYMDeASJw7BRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158442; bh=KOT7QynFG1Fjbrnx1pp9p3PXxIiiIK
    /j3wM9RA4iwoM=; b=HA/3O4b8lYYcZt/fJ5H8/YD/h/Hbb2jy9YaN+TTSAceaBb
    VRyhW8QClTOLcVuJCmxgDXSzEDfj2tm2Hq8dsEba06HUDuMNIPfzYdOKqEFF8elV
    EuR4omJdxNM0N7NGpZ5GVqjjRvI0QFG2pnXG5zqXy6UBZP//ay2uH2L1zyl93ViK
    DwbTIN1tyZsBjfPRBzaicd8eyy4AJ7v5k6XH2Bw+kPYO0GRYzRApJmNOuP+SUuKP
    qVK/3IfNzWWSkclFUVwDqkDdoun1PnqhnkvEpmBTxVh65ceqyJfBSXhRfZ1VbQAR
    QMcQEQe//h1vDo/sLjsAS4pUg/kO2V/4PDLdjltg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=l9e5jdCL x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=l9e5jdCL x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfM4bHMMWHzaoT4efvAZleLEvYewjIYhQPMmihsOp6Y1kAh662TMiSE9mGPeaX1sF7zIw0D5j9KBrX8RhSS88K9W6Lopy7NqQEq8vVbuZjouWp0aAKMCw
    b0Va3HxPKT2psvga8ALUuLZUt1Ti2yuFjyrGGXuz01nkW0UGuRWFCKo6E+vWTtLHLAwRPDZKj0BABcDgBNR6KPuBtYsVdvOzOdDv7YTePuTiRwnQ+7jpUfqI
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=TYBLyS7eAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=TgI1V_CVZkd2Hpm3k68A:9 a=G2REni5jrpL5heen:21 a=DrMnUpYJG97dv72I:21
    a=QEXdDO2ut3YA:10 a=zvYvwCWiE4KgVXXeO06c:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030971AbeEXKjk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030733AbeEXJ7P (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:59:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrei Vagin <avagin@virtuozzo.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 012/161] tuntap: fix use after free during release
Date: Thu, 24 May 2018 11:37:17 +0200
Message-Id: <20180524093019.883071948@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
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

From: Jason Wang <jasowang@redhat.com>

[ Upstream commit 7063efd33bb15abc0160347f89eb5aba6b7d000e ]

After commit b196d88aba8a ("tun: fix use after free for ptr_ring") we
need clean up tx ring during release(). But unfortunately, it tries to
do the cleanup blindly after socket were destroyed which will lead
another use-after-free. Fix this by doing the cleanup before dropping
the last reference of the socket in __tun_detach().

Reported-by: Andrei Vagin <avagin@virtuozzo.com>
Acked-by: Andrei Vagin <avagin@virtuozzo.com>
Fixes: b196d88aba8a ("tun: fix use after free for ptr_ring")
Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -728,6 +728,7 @@ static void __tun_detach(struct tun_file
 		}
 		if (tun)
 			xdp_rxq_info_unreg(&tfile->xdp_rxq);
+		ptr_ring_cleanup(&tfile->tx_ring, tun_ptr_free);
 		sock_put(&tfile->sk);
 	}
 }
@@ -3157,7 +3158,6 @@ static int tun_chr_close(struct inode *i
 	struct tun_file *tfile = file->private_data;
 
 	tun_detach(tfile, true);
-	ptr_ring_cleanup(&tfile->tx_ring, tun_ptr_free);
 
 	return 0;
 }
