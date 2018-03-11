Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932271AbeCKPZN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:25:13 -0400
Received: from mout.web.de ([217.72.192.78]:40837 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932163AbeCKPZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:25:11 -0400
Subject: [PATCH 9/9] um/drivers/vector_user: Delete an unnecessary variable
 initialisation in user_init_tap_fds()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: user-mode-linux-devel@lists.sourceforge.net,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Message-ID: <ed22974c-5c72-9a56-f67a-1ffab61f0646@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:24:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ZDWiHS4/3QJtbrun5LgxnZrVjOIF9pIJwhs2160Qh/guL+DMnyF
 JKJbNPXlrNC0Fh8maf43i5XqynV5h6zn8JWG6znnAucpOp05aoxFLNyKT/STMPkhD+fPMpr
 9u56FHUHEEslyr0dL+2w2Z1ZpTRjzlgavPkE4YKhF+zOC7+lUu9rH7hq+E+tmuhdDtke1p6
 znsvQuCgJXFhROjT8wsTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:v6u0G4dyXWs=:V5TqsqMcwMg1GILkUdjDRq
 063X1Ta8MgNvOYqK2Z7vV1FaMtOgYw//HQiMLhjU9ZnbCSM65e1Gib0VG2Xkvsb+coaD/7SBc
 J+DVcCZf30KO64DiDJ5YKf/p/v0MEuDURVfezwkOexM0qvAVkWJ2KGG7KeRm6FuXHDZXznVUd
 Ngvi/rJEfgX8ectS3/hmx/qNVXxWCGpLbYpUphAlCmqbnZpW5Dxv0rEQxTk9FTMy3a6jgVbRV
 0jVnhFg0rQU2smQ6023mTmQwwyEPxLxSRGEF4tRimqPaav/PP0qMl8oZ9g/QeDFuotYHoJndo
 IZd0h+htpZ+/SYVSJUN/599MZSgVTUgbKjQf7GUGBpneYF4QsiE3w1DDnsMb5nlQtXun4fp4w
 DKDRtmVc0dvGEOuDowsysiJlRkWkFT14XjmoOZEinzm/DJ8qwwy77YPPqEYpQt0tkqoIzqDZZ
 dYTJtZ9XBwopqzxjAoCgDVvi2y5/Vk8NWsaE1gYm9qFFyMDaE6mhxeufGLfKs9Gy/KiKRkFRU
 3tjVvY0yD/RqZNNCLf6Wh2lzUJGgxcy97ancN2JlOUO3oMOjH29t87JbMcHgzge+iKlQGYHIi
 MRpM1zYLdF3tPBgZs3PyZxVuIsDL6ym6Xvn/38zv+6/fCuFpLx9GPF0nnjkVHuBtDv4EaIJQI
 L58QaDy2Me6YBoJU989FJOBPtAAh9O48yOyb9SCc6sOL138frh6nuq5v0gQpUZJKsq1Fj6tTu
 YOh59pylFMFWtZlPtlMh9WKncG9Gsl/J2HHaAVZ5PS/QMmkX1Ich5rj9x7XvldabH58Bycv2F
 mdfeXMA3zY04TjaVNL1gtgXd6FsIpqx8xq3aFABzWW1iTRJ5Pc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Mar 2018 15:50:29 +0100

The local variable "fd" will eventually be set to an appropriate value
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/vector_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index bd625034a0f0..3bd510eded58 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -119,9 +119,8 @@ struct arglist *uml_parse_vector_ifspec(char *arg)
 static struct vector_fds *user_init_tap_fds(struct arglist *ifspec)
 {
 	struct ifreq ifr;
-	int fd = -1;
 	struct sockaddr_ll sock;
-	int err = -ENOMEM, offload;
+	int err = -ENOMEM, fd, offload;
 	char *iface;
 	struct vector_fds *result;
 
-- 
2.16.2
