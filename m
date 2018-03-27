Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133548-1522172433-2-7001402103690229386
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES encaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522172433; b=CZIvK7Ee0mde+OyQFifPFL18kigz29VgcJ9Fg3QFyjm85/n
    jiT7D8dr6EhLblH1WWwSw32J+2mZkuHa4BzximyefdDrRxBZeeq05KqBnyWLNiOm
    tSmzcZRTfRKIGeo4MTgnbh/8cibZMBD+e+qxgfmTtKM2juHVYeKNBUkiKbpKDssd
    uHs0aYEpjHMc15Qk3K7p4r+s3qPz81Nxu6DsLiTj2f8uoidrrzVVvpZbiMqoATg1
    2aIep9MgNkN9OeR9C/XIU8neNm4sjjdKrYiGhhHz6QxmwVEkUOS9xwXR5SVmkXE6
    QkjpZCcLJxbY92K3ZBtqnCOIZuqgq8k/8/CcQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522172433; bh=bM/3ISDddme7AxOm/ehPzCTXp/
    SXtBGBpebeRo8D0ng=; b=rfKRMfYwmwxdfUpAsfRKOwaDxXf8YPDhTcOy0Orwe0
    UeuvubMAuKmTrbXfd/OoIn+dDS55cAHOCerWzLl3+CDGeN5cfSSgdAxsEpKcmdXA
    bQ3LU9ZE/WAUZU3UETyKgM4piaKuCPT/O4YXBxS2R8wQ8itBDMvDmk+u8NYS352U
    CKx/UjYsxNXvA1GmKED61HNFZWkyKPPwUOw6ILxAft2opolYeBvqFrZSY8bDdmve
    VXJd/iuVG/3c9wxdd9uKLaOPlMRAF8vmRVgPnUI+7d7Dr983VCaRxf6LBHHnGMJs
    sM+jG9qxe+s4IJiOkDiw9le5T4Hzt0G+HIngNKJAipEg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfBmQjCTbzPnUv5YqpEupCL+9Xr61NgtOaQ3vKV5cIzrza+QDK+pphnPnROd41RTihY5GiOS7OsZavjT4AVeYQ6y1VpLebI29zap3/jwJNvnwnNwy/829
    kY8+KJ3+bFNttDjo+8t+j4awCKmRNkFp15m+m2xcC+Nf6j6joMcZt/Q5fbcLCy36B6Iv8HmOmh4jPtVqWombO4QvK98mYeeEHIYgPb/kt7DYfcSBYr+qkNE3
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=hVcwujEvAAAA:8 a=9Wbp7B8dAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=ag1SF4gXAAAA:8 a=7tl5JNMooLcZxBO2Bk8A:9 a=QEXdDO2ut3YA:10
    a=BESxJfN36ujmTJQqZ0Zq:22 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754180AbeC0QeO (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:34:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44232 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754179AbeC0QeL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:34:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>,
        Mark Craske <Mark_Craske@mentor.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 017/101] mmc: core: Disable HPI for certain Micron (Numonyx) eMMC cards
Date: Tue, 27 Mar 2018 18:26:49 +0200
Message-Id: <20180327162751.030735190@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dirk Behme <dirk.behme@de.bosch.com>

commit dbe7dc6b9b28f5b012b0bedc372aa0c52521f3e4 upstream.

Certain Micron eMMC v4.5 cards might get broken when HPI feature is used
and hence this patch disables the HPI feature for such buggy cards.

In U-Boot, these cards are reported as

Manufacturer: Micron (ID: 0xFE)
OEM: 0x4E
Name: MMC32G
Revision: 19 (0x13)
Serial: 959241022  Manufact. date: 8/2015 (0x82)  CRC: 0x00
Tran Speed: 52000000
Rd Block Len: 512
MMC version 4.5
High Capacity: Yes
Capacity: 29.1 GiB
Boot Partition Size: 16 MiB
Bus Width: 8-bit

According to JEDEC JEP106 manufacturer 0xFE is Numonyx, which was bought by
Micron.

Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Mark Craske <Mark_Craske@mentor.com>
Cc: <stable@vger.kernel.org> # 4.8+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/card.h   |    1 +
 drivers/mmc/core/quirks.h |    6 ++++++
 2 files changed, 7 insertions(+)

--- a/drivers/mmc/core/card.h
+++ b/drivers/mmc/core/card.h
@@ -82,6 +82,7 @@ struct mmc_fixup {
 #define CID_MANFID_APACER       0x27
 #define CID_MANFID_KINGSTON     0x70
 #define CID_MANFID_HYNIX	0x90
+#define CID_MANFID_NUMONYX	0xFE
 
 #define END_FIXUP { NULL }
 
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -109,6 +109,12 @@ static const struct mmc_fixup mmc_ext_cs
 	 */
 	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_HYNIX,
 			      0x014a, add_quirk, MMC_QUIRK_BROKEN_HPI, 5),
+	/*
+	 * Certain Micron (Numonyx) eMMC 4.5 cards might get broken when HPI
+	 * feature is used so disable the HPI feature for such buggy cards.
+	 */
+	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_NUMONYX,
+			      0x014e, add_quirk, MMC_QUIRK_BROKEN_HPI, 6),
 
 	END_FIXUP
 };
