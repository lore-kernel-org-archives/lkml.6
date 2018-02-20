Return-Path: <arnd@arndb.de>
X-Google-Smtp-Source: AH8x226GleNlrVKts3wxCh4LkR15OwX8UqK8j2Cmukx8jP61QWjHs532KDaVttSdhZ9jBQe3GJsA
ARC-Seal: i=1; a=rsa-sha256; t=1519127982; cv=none;
        d=google.com; s=arc-20160816;
        b=B6KebHMMShTOPOMjMj+4lHtwloBGZiraQTYHjegAjrOEXFM1VrRmVvUgmTuHOhNiy/
         jdTvPzrN6z3sjn5eRLWPa23tNPshHDikK4j9H5VFCFoxb+mvSzofc9pjTx8fWg2GNc6m
         ikJUq35lydeks6GYCpmNDj5qwLFhn0OBv7tMEz+8YbrU0V+bSR1XddmoHMEuTodZzK1h
         XsbKdg0Wo5/Ct/WlU6VvmYIq2m+rZWNFnDJi/awEVbsu5LYneJ24FY2+VSntzNBblVEe
         GG3+XO1VNK6kZONA3gsCL8w3xSuHWrhe3JatYT4SmSFxQ13x3hI6PwmOrD7e5C6m+aMY
         VMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=0MTWQo4aYCDaWOFb6buoMRjDsfmt8Ienmk+DfaF9Ojk=;
        b=t0U9tMQ3iQMJEOcGtNyCzVKBG9KZJYYpqO/K/y4jb6sS2fobitv/YIguLjN3Q+Fn+3
         yhYpKkcR+J6q/J6r8f665N0z8xcBobdZUHa4B96C0uPqLMF5m2pLPX5OsWICtAoi8x6r
         K34p3VULaL8F/qava0KHqgwVueHu40kIHr0S78VJWyaLQ8yMMOGmpuXT7YlxO4q1bTez
         bUA0g77Uc1FZzT0Iy9584hSskKO6Z+KZI3A1EhXXESha1Mo0KFW6/wjmD5Yl2jbx9mN+
         Tu8W3iwFWnruppQz3IvajCiOBEFGDrbmEui+u4gQUtOt8sImhOaf8GO08IaS/V5wRrqe
         yZmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 217.72.192.74 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 217.72.192.74 is neither permitted nor denied by best guess record for domain of arnd@arndb.de) smtp.mailfrom=arnd@arndb.de
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Kalle Valo <kvalo@codeaurora.org>,
	Solomon Peachy <pizza@shaftnet.org>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [4.4-stable 17/22] cw1200: fix bogus maybe-uninitialized warning
Date: Tue, 20 Feb 2018 12:55:04 +0100
Message-Id: <20180220115527.1806578-18-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:wogxyrLAeoVmOE3r29gJQXizDF10TMsXKGkb7qgte9xWgNQXIXV
 ZItIABqs8fnFDcJFHz9ZL5lvgYzWsuL242Xzyz6XLPs6eWeQzOFc8VEj4HMsXtrpBjtiUyO
 ur4fKY0/dQvYDG/sucXdH1vhItknyUh3kGkInc7JXKsYGRqEQ2vldH+4foOz3Y/je2yqFDW
 86BIGtC0UWsW1rU03iTQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vhbhmIYO6kA=:d0jNSAVvPX9pDsWukIZ82I
 yhlTLG0VwelRbFAxG34UmAPBdzJZD1op110upBwVOtIIzOl4kaXeYvIWfyj6bxktZ6fVx3yG0
 QaHkGkjAabxrL/QxUSkrNyZr2QtOVXRH/vqVXugxjE5UTxsXAZcrklkl7hqTj/pQVPeuOMstq
 AiyEDoKq3cHnQ/l06iAX36j3/EsAeFw45GpnqWqPiWCBivaoZRtPha35jmHDgh6iOuSoUryWu
 H0200kx2APW6oBslrqn+iv3EHN7/Uz68YWEpAMyuYL9dauFnKT9Q+g/R7/YtiCawujTdq6g3G
 HjQsMA9gHiWG0rABIcip+b0hDp0jFiPYuedBjdE2bj+htifFPyadZ8ycs3bNZIk2lHjws1zxJ
 zfqRurrYJfe9TkJ/bklmzHzyFsbTWXwHDx+T/+hNLmDOyuDITQOZZIZZbTgla+S8jXow6O5hy
 hTgH6+oeGQTmyWA0qvv8Rgi7y8T74ZOw0xtG/AttGaEZraH/z07nvjE47LxAE4PdlKoh99F1U
 Cz+RqcH3xktzymXOUpd3TtjnbjKWMa7voQ3v56aRJPd/QxrV/vHTIi3ELHs4KEIgGELqpJr4n
 EqNwpiyriezswWaSbhcIsneGmWJIcLxv2LLK3SapIyOSROmwRO92rS3iU925GWq75SH/Lwn6r
 2QpEo5RyVdboyrAdE38Sd2HjErwSkos/kMkJe4WJ4A2RIgRyGljRRBAFBhF79IAYAxPOdZbKT
 b+Adj6oToeNdJ8ypjWKm069fISYwL8YhZSoDW016dFF2dv9xU2E/blpIeTQ=
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592921143353273291?=
X-GMAIL-MSGID: =?utf-8?q?1592921143353273291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 7fc1503c906f0fac62d3506a6e993e49fb996248 upstream.

On x86, the cw1200 driver produces a rather silly warning about the
possible use of the 'ret' variable without an initialization
presumably after being confused by the architecture specific definition
of WARN_ON:

drivers/net/wireless/st/cw1200/wsm.c: In function ‘wsm_handle_rx’:
drivers/net/wireless/st/cw1200/wsm.c:1457:9: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]

We have already checked that 'count' is larger than 0 here, so
we know that 'ret' is initialized. Changing the 'for' loop
into do/while also makes this clear to the compiler.

Suggested-by: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
[arnd: rebased to 4.4]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/cw1200/wsm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/cw1200/wsm.c b/drivers/net/wireless/cw1200/wsm.c
index 9e0ca3048657..3dd46c78c1cc 100644
--- a/drivers/net/wireless/cw1200/wsm.c
+++ b/drivers/net/wireless/cw1200/wsm.c
@@ -379,7 +379,6 @@ static int wsm_multi_tx_confirm(struct cw1200_common *priv,
 {
 	int ret;
 	int count;
-	int i;
 
 	count = WSM_GET32(buf);
 	if (WARN_ON(count <= 0))
@@ -395,11 +394,10 @@ static int wsm_multi_tx_confirm(struct cw1200_common *priv,
 	}
 
 	cw1200_debug_txed_multi(priv, count);
-	for (i = 0; i < count; ++i) {
+	do {
 		ret = wsm_tx_confirm(priv, buf, link_id);
-		if (ret)
-			return ret;
-	}
+	} while (!ret && --count);
+
 	return ret;
 
 underflow:
-- 
2.9.0
