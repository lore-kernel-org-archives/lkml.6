Return-Path: <ji_hun.kim@samsung.com>
X-Google-Smtp-Source: AG47ELsSTomeaIGg64obkZB1MtrQJiT/4kKB+0Kswor4oB0TdHU59SsYx7limXJRZehuP1myylnh
ARC-Seal: i=1; a=rsa-sha256; t=1520921460; cv=none;
        d=google.com; s=arc-20160816;
        b=jGXVHO6yZ69FzPgeXgDH3WwrykeS6bMB3plPSXlx4Ss2SMtdti2RYQplySv5Cxv3U1
         97R4yqODHRX1R+6qxLwVDaZa8Xp2wMUYk29EDn7NeI1NiKI7wxuzJU+4qFYg6cIFKCAh
         LAQwbWGDAUwBL4Qg8qFWePT4r68m9BN4ziNegov2GJ2kJSjye5+Jt9kp1IrVL4fGiWC9
         iZpKIFn4YqHzX21RR0dDmx/GdOTW/0Qcr85zy9SrxYaBZ7nSTvOgIxt17VHR8K0D+6Gt
         pSYuVX1GYA+ZNrsY9Ww6lzlRH3fLvFTyBFkSwFQej7ULkOoI2QP2oQCDJj9gGcKxPexm
         TPRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=CqoXZxx5L4XYQLAtE888M8Xukucb03p4GghDrysTkdM=;
        b=GyQBNB958scZWcd9DObXfECFzcMfKL7GE/3OGK+XCw4xVjy3vQcP4kWhZjTgXx894j
         lV8ITC/Q/FueQqHMnai5nlo1R6b4b0J3LBitKhxpFlNvlynhX3q2F+rPYHahtok6diHp
         nt5oeFr/rJPbHBz6S0YRPPfBJ8boTtiB+qT8EBdipuYt7L796lIvC14HglE9KZsErjAg
         JjLlzdaeUrCPlLHZ2ByXEfpA5mN7pQxN/iUSdCBrKgYLld5ag0rt/obow/1bHb1nmpLX
         ZrbU4BCTPp/v2gRxHJ8NeMcBszG/Wz10LhWnRJG3L2RxhTkZarmWUodoVy3I9MyxpVeZ
         1M3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=KUekjZHq;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.24 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=KUekjZHq;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.24 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180313061058epoutp01a306ddc93f44beea3de572aff4d27c20~bZgIcMgBR2853728537epoutp01y
X-AuditID: b6c32a39-47fff70000000fc5-34-5aa76b1871d1
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: gregkh@linuxfoundation.org
Cc: julia.lawall@lip6.fr, shreeya.patel23498@gmail.com, arnd@arndb.de,
	himanshujha199640@gmail.com, joe@perches.com, hdegoede@redhat.com,
	srishtishar@gmail.com, devel@driverdev.osuosl.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Ji-Hun Kim
	<ji_hun.kim@samsung.com>
Subject: [PATCH] staging: rtl8723bs: core: rtw_cmd: remove unnecessary
 initialization
Date: Tue, 13 Mar 2018 15:09:15 +0900
Message-id: <1520921355-31348-1-git-send-email-ji_hun.kim@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKKsWRmVeSWpSXmKPExsWy7bCmnq5E9vIogw/NAhZ/Jx1jt9hz5he7
	RfPi9WwWb45PZ7KYtqaF1aL/9HZGi9n3H7NYLHtwmtFi6y1pi8u75rBZrNjwnd1i08xFzA48
	Hr9/TWL0uLfvMIvHzll32T32z13D7rF3S5bHl1XXmD3e77vK5tG3ZRWjx+dNcgGcUak2GamJ
	KalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUAXKymUJeaUAoUC
	EouLlfTtbIryS0tSFTLyi0tslaINDY30DA3M9YyMjPRMzGOtjEyBShJSM3bu62EsmMda8Xnb
	UqYGxh0sXYycHBICJhJ7PvWB2UICOxglHt0U7WLkArK/M0ocOzyPDaZo8t6bTBBFuxklJv9M
	gyj6wSgx9cssRpAEm4CmxMbua2C2iICcxJPbf5hBipgFljNJ3HrQDDZJWCBcYnvbQnYQm0VA
	VWLJy/1gcV4BN4l3H58yQmyTkzh5bDIrSLOEwAY2ieXv17FDJFwk3nV/hCoSlnh1fAtQnAPI
	lpa4dNQWIlwtseAKzGs1Ejf/L2WCsI0lensuMIPYzAJ8Eu++9rBCtPJKdLQJQZR4SNz6+YUV
	wnaUOH19GyPEw7ESLxeuY5nAKLmAkWEVo1hqQXFuemqxYYGpXnFibnFpXrpecn7uJkZwEtKy
	3MF47JzPIUYBDkYlHl6D5mVRQqyJZcWVuYcYJTiYlUR4lf8DhXhTEiurUovy44tKc1KLDzGa
	AkNjIrOUaHI+MEHmlcQbmlgamJgZmZoaGliYKInzBgS4RAkJpCeWpGanphakFsH0MXFwSjUw
	Ni64yL70u7Hs+Tdbda9tONvssVfo78Kl1dVSdqvvevrc7uVZ+f+98dVtJzeUb3UwZ66/u/CY
	kqGWC6/a1TunZ8jXhVbds6o7ImmUeeaTWLVB3sYDrdcPpQa9ZvfQN7QJr2+Un2f7Varo5u0z
	M9PP134Q2NRna13odDG6SHKrzPzTKbz/JJ8lKrEUZyQaajEXFScCADa++dlYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsVy+t9jAV3x7OVRBrevmln8nXSM3WLPmV/s
	Fs2L17NZvDk+ncli2poWVov+09sZLWbff8xisezBaUaLrbekLS7vmsNmsWLDd3aLTTMXMTvw
	ePz+NYnR496+wyweO2fdZffYP3cNu8feLVkeX1ZdY/Z4v+8qm0ffllWMHp83yQVwRnHZpKTm
	ZJalFunbJXBl7NzXw1gwj7Xi87alTA2MO1i6GDk5JARMJCbvvcnUxcjFISSwk1FiRlMLM4Tz
	g1HixNYGdpAqNgFNiY3d1xhBbBEBOYknt/+AFTELLGeS6DjexQySEBYIl9jethCsgUVAVWLJ
	y/1sIDavgJvEu49PGSHWyUmcPDaZdQIj1wJGhlWMkqkFxbnpucVGBYZ5qeV6xYm5xaV56XrJ
	+bmbGIHhtu2wVt8OxvtL4g8xCnAwKvHwdrQuixJiTSwrrsw9xCjBwawkwqv8HyjEm5JYWZVa
	lB9fVJqTWnyIUZqDRUmc93besUghgfTEktTs1NSC1CKYLBMHp1QDY/RrCdHWqBaFPbYhWdfN
	f/7UXxGf5/j9ylPeZcun/00pOmjfzKR9supa1CIe/umBBvEVte/vmF3LNIrsD6t9M9/BUvDk
	stNBp03c1/+exsF/yn/evxLpJ6yhyyeXF03u+PfWLTS8MVfm4lY9pwTX7ZmKJXNDuGev014t
	eb+iKdBCwG1arcNGJZbijERDLeai4kQA6fZEtzMCAAA=
X-CMS-MailID: 20180313060927epcas1p4a11e5ed88c7760b5a54b5c2bdf753b66
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180313060927epcas1p4a11e5ed88c7760b5a54b5c2bdf753b66
X-RootMTR: 20180313060927epcas1p4a11e5ed88c7760b5a54b5c2bdf753b66
References: <CGME20180313060927epcas1p4a11e5ed88c7760b5a54b5c2bdf753b66@epcas1p4.samsung.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594801742011558465?=
X-GMAIL-MSGID: =?utf-8?q?1594801742011558465?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Clean up checkpatch error:
ERROR: do not initialise globals to 0

Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index af0a9e0..9e132f9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1742,7 +1742,7 @@ u8 rtw_ps_cmd(struct adapter *padapter)
 	return res;
 }
 
-u32 g_wait_hiq_empty = 0;
+u32 g_wait_hiq_empty;
 
 static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 {
-- 
1.9.1
