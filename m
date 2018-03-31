Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1111812-1522476736-2-15037838410887063433
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476736; b=u4on702B6pDEDpz0Clej3zZiTdqapFN3N7x9KmhxD6Yyghyjh3
    s+bt3Yuf6aVkd+SFT+aDnt0KAmeVLJDmCYwhBO3KgLASpb1kcBD3qHuyhhK8w7y4
    p3oFx2rlKDOQxTaqnbpUznZZ4sxZ3UIK31aQXc3eiVhTFOL9rWzKRBL3CJWXLHw0
    j63s6xUbpil6OGCpjhOHSWM2mlLPoftPQfAj2tSfxDzThrINlAgcQLrS5vNY3vlO
    lt/UjNgc0sn35LFPkwUwbw94T15SRz64umWsSu9XVwxeNoGOzJqcFOqu5ydk+n8Q
    RLWHln4OB3eQAnMSQOjZd7cgrnEaYhJiQNiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476736; bh=yvfNC
    ddo0NcGzu8+R5zpjMzmoF9LzcHcgDlnxpQSKGA=; b=AooqDpAs46coyzQKyb0wg
    mikpMTo158IdzXtn123yYYe3aFkTQ6/2T4kd/bKYvznBY0rC1rvEqc3wvhz7qMj7
    6LGNquGxxk7fmUV3Z+RpSmoRAC8hzHYiZ4ZkKRsiXjNOSsNiOG6trI1TwBvitwe+
    d4wvfAACBFn7RwrSEe/OKDKceEGLTKtEwalKlKMu0mybz3+P9MNyfXdEzSqVdiTu
    XVRrYxD016pWEXXclRhnHE3iB6L/HOG+85QJ3c5pud+xWrTmAs0X+SYPxPgn25+n
    cwy0ppGeFEdGZYgxYRdHIlYddjYgY0Y88VAW1R7RfbrEj5WhD8oTQB6yRh6VYUrC
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfHTsGMOlELixJg3WnjVWgrgkh/Mn6hMLKXQhKtwm59x+OT8NoG9fZoqNY+puLbqFpI3/qae9rUN5GEdV0VIJIwYEuofEusvhu1C4EDZOY3RNZCqenkUE
    ardBmVJcBZ4jlZ6I36Dp3+8SEHlfCmlyGKGBZV0eq8e3MSVMNfUKgUrQ4o2xsKe6YYHGP+bTPdCwc5VcC412y06ndeD9Hf+7mNcfXkRWZLgWeU7LsHEH1dNi
    jkGyIGnxJEeipDTVkG5UiA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=MBXM6yTHWV4dAfAIpPMA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 60/75] staging: ks7010: Remove trailing _t from 'struct
 scan_ext_t'.
Date: Fri, 30 Mar 2018 23:08:40 -0700
Message-Id: <20180331060855.9452-60-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:ePSNVoDpjGzny4fOvnlpmM/BVWV1gBani1ZvCQJgJ9SU7dEuX70
 vzFRa9zS/u0MhHe34L5AwbXMjm75jjBTP1IniIWY0YS9nt0nfBCHfEggqElO/1H//6e4Jln
 L8ACMOFgCF3HuTWJvzGbbsghTaxZOD91tJ5HZ9c6zggqH8V61YNpzmKXaPya+nEWvgZL0Dd
 A1ZbXI3iYjXALP/Q1TwXA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6GuLniAcRoo=:N+3iSmbC4voyfCSw5obg4z
 1P6XNRY8ODR/dYUJ26seE99rxCr+ZKyEUZJnbYUCfWiDcvnd4+vOBTXSWQAvh03xSBYRszlZK
 et3VxsQeFXwsDRoUighD1iWPwtNsgNd1PU9Yrl+FDHBbE1GwIZV8pew/UKe3AuNTxTWQhQz31
 NxMkOq971rDovxLLZq0hJAtTb7vE64AFkBJP+3NwWKZoU48mBKWIeG8dhVYH/eC+XUR6vserZ
 1rsFicOqX5rqtRpwXAzYq/hhvjzTlyzC7EMSVi2lnGoWD+deS/lw+8vqSejW8rSlfkncGk95M
 as6RnPKQPps1q0x1lCTpDsgBp33p+xEw1NUKh3ldmv5Wk25OoDS2Gcc0sKT0g//qx6BYX/xQT
 x7Dq6nFzJ3NhC817U0tflJC0SMAaUCZBSEaWNjHXertuFaXQGOK1gpruYD+VYN9/cKQpWKsqt
 MbBNy7k23Cg1LLyl+Jm9Ar4gsH3osHYPkpo82KJi0G5pk5SeQYTyLWzUWbBGu7KU6vIfQS9mN
 SH2pDLnlEqnlFfP7LYowqlBZbLvVmbnhzWiAR2L37Ug7bMQFV7BTEFXrKOYL3LX6Pi+WXs+av
 6IbW/HledK2qwejD5ZsweSdCJ17zfDvqNmlfo8K9l7Ky937JUCMxD5IGCTZbPIFz1qoMHi2o/
 KOrrSFt9cKiwuGr13wrwN97c4NVriKpF6NjnJ96J250TcEXyrPW4oKZPDMCEE6Leu2WCvh6jc
 slgFrktf8pT2ucSAa6E2Q6gtNE0ovJK4z2sebYLRbojWWLJ2dqxTyTNJT8J8THXqi9ELogXjN
 r2g3PCytLVergKOCclJVS1elbsjr1JhAo9+K2lu53G91KtKv3gXlfWd441TNvKRHK0FKFBZSp
 HDBrV0bLdPf8t8R2puY5rijE0onEEY0R63wlGzQxkPblWFNFzat4bONvopo1k6
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

The "_t" suffix is not needed for structure names in this driver, and is a
reflection of an older typedef system that is no longer in place. Replace
all occurences of 'struct scan_ext_t' with 'struct scan_ext'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index d10ad152aa32..ece9950ba893 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -292,7 +292,7 @@ struct sleep_status {
 };
 
 /* WPA */
-struct scan_ext_t {
+struct scan_ext {
 	unsigned int flag;
 	char ssid[IW_ESSID_MAX_SIZE + 1];
 };
@@ -374,7 +374,7 @@ struct wpa_status_t {
 	int auth_alg;
 	int txkey;
 	struct wpa_key_t key[WPA_KEY_INDEX_MAX];
-	struct scan_ext_t scan_ext;
+	struct scan_ext scan_ext;
 	struct mic_failure_t mic_failure;
 };
 
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
