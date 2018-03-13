Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3014247-1520942927-2-8838319235333888186
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520942926; b=Gd0QmtLyczrrQu1JWpW2q44D7jCl2XGlmYVN7C9QTT5kB9h
    Y/uMDl8uk5dZOKwoaZWwtDPvFxgAdClGDEtoKQw0B3gvk+A1rIPOGN2ZmRvV4LnW
    yNOCOCu1oPN+FoTvmYJYHrNEATTan8wzrjc8xKA1EX1FNvTx34/YWjpCZIpxO2ea
    TqOyiXFu4PyH+PaMiqVj7pBuxZ00ojIAsprEzMFAh6gJ6W7+RFn7EYcrdGddROdK
    r8nMLBHEBIVJ7jEjRhcI92hcQ1AXXTDMucfZvhZcSeQbWg6HlakumRY3OYhmmZ8a
    jOIjmSYOME/gnqq0C/7WxsdpyRdXD/IoEac6GcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520942926; bh=PDp6IdM3+RhxsFaTpC9XGLp/8B
    yp2Nyli7uhNMlRw5U=; b=Q6z7QXJXeUfjHYJwTzs64dV9gxMyTCbh5vMpKk04XI
    AV4AFHdoQU770EvhdXjbkihYibIW+8ehLbP1uKk5Fxbhw6YhDT7YZkpqlZpvTZOo
    9QMUZ3WgmvpvD9m0V7LNkYc6vSqY6nxwQcXogXRcPUI4Z4Ouw7mGmHgRjbFkOvup
    1R0TnSV0cfIVg4pCMZ7vwkcnzKyxApmZ025QbfdhNAjGOTe8O+NJumeZwBsZMyA4
    A1k3zNNnjdmhE9ewZspHjT7NNhRYuA2vCQBS5j72NrPTl+4ilPSVEgS6gDTuV7DD
    +tZ3UXl2W12C5cwW0RJpX3WFKlvzE2Ki+BL8FkhDxyCw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbeCMMIa (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 08:08:30 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:35325 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932891AbeCMMI3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 08:08:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, linux-kernel@vger.kernel.org
Subject: [PATCH] h8300: remove extranous __BIG_ENDIAN definition
Date: Tue, 13 Mar 2018 13:07:28 +0100
Message-Id: <20180313120752.2645129-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:5KsR3Z1yojKHy5Y74Iy0PpyUgtWfJUmTVynDxs02Er3q3/dn64p
 FWog4ppmjBiEcHf+eKFmy/AJ/9Rj3PrKqlEOij4LHToY0NuwnvfB8DG8QOlMvBzkHoeNyNl
 m48iXS/iWmq8KUprQBL6ofq8AQeynIYx7SD3477A9sghUFyAap/15Pn/PdVX8QEZanHMpcj
 TUrhmrSRlLVYwfLgtHhow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0TSW1c1dtFw=:BhUuKInAoZk9rOKVEdHJq7
 IJ93kRSnuF2tkKh93SgPopDNK2y7+PdGzuVxiki/5VsKf2dzQPa3i6ccNt/P/oDQLNsiyHVKU
 5H5MmGuOkG3Bm2SQR1vfMAZZQI64VS9OfOeeITWLhXP9k6A/qqzAKVe7eDVeX1tq4bo85HSHD
 JClNp2iw8lr+lFtgb+eLQshUww2uzE7uZ/3qE+vZX0EtEvUiCgsRfXHPzN0bv6RO2hw7et4jy
 b7PsTVGG0j4Z8s8aqH6IvCxLmC0yu4pO3SD3B6WIOqmbtx8dLWqrZzJfFGLdqCQS7H4UY+AAI
 vOabfUIDNkADXEvrP3CWMjptP95dZ3N5rsziESDUih5qJTxyziAFDvIYFKl1IAHQvp19DoqDp
 8qbnL3VJkEtUaWVjF1A17JMrZl5SUwedmlIuNn4S7UZAh8iwxQ2ICCakfz6Yfr6TTsg4qhMSh
 fJl762BaGnHhVRTmvMEHdDRsjiGUgCaf1NxgRjDN9OogE05ItKpddBg0akpnaE64AjZkDhlhH
 0yGJmzSPGTT3+2zZysvDjydRUH472F4KTZl4OeSemJGMmECuSoOqddO2AxQ0LdsXYG2uuxqH9
 +ujI51R9TCRKuobxRNkbypbO4c0fcm8suxzsC1QuJMtuN9MZKxl93eLuOLsMthdXipVGPxg50
 mxpO7bvUcQ2Yog86dpvpxBTKjopGjCcF92qqrdPZPy7o0ncr1q/qWwfL2ZjHWqDjfCtGehqIW
 3rCjrdczYbLIlsttS2itKA1zwox8iUf/7TXHAw==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

A bugfix I did earlier caused a build regression on h8300, which
defines the __BIG_ENDIAN macro in a slightly different way than the
generic code:

arch/h8300/include/asm/byteorder.h:5:0: warning: "__BIG_ENDIAN" redefined

We don't need to define it here, as the same macro is already provided
by the linux/byteorder/big_endian.h, and that version does not conflict.

While this is a v4.16 regression, my earlier patch also got backported
to the 4.14 and 4.15 stable kernels, so we need the fixup there as well.

Cc: stable@vger.kernel.org
Fixes: 101110f6271c ("Kbuild: always define endianess in kconfig.h")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/h8300/include/asm/byteorder.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/h8300/include/asm/byteorder.h b/arch/h8300/include/asm/byteorder.h
index ecff2d1ca5a3..6eaa7ad5fc2c 100644
--- a/arch/h8300/include/asm/byteorder.h
+++ b/arch/h8300/include/asm/byteorder.h
@@ -2,7 +2,6 @@
 #ifndef __H8300_BYTEORDER_H__
 #define __H8300_BYTEORDER_H__
 
-#define __BIG_ENDIAN __ORDER_BIG_ENDIAN__
 #include <linux/byteorder/big_endian.h>
 
 #endif
-- 
2.9.0
