Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405707-2-7443326355110686988
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
    1524405707; b=Rmp1YhMPsPynKouI2bx69ulOpnZbdhSzvnPMVB1bGlbY9cNtjr
    eo+GUQRsws7c/BQ8GU2K5QKXlq4e1qcbQ4RJm+A0pUt/UdV9gaM5UamOVYz0VyC8
    xOembxRBXssBmJZVteyOg2UuJbGI0z5/sSyPd2GdAJ26XmgOqCx5ktOFJa4fBW2L
    jwhfJeRziKo9rSU8EmQceb0ysSfwkVkpo01IF/YXK8P3nKUbtlOi6f6AccKptyAG
    HZRTsk9VRMZwXwXXmp3dVkYiGfR7UaQj0y+U8OgCUrSuu3Rz1LQeq5RoJrycyQSt
    jQC6c9tf5IFVSencwOPqEhIa76er6nh3p/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405707; bh=wRYzQQl5MLQ8vYo0OGvc/zPXNfb7tO
    B22JF1lxKOZx8=; b=rv7yG5ewzW4rFD3El5lgfgcwEiKduqnG6GvugGirkNJ/TI
    9esu/60sF+SMhXGq8OLT14Dg2B0UHDLqjhl0UmVYG0zeUCpmGwz40nk4h5o296zu
    oRdGitIxNYesfm8viVOLHVN/qcQgPR1S5ryaIoa5GC8nrODuRzq7fbDRFz4p/J2S
    PnVOaioHezH2JRvlzrHWXNX77+FmMtmbM/KQEOF3opJ/LZuCfyRPfT2pYC3hFv06
    9ve9kbBgPgUV8JUXildDhoBMyXEvPdS6OldewPoe2BDPP2LxIfDNmcTinBtLd6y9
    hLfU4E6W6/ZzTn07wpk+M/CtQa8dxi6c+RDTpqqw==
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
X-CM-Envelope: MS4wfMyYiyqPfHqgItUK2WSqbc21kgAfeFXDtKfaAHEfuxVcA7Q6L3NFRtTSr/jMSgTULf7TqM9E+dqyA3SPwgXnSVraNmo+MhvKPynnuAdgbFNGT+KuQDEj
    HJUDrkppctnZS+2dQIXXFOR2CUY6iWl1H+KGG9FDBR5qx+3i9mS/BJ7M3HbrFFx4p5O0h1zWSur4s3hQIVxQHC/Nn7eIb0EfhNpO1JLjrMZ4qj5K5DtQ3ciD
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=vQ0PdpbSB7uE6cEkuTUA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754722AbeDVOBo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:01:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754729AbeDVOBe (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:01:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 4.16 125/196] nfit, address-range-scrub: fix scrub in-progress reporting
Date: Sun, 22 Apr 2018 15:52:25 +0200
Message-Id: <20180422135110.720196794@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
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

From: Dan Williams <dan.j.williams@intel.com>

commit 78727137fdf49edf9f731bde79d7189067b4047a upstream.

There is a small window whereby ARS scan requests can schedule work that
userspace will miss when polling scrub_show. Hold the init_mutex lock
over calls to report the status to close this potential escape. Also,
make sure that requests to cancel the ARS workqueue are treated as an
idle event.

Cc: <stable@vger.kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Fixes: 37b137ff8c83 ("nfit, libnvdimm: allow an ARS scrub...")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/nfit/core.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1250,8 +1250,11 @@ static ssize_t scrub_show(struct device
 	if (nd_desc) {
 		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
+		mutex_lock(&acpi_desc->init_mutex);
 		rc = sprintf(buf, "%d%s", acpi_desc->scrub_count,
-				(work_busy(&acpi_desc->work)) ? "+\n" : "\n");
+				work_busy(&acpi_desc->work)
+				&& !acpi_desc->cancel ? "+\n" : "\n");
+		mutex_unlock(&acpi_desc->init_mutex);
 	}
 	device_unlock(dev);
 	return rc;
