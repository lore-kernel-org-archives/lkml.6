Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F86C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3799620870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfAVWI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:08:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbfAVWI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:08:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2ABD358E23;
        Tue, 22 Jan 2019 22:08:27 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-14.phx2.redhat.com [10.3.112.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C53DF4141;
        Tue, 22 Jan 2019 22:08:20 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>
Cc:     Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak105 V1 0/2] audit: clean up CONFIG_AUDITSYSCALL
Date:   Tue, 22 Jan 2019 17:07:40 -0500
Message-Id: <cover.1548192740.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 22 Jan 2019 22:08:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiles and boots with config AUDITSYSCALL def_bool n in init/Kconfig.
Verified syscall code is not present in resulting kernel.

Richard Guy Briggs (2):
  audit: clean up AUDITSYSCALL prototypes and stubs
  audit: remove audit_context when CONFIG_ AUDIT and not AUDITSYSCALL

 include/linux/sched.h |   2 +-
 kernel/audit.c        | 155 +++-----------------------------------------------
 kernel/audit.h        |  73 +++++++++++-------------
 kernel/auditsc.c      | 148 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 190 insertions(+), 188 deletions(-)

-- 
1.8.3.1

