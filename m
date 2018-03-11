Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932261AbeCKPS3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:18:29 -0400
Received: from mout.web.de ([212.227.17.11]:35135 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932137AbeCKPS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:18:27 -0400
Subject: [PATCH 3/9] um/drivers/vector_user: Adjust an error message in
 user_init_socket_fds()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: user-mode-linux-devel@lists.sourceforge.net,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Message-ID: <0ba0e9fa-9987-055a-c065-3f36a06d045d@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:18:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:xEZSygjddeNMTOk4JMiU24b96DE3M73/FsRpFsZ3qO40B35miJz
 SCT3KDkBdPK0jP7HEaaQlOtaSy2zQ7BThW9xCseWwXziTEFQdbIQVbpfwsVscSlvlu6aJKu
 wWHxr481+rIfMQwmojkFTnAOovTeZm/K+6WaY6JaoumRciIXMehuyGeoS67fNrC13+ZXRFc
 0Yj+J000sZGkXLiLcsRjA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qX8J170FGs4=:kVqZCH7RjmIBEeSr891SpB
 fPh5Gg0cU1tUsUNgi5B9BbsTWaWgjmPnlGBpkbu0Kq0fRqcHBXEOqBT2a65fdprhx7BDkNTk2
 HC/ED79nJlT3Q4NLHqE1Dsgb4jbI85YdPT0PvqSbo1xmN/ZT/aBRSDD6P70s7DQnOCl650k8G
 Teh4hAZPqX1rSMq21FqBv4PMk0gDh3lHXoNBNjdmsNQducip/wAFxdLhXZ8AsERBvbMw7zgqX
 hAH/AfHCUu9x4oVugSQ0M7a1T8Ge9Vo+jDk7fi6Wk7Vc9Q8TFF3gZs0Gz6jp0yWiL7+5Ii+ml
 mvUhNtyQb33bgfI1QpimbLy3jysqn3TCUpbjo5qStkiUroHOWv0eVQRuCNwzLjNqF6dyDGDqY
 RmMT1VUBBWEa2crN6C1QQ/rodgBiGZC4c61/8/gaUolHa7bp89/V+FmD1LkD4P1rWGXJ2Dhu8
 jruGch1UbijQjOsfTydF8xld1hPDKHoj1qnmBQ+93EQ5C+QQpvuD7vCaemqI+A1tZJq0n1oJE
 lsXjzAaLywLea0V2+LZet6bpOQM7/9LK/juAHucDnsw4HSj7ZC6Nz0ayAzKDZ9Ydf9IG3qOSz
 7/IX3XkOTJO14FKg3KdS5RMGvpe90IvWYy9mx87d5BCxALJtYM3SwvM0FkB62n4Xd2Snpr3cU
 5OG4M1xB7K9kWMKcqaQf3i9gZnFFbWBg3Tb0ONQT6FRzApR7HSGJClD+OXCIpPv9GemFbm88E
 ycIaoUttVH1EFL6xoykexZDn1xPc6uhpL+7TUD9rOB88wnYJ6nJPNS2lPY0LnQsUhEaxTJTfb
 SqN3Lb9mmW6Apy2dhkuP/2g3NuzRKhcJ3sOqjU1CoH7LI1g/Cs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Mar 2018 13:53:08 +0100

* Adjust an error message at the end of this function.

* Delete the local variable "err" which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/vector_user.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 037cd85ee424..9cc4651990e3 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -305,7 +305,6 @@ bool uml_tap_enable_vnet_headers(int fd)
 
 static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 {
-	int err = -ENOMEM;
 	int fd = -1, gairet;
 	struct addrinfo srchints;
 	struct addrinfo dsthints;
@@ -419,7 +418,7 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 cleanup:
 	if (gairesult != NULL)
 		freeaddrinfo(gairesult);
-	printk(UM_KERN_ERR "user_init_socket: init failed, error %d", err);
+
 	if (fd >= 0)
 		os_close_file(fd);
 	if (result != NULL) {
@@ -427,6 +426,8 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 			kfree(result->remote_addr);
 		kfree(result);
 	}
+
+	printk(UM_KERN_ERR "%s: init failed: %d", __func__, -ENOMEM);
 	return NULL;
 }
 
-- 
2.16.2
