Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750960AbeBLFGi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 00:06:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750734AbeBLFGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 00:06:37 -0500
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak8 ALT4 V4 0/3] audit: show more information for entries with anonymous parents
Date: Mon, 12 Feb 2018 00:02:20 -0500
Message-Id: <cover.1518411444.git.rgb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More than one filesystem was causing hundreds to thousands of null PATH
records to be associated with the *init_module SYSCALL records on a few
modules with corresponding audit syscall rules.

This patchset adds extra information to those PATH records to provide
insight into what is generating them, including a partial pathname,
fstype field, and two new filetypes that indicate the pathname isn't
anchored at the root of the task's root filesystem.

Richard Guy Briggs (3):
  audit: show partial pathname for entries with anonymous parents
  audit: append new fstype field for anonymous PATH records
  audit: add new filetypes CREATE_ANON and PARENT_ANON

 include/linux/audit.h | 10 ++++++----
 kernel/audit.c        | 41 ++++++++++++++++++++++++++++++++++++++++-
 kernel/audit.h        |  1 +
 kernel/auditsc.c      | 12 ++++++++++--
 4 files changed, 57 insertions(+), 7 deletions(-)

-- 
1.8.3.1
