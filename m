Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750902AbeBPUXf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 15:23:35 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44538 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeBPUXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 15:23:30 -0500
X-Google-Smtp-Source: AH8x2253f9tfxe+SxNZDntEXye8UkizTucJonzh8bt0dmBFe9D18pMS8DvtSkpTgPoe7B1JytSNL4Q==
From: Ulf Magnusson <ulfalizer@gmail.com>
To: apw@canonical.com, joe@perches.com
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Ulf Magnusson <ulfalizer@gmail.com>
Subject: [PATCH 1/3] checkpatch: kconfig: recognize more prompts when checking help texts
Date: Fri, 16 Feb 2018 21:22:53 +0100
Message-Id: <20180216202255.25307-2-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180216202255.25307-1-ulfalizer@gmail.com>
References: <20180216202255.25307-1-ulfalizer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The check for a missing or short help text only considers symbols with a
prompt, but doesn't recognize any of the following as a prompt:

	bool 'foo'
	tristate 'foo'
	prompt "foo"
	prompt 'foo'

Make the check recognize those too.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d4040322ae1..2b404317daea 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2812,7 +2812,7 @@ sub process {
 				next if ($f =~ /^-/);
 				last if (!$file && $f =~ /^\@\@/);
 
-				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate)\s*\"/) {
+				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
 					$is_start = 1;
 				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:---)?help(?:---)?$/) {
 					$length = -1;
-- 
2.14.1
