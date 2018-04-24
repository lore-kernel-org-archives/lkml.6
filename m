Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3076317-1524575927-2-6993824853986831482
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524575926; b=oehoqEfluJlbcTD+IgHxtC11v8BvwXnjfXw//0o2CohaplARPF
    Jm7fD7SQJ8Pav+KcdGQohYNqmFKan9QpQ5VH39PsIEof/c752eKBSTbahruogxzt
    h+WGGYrTwasP5jQwHNPXI9x3Hi6Ckrp2LKGbaW+8e/B8L/LC8rsdiKWuy2086toM
    9PWDznTpuRoN//Ei4X2wDfbWD4CfDRmn7bmrlGz2Ihfv20phVhYthOkX0gkob4hP
    tQFEtLrPrkvcLdTE+gjc/Gjk8KYmia4bsDtE9htTFaHswXmAFS/DAqImonI+Xnrp
    x17/XeOzRYtbs4I3sCrhhG3kKvtkk0NvFyIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524575926; bh=MMl0d
    LDVodD9yKdvSM5bt1RASnwJILUa/cTYFet0hG8=; b=El4YR3sp9VdT0br5kzh4i
    qoioaOuQ9lgGGXyDEbzgEbK2W7gjexyzYC+zZAOiM9ihvqo7c8seln1dDflmfNrX
    j6FXwpBga4KffNzNvR5I1BzgfXqtG7amsM5q1rk3txaWcbwAjksLyJZRg2IybYD5
    HGcIiXyAJUWNqx2sQGc1Y0MkATTc0UVRiKahq6lOLrGPHMw5j0ZFe92CxWYPo0s2
    9gSt8Tm7bAgA0L05VEOqo9nMtRKnXo0Pw50E9Lr2X/+xCfulFYrNukfYT9+d1wAx
    GwDNohZIXdYEHJBwSZQUt21BZph8T4cm5pqx3pmSw6K1Uxsjcn+F430/hFpxnLk2
    w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tgnvl8H6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fOmnNenr;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tgnvl8H6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=fOmnNenr;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLir8yTuURq3eJos2xYB2zKnX++I9tit8ZnKiUoFbF+h+zXqBbu9nMkHNTQ2bnjRXymSG0xgUVYgafQQGD5eusSy8atvAQI5d+YVnf+qNvwoPwqTMJmm
    3FzdcYYZUcFN0GS9uxcLhAMVq+QJ+OiQA6nR5HyNOy8JB09gsau++4oDftJbUxqvJvtue8DqvxVHBB59nIFLwcn0rtuzqR6VxZFp56uTmuyg0aJ94R7f/kn2
    luit5dXgfzRTYq8FaT5rhw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=UWLGKgljVrAA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=IYDOp6s89EdUljmrzwkA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/E+LwM95ILD85qNpklAIrzE6ChEBU/k7XVK/vfPbkz/iKB6wIx9DzLQluKckeIi3/Zsc5lHw==
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: fix p80211knetdev_hard_start_xmit()'s
 return type
Date: Tue, 24 Apr 2018 15:18:35 +0200
Message-Id: <20180424131837.5317-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.17.0
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
Cc: Rodrigo Zaiden <rodrigoffzz@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
 Simo Koskinen <koskisoft@gmail.com>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, but the implementation in this
driver returns an 'int'.

Fix this by returning 'netdev_tx_t' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/staging/wlan-ng/p80211netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wlan-ng/p80211netdev.c
index ec9cc00ee..710ce8394 100644
--- a/drivers/staging/wlan-ng/p80211netdev.c
+++ b/drivers/staging/wlan-ng/p80211netdev.c
@@ -95,7 +95,7 @@
 static int p80211knetdev_init(struct net_device *netdev);
 static int p80211knetdev_open(struct net_device *netdev);
 static int p80211knetdev_stop(struct net_device *netdev);
-static int p80211knetdev_hard_start_xmit(struct sk_buff *skb,
+static netdev_tx_t p80211knetdev_hard_start_xmit(struct sk_buff *skb,
 					 struct net_device *netdev);
 static void p80211knetdev_set_multicast_list(struct net_device *dev);
 static int p80211knetdev_do_ioctl(struct net_device *dev, struct ifreq *ifr,
@@ -321,7 +321,7 @@ static void p80211netdev_rx_bh(unsigned long arg)
  *	zero on success, non-zero on failure.
  *----------------------------------------------------------------
  */
-static int p80211knetdev_hard_start_xmit(struct sk_buff *skb,
+static netdev_tx_t p80211knetdev_hard_start_xmit(struct sk_buff *skb,
 					 struct net_device *netdev)
 {
 	int result = 0;
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
