Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757248AbeD0BLF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 21:11:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55502 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754728AbeD0BLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 21:11:03 -0400
To: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] documentation: core-api: rearrange a few kernel-api chapters
 and sections
Message-ID: <f05c8785-e9e1-0a5e-b362-50669b75d80b@infradead.org>
Date: Thu, 26 Apr 2018 18:11:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Rearrange some kernel-api chapters and sections to group them
together better.

- move Bit Operations from Basic C Library Functions to Basic
  Kernel Library Functions (now adjacent to Bitmap Operations since
  they are not typical C library functions)

- move Sorting from Math Functions to Basic Kernel Library Functions
  since sort functions are more Basic than Math Functions

- move Text Searching from Math Functions to Basic Kernel Library
  Functions (keep Sorting and Searching close to each other)

- combine CRC and Math functions together into the (newly named)
  CRC and Math Functions chapter

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/core-api/kernel-api.rst |   60 ++++++++++++------------
 1 file changed, 30 insertions(+), 30 deletions(-)

--- linux-next-20180426.orig/Documentation/core-api/kernel-api.rst
+++ linux-next-20180426/Documentation/core-api/kernel-api.rst
@@ -39,17 +39,17 @@ String Manipulation
 .. kernel-doc:: lib/string.c
    :export:
 
+Basic Kernel Library Functions
+==============================
+
+The Linux kernel provides more basic utility functions.
+
 Bit Operations
 --------------
 
 .. kernel-doc:: arch/x86/include/asm/bitops.h
    :internal:
 
-Basic Kernel Library Functions
-==============================
-
-The Linux kernel provides more basic utility functions.
-
 Bitmap Operations
 -----------------
 
@@ -80,6 +80,31 @@ Command-line Parsing
 .. kernel-doc:: lib/cmdline.c
    :export:
 
+Sorting
+-------
+
+.. kernel-doc:: lib/sort.c
+   :export:
+
+.. kernel-doc:: lib/list_sort.c
+   :export:
+
+Text Searching
+--------------
+
+.. kernel-doc:: lib/textsearch.c
+   :doc: ts_intro
+
+.. kernel-doc:: lib/textsearch.c
+   :export:
+
+.. kernel-doc:: include/linux/textsearch.h
+   :functions: textsearch_find textsearch_next \
+               textsearch_get_pattern textsearch_get_pattern_len
+
+CRC and Math Functions in Linux
+===============================
+
 CRC Functions
 -------------
 
@@ -103,9 +128,6 @@ CRC Functions
 .. kernel-doc:: lib/crc-itu-t.c
    :export:
 
-Math Functions in Linux
-=======================
-
 Base 2 log and power Functions
 ------------------------------
 
@@ -127,28 +149,6 @@ Division Functions
 .. kernel-doc:: lib/gcd.c
    :export:
 
-Sorting
--------
-
-.. kernel-doc:: lib/sort.c
-   :export:
-
-.. kernel-doc:: lib/list_sort.c
-   :export:
-
-Text Searching
---------------
-
-.. kernel-doc:: lib/textsearch.c
-   :doc: ts_intro
-
-.. kernel-doc:: lib/textsearch.c
-   :export:
-
-.. kernel-doc:: include/linux/textsearch.h
-   :functions: textsearch_find textsearch_next \
-               textsearch_get_pattern textsearch_get_pattern_len
-
 UUID/GUID
 ---------
 
