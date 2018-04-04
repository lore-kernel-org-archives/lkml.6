Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeDDHrG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 03:47:06 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51050 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbeDDHrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 03:47:05 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180404074702euoutp012f973f62c5b8c7495b8365434c728a30~iLASmr7sq0960709607euoutp01R
X-AuditID: cbfec7f5-b5fff700000028a9-dc-5ac482f428f8
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To: Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org,
        Karol Lewandowski <k.lewandowsk@samsung.com>,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] ARM: decompressor: restore r1 and r2 just before jumping to
 the kernel
Date: Wed, 04 Apr 2018 09:46:58 +0200
Message-id: <20180404074658.28288-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.11.0
Organization: Samsung R&D Institute Poland
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7djP87pfmo5EGXzpNLPYOGM9q0Xjp7nM
        FjcPrWC02PT4GqvF5V1z2CwOTd3LaLH2yF12B3aPy9cuMntsXlLv0bdlFaPH501yASxRXDYp
        qTmZZalF+nYJXBkdVy8zFzznqDjXuZS9gfEHWxcjJ4eEgInE9xVXGLsYuTiEBFYwSpyfPJEJ
        wvnMKPF16SlmmKrLpy+yQiSWMUpsbFsL1s4rICjxY/I9li5GDg5mAXmJI5eyQcLMApoSW3ev
        Z4eo/8IoMfPEGVaQBJuAo0T/0hNgtohAgMTpYz/AhjKDFO14/w5sqLBApMTSj4/BilgEVCVO
        3ZkBtcxaYtqFZhaIi+QldrVdBKvhF9CSWNN0nQVkkITAEjaJg3MfskMUuUic/bgN6gVhiVfH
        t0DFZSQ6Ow4yQdjlEu/m7IeKNzBKfP6lB2FbS/xZNZEN4h0+iUnbpjODfCkhwCvR0SYEUeIB
        ZO5ihLAdJa5+fAx2m5BArMSkRxNYJzDKzkIKo1mIMJqFFEYLGJlXMYqnlhbnpqcWG+ellusV
        J+YWl+al6yXn525iBCaG0/+Of93BuO9P0iFGAQ5GJR7egAWHo4RYE8uKK3MPMUpwMCuJ8O5Q
        OhIlxJuSWFmVWpQfX1Sak1p8iFGag0VJnDdOoy5KSCA9sSQ1OzW1ILUIJsvEwSnVwOjXxiEU
        cFTD+L7gYwcVtpWLPeoOHteYX6Vmpeb1oPTP9Z/GcTHq353d+HZu7bn75sy/5+IvsisunSzv
        OtiZkOZbL1I8rWZC0ZfcPFU7Pgk1Pf5HTM9rzHoDPi0x3SsQ0S4pNcF1wsFdesERqxwLcxPW
        5n1iZzN3NchadPVcz3ZFBVX5C6tvKrEUZyQaajEXFScCADi7RggIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsVy+t/xy7pfmo5EGTzeJ2SxccZ6VovGT3OZ
        LW4eWsFosenxNVaLy7vmsFkcmrqX0WLtkbvsDuwel69dZPbYvKTeo2/LKkaPz5vkAliiuGxS
        UnMyy1KL9O0SuDI6rl5mLnjOUXGucyl7A+MPti5GTg4JAROJy6cvsoLYQgJLGCUm3KsHsXkF
        BCV+TL7H0sXIwcEsIC9x5FI2SJhZQF1i0rxFzF2MXEDl3xglVnzdwwiSYBNwlOhfegJsjoiA
        n8TdPweYIBq+MEp8XukHYgsLREos/fgYrIZFQFXi1J0ZbBC7rCWmXWhmgbhHXmJXG8Q9/AJa
        EmuarrNMYOSbheSkWQgnzUJy0gJG5lWMIqmlxbnpucWGesWJucWleel6yfm5mxiBIbrt2M/N
        OxgvbQw+xCjAwajEw7ti0eEoIdbEsuLK3EOMEhzMSiK8O5SORAnxpiRWVqUW5ccXleakFh9i
        lOZgURLnPW9QGSUkkJ5YkpqdmlqQWgSTZeLglGpgdPoetn/RJb4qtekd7y4eTp6md+C8UuSx
        Hwc0brv0PGex3McsU6G06sl7hvD3Tj2TA5z/pf9fm9S5bf5b05V29hbewet0E494fLlbW7/u
        Xda6hiC7jLppcUc3c/peKnuSu4Oh62uAAJu3zIMH5wNU+c4I3VJIzP6htPtg67MO3ocb11/Y
        NrHQTomlOCPRUIu5qDgRAE1KiHZNAgAA
X-CMS-MailID: 20180404074700eucas1p12cdb8b0de3da46c433e505555129c7e6
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180404074700eucas1p12cdb8b0de3da46c433e505555129c7e6
X-RootMTR: 20180404074700eucas1p12cdb8b0de3da46c433e505555129c7e6
References: <CGME20180404074700eucas1p12cdb8b0de3da46c433e505555129c7e6@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hypervisor setup before __enter_kernel destroys the value sotred in
r1. The value needs to be restored just before the jump.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 arch/arm/boot/compressed/head.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 182bf6add0b9..517e0e18f0b8 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -561,8 +561,6 @@ not_relocated:	mov	r0, #0
 		bl	decompress_kernel
 		bl	cache_clean_flush
 		bl	cache_off
-		mov	r1, r7			@ restore architecture number
-		mov	r2, r8			@ restore atags pointer
 
 #ifdef CONFIG_ARM_VIRT_EXT
 		mrs	r0, spsr		@ Get saved CPU boot mode
@@ -1365,6 +1363,8 @@ __hyp_reentry_vectors:
 
 __enter_kernel:
 		mov	r0, #0			@ must be 0
+		mov	r1, r7			@ restore architecture number
+		mov	r2, r8			@ restore atags pointer
  ARM(		mov	pc, r4		)	@ call kernel
  M_CLASS(	add	r4, r4, #1	)	@ enter in Thumb mode for M class
  THUMB(		bx	r4		)	@ entry point is always ARM for A/R classes
-- 
2.11.0
