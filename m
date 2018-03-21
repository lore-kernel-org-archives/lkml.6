Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753419AbeCUUEU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:04:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53346 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeCUUEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:04:10 -0400
X-Google-Smtp-Source: AG47ELuWLk9GVLsWMU9GNuZUtj81G8EkPy71rbIh9OOOg2tyk9RtdbDvTptuiS6IMDDtPcTdCZ4Frg==
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Masaki Ota <masaki.ota@jp.alps.com>
Cc: linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: alps - Update documentation for trackstick v3 format
Date: Wed, 21 Mar 2018 21:03:36 +0100
Message-Id: <20180321200336.32035-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bits for M, R and L buttons are already processed in alps. Other newly
documented bits not yet.

Signed-off-by: Pali Rohár <pali.rohar@gmail.com>
---
This is based on information which Masaki Ota provided to us.
---
 Documentation/input/devices/alps.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/input/devices/alps.rst b/Documentation/input/devices/alps.rst
index 6779148e428c..b556d6bde5e1 100644
--- a/Documentation/input/devices/alps.rst
+++ b/Documentation/input/devices/alps.rst
@@ -192,10 +192,13 @@ The final v3 packet type is the trackstick packet::
  byte 0:    1    1   x7   y7    1    1    1    1
  byte 1:    0   x6   x5   x4   x3   x2   x1   x0
  byte 2:    0   y6   y5   y4   y3   y2   y1   y0
- byte 3:    0    1    0    0    1    0    0    0
- byte 4:    0   z4   z3   z2   z1   z0    ?    ?
+ byte 3:    0    1   TP   SW    1    M    R    L
+ byte 4:    0   z6   z5   z4   z3   z2   z1   z0
  byte 5:    0    0    1    1    1    1    1    1
 
+TP means Tap SW status when tap processing is enabled or Press status when press
+processing is enabled. SW means scroll up when 4 buttons are available.
+
 ALPS Absolute Mode - Protocol Version 4
 ---------------------------------------
 
-- 
2.11.0
