Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3308147-1523479348-2-4963933498493975638
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479347; b=lNyy1fzewoZ+a346MLtiK6+E7yrNiTLWJtpJyWijkXGwxDubR9
    gRtGUAEzfHYMql9oOq/S6RGr2u6wJEl9ApOOWQ9ijPW6iQuDwnXXD0oiBFRbx28d
    OppIWyPV4I5T+10XXEUMrD5uwzGweIprK8mTizbbpnBJBS+yQiNAkGyMA0V/uzHs
    iyWkAApn4ZbUSaWumD5g4zanycXw4GS+xGWMeZ4qgm0Df6vbXGH3Zcx/LQssYvXw
    uzo7YytL2CLY3yZRJ2hmSK4WyY5aktFJgT4+YclUzT7Qc/e7LZP+xe/qa5Jm77xa
    s3qcfNLSvVfHb8cSrJ7d7GN1eZ3Pxm/GYN0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479347; bh=hoN97JzEfM/GqqrkJgimM5p8oifxWG
    lFkwwaFD0t2xo=; b=vFK2eB1s5sYesIfIPzuSvIQpvc+ijt3rbeIMJ1fK0bS0Bg
    hu09m05KIgmmULqH1Q080WiXoH02sM/o99FUJuKKrYFaFowyqaDjVbRoXIClAt8p
    UuZKpJCM14p8F05YFMRYfWpKMfvQ2NnvospmFKUz5lXdJymvPQ+e1r5+4YMb6a9O
    VWY5H+dd8NDEA8ZSg3qajsDHqerbscSpFeaQpygq03MOS5D29RhtpP0P6CHF1ujp
    QcYDRNBjgIXwZBQvPxpYm0Q6D3rxpWqAUmVsnubsozAfV0CMHTAp0xS+cRLc9Bq8
    kejq2FPT5JCeV1jaFohGTVHzwBkwY/9eI9Gut+qw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF21l96B20IW9Hv/iQCvzQOZZS5PxUIl/adq4eMpUECUrEJPI0lgPWxehT9ZZGnvEXkMrusHjzv/Ek5k8Zc/+57356iV8bKdEeFPydTL4fGxMvFADKWc
    HJOrWTWxzIecgLYrmwH98gKmwAm0GNDWvPcnXT2DpREq/n8eqorflxDVSmLYAsyjVys7yGXwYbgjNu+SPPuqws9U9PPm+Pz6gRE9p/rikykJkorO1iYUlppa
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=87FKqs1evWIA:10
    a=Kd1tUaAdevIA:10 a=DfNHnWVPAAAA:8 a=LpQP-O61AAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=xEerS14Cv3jbGQLTJTcA:9 a=QEXdDO2ut3YA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755958AbeDKSrl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:47:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59406 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755922AbeDKSrk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 094/190] wl1251: check return from call to wl1251_acx_arp_ip_filter
Date: Wed, 11 Apr 2018 20:35:40 +0200
Message-Id: <20180411183556.085953270@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit ac1181c60822292176ab96912208ec9f9819faf8 ]

Currently the less than zero error check on ret is incorrect
as it is checking a far earlier ret assignment rather than the
return from the call to wl1251_acx_arp_ip_filter. Fix this by
adding in the missing assginment.

Detected by CoverityScan, CID#1164835 ("Logically dead code")

Fixes: 204cc5c44fb6 ("wl1251: implement hardware ARP filtering")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/ti/wl1251/main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/wireless/ti/wl1251/main.c
+++ b/drivers/net/wireless/ti/wl1251/main.c
@@ -1196,8 +1196,7 @@ static void wl1251_op_bss_info_changed(s
 		WARN_ON(wl->bss_type != BSS_TYPE_STA_BSS);
 
 		enable = bss_conf->arp_addr_cnt == 1 && bss_conf->assoc;
-		wl1251_acx_arp_ip_filter(wl, enable, addr);
-
+		ret = wl1251_acx_arp_ip_filter(wl, enable, addr);
 		if (ret < 0)
 			goto out_sleep;
 	}
