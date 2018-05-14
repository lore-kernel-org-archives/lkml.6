Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526281362-2-13742639173316494600
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526281361; b=fJWQoAgf3vaPtkonvJqo8nkKFHEk2KP8prFw8SFJo3pb0xQqrX
    kkAnrF9O53irJmYcyZ+GLATd6/DE4WtWmCMaw8yK1yb1+MXVtOc2U5xdh9pkQfae
    0eNkyaaOE0KCMdkneMR1BU/bD/BpjNZPP0WkV7qfsqELsF+j9QS5w9BsNuUFfwKE
    frzKpw5+1w5dH7ysziy1lRGb2FR9FINSeN4JbMWKVaWdBqQUxSshuqboNF4Jo3dG
    gSxhfc/vV0LTVoRqV10ZKvT0oG3mqwz1Uu6XAwJE8FmAs1dIsFcV5kq5JVnZSy7Y
    ZGw/qxhoflv7t2V3ShQz4ScthhNS9xVvX5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526281361; bh=dsvQUC0639gqdBNnackTfLvIyZAh4M
    SWho3tbXQJKHU=; b=f8H5WbNl1SqRoLegqkOdETsiIthcYcu+5xtq1veNtfk1p8
    qfFggq6x7u74/2oH68o3oL8dgQcBQJmhaIu62VlKTBpk/2M5F6jm2x26AOUE9oap
    7Ty45nmaIf2a/RuFHVUXAZy69GcipKXW4QP1z0AV7fuawWfRNnXGjtnIy8BVtPaj
    ZSU6MhU1uxk8KVbG0tWZ4fls3vKLCxbqltwQ8B/9aJd1UMyX9smusjMplc5t4PJY
    tu9gwxi5GLGObQlNrQhLWszP9NmV0MP1qmxGXPaSB3cKwE8ip1MrA7jPDJLbg137
    9LkRFzJKpw3TSyEKQyCbYdfp0OyOPfSRj8MNDsKw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=wEX9LkHK x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=wEX9LkHK x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHS7pbyE/Xv2jyUoPK3pSdtBMuKk8GFkaAXteYQNyVnaVxX3KNVCqyJqT0WeGiuXhCUFtw4ca+LGOVJHdbMuQ1nyeur7hOXHyHpfmMKM6P/bx2nQXFA8
    9wy7tmMwFIr1dS4NQHmxq1mKu2brGzw8We8zN14DEktLi0BPgyRhN6fyo5dPQg1G2+iEJ4PERcPe3Jfhz/Ido1OGN6j9ie6lo2TKm8CjyPkD7hCyQXn8O/gU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=eW09wEK5EOd5C51ZBwsA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbeENHA3 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754161AbeENHA1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 03:00:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Charles Machalow <charles.machalow@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4.16 62/72] nvme: Fix sync controller reset return
Date: Mon, 14 May 2018 08:49:19 +0200
Message-Id: <20180514064827.351002320@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
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

From: Charles Machalow <charles.machalow@intel.com>

commit 4e50d9ebaeaa3c6761d2b513ef7039510c8cf213 upstream.

If a controller reset is requested while the device has no namespaces,
we were incorrectly returning ENETRESET. This patch adds the check for
ADMIN_ONLY controller state to indicate a successful reset.

Fixes: 8000d1fdb0  ("nvme-rdma: fix sysfs invoked reset_ctrl error flow ")
Cc: <stable@vger.kernel.org>
Signed-off-by: Charles Machalow <charles.machalow@intel.com>
[changelog]
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -122,7 +122,8 @@ int nvme_reset_ctrl_sync(struct nvme_ctr
 	ret = nvme_reset_ctrl(ctrl);
 	if (!ret) {
 		flush_work(&ctrl->reset_work);
-		if (ctrl->state != NVME_CTRL_LIVE)
+		if (ctrl->state != NVME_CTRL_LIVE &&
+		    ctrl->state != NVME_CTRL_ADMIN_ONLY)
 			ret = -ENETRESET;
 	}
 
