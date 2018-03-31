Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1111812-1522476704-2-6524593950338227079
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES daennl, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476703; b=KT/2li4FbV7mijhl/6z551YOZlLGT06ZMiOypvjt1E8L2EWoI+
    H2NRjMI2s7EML5674Yd8IF4DYlFuw+tzjSD0JB1xT+A+rOqk+lkfVFGdg2eF97+j
    QLSWK3BkCN/blcRMoyFODjOqF198aHPyXnsubhvWoEEpJWQRySn8TBEurHw7Ut4i
    8RnvneJwIPma/A9wVpLBVVyxOKlpncHXh18zvI/cmhXR17wuNYzi+R3XugtBlZJZ
    OJAVelgrtEmFxeisVvw7wriwEv1K5fOO0gnPfHJTXoNYCA7BACJJ81sbY9oRjWqW
    fOHTKSZpwVYYnej+YWKxcph5dSpL4NHDaorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476703; bh=rMFaU
    hTm8EedqiQWnbuD0C9ErwWuTnxs6WXL/d0DNMM=; b=ETRj8+D8XOgaxZ7w33kAi
    k+u1wtIoSGkpFbq9zkvDA8E2YSiPL9y5qTQO5eckvExE5O4HhwqzEYjGkj4HbgWQ
    OmKjW5m66S48zGbskSTuZVKuOYvJLTS51iWn/W9hfm0QkDrLd00O158pZaPFLJnL
    1oD1ku42hVMgRL+0fnAqqj75dksEPwI4J69ivasUcrMnw1bvOc1PMpaw09N3dmxz
    R8GwyIdIp86dZg4nnmaM2HuLKNPv4AFyXJcUmAD9ltnUVI0l8m8i9ridoUcpEIam
    kI6Jd5PjJ5vlOcXBEW6r3lxlH/cQxbU4h8NTHv7KGDSMEGLl/FmajAZW4FkPl908
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfLOSiCxAbVjCnHQC96WkbcOBlNL6v7a5sgwc0Bcm9h9HVPVVwQPy8Ykt1wMqvzHB4Fz4B0ljFtFF1eaQ5ZOY3GkfFe3RRA3hhxHTiz30VfL91yedHcHe
    iMRAu6EVnvMxOzlY8/VsEhnhJoSMKt39b3Xkz2IuWG4WM4CQmWE4sp0w//UYaG+rW+sSZKbedxU6IGBKmzxkXWpIrr0YqnZumm/6O9whxun1hlThYGP77tJ6
    ot5MOf5cFo53kywb9N+8Lw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=OtfmYoJFPOQwPnFs3jIA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 52/75] staging: ks7010: Remove trailing _t from 'struct
 rsn_ie_t'.
Date: Fri, 30 Mar 2018 23:08:32 -0700
Message-Id: <20180331060855.9452-52-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:0hOAq76FnVJAbRYp39U7Bf77Tf1trglzYnT8BPBeGQi0sQPrd+c
 77ORbMUeuLV2UZWqYxybj3wuvoScnaH9BwN/fQHYkosZ0WlsIl12WDBLY8Oq1LePacxHaDX
 J/YnM/IJD3/us0S2NgFJ7dUdW/TNrIlsTbisVPoDJethOW1b286B4BzylcsaCyT+op0ppl5
 KdCezXlwQB781W+x4aBog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JTmQvBv2LjY=:fkDUuqzSrPY7IBhq8Ut0xs
 Vk5xsMvBQ3z7lDFiPFDZG+lZ7v8+XL8bgkCuH6VyIEpP5TSZhEx3hrDWHkNlGfbSFU1gR4PnB
 ABwv6PD65nsJU2lMpMCGlFd8+Uf447X6A1wVH0EVTkLIhU9vMHcXKRW6SxICF5UsFlQqQg8yO
 bjH3AiRFnUyrimCsxKUOvdytTYKvS92QVrYtkx1jP/oS5rxCoS20xbF5pN7fPUycvjfaz9qEo
 qUZY01L4XpUPhHcbAgciD8+7VwNGBSooa9ME4m+Ow4S6e6qEDXtK1AzF9INhiPNFQMBBFErfx
 HJRNAmL3UL1mYpqw4Jp7SpTXFEHJkGTWifr1foW7IqLbLGIWbvVJVbcjkoQNBVU45SWhJf98/
 uI0UA3qn5H9yNJxlXY0hKfqZvYzrxXJC1FOfPQ/uKjGaDFj2lDVMeRfAHawiR4Ug/4pGfpglg
 VSOQAu2/mvVSxN7nWak5SWyi5nMwQwp+0j7a/lJhdg6HlBT1vNQiKkx4BFzLpuBAqD0Yy6qzE
 U5UA+gH0EPZkrDekjxKHOHW46e95ufAaUZ5nU6c4hDecEjGqzCEh3VJFN7mtm+PNy6d9weJU7
 41HDlU/oOitu8yW9v4GIe99LozzgS0Btee999I9APunZ7inLRk0f0ZT0j2pkGNBAGciWqSdkv
 KJxMkUU6gOa155p//RmXcNf8vzwB9Z3D3KN+pgz02KfYi3c23xfeR+kdYn0QBct6IKKYdQRnY
 dQGtny9Ka3jFkLJ/SsRUxsKKj+9zQcL0CALu7g0priF3v9Mbo5BHV3jj/aKz2vt5JzBvjBFKC
 jPB6xh/NCSYC879X7pJRUYclmJhkXHO4uoFC5iDYqIaTRv6CUElKR9YkwmiLbd8oWGc02QBP0
 FymFvWzL49BSfXeg/6aufA94ScxOFpXLQR1DJM4YLG9BQ+lm+PuBH4YlsTvBMN
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
all occurences of 'struct rsn_ie_t' with 'struct rsn_ie'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_wlan.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_wlan.h b/drivers/staging/ks7010/ks_wlan.h
index 3ea62b708b01..10ff4460594f 100644
--- a/drivers/staging/ks7010/ks_wlan.h
+++ b/drivers/staging/ks7010/ks_wlan.h
@@ -203,7 +203,7 @@ struct hostt {
 };
 
 #define RSN_IE_BODY_MAX 64
-struct rsn_ie_t {
+struct rsn_ie {
 	u8 id;	/* 0xdd = WPA or 0x30 = RSN */
 	u8 size;	/* max ? 255 ? */
 	u8 body[RSN_IE_BODY_MAX];
@@ -235,8 +235,8 @@ struct local_ap_t {
 	u16 capability;
 	u8 channel;
 	u8 noise;
-	struct rsn_ie_t wpa_ie;
-	struct rsn_ie_t rsn_ie;
+	struct rsn_ie wpa_ie;
+	struct rsn_ie rsn_ie;
 #ifdef WPS
 	struct wps_ie_t wps_ie;
 #endif /* WPS */
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
