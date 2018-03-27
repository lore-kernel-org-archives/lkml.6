Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-628284-1522188135-2-8031155923906790616
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endaca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='comi', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522188134; b=jc5Qu1mPffQ6M/ppumwxu4Sxi3nauBsJwjvBP3dtjwLNCRw
    eAUVCC6odgw0oYsZBeTwC17ticnBL4OMKPS9/pVutQfnWc10tX4v3rOT3vIGLW0G
    DLk6gfoZEfx94Sv/r/44cVTm9QZhTASpekZiWz3djwVcDFcRX/Zsts6tY7rXXtyo
    QGKzjCLkLz2SZtZZnlSL8njLWSgz/GvtoIos1UkWc7cM6Ananx6FdpbkgbyANb0V
    b3sqVaCLveF3uaGOrCR8nSZV3rUgXFSbKBsJDQAt/saW1L05B2bdpEFi/dn6349u
    RGok39PbvP4q8mKClSEcYGCBlqR9d6UdIB//H1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=arctest; t=
    1522188134; bh=DYjJvNQha2Fyh0b2+s7YPgcNSQMEcjNQmf4NWotz4TY=; b=L
    3pvvrDUPCr9dQuVrAMg0HreIDqQQpv7KtjgFoomtarDUAVN9T5bRJLt0A8QdS9Ce
    niNKDTLBiruH8U7pdHXOn3oH9xcmUsLL54CfVe5+srhaexgQZTYsv/bXi00qbcPa
    AURy1OOz8HBpI/3glOyXRQuAnfuf5CtvoywCyXWEmCw3n0p0wLXi1mM2yl/MSsm9
    xmHZRE8HBhGeiAA3ztu00LA4ST0rx3DF9v9rY/10WYhRJ3IJWiWPGSa1dJ+gndxF
    HM+ja9BNuXVlCSkVEaS+WIMZzrSML3dKztVWZW4mj98HttCiQSk6nQ4tl2KA8HWA
    +P/htx17CjsGqI/pFjt0w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=permerror (from header invalid) header.from=linuxonhyperv.comi;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.comi header.mx.error=NXDOMAIN header.a.error=NXDOMAIN header.aaaa.error=NXDOMAIN header.result=fail header_org.domain=comi header_org.mx.error=NXDOMAIN header_org.a.error=NXDOMAIN header_org.aaaa.error=NXDOMAIN header_org.result=fail header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=permerror (from header invalid) header.from=linuxonhyperv.comi;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxonhyperv.comi header.mx.error=NXDOMAIN header.a.error=NXDOMAIN header.aaaa.error=NXDOMAIN header.result=fail header_org.domain=comi header_org.mx.error=NXDOMAIN header_org.a.error=NXDOMAIN header_org.aaaa.error=NXDOMAIN header_org.result=fail header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP/CjioxusxvFiAESp2hgpl1MnAt44bRfXkflQh0TnkRXtqVomhoeQFFeTN6NFDJTIg0CnW370tyGePie1Pk0Clo78+7lHLwhigeMRk8kIaQEmaihcKP
    UEBJovab5T2Ie8AWKom5XTWQ0GeDjPaZazNZyRPEeATD4T+47rW0w7PcA4tn/euZ/DGxmxa6vuFXlVHnAEatqhy0mCMzRtPiz9ENzJqjupP5Rdh8cA9SdVeM
    d+pxpcWNfaL9wjJ87umWSQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=xWI6jEoKANEY_SUWOiYA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.comi
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 vkuznets@redhat.com, jasowang@redhat.com, leann.ogasawara@canonical.com,
 marcelo.cerri@canonical.com, sthemmin@microsoft.com
Subject: [PATCH 1/4] Drivers: hv: vmbus: respect what we get from
 hv_get_synint_state()
Date: Tue, 27 Mar 2018 15:01:01 -0700
Message-Id: <20180327220104.19700-1-kys@linuxonhyperv.comi>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180327215859.19624-1-kys@linuxonhyperv.com>
References: <20180327215859.19624-1-kys@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfABmXR7Rk+vCv4NXGkmCKpUssJxtEkQ0Yoc7ijs4GTxJUbbd3qbXoBelXaMZqadpCX3eqgtNIDb6XUqZyPpBe3Q3+q78/oMciN8lUi97ij+42Um8MF22
 Xe5k5lWBGpNPmf2a3uul7DbcEBhrOuG2rPNHM/v3f3ZhBVDD7qlkeUIpXFZ453h69vcbkEhSNdJs0/suO4bRCGNyDgSBOlDWRmcljU4nQ9urgGyV0BlPtQcq
 Opfu5mqKC/mEAC6wjHx1hYiW1Cv6y2Okq9H4BuklxR2cGVitlj0Z3OyAtXmdwdsuzX5iEvdqVcE5AicyZa6XCyG/4Xy6b8qoZldJlOOsqtu7/fZ3LiBcEhKq
 /Op1NRTWgNjkteV48/BLUJCPh3wAecbtwzZJKzeA6wo0x9oXHZCmigc0fvy1pmLkEnC4WU9qkn8BJ2dqG2nimx/dC1i9lAC1XcvkKHst3aIZLmueOuesCuVm
 HftEF/VueJKc4EreYc0wJiGUM5+XPO/4a1F6sWFZMzt56ICp9S8pj3H43zT5p0QFvUDrwi/NY+vNwzCdXvG74ANSsb6SCYxP8tg7+xBCDokZNItL87sqa0RH
 tbs7YE0HwaP+hjtuAyPRseSH
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
Reply-To: kys@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dexuan Cui <decui@microsoft.com>

I didn't really hit a bug, but just happened to notice the redundant line.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/hv/hv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index b1f6793acf4c..8137b3885b99 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -302,7 +302,6 @@ int hv_synic_init(unsigned int cpu)
 	hv_get_synint_state(HV_X64_MSR_SINT0 + VMBUS_MESSAGE_SINT,
 			    shared_sint.as_uint64);
 
-	shared_sint.as_uint64 = 0;
 	shared_sint.vector = HYPERVISOR_CALLBACK_VECTOR;
 	shared_sint.masked = false;
 	if (ms_hyperv.hints & HV_X64_DEPRECATING_AEOI_RECOMMENDED)
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
