Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932280AbeCKPTX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:19:23 -0400
Received: from mout.web.de ([212.227.17.12]:50467 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932155AbeCKPTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:19:21 -0400
Subject: [PATCH 4/9] um/drivers/vector_user: Delete an unnecessary check
 before kfree() in user_init_socket_fds()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: user-mode-linux-devel@lists.sourceforge.net,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Message-ID: <16c0e64e-01f1-4275-51cc-b56401f6f91d@users.sourceforge.net>
Date: Sun, 11 Mar 2018 16:19:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:y/pO4McOpkO6HQoWvEGuPinIqAXcJsZjDg0kFdZYhif0IpoulD3
 3XW384DTHhjzsNoGP6r8Qb14eMGvIQDfEYfSc5gId/ORp2Su67RkVHulqFtwrGt1DgliFV6
 OqqhaXyTzodbIMCFaf7x4+VFErPiL/dHfDza5WvFdxS9bItyQP021VYHMoclcOm6v1skmJf
 /RP/HNwYPpCG7Z5KC682A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZkHHzDE3kTY=:fig/FYcfL7oB7QRF/3QlDo
 0u/KBDW68yKxCaxh56RnoySBuRrkDAdO+P01SI9FfdXyumPhYJwL/0EWUVMe8cE5ofa+QJMWt
 /RvPFxOJKRbY8OG7jCQV+BmjY+08DH0UcxRCxoGxVE2PpKu2DSaNj0fJObS/bLyf4Fyn60kbQ
 u9g2LrYZzkil42ig3Wo8y1fLR44rW4F1PjCvCvIbOhtw2Qj+Gh4U2+HzUOTdDoNqi8yZj0x3j
 kzQ0JchiR+t3EaTBtbiTXMS+ZrXmEm/Z4gMr8L58+lgssIjRU0N24B3OufMWt+CeJBpfwEJVL
 CWoDvPFTr1k23H6C8G4hPlrRlcp4fELahOaMcNmC5B/Zto9OqxHMAlbM9iv0X2WVBzLSZ3PHO
 1SC/3yEZfGvlmIUZuAunydWmT65wnM2LDZD/PbTiPnIA6NxeNT6RNaIgx//cJzkfbfbL0vu4L
 5eNB5xF5sP4Pw9ekFSU3VSHWl0wWSvRE7SB9xw42p5SbgWzfjtPtbBDIHDIf6dvabmYOaIB57
 x6UHy67Q6PlU3VX/nGIsw4aHrNsdY00EXY0stDvfTs+oAmr/IfJcI3e8sGFZAicPGhuSSt2o1
 4xbtuZML2r3JB3jX6MzLB3LGVxv+qU8xfkyc+QYrmmAv8++jWkyej6Az9lT7ynY0xV9e2dTFI
 3aDuXgP/vU7HlsbdW/ZBJ3RglXZ0zG+RmdasfnYZWHa7Zu1oSQNv/R4e68eEfAHGBszFu0mYM
 OYy93xMuDnlhPmMRlKwnFA7SoQ8YduD1YhejZXxc94+pK6oUyPvIMavhWcnr3ZRWm57022rZD
 7hSYu4tJA5HpN5CAsTsybU76hFH+3wTdOS8yHttB4aL0qtLoEc=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Mar 2018 14:00:09 +0100

The kfree() function tests whether its argument is NULL and then
returns immediately. Thus the test around the call is not needed.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/um/drivers/vector_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
index 9cc4651990e3..e831bd85cad4 100644
--- a/arch/um/drivers/vector_user.c
+++ b/arch/um/drivers/vector_user.c
@@ -422,8 +422,7 @@ static struct vector_fds *user_init_socket_fds(struct arglist *ifspec, int id)
 	if (fd >= 0)
 		os_close_file(fd);
 	if (result != NULL) {
-		if (result->remote_addr != NULL)
-			kfree(result->remote_addr);
+		kfree(result->remote_addr);
 		kfree(result);
 	}
 
-- 
2.16.2
