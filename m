Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2984275-1521470144-2-13079074894480973047
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
    t=1521470143; b=AJ7R2MK4G+UeAkNSNAG5Ui1uccm9vM6MTMYv6XHKUT/eQTQ
    7x82mY2Dq9due47JthHN8DwPvVBlSuJoyA4fa4td7001HL1aEr9O69zPVI3DJ836
    0NTyZkdzT9SJPTSaOoIvyropDHmq2qOdYlScZp9yBP1LsN5uF3uR9fBPnh5+4mMA
    pNeDwXPJwjes9p36ZHnWtnd6T73vGiZNkxYcYfhzpRcFrDlpa7ZBOueDGN52sOmn
    P0ASIwGqsKzFQbPsM+kRYKwfSyC90LdfI+fQqEHRj0z5ZJ5KsVaiNJjCFz8YcjPc
    fD5P+8pTvHFHXM4RoySayZ0cO/oeIKtExhDM4Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521470143; bh=F
    PIZBIKXMAfanNsqBnSdYouhZTja5UZ77+92A1tJvlQ=; b=kFe0QznORmgRZxMM1
    mB+XRqvS4Wzv4PJrY2WI+R1uBVwTx6Rpqou7iVCJ7b512FSaDKRNKL5sXCjYaYFn
    VL051q1sJB4h/1J/Tj1zwDSwJRgSWSjt6kgEbi/v3CGpCFEJTV6luTKyu6IzBJkc
    41/7IpklcEzr3k64RylSVAhQYi8ElHlC+O5JJ+MfjkDmTPYlVdjALVJ3W2el1qTl
    dH1LgD+cA1pvJ93IELolOrzpVR5YgiEa/t91vE6CYFyPV6mSDc/I7AXp2IjzgPJA
    /kV0Xi1gEJv1pp+tzhGnHT4Lpsyd3puCPFEmU+BvNa3KYG+2AZ8Ts3BkrA6iF8CB
    lAqVQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KVbrrtMA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=15 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeigeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvufffkffojghfphejjfegudeftdggtgfgvghssehtjeertdertddvnecuhfhrohhmpefrrghulhcuofgtsfhurgguvgcuoehprghulhhmtghquhgrugesghhmrghilhdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudeffedpjeekrddukedrudekhedrudelgeenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudeffedphhgvlhhopehhvghmlhhotghkrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeehleejudcuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedv;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Wyror7gT;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=KVbrrtMA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=15 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeigeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephffvufffkffojghfphejjfegudeftdggtgfgvghssehtjeertdertddvnecuhfhrohhmpefrrghulhcuofgtsfhurgguvgcuoehprghulhhmtghquhgrugesghhmrghilhdrtghomheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudeffedpjeekrddukedrudekhedrudelgeenucfrrghrrghmpehinhgvthepudegtddrvdduuddrudeiiedrudeffedphhgvlhhopehhvghmlhhotghkrdhoshhuohhslhdrohhrghdpmhgrihhlfhhrohhmpeeoughrihhvvghruggvvhdquggvvhgvlhdqsghouhhntggvsheslhhinhhugigurhhivhgvrhhprhhojhgvtghtrdhorhhgqecuuffkkgfgpeehleejudcuuefqffgjpeejuefkvfenucevlhhushhtvghrufhiiigvpedv;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Wyror7gT;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELteurxfoIZskqPXInLppT+sYsmYsTVaLYW4f2JvmK7ImkfoFIbuAChBT1rVkvAdcE6qulGjUw==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Subject: [PATCH 4/5] Staging:rtl8723bs:os_dep blank line needed
Date: Mon, 19 Mar 2018 14:34:59 +0000
Message-Id: <20180319143500.19623-4-paulmcquad@gmail.com>
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

WARNING: Missing a blank line after declarations

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index 117fda4fa1bf..b43e24c3a23a 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -43,6 +43,7 @@ void rtw_os_recv_resource_free(struct recv_priv *precvpriv)
 {
 	sint i;
 	union recv_frame *precvframe;
+
 	precvframe = (union recv_frame*) precvpriv->precv_frame_buf;
 
 	for (i = 0; i < NR_RECVFRAME; i++)
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
