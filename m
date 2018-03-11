Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932224AbeCKPQe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:16:34 -0400
Received: from mout.web.de ([212.227.17.12]:55611 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932118AbeCKPQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:16:32 -0400
Subject: [PATCH 1/9] um/drivers/vector_user: Delete unnecessary code in
 user_init_raw_fds()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: user-mode-linux-devel@lists.sourceforge.net,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Message-ID: <a8ec6fce-df95-10a9-6dd7-3604fd403d0d@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:16:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:+J5lgW8tPCShh8+PC1Di65e017cePu6h7fCBuGGrOyB+8i/SzcN
 x+HCDA5nMHZKEY6W3ovyL8ksFxrUmX48bvGwePRsvRuVoBJdTOMm4GSmU/5FH1sZlbBrmBi
 FrPKx27DmpYuwCWS51henM+Rm3/MjyKGXatsJnoYxOTUj8uHFBWpDSG5ofJLVgSaNDFMR74
 Yp0Dv79eMUjQa9/DF1zrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LSfaxyr6pso=:8c2sJ0wOuFdNnP7Wfeqfeo
 kK47/TxL7lejg7HoRuoNO7MmT4gokjh6Fmu72DI5NtyRiMEfg7+/f4iQGSwToFRDryuzvtYxl
 XPmrORyCMoc0teuBOf3QjBsojeBkUZjVznXvKmznTF+q3kOnNe85qjVEfhb9J6CvxMYsAlj4A
 MKYgxtax22gviLMFlxsglyom9LyK7yPIUiOr36DRZjF5DBCC042Z/N41ZQqnC2uwMSQuYQy1F
 zWsJOR1lpGWtlJszHXcQL/gQXxKW3Wykdy/LNV5tEt2FXzJqzD7fYNxQfJP7fvRi4b/LPCN1M
 7MLfOEgnNlxkhQUYdkKLBXyxCelI6O5kWfP2pfWmjGb2GokwB3+BOrTtNEprvVzCDNtmp+6Z9
 NGLkF7SOP470Ul2Z5l9aG+lx2b9FxCFi6npYCsnP6fe+cs+ErogFIyrX9c+C55TlPVFKj4WI4
 fYjm94YTDQORP23IPSOWy5NFHEOF+eSfu1bBIfxUoPNUQ2BCz9Icm7ijs4DyIuDQvCIpTVfF/
 DJy0QA+kLwCl0Q1wolD5MT5beOub4AEpnfc8q2HlNdik9t2lJ/25y3UXHPdcoCSAm1BoZliWL
 /m7X4X3ib7Esbp8sWMigkk9642XorbNMyXIahmLnge0XpH5ve0Q4izTWKBTTk62nzLIu+NEVp
 2iE3b3Ue98OZ8YPMSgZuMuRLyQdn31V2Znwa4kcOgab8iYJrT6WK83juRCT3/aOKEA/TB4uT+
 7w9ndg4M9l3fl8GCGc+K98H5AByH8/85Tm91kkAXfZLQRWrc51AsfIafBhExhzHioA9zF+996
 I63JTHwZpTuv1K0YKzxgLZSzjrHzUjJRU+RnxrShVLFwJL3FGc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Mar 2018 11:36:18 +0100

* One condition check could never be reached with a non-null pointer
  at the end of this function. Thus remove the corresponding statement.

* Delete an initialisation for the local variable "result"
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/vector_user.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 4291f1a5d342..d6a6207d4061 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -211,7 +211,7 @@ static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 	struct sockaddr_ll sock;
 	int err = -ENOMEM;
 	char *iface;
-	struct vector_fds *result = NULL;
+	struct vector_fds *result;
 	int optval = 1;
 
 
@@ -276,8 +276,6 @@ static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
 		os_close_file(rxfd);
 	if (txfd >= 0)
 		os_close_file(txfd);
-	if (result != NULL)
-		kfree(result);
 	return NULL;
 }
 
-- 
2.16.2
