Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413631-2-7226150684755992542
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
    t=1519413630; b=ownGzPX01rN82TxtyuQTvvjiOUAnZJL5J0tkVt2om7DTPB6
    BRk4bbd5eJBhzJ3J7EOQ6s5s34UAfG/rg5tP5alXiZUTvlMKblvlBbNjI688XVZy
    MDtO+Pkmqwp8udh2OFW2J0yTi5wHcT+WSC9OY326n0z6CQ4TRlWWI99sKdIHzaxz
    +pwPnj4bb7fkcwYA1zQvCPo2QGDRouWcoB99K/kZjR7mwA9c2Tu+wQtXUR70ewmC
    LM4pkkbNXBSkq9S4Et2Luudz/tMeHCH55WNBulCTKKgLTuWSZH2Vx5l8dF3Q4Foe
    tCrhFMu2nzPekaE0NdaT8jPfUVKvyHBi5vd4RxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413630; bh=4FTjyyUiIcqXR9xmcZuD3O6Da7
    rHQSZCSHJy1uqknH4=; b=l5ts6y6uJemAeiZ1oYOqCH030Qd+GO7T1I0LQph+S4
    KxPt3jGyIjTRsc5H4YK5tdjE5TpOPTy45FJrc0nyNSTfzkPCC1beRyUB+xOAexXw
    osuTIHC4VxQgrtYEWvRLR04Uspz+URcm6KiR/piWEwxT0W5QF2cn5vi4EpHMX9Pw
    oFGpH5rt30E0wE46QRHenHXtBs0kGxRjx1KFd6LJcSfNB5JfeoU+OkV6WherElLi
    mjL6CGrH0wpYWcll9snKfX4UhIbRH4Jdf4SHYkH9nwPFUwMdf94e5Osp+9d336sD
    uNOTmDeXjzIH/JILQ6NtYxoN1Ox8wPKZuOmbNdLvmH7A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935463AbeBWSyO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:54:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47670 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935461AbeBWSyM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:54:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 107/159] s390/virtio: add BSD license to virtio-ccw
Date: Fri, 23 Feb 2018 19:26:55 +0100
Message-Id: <20180223170756.339678850@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: "Michael S. Tsirkin" <mst@redhat.com>


[ Upstream commit edfb8d8fcb94a75b2e61c63549d4a5f6474ad3d2 ]

The original intent of the virtio header relicensing
from 2008 was to make sure anyone can implement compatible
devices/drivers. The virtio-ccw was omitted by mistake.

We have an ack from the only contributor as well as the
maintainer from IBM, so it's not too late to fix that.

Make it dual-licensed with GPLv2, as the whole kernel is GPL2.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/uapi/asm/virtio-ccw.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/include/uapi/asm/virtio-ccw.h
+++ b/arch/s390/include/uapi/asm/virtio-ccw.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
 /*
  * Definitions for virtio-ccw devices.
  *
