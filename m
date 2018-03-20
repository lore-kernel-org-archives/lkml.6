Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2173734-1521577610-2-18117284171214395517
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
    t=1521577609; b=gN9METjYRRJs9mXRK/3DVvLDv//poWEgS2rwnFxMUTfucCN
    XnArGSlvTQ8UykUuXpZBw1A0Pof97p59TS5NkmEW1DkkirsmK32fgWMPlf51Cv7P
    V1Fil4eDkfaRwMIU9ymvxiTe9gclibGhVigMJN9tobOpOeP/I4UVv/DCtk6hRWWo
    h4DlJplJiu+azXZGD/kSpBMNVa5S6ITshv03ujfbPf5bo/wa5TfaWLKuwtn8XAuA
    W2mNFjeOI4NKeAYS8+aUZbP1CZYHh3XRC+JXRhbpL4kpAGYkjNIeQAsE8+qT5rjO
    65DVuqu5KW0u4PM0w/TjgiOhAn6QZ8UdDOLizaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521577609; bh=D
    pYikWpX0GRJbcB6MSiVLd/uOlYxmzCjq/GnqJAVCtw=; b=U+KNCYHCCBh/VpcvC
    Hw4R/b8hdEmmI2ebxo9NKqRnyBhcJwV6S1VGw7ySEzR6nvPD2b96NbxiYZjyK65B
    +0poa8N6ib19XPcJFOZ+Zx3IxLebyeinsZ+X74lDPE2FZmzJy/LGtWYmkPbJE6DN
    2b1aaC4KYGRhOXlOGanlsrEcEKOhlciWcfQMmMC1M3L/fLNm29pTSnEIULTEafaF
    b5unpdDIndGHQjlL9ywLeEAhQEx1BhoefffDz1RFIvN2B/vu50c/ojVVyjUi5BPY
    /+7UMAKjooOcRd1vUjFO3EFBbzt7Plrkwgj4OBD63cHdNbVdOcwEzHFZH01AWYXZ
    YX6/A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=B7mX+PCU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kYNOBqGw;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=15 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=B7mX+PCU x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kYNOBqGw;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=15 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvqnL6aHt9q8DyMtED6GMOI8LSHEYPkJZ7YTgMWmur2moOXftUbVGZfLuNB+DEIRC5bTZ1SeQ==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Subject: [v2 PATCH 3/5] Staging:rtl8723bs Remove unnecessary braces
Date: Tue, 20 Mar 2018 20:26:20 +0000
Message-Id: <20180320202622.13339-3-paulmcquad@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320202622.13339-1-paulmcquad@gmail.com>
References: <20180320202622.13339-1-paulmcquad@gmail.com>
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

Remove unnecessary parentheses highlighted by checkpatch.pl

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
