Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806175-2-16760624426685902459
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_RHS_DOB 1.514,
  LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806175; b=cHhH1Hd3hQD5MK77qTSjddzZ+nUvMsQVoJ8FU9pwMGvmDmX
    WsigzFvWT5toDIn9q0mK+PkmUrrRYHhV5P/jvwyZC29FfE9J4Vemx7ytA2gn9iuG
    XxkK/I4Q25wQgDcSew0l3jvo4d4QmJQuFVYQLHziDvDpQDwQcLoJ+lU+asR3G1hQ
    uG1v4rbCKDFvhzgWbpKfnOhZ8D/324Gg8TEJJCNVBjM5Aafx5Ep8XQTp7k+tXq3c
    4qh++iE4rbL5yBnZfbt7/HiuyJEaYGzAT1OR8HabdloDMCMu+AflbfakpxEYPcSo
    kPJ1MhupRlaQOpmcDtCZHz32HWlu4g8Igt24KUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806175; bh=Xq1JAxBHWP5eDIR0SW2avlNHVY
    Vov28lyOy+X6vz3es=; b=vcftvJgToRC0tFx3eZRWF5PE/HBRjZwdCrZbJiLAqs
    H1QHCx44Q2ucOOi7teP37dCV2ImfGbsbRR+UxJSMcU4bYt7NPjpplUZsye1bLb6K
    BPjPFdyrcV1o34tGKgXABO9rILoNVrsHnFvSSMOBlSAz19IYJJjOey9qGuSdgU0O
    Jb+f8dPkSKAJ0OZnLUEjvYhEUzaJY+Nc++68eYjhcwKTs/3IJ52zsFJA9rsXVy2u
    swa0gO18wmnB3b984LmDjyznKqnmn0DKe/IixjQOHecYG7ACxQbNm25B7ud6DaJv
    7g/KxhpNzikn3vThkd4MdrxeHUm3byuU6H1SRVpErlsA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeCWL4M (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:56:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37538 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753796AbeCWKA5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:00:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 15/77] media: bt8xx: Fix err bt878_probe()
Date: Fri, 23 Mar 2018 10:53:49 +0100
Message-Id: <20180323094143.236645979@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 45392ff6881dbe56d41ef0b17c2e576065f8ffa1 ]

This is odd to call 'pci_disable_device()' in an error path before a
coresponding successful 'pci_enable_device()'.

Return directly instead.

Fixes: 77e0be12100a ("V4L/DVB (4176): Bug-fix: Fix memory overflow")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/bt8xx/bt878.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/media/pci/bt8xx/bt878.c
+++ b/drivers/media/pci/bt8xx/bt878.c
@@ -422,8 +422,7 @@ static int bt878_probe(struct pci_dev *d
 	       bt878_num);
 	if (bt878_num >= BT878_MAX) {
 		printk(KERN_ERR "bt878: Too many devices inserted\n");
-		result = -ENOMEM;
-		goto fail0;
+		return -ENOMEM;
 	}
 	if (pci_enable_device(dev))
 		return -EIO;
