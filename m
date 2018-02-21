Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519218022-3-12592331452899637331
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218022; b=hGzdO4PKnDVVkuqvEoYNJz2fX/a+zb42mzPFss5vVgFZ0lm
    VYTur2krfk0fcEmuM23RtSSSpkx6oxs9HrVJm+atWwb19K96UsVrH/Z8avmmYnEc
    sxtBO+lN8ibxCrHlDWqVwtwnP+KsH6zL3VlIwA5UKLhFEFrHTaigpqonZyc81WFz
    CDPtBUOg4jrEH6Ec7evBnSAVchDgMt3UQwbbjwDgKi4PwU1zRqvPKTbdUUq8GcYA
    dQWPNUBW2sCoh16onO9SfyJQVdh36NjIibGVof2M7sW2dAGpwMZmsMUQT7P8XlR3
    aafe1Lxmhsk3g7qKez3tOBlTnndIXxV8xLqYpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218022; bh=mBXUC8flRhccTjLmWoLz/g3kRq
    WxtbcwvznA3d+QjMQ=; b=pe4tUUIJEkDw59SJpvfFQtw7FFdedohrf5OXMk9cIx
    adg+EpeGzQgFmPoi57uprd2r1KgezueQO9gXfhrZwptCI2Ou4U3XzhcUcwk9Vg4F
    a5zAfWLDW2zQ/xEKn6gMFFCbPhXNRAaPUZhaXbXGC6xB9BsrRVf/Lrxrf5whnJPt
    1T2MG9VSy4+bw2M8oELh8CxqZcCR4fq3lsEGp63+iwpS/VTcRHjyVVhIhXANYnpY
    Y8a0igdo7bfesPDh7tdgFTJYeB8DnIS20kZbficGVlzV2bTFOnqAKU521RMz8LZb
    8K0tTJo4cCeeySXkB934595knDODWrn7HcTRcOkS/15w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935251AbeBUNAI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:00:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932948AbeBUNAG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:00:06 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 055/167] PM / runtime: Update links_count also if !CONFIG_SRCU
Date: Wed, 21 Feb 2018 13:47:46 +0100
Message-Id: <20180221124527.550243966@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
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

From: Lukas Wunner <lukas@wunner.de>

commit 433986c2c265d106d6a8e88006e0131fefc92b7b upstream.

Commit baa8809f6097 (PM / runtime: Optimize the use of device links)
added an invocation of pm_runtime_drop_link() to __device_link_del().
However there are two variants of that function, one for CONFIG_SRCU and
another for !CONFIG_SRCU, and the commit only modified the former.

Fixes: baa8809f6097 (PM / runtime: Optimize the use of device links)
Cc: v4.10+ <stable@vger.kernel.org> # v4.10+
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -313,6 +313,9 @@ static void __device_link_del(struct dev
 	dev_info(link->consumer, "Dropping the link to %s\n",
 		 dev_name(link->supplier));
 
+	if (link->flags & DL_FLAG_PM_RUNTIME)
+		pm_runtime_drop_link(link->consumer);
+
 	list_del(&link->s_node);
 	list_del(&link->c_node);
 	device_link_free(link);
