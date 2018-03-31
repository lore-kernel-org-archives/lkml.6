Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1160787-1522476692-5-15157590077006716862
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476692; b=ZQubwW1VuW5i2zWJpTkYi2Voa4gTATFJBDsjCaRXmZar0G+3xI
    jkbiPJd/oaTuZYQYoIG4aaZZG1l7GVwUDhEcbHbC9nx2QwG12o3v0gqfFuWEQO2q
    oSgmRgqCEUohqJ6kNCQpTOJmGE6iKSsOV7kXUJsVNz1GoE1bmcfrYT/XQuBZCvQ9
    stGnHx08gToSvNxiqaRooGLUbo1U5xTIdaLbl6Oo1IbX+Nl6sHntHkvQ6yiplbIi
    bq+EaRft5S24QNqW7D3AwKG6rYWW0nyIfjMHQ8VgcD+Ot2jXnwaXnLnAyunPDlKn
    fsm1ZFVbrVJLrG7eDLAC4gxvEYnuu5juGIUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476692; bh=VenVt
    qxhYVntRq1rJs6hNBjFqg3L8Lvopy4Ip+gcwV4=; b=NuVCMuFSbPYn2XrMeHWzM
    pr0LVzyXF1+P+42y5Ls5hmxwKiAvjMNJWKsMUfaO1tE4r7uXEGxLl8QmwlvJIP3d
    iwkj7lAQf+98snXTv/BKwgWAGV4w+EDgdB8A8gYACkKC+qC2UtC6wH55ZxZoBwOo
    OSikGqnmq1P/hkAv3usxKFGOpi88OOkRpLAJYpNUiRlt6+WY2uGG7OY2hXltH1LV
    Ww11UTiD4m+hlkq9f9YM7umsRx7yVgdvLuFjQFpdFAZJIPLysK8zZsgcmHhXBDjz
    Hih3JaFXUc6sWcwzU2Zq+JdTXC9Y3RmeavFjrg+hopfZ9pMjuwzXAIMDV80SBq7E
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKtmL8F2Qyhu2kmFwaxPW3IveexRc4VTQcBH9P09Eb5h3oXwOzjz62muKor+vg9yBxJjzGtbL9NbYunCtRH3yoxTwbtQxoC9Y+gYQE7d7nrYqPtu531d
    WsDqVB/x0H73/rpSDkMgw0cLOJEeg0j9rG9qLdrLerQQbkY7WS0Z4/RV9koO9C0SXtH8fSVK3E3cogGR++Qu9MTQZhyliuwSVG8PTO7ktfB4i5lx+4+hTLtx
    cYqdk7YD4PRJuMlCDfZieg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=sXtwo3laXlq7sneXbSIA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 42/75] staging: ks7010: Remove unused 'struct
 hostif_associate_indication_t'.
Date: Fri, 30 Mar 2018 23:08:22 -0700
Message-Id: <20180331060855.9452-42-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:adYHqI6rtfiKvK2ooQAP7d1okuOnwmFd7z//JP3cjnKgWQYtYjQ
 gTTJhsJaomuqxeHWIoczLobvP9ZsaOm/aWNqupxb5B7R1BEkV4OlQlwaNjZ7D/IyrGtNhGl
 0jp4Y5kTWx78aQJTdeD+htLmUh2030ofD55LcfHiVfbwc8363Sh/1Ng1+8Pq8462r18xFep
 AQbGcxg4Pxeu5HKIqSAOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N8MW5YIthgc=:cEiSlR46uJpDSZQOqNxUWq
 8T1t3fTAvlm13328YtDra0oHFdzqNtpbRIHaz+XzNvnwtEenZizDhmdU5yHunHFJhoVanKq9S
 OAZkBxW8vVtBo5YM446xKjBglB8AzevaAJpNTg6Cj2onVwvlzlXRaFR03fnqMmEiOt6VPfH2x
 r20qJPttkVQ/hvtsS5++1a/lzYmyY13f506QVeHz4aXY3FEKm2+xRHLaMuCIIEyuKBc9coOKY
 x8rqkCM6/UrqliTAaSYrKJNzml2gzsBWKYV6hhwaz0pdg6B1fa5k+wwXD9fM4zEjUFokDuk6f
 vo/m+lN8tuwnmkCphL/YpH2QdY0MIjz1KjWhZTkavcdY0tcTCcPsKHGkoCg9qMSrK4vjU5MoG
 JwC3FrbfrXCvnSDYqrTNPUIpKzsCGPx83WKOg5BY5vH0YW8SVVlf0xZCQ5I1r9CZiFD31rph9
 d14fYZQhUZil95U3f676tNLOu/c+wXUBOc/LSGOtEwBFuhCpfTXBruAKYZPWWwy1VRdomskBc
 uo08dPnxzJV2jbSNvAEyE4/yYwxWVBgH4XENW5ljkwqEL6UioR4kNYArf8dJl/TEuWeb5L7eL
 oSn0liGJNpbbc3bmTmNIm/mCgctv8kpEaNdhtFzq1UG2nAPjLC/p/FNAnZ9BySpvqYG6fjRhd
 wOaUEoUyRwbnH7AITtXaXcYydUmA6Gq3G6+kBJ/33Bo/ELTiGlpTlw1L5q3jGv9FGuhpV6bkf
 tHUEtAPLLmZx4TH6xg+HJMUjcs/JsM76w16ncA==
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

'struct hostif_associate_indication_t' is not used in this driver. Remove
'struct hostif_associate_indication_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index d8ecde16ecd0..9c8b0a93f7cf 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -389,14 +389,6 @@ struct association_response {
 	__le16 resp_ies_size;
 } __packed;
 
-struct hostif_associate_indication_t {
-	struct hostif_hdr header;
-	struct association_request assoc_req;
-	struct association_response assoc_resp;
-	/* followed by (req_ies_size + resp_ies_size) octets of data */
-	/* reqIEs data *//* respIEs data */
-} __packed;
-
 struct hostif_bss_scan_request_t {
 	struct hostif_hdr header;
 	u8 scan_type;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
