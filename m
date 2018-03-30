Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2927865-1522393797-3-8489797946583536676
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522393797; b=kPQncK9M2Plyn2qQRkmepdmXr8kSytPd5xm7o9PbPSmkThmow8
    Q1RDJNiqeDHDNCpT7QTHQMlAztYeuDrTdn3HX8ZL/IutxQfUal9h2CD70jjzNvyR
    pyfxgSqGpAv93QgWNuQGFqkM8X4fjiT8F3QDvSPC78CjMSyD+QWi9kiBlJTi90F+
    mrjPny2J6014tj6rymF5Lug8X83dNw8O/I+leU44ytBZSmDvjrww6sufmJJJg+dC
    iTGsWuStSSoE5A8smtXAykmv+bS81K+mE5j/WSR/OvMtzomvFLFwrbzsSzLMjOpw
    LV0VtQ4KULPaZEPjlOtpU+iZ5l6I2n7XYNqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522393797; bh=IXuV7
    vRJps0YYali37oy+Bep6lzngr2R0kLrcqdO9Gg=; b=ZpMxWfdu5MtB53jaw2BOW
    1EMqbGbKkCs3zypBItBZvEX0jhY3+08nFAdhPSNlAR7l7+WvR/3WGSt/35YmMq82
    QRGbgZWxYfs6j6mH3LHYlDDsQaPVy+yyC1NOMyeYX5V8SrrGLLrRkl8PtbCOwCVp
    tH3c8jXrkvUcyTlXEFUUHcLpLPms1z+DSedFSteHUE3JjSk5NkK+EzLg4JJ/oCGl
    5gTRecdue6d4D7Jw0afBPoVHSvK/Rpo1G7JzxxBM2Pd5HYBVUoYfTjtTGT5tLZ8L
    8NxjIFxSsTY2OFtKOLfqtGI5nuuRviErOgLqo3+h7N4Das40OgC7Heaj2fDryk7U
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfAHWoTSywvThk9nTrw0v9/1So5Jpf6dqvhp7Nb5E+SZTS/sHTd5poOQgiKB2fbmtFx30Lr7GkaQuknP96Ee64Jh1jy4a3ekO/VLWMIweEkYUqwPDPMP4
    4ufa23ASXMk/wzuopQW7Z8WDlsKy5wJZPWGRkiJVqF7jXTjtaZjCFPC/5j2jZuNeK71FfZgVYjfjgCRp02k6EhVfhaoh+TQpL3uzYsuL5Y9rbN+Pjh1sbCcR
    0bUwoEktxcNh8V2OQYSzPA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=zcnEEkgR1p4y656zIssA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH 18/76] staging: ks7010: Remove trailing _t from 'struct
 rate_set8_t'.
Date: Fri, 30 Mar 2018 00:07:41 -0700
Message-Id: <20180330070842.25224-18-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330070842.25224-1-quytelda@tamalin.org>
References: <20180330070842.25224-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:XvoXKVdm3MsXemb5festL5Re8c/5oyLEmQ4P8wI/j6m4/h59lZa
 VUR0hB7iufvJjXPa+ivauCy261oxSDMdXi+P17nWl0QtGAtijYoroFbOJIfgsdlsROFii8a
 qBKbeKRxHDTx5WwYRR6cHaOF3kiFTEJQLhHxwSV2qy5KYSBoOYomqoRgsBX1GSQaYrYD4WB
 qTLfKpbUUlPFlJom/2rew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gWyj3Jrlt5o=:kaHXA1K3o5LN+hGRFbqUud
 kjTuXRFr/PBap5ZWSa6SSw7+2Wtu28yKIFFkPFh36OQiNitwFoNSiDcxzdheKkZb3u8AIIWfj
 m/1vX4juw2zzkgHIIeLQXkafFoZBbq/937lVJS2w90PyyDLj7CiLthK/K3mlELgOwuMNMq6kw
 qrhYvfuE8pmx2rcUEqI8SldHtxCEVL1QcoZAJZCwLAWD6ZcCPLhpxW3NeGGN80/WibXKUdLvG
 Jz56/uFzrvlPmDCrkvRBwgCINnskFPnSyp4CbA/qsgdHzFfPTtgopfwLgoJRx6i0WZZWpo7ju
 iILHDN40W+JCp/LYKf8Uu0sTcAKrDarR5DRNoghAkF7+zV+aQRYwm6Zil3J9ST283ljBzsEeF
 7kULOGvbeoEvkrLyx1ppIm+1ZWqU67OjEUXkzpa42UPLJfU+1MAZIKhF0JAvuos3cMU2xtGiu
 oLVhkSkNofe5tXpXHUFGYg3sYdVQl+d0/1Lkoz1qDBvdw5EkgvxW7dpb1++CHvBy1qDhcDk0C
 MFE+Qm7si8FpcdrKkvEA/teLK9A0LonKy+Mh9ctPAI81S5hny1D/jA+h3sUt+AM9qa8Jh1C5Y
 mtYLgP19EQb+iJjqVnYB73icOF6TDqHV+JGQIcUSssHkUEEufae1N/XbGDosmA3GNZT160S9K
 wxGWvNNZwO8Pc0xwAAPH4mQRv37CJSXV1XWMfh00Rgp9Z4Ao59+JqxdhZb6QXzHb4t8Efuhb2
 MvqA/fFAX7KoEDYCw+96leVZMnm7Psg2glQEIA==
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
all occurences of 'struct rate_set8_t' with 'struct rate_set8'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index e87153786d61..aa1f5fefa818 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -232,7 +232,7 @@ struct ssid {
 } __packed;
 
 #define RATE_SET_MAX_SIZE 16
-struct rate_set8_t {
+struct rate_set8 {
 	u8 size;
 	u8 body[8];
 	u8 rate_pad;
@@ -299,14 +299,14 @@ struct link_ap_info_t {
 	u8 pad0;	/* +09 */
 	__le16 beacon_period;	/* +10 */
 	__le16 capability;	/* +12 */
-	struct rate_set8_t rate_set;	/* +14 */
+	struct rate_set8 rate_set;	/* +14 */
 	struct fh_parms_t fh_parameter;	/* +24 */
 	struct ds_parms_t ds_parameter;	/* +29 */
 	struct cf_parms_t cf_parameter;	/* +30 */
 	struct ibss_parms_t ibss_parameter;	/* +36 */
 	struct erp_params_t erp_parameter;	/* +38 */
 	u8 pad1;	/* +39 */
-	struct rate_set8_t ext_rate_set;	/* +40 */
+	struct rate_set8 ext_rate_set;	/* +40 */
 	u8 DTIM_period;	/* +50 */
 	u8 rsn_mode;	/* +51 */
 #define RSN_MODE_NONE	0
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
