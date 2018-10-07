Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E178AC00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02D62075C
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 14:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02D62075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeJGWEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:04:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbeJGWEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:04:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB397356CE;
        Sun,  7 Oct 2018 14:56:55 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-200-33.brq.redhat.com [10.40.200.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27657612B0;
        Sun,  7 Oct 2018 14:56:52 +0000 (UTC)
Date:   Sun, 7 Oct 2018 16:57:26 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Hans Wippel <hwippel@linux.ibm.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH net v2 0/2] net/smc: userspace breakage fixes
Message-ID: <20181007145726.GA16173@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sun, 07 Oct 2018 14:56:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

These two patches correct some userspace-affecting issues introduced
during 4.19 development cycle, specifically:
 * New structure "struct smcd_diag_dmbinfo" has been defined in a way
   that would lead to different layout of the structure on most 32-bit
   ABIs in comparison with layout on 64-bit ABIs;
 * One of the commits renamed an UAPI-exposed field name.

Changes since v1:
 * Managed not to forget to add --cover-letter.
 * Commit ID format in commit message has been changed in accordance
   with Sergei Shtylyov's recommendations.


Eugene Syromiatnikov (2):
  net/smc: use __aligned_u64 for 64-bit smc_diag fields
  net/smc: retain old name for diag_mode field

 include/uapi/linux/smc_diag.h | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

-- 
2.1.4

