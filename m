Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3402981-1522275992-2-8685807867739466745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES endasv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522275991; b=c5RrA34RCgwQOa4VDtCEdZFGMTR56DKYxjfFhk0pshGRxLo
    WAKsCYrQfT/QZmGomarfn7sjHPs5U0JGFsJBU/W2H4bOQDNXe9oDDdx4DjPK8DK3
    BWf4hrSDkqPXfYe7Dxf2yfX28/WwV1NmTF4dBeNdEBboM0Ry3OgoHLx9RqsBuxQs
    ZE1nfvnezsOfV6WHnVyvgacYIr839+IDURrxOBIFcdN//WbInBHAptI+75xEiHtp
    yEACCMrxwggcbGshjJOht/p549vnTJXZ6ecwFTtMXzwMvglSRfb+7IxVq203CsSf
    F9y5Unuvcr5GVDIf7AKG40ibuk83VgAlnGuQOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :mime-version:list-id:list-unsubscribe:list-archive:list-post
    :list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522275991; bh=1
    RIjJt4Sut7PW077akdaxrWX9Bml4Nl0XHGStVem4Jk=; b=Oj/8rdv6kAFuXgOxN
    f8iTU4LinJ0gw8ewJarHNhYcL38p/DxN72XzpsWwDkZ1ffQ7OvO0QPUWV17fTqSv
    1yePJKkaGjdyQdFMrydHQvimXy5+ibe1WzITWketKMYrYuJF5afAG9w4HMOe3JbG
    T4EiOikYi1t7Naw6weX8vBN5XXCes/LGhrRPkXU75pJJPkT+hnoYFVQ3UrIpifm/
    TxH1y5exLAAyMt1B4GocCCaZdKC6Jmas73jt8j/WWaCIpxud0y6xtFvTAbNTll9Y
    AmlSzYNpAGVkxFuqUrsrg3+YeQNxscmLctcUDbyGeYTteT4tMO0WGLCNEQwoUpvk
    uo2AQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UrpVbpej x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IdjgS9Ly;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=UrpVbpej x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IdjgS9Ly;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPRVmQW3ZFRYqfc6+CQWQ5jtGU5tHtbYJj1heguOzd9I40HkF88hXHub6fphm22dke5UFkkF724GidpLQw3lzihTGbdSk2boEwWXDLsHFhCeavI/icvr
    vkoVpFKLhOTAJRm2uzxy0R6Ozla5QiQPqz2NZoz8NvMppxBPCvtfLdN6Z1ZqNIEx+9XxTKtheet9CND2Qnmhb+1DWbPO5j6xv/kppyn6hUgVoz5+12PZkQ3A
    S0YVunmJJZ3cwy6eUYMF4Q==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=_n5q_SG4vf0A:10 a=v2DPQv5-lfwA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=kIuu8CC8UfMr2G1DqIsA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4/kvk/kYgV9Lr5biQT/n/Neb6lJ5fmG3gwW+OPayxO7g2fhm0r0+biXCo7i73YoJg8t7wyHew==
Date: Wed, 28 Mar 2018 18:26:22 -0400
From: Thomas Avery <tavery321@gmail.com>
To: gregkh@linuxfoundation.org
Subject: [PATCH 1/2] staging: rtl8723bs: Replace yield() call with
 cond_resched()
Message-ID: <20180328222622.nure7tvmc6bp3w3u@debian>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Remove yield call(). yield does not guarantee progress, and should not
be used. cond_resched() is a safe alternative.

Signed-off-by: Thomas Avery <tavery321@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 7d7756e40bcb..fdcc5b28af22 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -4263,7 +4263,7 @@ unsigned int send_beacon(struct adapter *padapter)
 		issue_beacon(padapter, 100);
 		issue++;
 		do {
-			yield();
+			cond_resched();
 			rtw_hal_get_hwreg(padapter, HW_VAR_BCN_VALID, (u8 *)(&bxmitok));
 			poll++;
 		} while ((poll%10) != 0 && false == bxmitok && !padapter->bSurpriseRemoved && !padapter->bDriverStopped);
-- 
2.11.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
