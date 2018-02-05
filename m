Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeBEPOI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:14:08 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:53241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752933AbeBEPN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:13:59 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andi Kleen <ak@linux.intel.com>, Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>
Cc: nico@linaro.org, linux-kernel@vger.kernel.org,
        Wanlong Gao <wanlong.gao@gmail.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] modpost: don't add warnings for LTO-generated symbols
Date: Mon,  5 Feb 2018 16:12:52 +0100
Message-Id: <20180205151300.539874-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180205151300.539874-1-arnd@arndb.de>
References: <20180205151300.539874-1-arnd@arndb.de>
X-Provags-ID: V03:K0:HfiFsrmLuFcEBM9q+cKCfOl2SheuK7uIeIYfeISntpAdhkfUEG8
 SYWy0IAbcPU/F1af8+jDLNpMApvhE4Fu8kSYNGDiqrPUDEfBeq/E3kXKE3qJRYqn7swVksN
 SrT8iVLmQfDvLoQFN1yHI8XG1t9wE4m4wWzzcQZEolgTaS8TbNdnftXDh3pAe8YNs3XR0Ub
 TOeewhG5M0n2vD1fKjSNw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:E/TbT/cVDug=:+5fE1KuU410su1SrbgXdlm
 FAoby2xA6k1Q0obtm8VM+k620nIFHYdjj8tP44PCHnAGHDsDBImKPnUFzHGjo8eFr1Kar9Hjh
 eUR7PWIFq6QNHH42qI4PhEMH2BlsUTL+xG9J0MVMYowroJeWOs229rhMTitjaNaKmw3sy/Cnx
 Iyr7Y6t/PqeOadHkJQ6+okRWe9gFChoMLqNK6fGbNLEp18o+NqqaLb/iWpzRJ9prFT4CdFMKC
 ZbUtDhFuUA+6hw97QsdP80srycVl9KOWqVY43wiHM9lqIFS/MOUr8SIBmqetP+3QEphSaT/G9
 gDRml/d9qaBKuZtX2Glmx9nZIgzorO2RhZyOaQvAvhcYm/in2EOmxK8RbFYEq75ETJiD7aK+c
 WGcc53Uo4Zwyq8foiViQKhYHRjQ/eWCHggJc6m9QG+1zSR86UilLWC0WkhrcJAW3mkNd92HnJ
 3pSFqj7OLIkYYXDqT0UadjmO4sPGiBi82ks7bpMEmd/Fwnnpwr82Z4nwRgy6u92ucoqET8xCq
 OSrB3andWLtmwQSb0wh12IUNr6Lb0L/AH4Ul3zik13iTTWobgZRK4lUXbML3FLQMwyH7nfl5r
 bY8PtYpD/biDw3ou8uX3I1Zwbz6I8JFTi06fCYaSjMoiEki+Qvy5UtH9UCBE2elAVNfvQAzAX
 auhD5wNHNdYstvbY0im2w+RLeveJLIDT8PeNvCOjRJVJ9fYAqhJRtkBXNPerghW5x1JOl9MtJ
 btRvdR3xH1S0NVpQUW/lceww44Pf4kxlTUnC7w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: vmlinux.o(.data+0x12e0): Section mismatch in reference from the variable pfkey_net_ops.lto_priv.2992 to the function .init.text:pfkey_net_init.lto_priv.2977()
The variable pfkey_net_ops.lto_priv.2992 references
the function __init pfkey_net_init.lto_priv.2977()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f75224d59294..8a8a473cee08 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1027,7 +1027,7 @@ static const struct sectioncheck sectioncheck[] = {
 	.bad_tosec = { INIT_SECTIONS, NULL },
 	.mismatch = DATA_TO_ANY_INIT,
 	.symbol_white_list = {
-		"*_template", "*_timer", "*_sht", "*_ops",
+		"*_template", "*_timer", "*_sht", "*_ops", "*_ops.lto_priv*",
 		"*_probe", "*_probe_one", "*_console", NULL
 	},
 },
-- 
2.9.0
