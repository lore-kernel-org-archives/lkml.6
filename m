Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4151933-1522302748-2-957975641915089255
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522302748; b=Bpcq8xLkpP5kL/dspBXdj7jpdzfMjfDCVncrqBYuztf+loV
    zVNE8o6DsxZ4sxEFozO/uwHx2wSDTyrAKmU74xWBfsn1OKylSveP8ygzH3wV8qh9
    2Xg/9s4yrAJ/2X1cY0jSLpAPTkIdHurbEBLsJVECk0kiVmmmnrQE+o80GMI8pasz
    Wvv5/iyxthHrSjMhKagiHL9yrWddB6/5DNLmUusuHgzSKKhey+7lcqoQPyKofRNr
    1FXDuqb4svVHHpAHxaGna7ZaiT57u24fzGxBWrSbPIFU4QK+su50uaovO16DdM6Y
    jb2aB4pPFH1MrMzWPMMy5hN5p+Bs4z78uKxIt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522302748; bh=i
    c2FFDfWzI+t01XcrUCQTqOSM4pRcXgJPdB3yhYR3+M=; b=V93H4TW86BfsuoAKY
    3affeoLB02GDSLKqgWsM7otNIUekeIwD7rN9PHfnFlyfiMkfL2g9zGpZFDlpodjZ
    S0NY50wLDAArixyfq5IgVDyQtCbs4LxCaWKXEj/UPtd8vYlVK2Z3tIczlRGkUFnx
    xTZNay49Nr+AZmQGR/uLuBqgHXHUEWVJ97uv7Q/d400HY/7HFTUuprZUuYuUNP4T
    9LUrpMuqeEjWCHpiPNwCeLX8yRbhpRmsL024axAiIUvUhdXo637e02tszhqQw2su
    G53i7hbhW85Fr24Cd0L6Bgrq4udWhRuzsh5isbPj8DkzgMvbXMqjSZzZmGj3nzbr
    CW75A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNLVoax+TN6KO6XLigtvrnsE03Ns/hezq7+qoIU21Qd7TUlqe9GYNMu8JINHq49zMqCBmnEr04nBYjWHEyqE9AYwkrOq57oAqPLu4FayqDYsJrFJtJqw
    LfMdcD9yXZsLjpjJ0TqNlM6doA7AV/VotRzOqvdcLlj2QsEu6GWPNA7r1R6fejmxqHsaqrhpCgFYz1pgt2AvThGdaVvCspV0+zT1uTPXLXkCImdjJrsFU+8S
    NoOrcvxCuG9iHiUZ4V7snA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=MJ2wh_4khJxs5KCPlb8A:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 6/9] staging: ks7010: Remove unused member 'reg_net' from
 'ks_wlan_private'.
Date: Wed, 28 Mar 2018 22:51:49 -0700
Message-Id: <20180329055152.13059-6-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329055152.13059-1-quytelda@tamalin.org>
References: <20180329055152.13059-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:jwA0KTyCh9DMSHBTS47DZ9xwZcC9hcjslv/QmLAm12XlLQHqAEk
 1LQQg6WXDQGRibYUmoDEjlpePSZ2wMisj3NUAYLzZd6adq4pyIJB8YVPnYRaRmV5YMuw0P9
 XblmEa6vfaoTTaJceBVtiYh+jD5pc2sE6tfw6QLLvJOdNmexFAcQNIKDlnNasZ1roknKMtO
 Q/LJyCqJqDVJV65uNJp/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hdZnXA4jVVo=:79XnmLJcNcF59O6/dIZSv8
 E1cz9JCoK0NmW3GGispeeBH3KFMiW8ge6Ez+3+a1CEz7APhQqzj55o1aGyO5/Fe9LVJdRS8SF
 BBuTP2RRvp0XzQKIbRIFJUCM486mqkskNnzLwKcwJL/gxL38iHiRSKd0DNAecwJ9HlrrN4tTL
 WHldSluIHWe0/4WivC8QVc5cC4dKxOykKi6BU8Vx43GI7AB00+mV6f3lzmkS2UxKWLF77jb5F
 LIuvqTgVUMrO8e87TIkZPmIhMqWusDy8u3p9LCi5LjblfAIkAkudNzQnVo85GJMo6nv74lPbO
 65QvoqRtQdy8leHDsGppzaEVNlhsf6Kd9YzWk41iJE/+ZbzkrG/iRjYRhR05STXcuszTD/h9s
 uY88olQvG/XgRGG0a6abc/qXGgoGK42EZu7OCoaMxbZHk7VxsYdum21HAeiiq4Bg5zNAWx44T
 F3UyOvUwUr7VyTLJlAcsTCvKHacgGBiM5Od5uA4K3Q2CTYeNwyWKnZ91FSAuTjoGEIz5xqY0e
 HyO5F6mm2I+p5wrwYTpzN7BBNMhLauPwl0Ls3TJk7vIqWOUF1TDAUXxAD8QaijGanZgtHH5iu
 A+hqLGSX8vOWH3cSAJ2BT771MbgYt/qRJc4Mh7oEKC9miTf9v1vCUiM18dxD3S8Zud2SCaq5L
 CQcFLmLfdQKbzidRVZM/hjxor8NMBG1JLqX3W6DI+m2U8FV9AblGSJSGsc9gC+aQl7GpUIJ5Q
 tkz13jVD2goPmCVmhTtA9esAzV+jZo7alXHhJQ==
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
Cc: devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Quytelda Kahja <quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

'reg_net' is never used in this driver.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>x
---
 drivers/staging/ks7010/ks_wlan.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 846bb1041850..1b7036c32d1c 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -406,7 +406,6 @@ struct ks_wlan_private {
 	struct tasklet_struct rx_bh_task;
 
 	struct net_device *net_dev;
-	int reg_net;	/* register_netdev */
 	struct net_device_stats nstats;
 	struct iw_statistics wstats;
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
