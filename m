Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3042595-1521470143-2-4816573884204292640
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521470142; b=i9SZN/MnVMtd5t+Ie9c8Q7O6FymlzXw1AYsM1z167m05mh2
    Fr7j6/q2jHy+DX0fOSI4qBYjga/UGVmu72Z0ZIqERiqzgQ4aaZDjkdwTiuoSvJLt
    I0n6/k+wvPU37YBOAeSGjM0Ad/qjjiQA2T3+HMwAQ2dmF7qofptM9sf1wK+Fy3lC
    Gwkg7yKeuffY5bV9nwfEDo5D7r9gOTJ80A8tR6kjub6yYg94V40BZc2l/GQnUgFd
    Zn4dthIySC+xOeaA6klQrX8D1BOjiGYgqxmJCf49gxz3FirQFzVwvmm6yrv274uO
    q7+K0b8ST+rQKE9u5AAg8oDbmtbazNg4P4dJsJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521470142; bh=0
    PUnld5hIJy+Q6rQFAwf636V6d6GK7fAajODTAuP41g=; b=iyWl3UCFKfybBSC1O
    TX/oxHfj0cfmYy5fix3whKoltu5/ESQ7zeUYq6jduGlfQk60QlY4BdOB5sEs4pKO
    tcwY80zpFeh5e6ELbHsm0r7lqq8Kc8WoS+xWCxVCPr3cMY4xQrAX+uzZagVTzXk6
    uPDVOJA9vH9ipBKUAULK77gwfJhtRrz+7GjdtXK13CThSa9K/paBJQzhbhSwiI6O
    TXXwm2gbUl8YZqBIH/lXUo/iPOJIeEQFzRGMa5CV+cvyhHqsjdwNxB+F73lh4tB3
    HMe/G9SEVfUZZS84qHroueBvQBYPspIe3eZ+jBgx5ZlhymYwjwZSQPM2snHU8SMq
    diJhQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=f/K7DDyA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=15 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeiheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvufffkffojghfphejjfegudeftdggtgfgvghssehtjeertdertddvnecuhfhrohhmpefrrghulhcuofgtsfhurgguvgcuoehprghulhhmtghquhgrugesghhmrghilhdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudeffedpjeekrddukedrudekhedrudelgeenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudeffedphhgvlhhopehhvghmlhhotghkrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeeifedutdcuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedu;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NMsfMchA;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=f/K7DDyA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=15 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeiheculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvufffkffojghfphejjfegudeftdggtgfgvghssehtjeertdertddvnecuhfhrohhmpefrrghulhcuofgtsfhurgguvgcuoehprghulhhmtghquhgrugesghhmrghilhdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudeffedpjeekrddukedrudekhedrudelgeenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudeffedphhgvlhhopehhvghmlhhotghkrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeeifedutdcuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedu;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NMsfMchA;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvhJheJTwh1XLYxxbqNVAez1DUPaedv66TzkYrq8lHuUJ0ThtHx2sAi1Er8uMm4sVOuBcxJmA==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Subject: [PATCH 3/5] Staging:rtl8723bs:os_dep braces not necessary
Date: Mon, 19 Mar 2018 14:34:58 +0000
Message-Id: <20180319143500.19623-3-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319143500.19623-1-paulmcquad@gmail.com>
References: <20180319143500.19623-1-paulmcquad@gmail.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, keescook@chromium.org, johannes.berg@intel.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Linyu.Yuan@alcatel-sbell.com.cn, hdegoede@redhat.com, arnd@arndb.de,
 arvind.yadav.cs@gmail.com, colin.king@canonical.com, davem@davemloft.net,
 Larry.Finger@lwfinger.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

WARNING: braces {} are not necessary for any arm of this statement

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index e804b430931c..117fda4fa1bf 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -181,11 +181,11 @@ void rtw_os_recv_indicate_pkt(struct adapter *padapter, _pkt *pkt, struct rx_pkt
 		pkt->dev = padapter->pnetdev;
 
 #ifdef CONFIG_TCP_CSUM_OFFLOAD_RX
-		if ((pattrib->tcpchk_valid == 1) && (pattrib->tcp_chkrpt == 1)) {
+		if ((pattrib->tcpchk_valid == 1) && (pattrib->tcp_chkrpt == 1))
 			pkt->ip_summed = CHECKSUM_UNNECESSARY;
-		} else {
+		else
 			pkt->ip_summed = CHECKSUM_NONE;
-		}
+
 #else /* !CONFIG_TCP_CSUM_OFFLOAD_RX */
 		pkt->ip_summed = CHECKSUM_NONE;
 #endif /* CONFIG_TCP_CSUM_OFFLOAD_RX */
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
