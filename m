Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754379AbeDAUmV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:42:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50636 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753931AbeDAUmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:42:17 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 20/45] C++: init/main: Constify pointers
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:42:15 +0100
Message-ID: <152261533587.30503.7461802756178219198.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ramdisk_execute_command and initcall_level_names should be const char *
pointers.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 init/main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 969eaf140ef0..642e917387db 100644
--- a/init/main.c
+++ b/init/main.c
@@ -135,7 +135,7 @@ static char *static_command_line;
 static char *initcall_command_line;
 
 static char *execute_command;
-static char *ramdisk_execute_command;
+static const char *ramdisk_execute_command;
 
 /*
  * Used to generate warnings if static_key manipulation functions are used
@@ -873,7 +873,7 @@ static initcall_t *initcall_levels[] __initdata = {
 };
 
 /* Keep these in sync with initcalls in include/linux/init.h */
-static char *initcall_level_names[] __initdata = {
+static const char *initcall_level_names[] __initconst = {
 	"early",
 	"core",
 	"postcore",
