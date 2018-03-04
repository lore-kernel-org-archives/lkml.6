Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2187568-1520154016-2-961802925425562145
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520154015; b=AkxdIXtfQASJI/M4/ohJ83MscTjX9Fdx/UcKppgQ+WFT0xP
    0HfgJQgacMNpII7GCJk+TPpI33G6LDrMzXvqgEXOMe7LhVtTt+x4QQtEAojToj+N
    zMT5RlrsjeNrj8dCYR1o3bNuJXL2PAKlD73t6Xf2HEUeEUn+yQwEwz2/jZr1DJhm
    SCl2YC/mJBgqnwlhm422Zz0AylUAmDxvfRp+V2Swsn2DbLVyzvW+ppc2Kava2TWb
    Wwo4w/Ub5Es2DZHRNW2TrRf+Z7figCkuxWRxIuDZYSjUvJWeW6d5bl/H3ETzPEib
    jffHP1IO+ppI6Nn2SlUMZFY4MrfLi6SyzizLe0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520154015; bh=G
    0sqpxGtAyQgCkUSJtrIPlRMUERN+0lYN3DmJohDdbI=; b=jB+Mp38g7w8u8n4hg
    ljN3DfU4hJ8ZWx1ErpFPJcaOVb2mLZ3vd9+Vs/U6M5RSeARGu5e58xwCFUseg1Ew
    kNxDcXUq+MF+bmWtZDcGUT1bjxjn9OtVFYnuvpR1vEz8+9fKZG4aQ4LuEDCHQwfy
    SmMhhH4RIzVZxlRaU3R2KxzXPzioDnNM5nDtG7QN5SReJ0uZOrzWgjwTLBOF5FPh
    FtYyOVuFR45C15pymJXKeVcp066m6naRlC1KDLRJChayayepdsX9RmaQktc0LjQo
    ifZ/+mPx9O7O1GCUi9XFjd53DcXAVCWsYDpOlEIWbwQHVWs+QvyH3N7j3Tq7mtIC
    Siz4w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UcsyAB6w x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h24z3bXZ;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UcsyAB6w x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h24z3bXZ;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtqDE5NGwyNVyuIEm3MoYXlICDFnSPuENB0DxDHPd7wLx9HhIiYzARAfKLpqGzeo336H29S5g==
Date: Sun, 4 Mar 2018 14:29:35 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH] staging: ipx: Replace printk() with appropriate pr_*() macro
Message-ID: <20180304085935.GA20591@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Using pr_<loglevel>() is more concise than printk(KERN_<LOGLEVEL>).
Replace printks having a log level with the appropriate pr_*() macros.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/ipx/af_ipx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ipx/af_ipx.c b/drivers/staging/ipx/af_ipx.c
index d21a9d1..27f4461 100644
--- a/drivers/staging/ipx/af_ipx.c
+++ b/drivers/staging/ipx/af_ipx.c
@@ -744,7 +744,7 @@ static void ipxitf_discover_netnum(struct ipx_interface *intrfc,
 			intrfc->if_netnum = cb->ipx_source_net;
 			ipxitf_add_local_route(intrfc);
 		} else {
-			printk(KERN_WARNING "IPX: Network number collision "
+			pr_warn("IPX: Network number collision "
 				"%lx\n        %s %s and %s %s\n",
 				(unsigned long) ntohl(cb->ipx_source_net),
 				ipx_device_name(i),
-- 
2.7.4

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
