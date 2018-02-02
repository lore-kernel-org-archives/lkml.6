Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225d6XCEl8RwXmC+hNzds/cp+aSC5iFKjjAo9cEcVkCsBLf+rm8p/qBrAP4X9fAch+YRvdhL
ARC-Seal: i=1; a=rsa-sha256; t=1517591210; cv=none;
        d=google.com; s=arc-20160816;
        b=rbqZ7R/Nx4akzxJbom6016IvsaCjEkZ8BjGD0bJtMY9EDgyZfvi5GHq9CnBpLv4Iol
         T2n+vZ8cq/JCtpQQm5SQovj/eEQoYcpUzSFhMNYSm7ZFtUmfPL9zt2R2cA3FUiIpxFgK
         0fl64Z4PqaZ6b2GLbViWfaL5VOJaS1qgeLbOhGtE/cKYftUgCZkWcSVqkKUl+HXjqXzh
         97OcBzv1cLr+l6olpwBnlzSdL2Y3AARE112vpfoGh2vSN6gWD6a5NnpCRlGgqRB6LneA
         bJpPKsmXSpSdhbclbmS9S7i7j9dlhDmew5/d4+ksaA9cpQlTfmF331v+tcuRewiw7ToI
         7axg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ev2uTCBs+bNEU/rV6Y1Rtlr6wEM1wRmEuXgDeeYoFvA=;
        b=WPeoQCAE8f9s8Gr3k25MtpL9kEgl+3ITw2sB6oizvmqwTik1xmicqQjBTyIPzq8OLa
         NHxnGp2NbFWIqoxcr5b47X16Sd3OG5yCdZmHy99ghsUBNH/Ela94Uj1gtinPZPH4LM8H
         6y5Vcp/p7/22pFHdKse2JCA1lX0froFbWkZ+3j0tvxJiFyNUAmdmhInavMCiiw7fUPvW
         Sbm36erkZP8I6NbITKqYzSGikM4K96STl/SFikQEy3aSFDg/iDQqlg1Nk5C/taIRSHfX
         RgRnbgC3UyNmrABwovPUSeyeHFTkvQJGvCAI4sg5jJiOuWtFFuHEhhvHKnpgRvV+mtFy
         Bi4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrey Gusakov <andrey.gusakov@cogentembedded.com>,
	Andrzej Hajda <a.hajda@samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 56/86] drm/bridge: tc358767: fix DP0_MISC register set
Date: Fri,  2 Feb 2018 17:58:16 +0100
Message-Id: <20180202140827.543409660@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309721522702501?=
X-GMAIL-MSGID: =?utf-8?q?1591309721522702501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrey Gusakov <andrey.gusakov@cogentembedded.com>


[ Upstream commit f3b8adbe1911f66fd3cab1aaa74f0f66b7ceda25 ]

Remove shift from TU_SIZE_RECOMMENDED define as it used to
calculate max_tu_symbols.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1510073785-16108-4-git-send-email-andrey.gusakov@cogentembedded.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/tc358767.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -97,7 +97,7 @@
 #define DP0_ACTIVEVAL		0x0650
 #define DP0_SYNCVAL		0x0654
 #define DP0_MISC		0x0658
-#define TU_SIZE_RECOMMENDED		(0x3f << 16) /* LSCLK cycles per TU */
+#define TU_SIZE_RECOMMENDED		(63) /* LSCLK cycles per TU */
 #define BPC_6				(0 << 5)
 #define BPC_8				(1 << 5)
 
@@ -716,7 +716,8 @@ static int tc_set_video_mode(struct tc_d
 	 * Must be less than tu_size.
 	 */
 	max_tu_symbol = TU_SIZE_RECOMMENDED - 1;
-	tc_write(DP0_MISC, (max_tu_symbol << 23) | TU_SIZE_RECOMMENDED | BPC_8);
+	tc_write(DP0_MISC, (max_tu_symbol << 23) | (TU_SIZE_RECOMMENDED << 16) |
+			   BPC_8);
 
 	return 0;
 err:
