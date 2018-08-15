Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6937AC46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13458216E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 05:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW3+9xcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13458216E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbeHOIhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 04:37:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52078 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeHOIhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 04:37:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so351865wma.1;
        Tue, 14 Aug 2018 22:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=7iat0ktaBOWwjtBUt7x2aQfPfuUy19h2lhAIj61y1/o=;
        b=IW3+9xcP8yvILjpd9vyv4fNGNG8mUUT9+pWtcDub/pJAlnL04eekoq8g3W6Y1h9B3B
         AZ9tBDXKssFqXdSriekvqN5EiGm7Vq609aMDmNbZQJRSTx0RnmyssKseyF99nkfZFlYf
         NDSlLg+xP+WLfHRGTjI+rSTd9oVR1gtElNH3hk9dTXn/exyaZlkonAyF2cn+nBUm6Mk/
         yF4eqyKBn/nx1XWIydOOp2gmzdlFxFxoHCeLpVQWLYpn85N7lItotU1zQ5tjgpzFSUtE
         TKA64C/i2j0DMT7tazRnjft02CV+tqQmsTwndtDCw+Be8fh1QTkBoeDEuQ+GUhQdnHAo
         tH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=7iat0ktaBOWwjtBUt7x2aQfPfuUy19h2lhAIj61y1/o=;
        b=pReufBGimO5Iop+ZuHHExpx07sipmP1VTdBlalP+SV2xI/ZTM0rbyFWWa4g3/ixGU7
         pgZzvMmQoxVxi7D+53AfLM2v2BGwqmnyIxeYPnFkhPUe6AeYMIp9+6xIyXYrVNLBF+JK
         2BV3vPA6G2Vfz8chxXaa7c4A9tcqK7p5Sqb1ciuDemSDht9pmAARLh+m5nD1z7fU5RSw
         DQ2kr0iq/09EjtUC8KZ873kbZREwafwFtEkFBLEAb7a3Fpe8wOUFU436mexqOH+VOnwM
         iBQ0oEFG2CaDxmi2xbjBlCipqpkzcU5rKHZY3k0N4+MiyA8+IxUUm6ErI0khuKVZC3D9
         ZLiA==
X-Gm-Message-State: AOUpUlG7FuOXrFfnLu3ltYsTI1reTi69f40aO06F2ih3NdWABoF9jCd8
        BnnU4+JnBmlmF8aXLGwIjJo=
X-Google-Smtp-Source: AA+uWPzokLL+hN55stYA1ngsIiKQtWTtCNwHxvzDUrVXzelcbeD4oQJtbrih7885RzJ/ZCnko0WCqg==
X-Received: by 2002:a1c:6d94:: with SMTP id b20-v6mr12800831wmi.28.1534311989488;
        Tue, 14 Aug 2018 22:46:29 -0700 (PDT)
Received: from lorien (lorien.valinor.li. [2a01:4f8:192:61d5::2])
        by smtp.gmail.com with ESMTPSA id w204-v6sm1179680wmw.5.2018.08.14.22.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 22:46:28 -0700 (PDT)
From:   Salvatore Bonaccorso <carnil@debian.org>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>, linux-doc@vger.kernel.org,
        trivial@kernel.org
Subject: [PATCH] Documentation/l1tf: Fix small spelling typo
Date:   Wed, 15 Aug 2018 07:46:04 +0200
Message-Id: <20180815054604.27895-1-carnil@debian.org>
X-Mailer: git-send-email 2.18.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix small typo (wiil -> will) in the "3.4. Nested virtual machines"
section.

Fixes: 5b76a3cff011 ("KVM: VMX: Tell the nested hypervisor to skip L1D flush on vmentry")
Cc: linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-doc@vger.kernel.org
Cc: trivial@kernel.org

Signed-off-by: Salvatore Bonaccorso <carnil@debian.org>
---
 Documentation/admin-guide/l1tf.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/l1tf.rst b/Documentation/admin-guide/l1tf.rst
index bae52b845de0..b85dd80510b0 100644
--- a/Documentation/admin-guide/l1tf.rst
+++ b/Documentation/admin-guide/l1tf.rst
@@ -553,7 +553,7 @@ When nested virtualization is in use, three operating systems are involved:
 the bare metal hypervisor, the nested hypervisor and the nested virtual
 machine.  VMENTER operations from the nested hypervisor into the nested
 guest will always be processed by the bare metal hypervisor. If KVM is the
-bare metal hypervisor it wiil:
+bare metal hypervisor it will:
 
  - Flush the L1D cache on every switch from the nested hypervisor to the
    nested virtual machine, so that the nested hypervisor's secrets are not
-- 
2.18.0

