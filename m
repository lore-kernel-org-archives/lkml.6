Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3490358-1521484921-2-8015971156083367748
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521484921; b=c8D8slbuFtNjTA1/6v0ZPX0U4R0KvvzbRPDIPwkzBuzb8b9
    nlqh4OGrPB1XNTfA9UznKfSrP/C7PFgNo39C1zX11t5K9jtEWJWUiBBW+kD5Qg+4
    pF9yPef5CbyRkFQ+aIvrDPVKiCL+GekPkBP+AlcZnweEVt/sWk26XFvzBx+HR9zx
    aSyDr1eBVFHyd3LSnqIZZdqE2u6OhFDWpLwsI4ajx+BYR9eNUTJN9ALk6xL1E1kG
    +4K+3IjdleWIDZN/UQlNSslFdVd35rsPn2q3nJZnuwAdemCQu3hAWCkaoLIJvyk7
    zwKTbeGslhmuAGzcRPUKkpTGcotYnNeA+DYXHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521484921; bh=LA7rcr221Bgol8h3rhn653vzkC
    1mi96ie8ykYnigkHM=; b=OySj8CVOE0URGhekpguZl66xsQXNN7jmhFt6fFG1lk
    tiwCxwxPuabJTt4HhykFH8QtO4d23GTezXrTtff2NoEC6Dbc07LSD79vQ4sJd/75
    TpiYRXQK0O65MNKMlGMXXcNKKk6OMtRJjKm2Txz31wkh/kyTAXTiHJJ6F9gO6otS
    OPYJgzlwLpAQl6ZxUbA8mq3QQRYTz71wYXJk8wlQRxsV96y7dfKoKsxhIw7A71iV
    LlfAm4jF8QpQPjtuyeoMvtHJUw/4LVxLq4snnObuYEtn59YK83jbjdDqpK0cs/JB
    gHncfCu1kPDn9iBwWDllAOq4p142WacwAL1uFSSElBwQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeftdegudenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeeftdegudenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970341AbeCSScp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:32:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53672 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970238AbeCSSbs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:31:48 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoffer Dall <cdall@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.15 23/52] kvm: arm/arm64: vgic-v3: Tighten synchronization for guests using v2 on v3
Date: Mon, 19 Mar 2018 19:08:21 +0100
Message-Id: <20180319180736.394562711@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
References: <20180319180734.976730813@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

commit 27e91ad1e746e341ca2312f29bccb9736be7b476 upstream.

On guest exit, and when using GICv2 on GICv3, we use a dsb(st) to
force synchronization between the memory-mapped guest view and
the system-register view that the hypervisor uses.

This is incorrect, as the spec calls out the need for "a DSB whose
required access type is both loads and stores with any Shareability
attribute", while we're only synchronizing stores.

We also lack an isb after the dsb to ensure that the latter has
actually been executed before we start reading stuff from the sysregs.

The fix is pretty easy: turn dsb(st) into dsb(sy), and slap an isb()
just after.

Cc: stable@vger.kernel.org
Fixes: f68d2b1b73cc ("arm64: KVM: Implement vgic-v3 save/restore")
Acked-by: Christoffer Dall <cdall@kernel.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 virt/kvm/arm/hyp/vgic-v3-sr.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/virt/kvm/arm/hyp/vgic-v3-sr.c
+++ b/virt/kvm/arm/hyp/vgic-v3-sr.c
@@ -215,7 +215,8 @@ void __hyp_text __vgic_v3_save_state(str
 	 * are now visible to the system register interface.
 	 */
 	if (!cpu_if->vgic_sre) {
-		dsb(st);
+		dsb(sy);
+		isb();
 		cpu_if->vgic_vmcr = read_gicreg(ICH_VMCR_EL2);
 	}
 
