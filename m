Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbeDAKRc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 06:17:32 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33151 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753338AbeDAKRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 06:17:30 -0400
X-Google-Smtp-Source: AIpwx49fNjTzpVgP7N+JBKsiHSzF85jOV5QyreLhAETBzLy4pdp6t7sdsGcFKBxruDGu3Hq9ZPKLKA==
Date: Sun, 1 Apr 2018 10:17:27 +0000
From: Sargun Dhillon <sargun@sargun.me>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp, keescook@chromium.org,
        igor.stoppa@huawei.com, casey@schaufler-ca.com, jmorris@namei.org
Subject: [PATCH 0/4] security: Split out hook definitions into
 lsm_hook_types.h
Message-ID: <cover.1522577650.git.sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves all of the LSM hooks type information into a separate file,
lsm_hook_types.h. This enables us to use this file, along with macros
to generate the security_hook_heads struct, as well as the security
hooks union without having to duplicate definitions.

This will be useful for further datastructures which want to use
the set of security hooks in a completely unrolled way, along
with the type information there within.

A couple uses are already taken into account:
 * initialization of security_hook_heads
 * generation of the security_hook_heads datastructure

There are a few things we can follow up with, including:
 * generation of security.h
 * generation of datastructures such as static_keys for performance
   enhancement

Sargun Dhillon (4):
  security: Move hook definitions from lsm_hooks.h to lsm_hook_types.h
  security: Refactor security hooks into structured hooks
  security: Make security_hook_heads use definitions in lsm_hook_types.h
  security: generated security hook initialization based on
    lsm_hook_types.h

 include/linux/lsm_hook_types.h                | 1669 +++++++++++++++++++++
 include/linux/lsm_hooks.h                     | 1934 +------------------------
 scripts/gcc-plugins/randomize_layout_plugin.c |    2 -
 security/security.c                           |   17 +-
 4 files changed, 1691 insertions(+), 1931 deletions(-)
 create mode 100644 include/linux/lsm_hook_types.h

-- 
2.14.1
