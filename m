Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4187132-1520847583-2-9032207494449248059
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520847582; b=h/uZ+oH7cAVzY8vTC9weebBhG1fctTd1NxTcdrP97gUPYxK
    v99Y1sQ8I50GGBxcGAcV+mPVYg5JIds07yPu5f0LgvtW1p3DgDlayTkwkYXNXg2w
    0Fu6MgXbdkOYo+m1yxgwcELnEUu+MM6DaX24Y987ak52P7IlRKgJdis0MTL7PA9C
    zJH0iFN4q2VCqgAajxWs3/V+DxrnptVE1FYdO3sFrQWgXvSrWLtTWl2A3i6+UJtG
    qsys6oM4YPjIhH5G6jwS7XZFOAd8utnBXH7PPRbejmppeR64RBwSBCQ/9XwFaEm1
    0++TID0yi6nOF9WCJUeABk8v4r/MgZsgl/6ZOLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520847582; bh=5
    CViF79NaEzvZe8tUmnSspTMv+DctfBFzs84fxyzvzU=; b=ihGSM/RHC9Z2k4yyr
    EnS+aFGFwvew83i8DCFNnvGUlt2/4RUuorC9vCL3CIg21pEY5Kb0/FWju3CTpMwn
    golwfl5R3z0nQlIP6ivUfEtb1zig5oYurpDj3SQkVMJXFIVzezpu84OQYOtwwtg/
    9BcKk5R7ZYlng0mXRxxzfDXEgI/8m4sZpmvpxPFg5KRXy1eBvkB+JQ6XA8xB2nhM
    k7+UifD1cMVqLfnnpvAyH9N42IlagC+g+awB39AbVfmxXOwHW7aT93McHTdgT0oK
    g+kHQMXlu2A92vjwYTIugHvQ20S7Mn8fkeml6kxTKrbRWwk3VAHCkCIrM8e6ku4Y
    18cUw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mU8fY7XP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=namoaOFy;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=mU8fY7XP x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=namoaOFy;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELt3x0UFRkqAH3GN+mPwW84byv6PDrlo7QxdugTPn339RDOnQaC7INI6d4/N8kKYQ06Xu/F2pw==
From: hariprasath.elango@gmail.com
To: aditya.shankar@microchip.com
Subject: [PATCHv2] staging: wilc1000: use pre-defined macro
 is_broadcast_ether_addr
Date: Mon, 12 Mar 2018 15:09:03 +0530
Message-Id: <20180312093903.9147-1-hariprasath.elango@gmail.com>
X-Mailer: git-send-email 2.10.0.GIT
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
Cc: devel@driverdev.osuosl.org, vbabu3@visteon.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 hariprasath.elango@gmail.com, Ganesh Krishna <ganesh.krishna@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: HariPrasath Elango <hariprasath.elango@gmail.com>

Use the kernel pre-defined macro is_broadcast_ether_addr() instead of
doing a memcmp here.

Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
---
 drivers/staging/wilc1000/linux_mon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/wilc1000/linux_mon.c b/drivers/staging/wilc1000/linux_mon.c
index bbdfc7a..f93f411 100644
--- a/drivers/staging/wilc1000/linux_mon.c
+++ b/drivers/staging/wilc1000/linux_mon.c
@@ -27,7 +27,6 @@ static struct net_device *wilc_wfi_mon; /* global monitor netdev */
 
 static u8 srcadd[6];
 static u8 bssid[6];
-static u8 broadcast[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 /**
  *  @brief      WILC_WFI_monitor_rx
  *  @details
@@ -193,7 +192,7 @@ static netdev_tx_t WILC_WFI_mon_xmit(struct sk_buff *skb,
 
 	skb_pull(skb, rtap_len);
 
-	if (skb->data[0] == 0xc0 && (!(memcmp(broadcast, &skb->data[4], 6)))) {
+	if (skb->data[0] == 0xc0 && is_broadcast_ether_addr(&skb->data[4])) {
 		skb2 = dev_alloc_skb(skb->len + sizeof(struct wilc_wfi_radiotap_cb_hdr));
 		if (!skb2)
 			return -ENOMEM;
-- 
2.10.0.GIT

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
