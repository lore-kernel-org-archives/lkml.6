Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527156229-2-10606172468512945401
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527156228; b=GZ/Rie9Vv7Ktby4Q49Bk6WpNnOC3YPWpnJ7RRYSx1o/Gg3OC+6
    I/Lra2d7Bip5WFIVMGPLnYqj1VHq90Y2wy6LmTm4/Ufg4RxxAnybymDHQOKLMht4
    6+7V2HU42OxVx2cbLrer2Phr3Z4E76y+9ioXGzAPR6gXbuBs7ZUJfA0Me5jNUv+x
    hc+GpnGVu/aHkrxULy/e3CH5vwuI6iZxouWWQzaNsvVw6zEVrdfDBDnglmm3X/YP
    UPISiUU885pmCCWWHOnoKQx4Km3HUZOvkcddrDekYkeWrxYsjpED+fC6vMX8vzIX
    JlWr93oU3hPlmqzTaflWZHlLqJ5goipxvzNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156228; bh=ROu3naTUp3eIzvzvaNIWhVASnQv7ev
    w4VvbZgGGWk+s=; b=fuL4cFcwK8HriB6Jy3GFSxGvMBIM0YfD1hBRY2UeowJlRo
    r37AiNVE5zV3hbodDYArabEYb+b0Fyus84icJTehVDnjJKMYMVBThCBM6CDd9dSl
    W0RgD6k3/ZLwrtfChgxOH7heInp2VCViwGr/LFTquRazg0NyLarzaqU5cdh2REtH
    lnHVO4saY1SlT7dM7knQjDSxNFDlTYDSdaDAIADldKFJdfSXFta3QKfA30hekZ+I
    Q1gJBFZ3LEYPRoB93Rzqnf5OVDDzri2sLfxpbV7EPyx9GGg8IopQ4t3TNZu3pYf/
    FOs94szoB1hqIG/2BgS12kTtev1E2Y256jzkqQWA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=JjMWQ2qk x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=JjMWQ2qk x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDdiAHJqQsLRVOrndvFhInSyLGdcCyE4lF8JCKwkBewGEqSua78FabmF4tdJIe89ZZq3IqjfhcUQghUsDfOubx/7vPhWckvR9XJYO3OKELCGpwny+S1/
    4YlyZ+tCZRzh1M9tIpZNqXgVHjMjMTg13QO2WLhJd3iYbMPVHLA8tKX4IUz34/3oyrnZjikFHmKYWst8G8zwF9g34uvaXBkom/H0JQ6k/u+xmGJBCECKyC1H
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=gu6fZOg2AAAA:8 a=MvuuwTCpAAAA:8 a=3Up_VBsHAAAA:8
    a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=CgnBGgMzA0uDPexRqTwA:9 a=QEXdDO2ut3YA:10 a=-FEs8UIgK8oA:10
    a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22 a=dVHiktpip_riXrfdqayU:22
    a=p-kn8v_atdPrL5O0KNWa:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030931AbeEXKDn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030922AbeEXKDk (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:03:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anthony Cheung <anthony.cheung@hpe.com>,
        Takahiro Yasui <takahiro.yasui@hitachivantara.com>,
        Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        SCSI ML <linux-scsi@vger.kernel.org>,
        Xose Vazquez Perez <xose.vazquez@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 108/161] scsi: devinfo: add HP DISK-SUBSYSTEM device, for HP XP arrays
Date: Thu, 24 May 2018 11:38:53 +0200
Message-Id: <20180524093031.355250272@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xose Vazquez Perez <xose.vazquez@gmail.com>

[ Upstream commit 5f96f42b76e00e2871033745ff029056cc725c76 ]

"The DISK-SUBSYSTEM is a special model name returned when LUs
are not installed. For example, when LU#0 is not installed in "OPEN-"
models, LU#0 is detected as the DISK-SUBSYSTEM model":
https://marc.info/?l=linux-scsi&m=125424006417825

It's missing for HP XP rebranded arrays, "HP"/"OPEN-".
Only the HITACHI one is present:
13f7e5acc8b329080672c13f05f252ace5b79825
627511e3e67553b04f6917c03e39b797df210e04

Cc: Anthony Cheung <anthony.cheung@hpe.com>
Cc: Takahiro Yasui <takahiro.yasui@hitachivantara.com>
Cc: Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: James E.J. Bottomley <jejb@linux.vnet.ibm.com>
Cc: SCSI ML <linux-scsi@vger.kernel.org>
Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_devinfo.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -189,6 +189,7 @@ static struct {
 	{"HP", "C5713A", NULL, BLIST_NOREPORTLUN},
 	{"HP", "DF400", "*", BLIST_REPORTLUN2},
 	{"HP", "DF500", "*", BLIST_REPORTLUN2},
+	{"HP", "DISK-SUBSYSTEM", "*", BLIST_REPORTLUN2},
 	{"HP", "OP-C-", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"HP", "3380-", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
 	{"HP", "3390-", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
