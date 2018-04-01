Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754708AbeDAUot (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 16:44:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754185AbeDAUoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 16:44:46 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 45/45] C++: Move initcall_level_names[] to __initdata section
From: David Howells <dhowells@redhat.com>
To: linux-kernel@vger.kernel.org
Date: Sun, 01 Apr 2018 21:44:45 +0100
Message-ID: <152261548549.30503.17477120572899326312.stgit@warthog.procyon.org.uk>
In-Reply-To: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move initcall_level_names[] to __initdata section for the moment as g++
doesn't want to put it in __initconst:

	init/main.c:876:20: error: 'initcall_level_names' causes a section type conflict with '__setup_str_set_debug_rodata'

Signed-off-by: David Howells <dhowells@redhat.com>
---

 init/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 642e917387db..6d404fc07007 100644
--- a/init/main.c
+++ b/init/main.c
@@ -873,7 +873,7 @@ static initcall_t *initcall_levels[] __initdata = {
 };
 
 /* Keep these in sync with initcalls in include/linux/init.h */
-static const char *initcall_level_names[] __initconst = {
+static const char *initcall_level_names[] __initdata = {
 	"early",
 	"core",
 	"postcore",
