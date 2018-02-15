Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032664AbeBOCwI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 21:52:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032483AbeBOCwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 21:52:06 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH V3 0/2] audit: speed up audit syscall entry
Date: Wed, 14 Feb 2018 21:47:42 -0500
Message-Id: <cover.1518662391.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fixes should speed up audit syscall entry by doing away with the
audit entry filter check, moving up the valid connection check before
filling in the context and not caring if there is a bug when audit is
disabled.

Passes audit-testsuite.
See: https://github.com/linux-audit/audit-kernel/issues/6

v3:
  - squash patch 1 and 2
v2:
  - bail earlier to avoid setting up unneeded state
  - don't bother checking for bug when disabled

Richard Guy Briggs (2):
  audit: deprecate the AUDIT_FILTER_ENTRY filter
  audit: bail before bug check if audit disabled

 kernel/auditfilter.c |  4 ++--
 kernel/auditsc.c     | 22 ++++++++++------------
 2 files changed, 12 insertions(+), 14 deletions(-)

-- 
1.8.3.1
