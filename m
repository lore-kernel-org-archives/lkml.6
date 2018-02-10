Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeBJCp1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 21:45:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752167AbeBJCp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 21:45:26 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH V2 0/3] audit: speed up audit syscall entry
Date: Fri,  9 Feb 2018 21:40:29 -0500
Message-Id: <cover.1518230355.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These fixes should speed up audit syscall entry by doing away with the
audit entry filter check, moving up the valid connection check before
filling in the context and not caring if there is a bug when audit is
disabled.

Richard Guy Briggs (3):
  audit: deprecate the AUDIT_FILTER_ENTRY filter
  audit: bail ASAP on syscall entry
  audit: bail before bug check if audit disabled

 kernel/auditfilter.c |  4 ++--
 kernel/auditsc.c     | 22 ++++++++++------------
 2 files changed, 12 insertions(+), 14 deletions(-)

-- 
1.8.3.1
