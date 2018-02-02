Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeBBQWV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:22:21 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:50294 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbeBBQVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:21:33 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@linux.intel.com>
Cc: Nicolas Pitre <nico@linaro.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6/7] Kbuild: lto: clean build artifacts
Date: Fri,  2 Feb 2018 17:21:03 +0100
Message-Id: <20180202162104.2300532-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180202161550.2106846-1-arnd@arndb.de>
References: <20180202161550.2106846-1-arnd@arndb.de>
X-Provags-ID: V03:K0:Q1tpS3sWZ5LNeV0el4my5icWFnLMwoMc+8eoN7V3rt5qwXJuzQ8
 vtGU13j1C9xMJsLIEv7EsNn9CsyZ5lo0q/dSqI6FT9QppVG7WB1NajeZiF/dN97kNSEdMv2
 ANuasXrS4Poz+3emQBbyrmrRT85DQUrq92OWbzC+dMhLcD1UhfkKTBNK3XyyAIa13xVFDVE
 SN6aiXKdt/FN06bBO1p6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RWiW4QIXb4c=:1Q4uXSpidCYq2vVAjTNwZd
 0k+FQ78LOWPtd92fMTBUMoF3pe6xPsYu23LUOt+u8ttFjYcWhjDtaJ1G6bxnv2wyCnQJW6hsv
 /sDahi74CGuj4Om9RoyKOb/vGL2f+k+LW1uTlp2banOv1lpPzjVJgIlmAO5Xa7oWvVgR3Hdd7
 S6tIyatXO7r05c5z2afhJRO0RWIqYCzPfInjhOS39GJtUexIYi4cJ51iEVl+QfD09niPAJOxb
 r3uLW3GbOoFSK3acLKy74H8WuFyCeBNRsHPof/dG3jnQzXf8YdO29sVMvzYQR/8c6j4rh35dA
 tClPoT7qJJcdxI5ouOgvYbQZ90gxnW4zhV0xV1IZJyUUepGIAjUmkC4c41dS1WbKIIVimq3fZ
 EFi4aJCqMYnFdMSootJTCR7rxAme2OPQamgSJ7yy+FvyWb5qsytymz9C5zSREouW2oxT6lP1t
 rxcP6Hv8D0EyhmyWVb8XxhIJiD92TF9Vg08Arv/Mfl26rxE5tbOfLCXzfLyn4KVeOyG5rfOw3
 XhoBkPlYZ8sQAhvu1SjTJA6xQMsGRT06PiDya71GpEBcE8KuWecOa8vJhy2oUpp3+wayKdtga
 xvOLvWWaREoEwzHh+SyIxDnV2boAyNGxi96t+wxl0ZqPn7c3XKSNFFXAAg+HCAEBoh0elG9OL
 rxToquRiW65cJpkng2jOedOHRAPW4MAT6Yp1J/AGttk/TkAfAsKALSkqD6Bifv9DUCLgtSyzP
 5oSpGG2ulqM2svtyn8Ea/6ucGp3kvORvEJRxlA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During test-building I filled up my disk with stale files
that never got cleaned. This should make sure we remove them
all.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/link-vmlinux.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 964b2ee855dd..130df0781072 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -113,7 +113,7 @@ vmlinux_link()
 				${1}"
 		fi
 
-		${LDFINAL} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}		\
+		${LDFINAL} ${LDFLAGS} ${LDFLAGS_vmlinux} -o ${2}	\
 			-T ${lds} ${objects}
 	else
 		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
@@ -195,6 +195,8 @@ cleanup()
 	rm -f System.map
 	rm -f vmlinux
 	rm -f vmlinux.o
+	rm -f cc*.ltrans*.o
+	rm -f vmlinux.o.* vmlinux.ltrans* vmlinux.wpa*
 }
 
 on_exit()
-- 
2.9.0
