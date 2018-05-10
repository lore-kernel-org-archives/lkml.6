Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933819AbeEJDJh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 23:09:37 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37253 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756495AbeEJDJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 23:09:34 -0400
X-Google-Smtp-Source: AB8JxZp/JRPFUWw92gZxYlMpWF86dy3sNDpERq0vSULK2E2hjDQ0hsb9jXboUYz+uJkb4unEDvToLA==
Date: Thu, 10 May 2018 11:09:21 +0800
From: Wang YanQing <udknight@gmail.com>
To: daniel@iogearbox.net
Cc: ast@kernel.org, corbet@lwn.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] bpf, doc: clarification for the meaning of 'id'
Message-ID: <20180510030921.GA25941@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>, daniel@iogearbox.net,
        ast@kernel.org, corbet@lwn.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For me, as a reader whose mother language isn't English, the
old words bring a little difficulty to catch the meaning, this
patch rewords the subsection in a more clarificatory way.

This patch also add blank lines as separator at two places
to improve readability.

Signed-off-by: Wang YanQing <udknight@gmail.com>
---
 Documentation/networking/filter.txt | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/networking/filter.txt b/Documentation/networking/filter.txt
index 5032e12..e6b4ebb 100644
--- a/Documentation/networking/filter.txt
+++ b/Documentation/networking/filter.txt
@@ -1142,6 +1142,7 @@ into a register from memory, the register's top 56 bits are known zero, while
 the low 8 are unknown - which is represented as the tnum (0x0; 0xff).  If we
 then OR this with 0x40, we get (0x40; 0xbf), then if we add 1 we get (0x0;
 0x1ff), because of potential carries.
+
 Besides arithmetic, the register state can also be updated by conditional
 branches.  For instance, if a SCALAR_VALUE is compared > 8, in the 'true' branch
 it will have a umin_value (unsigned minimum value) of 9, whereas in the 'false'
@@ -1150,14 +1151,16 @@ BPF_JSGE) would instead update the signed minimum/maximum values.  Information
 from the signed and unsigned bounds can be combined; for instance if a value is
 first tested < 8 and then tested s> 4, the verifier will conclude that the value
 is also > 4 and s< 8, since the bounds prevent crossing the sign boundary.
+
 PTR_TO_PACKETs with a variable offset part have an 'id', which is common to all
 pointers sharing that same variable offset.  This is important for packet range
-checks: after adding some variable to a packet pointer, if you then copy it to
-another register and (say) add a constant 4, both registers will share the same
-'id' but one will have a fixed offset of +4.  Then if it is bounds-checked and
-found to be less than a PTR_TO_PACKET_END, the other register is now known to
-have a safe range of at least 4 bytes.  See 'Direct packet access', below, for
-more on PTR_TO_PACKET ranges.
+checks: after adding a variable to a packet pointer register A, if you then copy
+it to another register B and then add a constant 4 to A, both registers will
+share the same 'id' but the A will have a fixed offset of +4.  Then if A is
+bounds-checked and found to be less than a PTR_TO_PACKET_END, the register B is
+now known to have a safe range of at least 4 bytes.  See 'Direct packet access',
+below, for more on PTR_TO_PACKET ranges.
+
 The 'id' field is also used on PTR_TO_MAP_VALUE_OR_NULL, common to all copies of
 the pointer returned from a map lookup.  This means that when one copy is
 checked and found to be non-NULL, all copies can become PTR_TO_MAP_VALUEs.
-- 
1.8.5.6.2.g3d8a54e.dirty
