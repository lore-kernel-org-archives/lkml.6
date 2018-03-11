Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932256AbeCKPUq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:20:46 -0400
Received: from mout.web.de ([212.227.17.12]:33659 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbeCKPUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:20:44 -0400
Subject: [PATCH 5/9] um/drivers/vector_user: Delete two unnecessary checks
 before freeaddrinfo() in user_init_socket_fds()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: user-mode-linux-devel@lists.sourceforge.net,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Message-ID: <cccfbd35-ddea-dd71-2538-7230d5f2b543@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:20:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:zXax/aZT0wsiTCVw7vRU5ZoMl/RgANnRp9QoL41CYE7mK6YpThp
 uiLTX881YOukL7+NLhUtjNqYKBBHzQ3Dpoeyc7tF0KFL0cpvwpm8fpm+lpNcPI73GQ/7W3+
 MMVeACSrOcvJq7EjqBw3FSyqltCt61I5oh5mY/xjERWBjPph+Sq8WGNgINvd0cIFQx4Bx0L
 E/ZAcBvAvpdOtpQyKa8ug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l9wl8tQipAg=:AxesVkkZRGb3yLJdUBJksk
 W0MToWC4r3j/KWoUolnBi5iHQ9w1NFNi4ODhSOOfp51KVfdutvYXrkXxrnnbAO7mXQOTTJfze
 3D0f/N5RBNwj4NXBrf6iPbSpscJPzxIw8w1r40Jdyu6w8PQFiQbD/EJkpC0SYVCcIItom4P2l
 W4NWS3GUR/XOpIz1K4fwGGwEy93q1Bsb7oaYCs/hayv2KSgK3ufhj6uhcuyDyFLPxD02z2v/m
 EiPEOKB8QQK/V7SVFJ5x/m6wDFN2ft8T29Oq6oJ2DnYYcCKxhojBvVJPzL3+eIv9HyqMxX1RT
 mDT0vwPf4f7+MP+oki+VPv2Lpfw+hX2VIrvvrBrXtHnM1V47g5bgVqCCy7SpRjBPKzZx2m07T
 s8vJFIoa/eUb1jGDlI0dFCJr3LDKswtf6yRR9lkrxuP/zUdTb1NlbtkyOUHIWxzG0sr2K3MoP
 G7bjzjoOKgZKIyaWb+GZd4QZlfVhet8tCn9QIYb8iB0GD80Imd0+v9c+gTaOxCEdJvnywMm4I
 uZeIZmvpF+DkutF/mhRWcF4w+Vo7tXNeyHMdGQnmnHPP5UdIANjvQEWxzcnfRbRqnnd1pl+Ns
 74CNBUpGC17i3uvAnd0NX9jGxgVI2ZISvlPWUYazBWEVpa9pjWkPAZRpm1/sCzaJUmJAdmrag
 RNkjVcpYeR6ayu4WzJBh6iiHoaLDyATPN6Gdn/VBWd5XJYo9neFW01rGoAib6sJKxE4KvWMl5
 duwfOa7YojGrSJdXINExufp/tR8YEKMRgFHgnGmwnZBw/k7UG4zDBYgg3tlGAQ/97PbITae/8
 3OACrKnUFBZAmg7W8waOjNvWLSNG8RPRqJPTFlx/nqJ3i9YICU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Mar 2018 14:20:46 +0100

The implementation returns from this function if a null pointer
was detected in the local variable "gairesult". Thus the check
before two calls of the function "freeaddrinfo" is not needed.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/vector_user.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index e831bd85cad4..2dee1e183387 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -384,9 +384,7 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 		goto cleanup;
 	}
 
-	if (gairesult != NULL)
-		freeaddrinfo(gairesult);
-
+	freeaddrinfo(gairesult);
 	gairesult = NULL;
 
 	gairet = getaddrinfo(dst, dstport, &dsthints, &gairesult);
@@ -416,8 +414,7 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 	freeaddrinfo(gairesult);
 	return result;
 cleanup:
-	if (gairesult != NULL)
-		freeaddrinfo(gairesult);
+	freeaddrinfo(gairesult);
 
 	if (fd >= 0)
 		os_close_file(fd);
-- 
2.16.2
