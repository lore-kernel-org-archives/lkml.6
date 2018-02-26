Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3726165-1519676519-2-10530167423595038162
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
    t=1519676519; b=mHzOXb9r03AYAolWegfywVHmBUvslBfyMSyMbtzD13X3kKu
    2jBKSkjs+kYe13TBySB6Kq3+WRHrWiCpwZxYzNc0mT0N8ltjNXrl71GMOdUHuyMt
    P2mZFgzRsgJR1u38XynLO4DXT1hdkWGf8ijtUrSr75V7QBi1/9GrPnI67aLNLUJa
    NTZ3sD3eQQIKRZ4Sh89V6NgihU+D++RKlgH+GXx1ruuApQPUPPX/elI82tZ8HZSX
    rVzIPyoulIYcqFWsF3SqXOSX//DFGp8dz3cbfas9CboGqHpNgg5DU65VzGjtJ0XR
    RFRpILMXyJNrfVrxZsuEuGgkuCpVZS9zH6FlAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676519; bh=g6pSEZB92Om89FhUfLiUkrZ1s8
    Sn7kRQXEWQUSQvNMI=; b=O/m+7Ig/oNq4F9yco5Sbj7rJGC+v/0ZhVM5n4S7C2H
    bqlYK9z5b8FiGCtc6jqOJgIUBuM+mKrFF3c5oHXrFc3EMRqU08Kr56Qtfq9lmHbP
    avbqqUtC+v1/j1Q7GFyWm3sP2vK55qHNjn3NBzhS7HjqysToYPR9mBLcIpuTwObU
    ITQ0BFAVR6kHokOBbk5ziFbyvRez13G1NTQ+V1uGD06uDXxvQGyk4KFnV86kYLkD
    CCPXk1qskxK14rWLChVfdbuJRH8H+Sx1VfHw/8YqHENPoJe2Mh8YLa/NSrQl0z4i
    v6eVNef6LbKXZfUA5yIn0HK5qIEGcEuyxhWNn5XQU+ig==
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
        id S1752441AbeBZUVr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:21:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:33288 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752433AbeBZUVp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:21:45 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.9 20/39] Revert "usb: musb: host: dont start next rx urb if current one failed"
Date: Mon, 26 Feb 2018 21:20:41 +0100
Message-Id: <20180226201644.564598430@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bin Liu <b-liu@ti.com>

commit 44eb5e12b845cc8a0634f21b70ef07d774eb4b25 upstream.

This reverts commit dbac5d07d13e330e6706813c9fde477140fb5d80.

commit dbac5d07d13e ("usb: musb: host: don't start next rx urb if current one failed")
along with commit b5801212229f ("usb: musb: host: clear rxcsr error bit if set")
try to solve the issue described in [1], but the latter alone is
sufficient, and the former causes the issue as in [2], so now revert it.

[1] https://marc.info/?l=linux-usb&m=146173995117456&w=2
[2] https://marc.info/?l=linux-usb&m=151689238420622&w=2

Cc: stable@vger.kernel.org # v4.7+
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_host.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -418,13 +418,7 @@ static void musb_advance_schedule(struct
 		}
 	}
 
-	/*
-	 * The pipe must be broken if current urb->status is set, so don't
-	 * start next urb.
-	 * TODO: to minimize the risk of regression, only check urb->status
-	 * for RX, until we have a test case to understand the behavior of TX.
-	 */
-	if ((!status || !is_in) && qh && qh->is_ready) {
+	if (qh != NULL && qh->is_ready) {
 		musb_dbg(musb, "... next ep%d %cX urb %p",
 		    hw_ep->epnum, is_in ? 'R' : 'T', next_urb(qh));
 		musb_start_urb(musb, is_in, qh);
