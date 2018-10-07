Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3AEC65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8779B205C9
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 16:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8779B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeJGXmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 19:42:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbeJGXmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 19:42:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4980C30820C0;
        Sun,  7 Oct 2018 16:34:26 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-33.brq.redhat.com [10.40.200.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DAD0101E597;
        Sun,  7 Oct 2018 16:34:24 +0000 (UTC)
Date:   Sun, 7 Oct 2018 18:34:57 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Hans Wippel <hwippel@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [RFC PATCH net 0/3] net/smc: move some definitions to UAPI
Message-ID: <cover.1538929504.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 07 Oct 2018 16:34:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

As of now, it's a bit difficult to use SMC protocol, as significant part
of definitions related to it are defined in private headers and are not
part of UAPI. The following commits move some definitions to UAPI,
making them readily available to user space.


Eugene Syromiatnikov (3):
  uapi, net/smc: move protocol constant definitions to UAPI
  uapi, net/smc: provide fallback diagnosis codes in UAPI
  uapi, net/smc: provide socket state constants in UAPI

 include/uapi/linux/smc.h      | 26 +++++++++++++++++++++++++-
 include/uapi/linux/smc_diag.h | 17 +++++++++++++++++
 net/smc/smc.h                 | 22 ++--------------------
 net/smc/smc_clc.h             | 16 ----------------
 4 files changed, 44 insertions(+), 37 deletions(-)

-- 
2.1.4

