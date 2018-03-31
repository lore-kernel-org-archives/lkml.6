Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1111812-1522476685-5-7787864352647689024
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476685; b=n+q0aWa70oQfcn01i+2rQWOo0iDrsfaH9LKfuluG6tg+L+TAxO
    g55BDMxeJXpOniWvJ7ERqyIFV2NBhrFpX7mawHpHsdwvbGHysvoS3NAJlixfJZxV
    NGaw+8ZEo5pDEKsUKD2c0zHU2aP+EjvOtsmAzp+j0WJ3oCzu1BKc5sA6niIXl+f4
    Cyd7ty20hR5/CQQyRd2Lqh9gRHxXuqIAmyojtXfvv+ydA1727hnoLJPDc+wwj12y
    0tqnfuLtHLpb8NMZ7ibKQEZhe7zioQB5OqgnnQypktiMb9n7Yl7CL/L78Y+ePK3p
    +epvkhat0bfN+POv5dcBhy+VYkTMiTAbC6nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476685; bh=ToXPh
    OdRoucmWyqskAI8eP9e0Cjl1jMal8N3YuKpXxA=; b=Nla445PZTJduX684A1att
    Ckhc8xDNKORuCCnWvgB8WXiulgjByvmuIjXhs2CumyBeTT1ZA0YoP5b9F973fXeV
    tfD5685tCxB2Omces6lWp2VEcQkHrlAkFR+dUEBD4mKx1rVV7kMoxnrFEcQCRCBE
    oEZO2acLyZYXzIpGsdLdhlGdCHtq1QyQ8R47xctCBqNUilcWk4+dRHZDWk4pi28o
    HHSY97h8HZXDXWbDBeGCLqnT3zs67lXmPVH4uI19XI3Q92eHs5NNosLh1IuNoQtG
    qo++EJgYeY22neKaT6Momm5/tUwO+PuNtzY4yvIuBXE3ypMS4Pg5uPCNiLa9ysFw
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNv/ZXdOe/ft9mgkq4SqnlZCk25j1u5rNjxp70MHqaEU9Vox/Te+YF0mDHNUdgzCw2cKJEdrTxTgJ69QVHBjneO4NBOMB9yfe6MPByJIu+pOSUB/8OYB
    jYw73j18GY2WNSKVVg3fhZnWNUPBlfrks/5If2jJbgNFkgQ8r1qK+dGoNmO92J25pI8szgV45FFVVQAg0C0bRktc/di110b9zr6xskrwrAByl66/bOL+QrKm
    p4M7+vCTF/GWCBluScVnOA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=V_zipIKupC2UuXeJSREA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 49/75] staging: ks7010: Remove trailing _t from 'struct
 hostif_mic_failure_request_t'.
Date: Fri, 30 Mar 2018 23:08:29 -0700
Message-Id: <20180331060855.9452-49-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:U+7/EeW2gBviOBroN8rISpMnrsxgM8LFkoXnvFu82P2OsVAf1L8
 kXW4Dp7pdrR/XLyOuWL0PS0n9vaQfZQmBzJsJtrmsHkXJ8v5ooRABESqgtVEln/v4mRP5TN
 rFVxDowdl+sTFfak4tUxy8rmiExe4rw+UHfH0gA35KN9BYtKxno1zvlRtiICqK4jrst0T4L
 MBYZa0XM1JUfd0zhzYkow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mOUkIdcwe0U=:EiRyQT3eByQzaE0ptjE+QZ
 w3dR96MgQoZO5QkAywubM8rb8093ZFZu5c0KzYkNMNRLore0G66pCbd3EDHK9zgDbaX+K7zhI
 0J/tUmZs8D8HKKB3zi6WE8YOcrL8Ong6zzrWOGuqNLNALCwIWXhG6O+OmW8+HWOTfyb4Lkrs0
 tKpgk7T0nRhktbQi2qxAMLFatxSQVoKYOlTjI5mhwxQ8CHa7etNKgjY5T2axksbAbwiy7TLAY
 KnId6zwgDZcc+BkffIC9qzb2k+WCHSn3Gp1js+UcyEMT71QCeSDrJqsyG1mcrLSb6bDMdEDqY
 +PGCdCj1aPDVylFFhroNxbH051wZOyghTGE8x1ni6nEtdKSJeMmPBHvsYOP6Y6M26vrmXMYoE
 IolNNviw7Wg0fmWzxuy037egLMlX02E6TFQA5YPogI13vRFVIOujo6hTR+1ujfvO/Hobx3p/I
 CyN5rlmIDDTdfmAXrgVLGyGbDGFq3oc1oAyyWMdduJ0htG28lQx+5Dt4Tl27jzeE8z/mniDKd
 /7+redaWR1c5Rfq9VEN1ZVsCr5A1q7VGdY8cBVSE7dHkkKE0oIRm+z9P7S/Jw6xWKMh/UIdqk
 MmIjAHVCWHxa0JnASGMdzZ+VZE9FEPeFGncnTeinrQjVOkEPCWIua8wa2vP8gIx4bIQSe3ouU
 l7+4kSd7ZfGGqG93cW8C+r3J/I8B1WRzkBFYIYmm7nLlFH7UgsTxy3EMeVP5p0vEe5PeSc/NA
 RAUMdaLavAdwqXMFjkgXvgQBo+MQ6r6pygBhIA==
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
all occurences of 'struct hostif_mic_failure_request_t' with 'struct
hostif_mic_failure_request'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 drivers/staging/ks7010/ks_hostif.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index cb768e861b07..2f732d8bcc4f 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -1558,7 +1558,7 @@ void hostif_mic_failure_request(struct ks_wlan_private *priv,
 				unsigned short failure_count,
 				unsigned short timer)
 {
-	struct hostif_mic_failure_request_t *pp;
+	struct hostif_mic_failure_request *pp;
 
 	pp = hostif_generic_request(sizeof(*pp), HIF_MIC_FAILURE_REQ);
 	if (!pp)
diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 16ee997c37ad..f6345779a039 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -418,7 +418,7 @@ struct hostif_sleep_request {
 	struct hostif_hdr header;
 } __packed;
 
-struct hostif_mic_failure_request_t {
+struct hostif_mic_failure_request {
 	struct hostif_hdr header;
 	__le16 failure_count;
 	__le16 timer;
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
