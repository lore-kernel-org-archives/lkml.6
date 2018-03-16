Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521214704-2-12961054512461447005
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
    t=1521214704; b=Feo5+vqFYAdu15ebsJBRBsIvWTNSqy6Mj1NuYCmJABIslPL
    Y2p5Zkfa97h89TbA7u1WYYfY3L2KanrhXiuNT8Z1wkpzIyI49IDAFEvP3J6CNpGC
    tc2n1ehLhD5p1YU4/7bIP/uk63Pat9F9oBauS3NiNiBGhQX29TugpS5LdTabKNbD
    wmgD94BmBimsBH4gTIkj0AUFgoT9SmEKX2UjPJkPtZGylmC9+ZG6AdHoBEcxVn77
    lNomy3yJR1opGgvTv3Eg3nlkhTt0oyqZ0hkbfIOQtFzPQbAi2FfTst9TPT0AneBQ
    0QB2FvB19dKI7UXPCLUdfx3xuHC1e8z3Y9NSnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214704; bh=bl6TeEnXMl0njGb6lDtmNHshmi
    JnjYJUoV9snwPYTbY=; b=lltSwBLP8WNLhUV3W9ftf9+dlFI1sJZBtbfTx1ZAMl
    w/Jg2xAa30cJurgzumoF2R9OOFG7doUImEHk63rAQi128mgYC7CD+wfqUF/c+wUo
    44Mu5JoEMXw2d5tQkzTFwe3UmC4NpNYy6aYfCAsP4XbA4kLAZJs0oqtq6XDEqDIQ
    OhnEeW5GdMHxrEb1APS6mIWPA2eeUHPqcpcRwIFHLihNkFbF5trM/OEncc2i+K4r
    jJIOiFyouGqYGvSeQOD/k6ePYGLoZyzn+ShKr492lMCwXchtKqOjPskSKq8Q/toM
    TzCjN/HvYktqGM5FDkEF/AThpyaKWiyEmiN8Uh6Z1GnA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbeCPPiS (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:38:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42228 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754501AbeCPPiR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:38:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Mika Kuoppala <mika.kuoppala@intel.com>,
        drm-intel-fixes@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 096/109] agp/intel: Flush all chipset writes after updating the GGTT
Date: Fri, 16 Mar 2018 16:24:05 +0100
Message-Id: <20180316152335.108610830@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
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

From: Chris Wilson <chris@chris-wilson.co.uk>


[ Upstream commit 8516673a996870ea0ceb337ee4f83c33c5ec3111 ]

Before accessing the GGTT we must flush the PTE writes and make them
visible to the chipset, or else the indirect access may end up in the
wrong page. In commit 3497971a71d8 ("agp/intel: Flush chipset writes
after updating a single PTE"), we noticed corruption of the uploads for
pwrite and for capturing GPU error states, but it was presumed that the
explicit calls to intel_gtt_chipset_flush() were sufficient for the
execbuffer path. However, we have not been flushing the chipset between
the PTE writes and access via the GTT itself.

For simplicity, do the flush after any PTE update rather than try and
batch the flushes on a just-in-time basis.

References: 3497971a71d8 ("agp/intel: Flush chipset writes after updating a single PTE")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Mika Kuoppala <mika.kuoppala@intel.com>
Cc: drm-intel-fixes@lists.freedesktop.org
Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171208214616.30147-1-chris@chris-wilson.co.uk
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/agp/intel-gtt.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -872,6 +872,8 @@ void intel_gtt_insert_sg_entries(struct
 		}
 	}
 	wmb();
+	if (intel_private.driver->chipset_flush)
+		intel_private.driver->chipset_flush();
 }
 EXPORT_SYMBOL(intel_gtt_insert_sg_entries);
 
