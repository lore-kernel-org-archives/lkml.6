Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968725AbeE3JJK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964904AbeE3JJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:09:06 -0400
From: Jessica Yu <jeyu@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH 0/3] lockdown/module: make module name available for module_sig_check()
Date: Wed, 30 May 2018 11:08:27 +0200
Message-Id: <20180530090830.20737-1-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

The changes here involve cleaning up load_module() (patches 1 and 2) in
preparation for patch 3. The general idea is to do some preliminary module
section parsing and set up load info convenience variables earlier so that
we could log the module name during the module signature verification check
if it fails. Right now the module name is not logged if signature
verification fails, and it would be helpful to know which module failed
loading.

Currently, all patches are based on the lockdown tree:

    http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=lockdown

But my plan is probably to take patches 1 and 2 through the modules-next
tree as they are generic cleanups, but I wanted to give you a heads up for
patch 3, which should probably be taken through the lockdown tree.

Thanks!

Jessica

---
Jessica Yu (3):
  module: make it clear when we're handling the module copy in info->hdr
  module: setup load info before module_sig_check()
  modsign: print module name along with error message

 kernel/module.c | 105 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 57 insertions(+), 48 deletions(-)

-- 
2.16.3
