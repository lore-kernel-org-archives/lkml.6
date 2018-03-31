Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1160787-1522476690-2-11730947314700497734
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522476689; b=ad+yHZCCZa5CJI7i+xU9acp7iU+hNyXEyN46+ACXCNiLO8AlO+
    v6rc1rPcOUsdUjFnYFOhVHyaFkblkrhBJtHKnNKMB5PiuKV9wSeWVVD/oLvBLrZE
    LlQr8MYT6TsLysPBWnrNat+JSAOzQKOANEvrdrHWf8NGAWjINM5Bg1NpaEbYQ248
    GHJFWwLeif2fDQiyFbAWmtfcysVuZbpyVqyhrwT7LrQopa20J2eu6lqKQad+HEz4
    mxFv1OQHwwdpUCiC9ydzKzFQ+DdApNzvNjVV0emxiIsd0c72k/uhkLpLYdqcKzVz
    rCasR5ko7WUQCdg+WN2f+zWkSh4nMq3N5Skw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522476689; bh=Mizso
    FlmaENQ8vctARjmkimB6G3xaDd/rfQv2QwE/ps=; b=JPX2dRuyuSw7BMaJpcC/j
    4Jv/tUgULBgKfCDo6zT75K1eweEsCSctVo1ii5mzBIzB0TRZi4Kb/8KXQ9oereh8
    rxlmQpFhZJnBjOLLqu9tIVM/7S3XYE6pcx3HnZC606ZxRyfwwYGbR2YAtgHMfhb9
    NwsAC58utdsN89hFNAgntyRnnpp26+eIXHwrFx4rLXdGkFEtil5ptdtBOXlvFmOq
    hg+s1WUkK9W5TyputBoljQY+yVLTAAK4XfX35BbYXM+KAIVCECyhxZ58lL2hepN6
    QRgxyJRy+vKcgc6ZUy6hh4KnqM8rPhVY4Ed0unGhxkSJRkLHFWxpf1rCrRmlacSy
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
X-CM-Envelope: MS4wfBq75w0qUHsMIp7KEGRZM+eL1NP0x/HKZwypqqOSqJxGtVTZHhodTdlHzBjQCRicxu7MVOYG2bPdsTASrSgvpJa5ZXid/4JzeIfva5pC9kT87DRik7f3
    rUd+p9CEh25PqCdKILhIc1O6J0Xj23K+ryxQJkRCou4c6MUaik9hXK2gqYLFiLRs9VbY2wbbTtkaRyqsirXIfMcxYrUhxWjLFRLxbYG24KzQOZhVbT9s990m
    CtJzFfaGiZ3ISeSPZh6V4w==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=__pXbqSboZWN9RT4u2sA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Quytelda Kahja <quytelda@tamalin.org>
To: gregkh@linuxfoundation.org,
	wsa@the-dreams.de
Subject: [PATCH v2 46/75] staging: ks7010: Remove unused 'struct
 hostif_phy_information_confirm_t'.
Date: Fri, 30 Mar 2018 23:08:26 -0700
Message-Id: <20180331060855.9452-46-quytelda@tamalin.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180331060855.9452-1-quytelda@tamalin.org>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
X-Provags-ID: V03:K0:rmTwMMTfdzj0+NeD2BLjwWnXiqxJU7QWV+NztWF6YJI68rJXc0L
 Cl4gP8D2/lv+y9B4nvnriEETImWEOhhf+oTfR7dP9uqG/aC7cvVEXQYiZjwfjB9MwmVF8OU
 6GVstea88QV4qFMZjR9r6V2K9bd8Ggb7VkpFAImezzW4ZFbAqwmVaMP8Pa47tAfPTTEctRf
 +m4m80KGqCk2blNlqVWTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/ECbLpSgvM8=:aaUCrPRm6Qo4Vr0KSYZEG9
 a7b3Wm/pqR8B4JOGyUkl2Yo59Bo7gIcw/dJmQ2Fx2zSocd3q6M5G62rJvPAYOkGYmj8WbVTkO
 M322k7Da7SRSMYhEBhl413We/kpQg0lb/eUm9DsWxBlJahT1Zp/QkFacPiQsHggVIjcLZaU7g
 w/qNUSsEB5u0Xf9IjcmPP4WAPd3mpi9lB6iWcsuKfEK6oV7FOitPhKiYTUqPyPE/1mzZkM16n
 XgZO76XUZRGaBydp3q9pQ7OJSlp8aKgG06xm5/b2U1/22u9OBkbh3pXIIVlxgw+cqbDh/BZVT
 JKztXHWRDt+GAun/7o5VlAtz1IpM60Gsl1a0WMrsZGxzhnEV49dJETdmwFCB46ly0lTxyeKCr
 3VG1nHTrnPmOH4HheKlc8Z3nsWxISOH65PqHdkw+Z+AHwvtV2ERmqGiKDq8mEubrR1F4IA0SR
 J0SgdSDGUrBOxfsNhEGagHNERR2zSgxVY2YwpuIUp2o21WYq4IIwOmI3N12AYQkWwBSvwCxC7
 Pt3O0Ko3+hrZifI3J9tCYiuf0HuEIG4cZDmDKoBCROqc/8RwiOUEmMKHR4IKtCLV/nnlXNIz1
 lomKk6vW68wNJy2zA1o9kfv6E/O5Q9lzGAvET1KM7N6puLjRITn+6Sc4S16X3ZJENcozKmtWe
 a69qoUPmM/2Dhe3E1/bnvtZ1z8FKU+lhZR47SIDuLSwi4Q1QS7jcLECTkmzoEkVDvYRlbLfgp
 6XIKJLkN0xinRDL4f34DyH+WWYRPqfJafllcrg==
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

'struct hostif_phy_information_confirm_t' is not used in this driver.
Remove 'struct hostif_phy_information_confirm_t'.

Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
---
 drivers/staging/ks7010/ks_hostif.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 348fa2844003..869068ed963b 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -409,18 +409,6 @@ struct hostif_phy_information_request {
 	__le16 time;	/* unit 100ms */
 } __packed;
 
-struct hostif_phy_information_confirm_t {
-	struct hostif_hdr header;
-	u8 rssi;
-	u8 sq;
-	u8 noise;
-	u8 link_speed;
-	__le32 tx_frame;
-	__le32 rx_frame;
-	__le32 tx_error;
-	__le32 rx_error;
-} __packed;
-
 enum sleep_mode_type {
 	SLP_ACTIVE,
 	SLP_SLEEP
-- 
2.16.3

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
