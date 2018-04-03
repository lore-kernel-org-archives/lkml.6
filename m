Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeDCTRW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:17:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:60503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752675AbeDCTRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:17:19 -0400
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] checkpatch: allow space between colon and bracket
Date: Tue,  3 Apr 2018 21:16:55 +0200
Message-Id: <20180403191655.23700-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180403190214.23082-1-xypron.glpk@gmx.de>
References: <20180403190214.23082-1-xypron.glpk@gmx.de>
X-Provags-ID: V03:K0:0vYSF0fikT1yl123naZKs91yBnbCaOabmypzU2RI9KlU+X84P3F
 NtXGQnaJ9sCAJVF2YBkBsrbXEMpQ4IsuDbBwoFdM4Gt79mOOG/8lm4jy+dKAhNqZNx1lYk6
 BNiMc9azb85mQ/H+zdzyc5d2LPJsyJNTNlVyOjnuMx2LGkdi9BqDqyPUm1rW4yTqH6jceSq
 BgT5cWrWQyEjd0p23IPIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AgOkwy3HZnU=:zaWwqUkBqmMMrtAMTp6FxU
 KvCjVMxZp6ofU7m50a0l06Pr9KY855ABdhOikoG9HgBtCql0qM7cMewaxJRAxlhIUwG4/XdEq
 ZX5T4qUBKbBJjqV0NB7dodNJWzLr6L+3FAPtgeS9apgaRQAZ3urhM7vH+OMa9hi3rtYuo3zqS
 xVJdlnAIZ5q8+/ofTLVValGa6S+rN1d6KSHvNEvSORMk7fmn1aoMBwMDhs36rhirKDUxLSGj9
 GAi139sFwh/bkE3ZNLjjjA1urDiJ1UO6CrBGF5scdyitecEI4XMiBrs4qLZN8lSUPly71kIJS
 S6QiwOwqmpkA5x+8qsCP0cO8Vo6lSjt5t/ho22WCqwB1Kkx+LWtWFOXvMFqyVE/4PL951VWRl
 0BiqgU8cuCak3zTpqr6NJAW7bjCOvxY2Xm4tGmgPOvEsUaFjmmjumlxOg640/NBjrekRNTeGG
 PVeYNXFSB/BEJ/No/4SU/oIqGR3jeXtZIQENpQW6Qe7vRu9CojD4wmRGHdYu21nQ8OorizFdJ
 z8TBcofwTQJC/RHfUVpDpWzh1ILWNyVbdGADhJCvrEKH6Nfzlqbk+6coxKFxbO68pZf9Q02/3
 zCvQKwWbXP93/m+AoUGvt3EdNZcbxGxzCsJpAzGb1n1YPW56FHIFIe6Z+SYwlVBlYAcHaAojr
 xQpdqOykL6Wb2O15kAyqDIzv9poehgNG3VIQasmu0Lrsul0+VKng0UUSnTnMNsxN1BsMhtZ7F
 iVRJAdVcOI1Rr4OjQhKDPO2HezQ6UbEpiK7wZc69vsT3v0S1uiDX5iC7vYjcDFQBsv2UltA9t
 UNUYYU1P3pht2XxtFowBiO92qjxCA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow a space between a colon and subsequent opening bracket.
This sequence may occur in inline assembler statements like

	asm(
		"ldr %[out], [%[in]]\n\t"
		: [out] "=r" (ret)
		: [in] "r" (addr)
	);

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d2464002bb40..2cbab86e6d4c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -4083,7 +4083,7 @@ sub process {
 			my ($where, $prefix) = ($-[1], $1);
 			if ($prefix !~ /$Type\s+$/ &&
 			    ($where != 0 || $prefix !~ /^.\s+$/) &&
-			    $prefix !~ /[{,]\s+$/) {
+			    $prefix !~ /[{,:]\s+$/) {
 				if (ERROR("BRACKET_SPACE",
 					  "space prohibited before open square bracket '['\n" . $herecurr) &&
 				    $fix) {
-- 
2.16.3
