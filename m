Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1006072-1526313274-2-18285857497733094258
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526313273; b=jnNSqciai0C8XWnNWY4Y61Mza+l2ayR/erci9dUNCorOhL1IqR
    5CWqE1+HfriCAMTyN7rRRlRtxYi4kbic1ICdLmDqXwk+wDuk1XjUsrNX2AfX0Vm6
    WVK51fIDaiLhf+bBa41tjOjHoSOp8BvWJpnOwHkst5txfukRnhS2MnyFfJGsTvZG
    KmfnjZ9w/0uIxCHrFvaOmKRElFjY4mN5uYOE82XKNv7u4xWM5BuoawvDA5uRdGdY
    d5xTWkdZgvkGkdYMpEQlZ4Z/C9P6CIZ5O8psjqpnQiPaihHiii9a6d7MMGCABEfS
    odTbQhcsOHiTtEIZEUFOb9XDbgJhwDNK8pxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526313273; bh=c9HfY
    SZiaOhHcfAdusGRF/4pucRlwNTJ30l7b8srjsY=; b=AG4vLvkPb2GTQSAs1WzFl
    T0bvjjJVEF4e/JE8ooqcAJT2kpo5L5nXU9PvFpKGIy4WyfNtL07OFdaXgL0xedKd
    S/MUjqVqNk71b5TvWL47Jk13a2HmG15Np6QEpXMER6u6/XejLWZwFI6TMFBFGAu4
    CkoytjiCabOSFso7rR6mod4C5dcnzQhZ9yXlDE41mWkE/TU0K9Gwl3kprsRnZUCq
    db0ZUju02sji26FGpCEgOwr2jvxqo2Oouj+pi38elil/icca0Pqo616CNf5H488P
    Yg2Ge3iunBVgJ/3kdVYbOP+9UWHm4ZM/nHPdxz1Fq9P4ewopA8m7dH1dHwkuiNNh
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=FJHmRP7e x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=mJA0uiqT;
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
      header.d=gmail.com header.i=@gmail.com header.b=FJHmRP7e x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=mJA0uiqT;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCqg9k6D8bJNeLFedtyiDSVpK2Tr0JFAbxnFRBNkQpg/lN66C1VoMgaa6404aW4BLrFzfMzNPIfLpWV98tivyTYr46yMpdFZuWmK4CJbXTWhwaH3EH4j
    ZQyUb74YFnCl65ivbOaXmeVI0KkugvC3ytmBkaR5tycwDxn5F07ZRUdoAL6r2bCJLT6SshZ7KNGEJ0MooQG7DR1Q8WJWHoARrRgG/9uuJJYhaFub2C/hPZpG
    jItlZd1jjENx5CKmL8F/iw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=o_dtBaZDOvUA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=shWsMj1YcjMxOzRTmZ4A:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZreEvJHgCvXE/Uyv4MoHORCxT3dByLZrHVvDAHDJ2fjnz92N9KPoGzECsMG09I1uUFRZ/+p7w==
From: John Whitmore <johnfwhitmore@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 13/13] Coding style, corrected an indentation issue,
 (use tabs).
Date: Mon, 14 May 2018 16:53:18 +0100
Message-Id: <20180514155318.32195-14-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180514155318.32195-1-johnfwhitmore@gmail.com>
References: <20180514155318.32195-1-johnfwhitmore@gmail.com>
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
 linux-kernel@vger.kernel.org, johnfwhitmore@gmail.com,
 colin.king@canonical.com, tglx@linutronix.de
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index af6508dfd897..7a765b022f8c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -769,7 +769,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 		//no MCS rate
 		for (i = 0; i <= 15; i++)
 			pOperateMCS[i] = 0;
- 		break;
+		break;
 
 	case IEEE_N_24G:	//assume CCK rate ok
 	case IEEE_N_5G:
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
