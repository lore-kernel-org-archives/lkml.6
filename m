Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbeEBHvO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:51:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33853 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeEBHvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:51:12 -0400
X-Google-Smtp-Source: AB8JxZpbBZyE1JuUbrQG08br+h8idjKeD+k7pnyqcNc5UquA49zBJLkCMDMbGrskSvToDzkBPzu7Ag==
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH] doc: botching-up-ioctls: Make it clearer why structs must be padded
Date: Wed,  2 May 2018 09:51:06 +0200
Message-Id: <20180502075106.7476-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This came up in discussions when reviewing drm patches.

Cc: Eric Anholt <eric@anholt.net>
Cc: linux-doc@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

--

Aside: I wonder whether we shouldn't move this to some other place and
rst-ify it? Any good suggestions?
-Daniel
---
 Documentation/ioctl/botching-up-ioctls.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ioctl/botching-up-ioctls.txt b/Documentation/ioctl/botching-up-ioctls.txt
index d02cfb48901c..883fb034bd04 100644
--- a/Documentation/ioctl/botching-up-ioctls.txt
+++ b/Documentation/ioctl/botching-up-ioctls.txt
@@ -73,7 +73,9 @@ will have a second iteration or at least an extension for any given interface.
    future extensions is going right down the gutters since someone will submit
    an ioctl struct with random stack garbage in the yet unused parts. Which
    then bakes in the ABI that those fields can never be used for anything else
-   but garbage.
+   but garbage. This is also the reason why you must explicitly pad all
+   structures, even if you never use them in an array - the padding the compiler
+   might insert could contain garbage.
 
  * Have simple testcases for all of the above.
 
-- 
2.17.0
