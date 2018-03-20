Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2284343-1521577613-2-7166440785788996174
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521577613; b=rey45bfsVsNXoDTStSG7MdAWzjeEyNa0RbGei0sX0G/1F6s
    agZx+63KI5MahXbXmd9T6rCFm1FtU2HRrOz09c/js6UQuUyhrOvfqIdtGK2SZfES
    ztPEFJtUWPa0ICtLW9On+RhNcGcpWflLV6VnYVHAL34Ry3KKsSq+NOPByoJ5/Jjn
    tSZYvR7Bk2Rj1XFf3utUCTd8DCG/zombkNw62B8WV1q7rU1A/+LB8H66MlKRfdvN
    md7umhu3IJhC0uiJrLLu6hzg5nkqTMp76t6dK/wE11M0YM1xzN4RsSk3GMIp0Kq3
    aU7NxckLqIb1j6NM8anV9FV0JBRRUlAheOpDNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521577613; bh=I
    ooylgqVMPu4opkymYq36X+62AfHSbfwu0Xim4kW+lw=; b=FfXxtn1kTK2TDzebN
    Ibt4BpQIifuvg6Qu5SLerKc8zWgr2S+wQ0CZZuqBeyzX2AdrNvjKxY8GCy+GgNbt
    PlRtn3E5wsFe6YQmeABdBC340D+2e/AoNmWW/Uy8qr47za2SIguRSaaY43vbHPkA
    PDIt+HBd1dGvtuhNz5KbrtKMiv078mq01VEgAIbUrPupJmvgmvKSXooQECQNNERz
    dnkGtemoKZXqL4ET+Qo5f47Wll79okLbI+tAaKWa/RYN2xxpM7ce6eq/B6qjVzdk
    y+VvblPdafGSFARBBMSmhMnWkD773vvu0Ro2KDpaa648e2KuH8fQM8ifc4978+v6
    RyFnA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qCeJbj/t x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y9A3td8K;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=15 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qCeJbj/t x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Y9A3td8K;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=15 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtx8cnA9w0a6uJbrAwz3nWAIlcfZZapc8HTUcE02YOr3/VxOogmHq83a53uh4+nzSBwB4PWKw==
From: Paul McQuade <paulmcquad@gmail.com>
To: paulmcquad@gmail.com
Subject: [v2 PATCH 5/5] Staging:rtl8723bs clean spaces
Date: Tue, 20 Mar 2018 20:26:22 +0000
Message-Id: <20180320202622.13339-5-paulmcquad@gmail.com>
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

Used checkpatch.pl to clean up spaces around if and for statements
to make it easier to read

Signed-off-by: Paul McQuade <paulmcquad@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/recv_linux.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index b43e24c3a23a..e6de8d2eabb7 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -20,8 +20,7 @@
 
 void rtw_os_free_recvframe(union recv_frame *precvframe)
 {
-	if (precvframe->u.hdr.pkt)
-	{
+	if (precvframe->u.hdr.pkt) {
 		dev_kfree_skb_any(precvframe->u.hdr.pkt);/* free skb by driver */
 
 		precvframe->u.hdr.pkt = NULL;
@@ -46,10 +45,8 @@ void rtw_os_recv_resource_free(struct recv_priv *precvpriv)
 
 	precvframe = (union recv_frame*) precvpriv->precv_frame_buf;
 
-	for (i = 0; i < NR_RECVFRAME; i++)
-	{
-		if (precvframe->u.hdr.pkt)
-		{
+	for (i = 0; i < NR_RECVFRAME; i++) {
+		if (precvframe->u.hdr.pkt) {
 			dev_kfree_skb_any(precvframe->u.hdr.pkt);/* free skb by driver */
 			precvframe->u.hdr.pkt = NULL;
 		}
-- 
2.16.2

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
