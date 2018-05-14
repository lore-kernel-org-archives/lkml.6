Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1405515-1526333122-2-897798155620044088
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333121; b=jWap1kI0Ikp5EqFJIwYRY2nD1j40XrcQjkS0jVrCUJ25aJZXjT
    z+oFjz8ly5tT68oBEklOOJT7GZ4NH/nXkadjvQ/1vm9mntH8MDxzBIeM1EqSRdcm
    OPzWIimvMm6bSbUIwKdiVa5J2LZC+g50hjuMC8wkkSJp/zCFvnpLr8+kUWqPhrr8
    8oO08P46R8ViOBYG9haahekWTQi/V23m8seIgOqlrCk087EZ2tptS3FE2uv0Sfr3
    q3jNX8KXiR3uUq4cBBSwuI96WdGFJS9I4dRjCdmtNKJmlFq+mpGF9470GGA1OvtW
    Q8DdbX/q+wtDIaCbLRVBRyMGgYKN8Ct+k1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333121; bh=4qCdg
    +EJO7v/IZ5pAm/oBvjHQCOO+6gI0TcbHY++rPM=; b=DFQNPOsVsakmyXMfJdHOb
    5On/7kI3RAuY1YyoLzg/L7j9icHhN5e9ig8ijg9Z2EHneElpRO+AS1K5V7d5X+YP
    2bDl0t/sJd7oaxOT2ltVAFMyGmVZoX93rx2P6B8rgwY5xxiBaQ185sTnPvSYcaGq
    5WbSZVO9GXEe/7nU2pw0jerMB60eco1B8y2M618YrhDR/ys4Fvo5/FUeVoHiCu6X
    4GHKlqjLOAm4V6rHcyacVWAGyEz92JOKmO4Im3iD/WiuaYh7JCdXXrSLtM3oEacb
    mcCCMe/QfiaJREilpnjxqLN/3yNTSxZ/POEeAnrzhauQrcV3H8EmMUWvIy/rT/+x
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=ulO5tRnu x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=oM4h5WJ1;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=ulO5tRnu x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=oM4h5WJ1;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGTituQhP0uUDQdli4ucTfuxcgi9D9Jecytz7Boohhqlf+AxeZ4vgk7E+BkpWOoYcXYEB80G29BaQdZkY6DClMabvtEqkEFZaedW2laaMl7tq20cWVQh
    9izjSRTi96gBSTWQlNY8qoBwhaiqqea58FZv0XLpXQMPW2zBmLN7H+9vXpCDnPJUNOu3R1RLRtf9dl5TzWf6BY3Qsa4RfBWDLqTcG8J93yWm+t6zIukoj/ju
    07vI/xShKXQrEVS8WlfAgQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=7lWtn1aDIJh365hMJcUA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpqKkPXhraqOrw9Bs82z0Ug5j49CN5cRi3KtZuWi75o+tWHVGFZFB3JyXwGL4ZBRvnTjJ++Tw==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 06/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 correct braces of else statement
Date: Mon, 14 May 2018 22:24:13 +0100
Message-Id: <20180514212434.17514-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180514212434.17514-1-johnfwhitmore@gmail.com>
References: <20180514212434.17514-1-johnfwhitmore@gmail.com>
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
Cc: kstewart@linuxfoundation.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, John Whitmore <johnfwhitmore@gmail.com>,
 colin.king@canonical.com, tglx@linutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Coding style edit to clear the checkpatch.pl error:
ERROR: space required after that close brace '}'

And balanced the brace of the same else statement:
CHECK: Unbalanced braces around else statement

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index ed3e3acd78a3..beecdbfe401b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -132,9 +132,9 @@ void HTDebugHTCapability(u8 *CapIE, u8 *TitleString)
 		//EWC IE
 		IEEE80211_DEBUG(IEEE80211_DL_HT, "EWC IE in %s()\n", __func__);
 		pCapELE = (PHT_CAPABILITY_ELE)(&CapIE[4]);
-	}else
+	} else {
 		pCapELE = (PHT_CAPABILITY_ELE)(&CapIE[0]);
-
+	}
 	IEEE80211_DEBUG(IEEE80211_DL_HT, "<Log HT Capability>. Called by %s\n", TitleString);
 
 	IEEE80211_DEBUG(IEEE80211_DL_HT,  "\tSupported Channel Width = %s\n", (pCapELE->ChlWidth) ? "20MHz" : "20/40MHz");
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
