Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2222762-1524248340-2-7661975066203664394
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524248339; b=oC4P1tBANwncCwuk5F++mGhRT0wgWcygvrYS/Uw8G2/TV/4d9Z
    pOfGoATG57+OzC6dY4h1YHdEf01nujYUD0iqoIBAImxifluhzhJai5PwLTP68b1B
    lMdECLiCj9D9UPPckJuHCsYk2Y+rzqcAui3Sre9fGaBOKFD3NkO7OfG5xkN4v7qB
    j0MCzSAhcTaOf5weBDPkYkios9Lr4zMerf2eWDjJuMWINpB/fJMiuT28CL/YzFNp
    nKCjiEm/wKHc7UQAzAKT5nQoQUlvvZrGZwZM4Nizptz8egERhuEzZKuAsrUbdfly
    zQOvID9631uTMdHOi+ng+hykt2rQYlgBR8uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524248339; bh=Uiv/XOpcfAUsdumQ+aiIEb3JZHM0cU
    yi4cfPRDOpbRE=; b=vHamhkcmWPP8pVgWnZceuW9klF3N2GLXOhiHPQFbznkB7y
    Y8KJJ1wK3t1u7M7dkl1CahKGH+lC9jHIawhSpubvm7Dg3bv6S4S/hp0KdXb9ZZWt
    92tnMZxY/kXTs4L5vVfQS7fc75RzTPKuHbR5E9zPfe+Pm46wcDCtnRThQh2I2Srv
    9XM7+iZAG0Qby5TK+gdP4Qblib7OZwwnhM4fVNc9mp1sbR6qdLinzz2MtJu9zVew
    UUaDSv/qme+TWQVxp7Izc+0Q11KmTVnXOMnEC947KrciaAN4aAZlHU7LZA4PP7O/
    /kh7NwXc9yiLOXg/XqdejvuDz8GLWNdGh6tLx9xQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIRib+kbPkScWoetWeIJFzSTzy38PwYklwmWTAbSxumFycM2aavT5/l6wiK0/DCTHNkLqQSE+RHGRKtT/o/rPgLjWxt9VhfLgVydDUrTbBXHWE+Gyags
    q54xNn2BNPKD4OB4o0y7YmJzHyjZUJkPNdzpvZAtd0hJ4ihCWoAQnIiet/ozqPC9CRtUMJ7Y++lRCuNp7SIhKk2RKNCLTbd1E7QPaeWzelMpaCLfalZRC6Wd
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=LCupdz00hl00B3_RI0AA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753775AbeDTSSF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 14:18:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753706AbeDTSSD (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 20 Apr 2018 14:18:03 -0400
Date: Fri, 20 Apr 2018 21:18:02 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Tiwei Bie <tiwei.bie@intel.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 2/6] virtio: add ability to iterate over vqs
Message-ID: <1524248223-393618-3-git-send-email-mst@redhat.com>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524248223-393618-1-git-send-email-mst@redhat.com>
X-Mutt-Fcc: =sent
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For cleanup it's helpful to be able to simply scan all vqs and discard
all data. Add an iterator to do that.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 988c735..fa1b5da 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -157,6 +157,9 @@ int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
 #endif
 
+#define virtio_device_for_each_vq(vdev, vq) \
+	list_for_each_entry(vq, &vdev->vqs, list)
+
 /**
  * virtio_driver - operations for a virtio I/O driver
  * @driver: underlying device driver (populate name and owner).
-- 
MST
