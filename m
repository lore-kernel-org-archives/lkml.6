Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B01C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F1A20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWBCC3/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F1A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeJCM0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:26:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34047 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeJCM0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:26:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id g12-v6so1037217pgs.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:reply-to:mime-version
         :content-transfer-encoding;
        bh=wS11UV4KT5sFIVDAPWIln9I2oDbPG9WCePLmWXBCMwk=;
        b=kWBCC3/yrj1peOMfL1nTcx78YhP7gxmVUGpHmxmpB+whRYVzceozEMqgd7X4xieeyV
         F+2fmD0YAoaeD1+vIvgXBpElpW0IM1iQkrFA1b35S6rEdT+3GSBxXwscsuOFrB4EjS7o
         zlit4Hu1sFCrc1Os+OV/59v35b3uOu/GQCDQ4hD3MibvCoJopl7X6qCh3HXrJ5fZUFvK
         VHS1Pgq89/iBa72KvQ/xkTB0Zhmm4soPsEnH7OSYqX5Eb/xxYFk7VeUdKWmZYV8zIhF/
         Ar1BDQXcYhIHF+l8IbQvCYM+fcSor/2gK/BsEZUL2Wilwq43clMPDbsIKmpOuXBwZsfz
         H/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=wS11UV4KT5sFIVDAPWIln9I2oDbPG9WCePLmWXBCMwk=;
        b=Pnj6cGbtBxBKTktLPpHlBCyTNgHQcxvbtOTEjsRypRNZfjmlt4IL/7BZwJqjX+HOBc
         6AzSdFwmnUUMGHUd2PbbFZBm/OpQe3OvWopCDiHogO0Ke+7+ms/AfC916LpaRNzId4Vu
         vl0BOhd80bweDRLfWyTgQdBMGxJmUpt9vPrfr+38TaDYU0dvOB1euBHtp0ycJXrhjMkE
         iZyo+8saxK0QnrclN7jbzgjYReiCf6Rw9iZB10pfZ/lHQWxTcRQXNO2SQBuwdX8Wvgya
         fRMyI/i85QxZ8E315SdxhsrPrjkxUvSK3B2dmk2eB8MfzLCR+nPBm369pBVnpdlUhN9y
         HTPw==
X-Gm-Message-State: ABuFfoi9kR2RMgLODWw61oNPqkmmyFEKk4byT4qVvQLZY8y8AIc4IAYV
        lQ7C20vAn3bXKIUz75DJbOE=
X-Google-Smtp-Source: ACcGV6390ChtZXXV609BZ4aT+W8IG7j+TPq2Ioe6iOKuOdtOtnNhmAcwpaw7GTIK3CqdrfDL1+VZqQ==
X-Received: by 2002:a62:d841:: with SMTP id e62-v6mr18226837pfg.60.1538545165529;
        Tue, 02 Oct 2018 22:39:25 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id e3-v6sm520076pgc.71.2018.10.02.22.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:39:24 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id 7C49C1643D0; Tue,  2 Oct 2018 22:39:23 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>
Subject: Using lockdep instead of spin_is_locked()
Date:   Tue,  2 Oct 2018 22:38:46 -0700
Message-Id: <20181003053902.6910-1-ldr709@gmail.com>
X-Mailer: git-send-email 2.19.0
Reply-To: Lance Roy <ldr709@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the main uses of spin_is_locked() is to require that a lock is held when
a function is called, for debugging, but lockdep_assert_held() is better for
this purpose since it won't make a mistake when someone else is holding the
lock. This patch series replaces all of this kind of use of spin_is_locked()
with calls to lockdep_assert_held(). An ulterior motive is to reduce the number
of uses of spin_is_locked() from the kernel, to work towards possibly
eliminating it.

Thanks,
Lance

 arch/x86/pci/i386.c                          |  2 +-
 drivers/hv/hv_balloon.c                      |  2 +-
 drivers/misc/sgi-xp/xpc_channel.c            |  6 +++---
 drivers/misc/sgi-xp/xpc_sn2.c                |  2 +-
 drivers/misc/sgi-xp/xpc_uv.c                 |  2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c  |  3 +--
 drivers/net/ethernet/intel/igbvf/mbx.c       |  4 ++--
 drivers/net/ethernet/sfc/efx.c               |  2 +-
 drivers/net/ethernet/smsc/smsc911x.h         |  2 +-
 drivers/net/wireless/zydas/zd1211rw/zd_mac.c |  2 +-
 drivers/scsi/snic/snic_scsi.c                |  4 ++--
 fs/userfaultfd.c                             |  2 +-
 kernel/futex.c                               |  4 ++--
 kernel/locking/mutex-debug.c                 |  4 ++--
 mm/khugepaged.c                              |  4 ++--
 mm/swap.c                                    |  3 +--
 net/netfilter/ipset/ip_set_hash_gen.h        |  2 +-
 security/apparmor/file.c                     |  2 +-
 virt/kvm/arm/vgic/vgic.c                     | 12 ++++++------
 19 files changed, 31 insertions(+), 33 deletions(-)

