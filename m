Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116787-2-11541596668843912534
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
    1525116786; b=VOOFkQZc9fy4NXSqKMDFKd5vP/8P0jkxI8CWL13lBGRaDCZT4W
    95zystUJk+WLa/nrLCHAnyu9f87+ziJp7Tw7g3hpMIoioKtIkKo++wNN2G7NjijH
    z35Xg7Wm5xlJqM7KdHxgm4btr57/vyA0VaHxqMSZaHg8X9H/xR5YOcv3rjAPP1i2
    C3G1TnZYjLP8Vjc2c/NC05fKhy2VmiQbQ36x2WvKLV77/yegHBJO69n0hMd0TT3x
    dK/Ero+fJ3uAos3YwRapmlnkA9yC6ycLI0i7iDg12uN8vRaiWcvXMJwIs5d26SFT
    0SkWNdAnTCrhHXcTZlFS5UdeiIo0FxenCQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116786; bh=U+3fIaiuQAP0P0C4MyRhgXjVufcTcA
    cSdqFvwDtO1AA=; b=IvT19wjT5GNema9011F5AVBiHFVDWCSQuYwRQ+ue/x87do
    +TuSem0/BgymF8Kq0FxNxABTIIdtQ4BnnB57VwSlpVJIu9+9RexvukYUZR3cN/bk
    kCCvqDpMcvBdLn3ae+niPgkOOQ507AkVDKtEcGN3r7dsNfFegWxRpz8VR5AP+LQF
    EH7tx5jiXde6NE87VwuQYt8yhCLKI4isFx3hRo/52nOBL0FLcWtTHXf4hOH/HBMV
    Uq1y4opZ7V6XI5xJJBhaupxqYM85BwIt6dBY5DwGDSwnTFfvxLSNaE9Ap9Woztu1
    kNwgThajgH05iL+4V5KiYwgMkHHWebR4FUlhDkGw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfJNunnvIPsWfDjQEqf6VxBH0ARfFhc95/UHUiIXCO7OCzDePgPHb8WWmWk3JeeN6IbbcjTXk0Cdhq8Hx7xLr7GBOrOLnExF+ESIB0LbPKaX5PGG4PAcY
    jia1hXEGg5PQI2OKO10BR5LU56VWjQWYAzfnO0uRGBXO81VsBwAr+COrVX8YyFBQeuZhuYd5UhuDpX353hkAr9E8t1NVKb5iXc0TKvGqayV0hLt0WEiBEeWd
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=O-rJpSWE__A3FIjncxQA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbeD3T26 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:28:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756427AbeD3T25 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:28:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B378F22DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 4.16 077/113] ARM: socfpga_defconfig: Remove QSPI Sector 4K size force
Date: Mon, 30 Apr 2018 12:24:48 -0700
Message-Id: <20180430184018.445977046@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
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

From: Thor Thayer <thor.thayer@linux.intel.com>

commit 6e8fe39989720b87439fee7817a5ca362b16d931 upstream.

Remove QSPI Sector 4K size force which is causing QSPI boot
problems with the JFFS2 root filesystem.

Fixes the following error:
     "Magic bitmask 0x1985 not found at ..."

Cc: stable@vger.kernel.org
Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/configs/socfpga_defconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -57,6 +57,7 @@ CONFIG_MTD_M25P80=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_DENALI_DT=y
 CONFIG_MTD_SPI_NOR=y
+# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
 CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_OF_OVERLAY=y
 CONFIG_OF_CONFIGFS=y
