Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133288-1522172389-2-15459516487468852811
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522172389; b=BHkxHVB3mEykwssJbJr8dZ2qkF0ZgxtMHkna3Wn/SEUcPRX
    X3jnbzCDdmTgAjNNfeAwzKqeyttScCHGK+CaYnEdoK6mrtdAQCUO79CxxoazBtlH
    fBSADGBoXDSfRdswf+FYrn6UMVy1f2JLyErajQC6PPDAmG5K3Sh+19YK+6WZh2iP
    n/Th1pk8NMDwckefZ769R/Hqvn80shELCINZRAoEToW6WFwDcjTgF774mVhhCQBN
    IJcCHPLU4+xkDm8uGTCKSK6buNeTkAhVk/lIuiFLDOnLUGl24D1lzJuCH+RKROm6
    79J84tocgpfQ4oPGP5bjkc+HoXiMbjzPBGYhtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522172389; bh=Bw3tvjJSqenHMNcAL/O6pab7HY
    PGe+zGwL+vsSkWpnM=; b=NRfmmYCttDRljM0pigXgq/mCpK3biWJhZIwsJdedlC
    WjZpxSHQF6kJqxouGyhtKFpD2GPzdaHEw/+iRzV2iadWuHFCj3P8UzHwfjSw5KFJ
    w4MNaVTrPhCTJ4VDUFA7VznaMuRCw254QWb1wd8mI/n5cnWP62Qj44dPSeMWAL4V
    ybQH+4OfbL6q7cXU3jK5W3FavdgVfzWqPYvfAu5Rr9RDt0l+4GTodsbN2Jez+teO
    BI4BueTuQ0P+bJCLE2sXPkxL+Nm7IKrl8eUCE6LsL1UAUV7E180UziEB6I0QMlrR
    Ipit1FQCoyF+m1Labl+OQsWdmbXLJea4EjeL4w1gpFjQ==
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
X-CM-Envelope: MS4wfDQ+TnVuJSZmUrkBgr8/41I+ag6+uwO+EW90ABNoFcwxM+km8NLMRM4MeWGSvQLP52bpCAhKWZ1Cooh/luSKUkQzICQP/G9uM47Gmu205/sJS2YgzTaL
    5L5+fbzj9mNyMvYkvD/aLRXi6gVo31APtwdYWmcZC6iA0FzlqSvQOix+Y8ykmAXIKwKWwNEWuf+istlMlZx7fjCAZQtvAC+6BnBpqiegolmWqnSzug82N1HG
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=mK_AVkanAAAA:8 a=WPyIoOwQAAAA:8 a=Vxy2kpnnAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=nMMflWAxvouxslZPM44A:9 a=QEXdDO2ut3YA:10
    a=3gWm3jAn84ENXaBijsEo:22 a=S-HzPIwwDS8t1QcwSuWs:22 a=mQL3ssppXrSh16SuiSjD:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754219AbeC0Qe0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:34:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44354 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753712AbeC0QeW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:34:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathias Kresin <dev@kresin.me>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 003/101] MIPS: lantiq: Fix Danube USB clock
Date: Tue, 27 Mar 2018 18:26:35 +0200
Message-Id: <20180327162750.205847720@linuxfoundation.org>
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

From: Mathias Kresin <dev@kresin.me>

commit 214cbc14734958fe533916fdb4194f5983ad4bc4 upstream.

On Danube the USB0 controller registers are at 1e101000 and the USB0 PHY
register is at 1f203018 similar to all other lantiq SoCs. Activate the
USB controller gating clock thorough the USB controller driver and not
the PHY.

This fixes a problem introduced in a previous commit.

Fixes: dea54fbad332 ("phy: Add an USB PHY driver for the Lantiq SoCs using the RCU module")
Signed-off-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <john@phrozen.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.14+
Patchwork: https://patchwork.linux-mips.org/patch/18816/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/lantiq/xway/sysctrl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/lantiq/xway/sysctrl.c
+++ b/arch/mips/lantiq/xway/sysctrl.c
@@ -562,7 +562,7 @@ void __init ltq_soc_init(void)
 	} else {
 		clkdev_add_static(ltq_danube_cpu_hz(), ltq_danube_fpi_hz(),
 				ltq_danube_fpi_hz(), ltq_danube_pp32_hz());
-		clkdev_add_pmu("1f203018.usb2-phy", "ctrl", 1, 0, PMU_USB0);
+		clkdev_add_pmu("1e101000.usb", "otg", 1, 0, PMU_USB0);
 		clkdev_add_pmu("1f203018.usb2-phy", "phy", 1, 0, PMU_USB0_P);
 		clkdev_add_pmu("1e103000.sdio", NULL, 1, 0, PMU_SDIO);
 		clkdev_add_pmu("1e103100.deu", NULL, 1, 0, PMU_DEU);
