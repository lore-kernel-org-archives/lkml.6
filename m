Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2342767-1526573237-2-5686623027741091068
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526573236; b=OX4+yERJufysw5PRR/HFVgMtDnYwP4aCwW1DG7um6DLFrUra1o
    NYYIeVbFxW/la/4PUIBmLTBFk0BjFvvxQx8y3UyXCpmp8pMCBLA0ktpYqAHk5LRu
    4xl7IfO9XtdqmXMJhaoq2gbCTSzSvr6R0Y0ze9zITBWmX/rtXJvuCohm3WLw77Cd
    /JiMakig8ug+5mamS4G9+6HG3BwC2Kj+TWawN+8b3lGSfAo29QwfGED16Kl8xQZf
    +ej1eOl+Jdzbhn+iySaemfzg8UUu5N5rQ8Op2ovaxojgCs46AaDeODRxDqjt7iYo
    e9Lxxxu61oxcZx+znI9h8FA2hifCyduSw3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526573236; bh=pEA+H8ucHvMNvCRUjHaVcWVikGBnhP
    AMC9AgdPWCoQ4=; b=bHbifMM2R2ZsejWAptloj/U+Rst5Sqm+Q7+cFUUZTtBYTm
    GyT1kp+OJw9KziepSufq0PSPCyayqZbfv0w+GvfgHwFMf91/z54usCqp4R+13WvF
    /d2YsieDeZ8K0/lEGL2jDaefRGpw/G2QkbwhKT/6i9VFtkuP3pKelugi09okk6jX
    MSZDNqsB8HQwVjT9PRxmOW2DgxAcu9Uzg8MVHVWCXD3sBL9weo0B207QGqSE26Or
    uycm1YVFn4UxAPhw6fC9EibWVMTQ0uRmrUUkCh3NBXh8ILj6pJXqyZU2chGH5y51
    0cyksuQN9h+MBMpY955p3rjePMxS0m5/5zTTt5rw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGBIqDeHKW1nX0rUCnUTJeBqkaggSTsAh7t2aUn+4tVyXm6FipDJvzHVTaDgI+q+f25nfB7LewyES9EEwMRs5XF1ixpBCQwlFzSBVINlIZx+87h+3Ndd
    2uSGDYNfAgf5VEJGL7dUzxPATWNNwotevfmRj7dPHplVXfkHdgkZ4J9fXjXpmpVHbtKZRkY+iEq23cUTHLqmax583bMgr1JTta9mRH5zQ26wXGLBRMK0np8Z
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=Cr_5Md7ZIrrN_iHfZLUA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeEQQGw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 12:06:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:23485 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751977AbeEQQGv (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 17 May 2018 12:06:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,411,1520924400";
   d="scan'208";a="225073994"
Date: Fri, 18 May 2018 00:06:41 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: kbuild-all@01.org, Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] USB: dwc3: dwc3_get_extcon() can be static
Message-ID: <20180517160641.GA55289@lkp-ib03>
References: <201805180059.3X1bJsDZ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805180059.3X1bJsDZ%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Fixes: 5f0b74e54890 ("USB: dwc3: get extcon device by OF graph bindings")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 drd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 2706824..218371f 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -440,7 +440,7 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
-struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
+static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
 	struct device_node *np_phy, *np_conn;
