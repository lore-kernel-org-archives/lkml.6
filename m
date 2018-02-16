Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-399776-1518794873-2-12163378346196741677
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: to='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518794873; b=se3kZVxv8uoQVq9CDLyW4mY49u4mLiWWOruyvJgLy8/rc9O
    1Sv3LvWozikKhyJXE1jlqiq9hN6Ja6HYiXReIFYNb/OX2W/UKx1lotM+QsKObcbh
    toilT/BS4mcmfxI447LhNnuhrrS483eYbjt9WRjUDLso5QnTz0QsQxK4LInFU7EA
    f2xrIVTCwvNoPZYYzEH/MQOP9h6361frBtKGLYncQtK6PWzh5Rb5QxdrwSa0+q8l
    0X5dulrQH05KY+uSCpMe4/sZmOZ9uJcIO8EVU4hxKvq/ghmYg3vJHN3mfmTebq4y
    Eeka3qx5Uu7q7gwFMyJWKiAfW8D0upcnzUJ9DVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518794873; bh=sROmB3ZIAYDAHsGl2oWRjKn5KG
    NQO14FSbILvGwIWGQ=; b=RETQlFRtc/gBZiHH1uwPw7CXHU+/jDodYTkQxf/QBu
    a0O47AQl8dQcV1W/L5c67K0sHq/pKkYdGwemQSbG1o++M0CcCWr1m9MRUUKtj+EZ
    s9wu0XPjBsBRwoHNu/1wT0BYaYAdZfJQQaWozCAD0hP3c/KMXfJNXjcHq8LQjXTc
    sVfdOqqU56unz+b1+wZNKfiRdU13sPUe0zuXZ/IRevePsBtzSF03uwWqJgEBhSpb
    rtKOIhIpKit7f9KTStu9As0/QJK/1lwb/zWs45bDAkWZose0xMo6OuIh7aaY8vJ5
    TML5P+VopnTOqfAwTOjKtz20kaYovlwFXQx3Iri+V1CA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030205AbeBPP1j (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 10:27:39 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:37925 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966777AbeBPP1Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 10:27:24 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Julien Isorce <julien.isorce@gmail.com>,
        Kent Russell <kent.russell@amd.com>,
        Christopher James Halse Rogers
        <christopher.halse.rogers@canonical.com>,
        Cihangir Akturk <cakturk@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] radeon: hide pointless #warning when compile testing
Date: Fri, 16 Feb 2018 16:26:57 +0100
Message-Id: <20180216152713.1628013-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:7HIl8TMjfbgARLpOfK0R9jPulB0f9eguU+5e7NN1qU5XEsZBcR7
 CGgH/PNAQ6hYTe5aR4xs0O8c0ivSW1VMWmG0BAJrac2ePGzsBxaw0x9ZXzouV1rFZBiyutm
 POf32Bke4bq8KQDwFoJMbcCFbgcIF7M8SOTXuOseOeEa1V3EZ4gwr2o6SUzMj6TVlIjmKR4
 da7SqVIGm6NUScrZwx3Ag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:p6W9yiGQQ/c=:tOLfvxmvKStKUjx94JXEjx
 nptsFhHupBmncCZrR1V1bJCBYyXBR3QBs5MsPL7fipd+NJ2FF6XzHrnicJ0ZYU6IPVU7Mwynn
 zcSukgAC0qF0/2mXn3SJnnFC+ZjBNi7Ol7cg87EyzDxcblfTNTPQ1CEFRQ+67kdqxOli6JuTC
 w6lrlN+pdAgTOdUkfkgDnLO95jV7x0B9MRERofe3ZteGgC0JoHTVkBq7fj2yBX8BgDhY2wfV8
 808kUC9FGBcQdXogwhqoAcrWqTQ8zbtSQyL41BYaiHGCJvYqIJrn6Txb6wtWyEy6mL1gMo8C7
 /dCh35bVSXr0+io3LgdxxUzAvxibN5mFGT3apSgXvzArQvqglz/nxUBDu7eOvELc5DdJEvogf
 fWUSkdfPlsWG71kdnzzvMgB6C9nSvlCJx8T/tADueLDKtBuTzGHUcN+hL673j3ea97RkO/VIf
 2pIwoWkKPPnZla9/qeqiWej0JgE5j66rkx+wDsz8zd8ZqW5t2VHf3reWcPLumB3eKEKAkV4sa
 pcOsvaQxPHL+oMuYtxhuO9MkGx/DL6S2dRDHbgxHkTVcbgnaSjLuAsb93XssrFayx2y4AKLMJ
 sR8MbJ8AqF0WUj7BkvhgM2iUbeh5A4gV479BytX/Py8Zv6h/XG//2DhZGNSR9g6bj3u0K4HRk
 5fo35uzG0JKB4NPpwou0MtXhulL0C78TniPstk0tmVWZS605UktwSsT3bAs0y7MzPIzrsdeaN
 v6TbM0qZq/yn3NgcPDINjlvuEGKD6ccq2PxKDQ==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In randconfig testing, we sometimes get this warning:

drivers/gpu/drm/radeon/radeon_object.c: In function 'radeon_bo_create':
drivers/gpu/drm/radeon/radeon_object.c:242:2: error: #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance thanks to write-combining [-Werror=cpp]
 #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \

This is rather annoying since almost all other code produces no build-time
output unless we have found a real bug. We already fixed this in the
amdgpu driver in commit 31bb90f1cd08 ("drm/amdgpu: shut up #warning for
compile testing") by adding a CONFIG_COMPILE_TEST check last year and
agreed to do the same here, but both Michel and I then forgot about it
until I came across the issue again now.

For stable kernels, as this is one of very few remaining randconfig
warnings in 4.14.

Cc: stable@vger.kernel.org
Link: https://patchwork.kernel.org/patch/9550009/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/radeon/radeon_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index 093594976126..54c2b4fc5ead 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -238,9 +238,10 @@ int radeon_bo_create(struct radeon_device *rdev,
 	 * may be slow
 	 * See https://bugs.freedesktop.org/show_bug.cgi?id=88758
 	 */
-
+#ifndef CONFIG_COMPILE_TEST
 #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \
 	 thanks to write-combining
+#endif
 
 	if (bo->flags & RADEON_GEM_GTT_WC)
 		DRM_INFO_ONCE("Please enable CONFIG_MTRR and CONFIG_X86_PAT for "
-- 
2.9.0
