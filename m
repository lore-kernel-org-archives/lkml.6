Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2342767-1526573218-2-1592146898898544782
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526573217; b=ECKMMO35ErVp9f82GvEk0DgvsGV86K6D4nOQLgmJY3Ucd096HN
    MTzM0tibzNNs3JNfiGbTbWXH7L+rzK0gtUZwhCeJGZ41wgeV3BjVrqVRwnFdWSQM
    P7b/UJdy6FdlgsnRwDXdH7VA7G08MDLVdW+QPo7s0dz/79n0/h4k/+EErT2yPoDq
    pFCMg6H9ZWZOjfdLHYQPBWjqx+n5cO9VcFPS109ZiUDcSPLntwxPPAlQdTiEc+yX
    EZo2rY52Kt+nga6BjtkjolHZdgkXhtJQzn5lN03+S/n4CP1UDYEAP7SCSByHPyft
    0KrJF8yN1bUaOmR/NCcE30SyEYBDVmB1UupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526573217;
    bh=fP/tCPlxtVM1J0+vhRzeU9BDQTFUzga9LQAK4GCLFB4=; b=X8oGGPio+FX9
    zrOJ6Fg3reXn9Lh1L6FWzpdYcpUS+yNA16fWJDItJ3xrIGywJQkGs7XhnToQQEd/
    2MwWUR5V4QWyf5/MWPnO/3ia64ozeOIlfFX+Gv8jgyvVGAdPMSl2ys79Nj8uXq3b
    GZjrcXoMeDjs9m0lrkwGXuLu/42kUL/xXMgwUiVEjq3o3O/udqin2K1l53LDioFx
    t/2Zt6uCdmUWJ6J0RMOO4wZYNSEPoC7d9/ZDHcoyOsS3lnkop38ODmjR/1cmcxNK
    z+gqg4gvnK34l1YhiILhiG5EYvu4Qg7cNGSWVjNrHkb5uZlMxccCy6HwiAQM0cYP
    oIAt2jdlnw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfJkwA3H8RvDvlE03+s8sb2HAG+S58hnzU5XSnQNwV5U7YQgy4hI2Dw9KfIeGV05d7IuyPrqCdnK5SWRcq1IyGkMuVaNeeK/RCsRO9Obo7AxkcUei/3nu
    bfxuvf4ttadN18w9lkLPAwCf02/O/W83thhp1diET9XIGL4e2Pku3xF5KBR4UmzSNIDmFooViLpZdmKEAY/N5xeKv8EI/zbWaUEZXFcdvnLvfslYeYHxW/Jj
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=i3X5FwGiAAAA:8 a=g_ZqDOrz4KH440Ian7AA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=mmqRlSCDY2ywfjPLJ4af:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeEQQGw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 12:06:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:25379 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751916AbeEQQGv (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 17 May 2018 12:06:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,411,1520924400";
   d="scan'208";a="50074354"
Date: Fri, 18 May 2018 00:06:41 +0800
From: kbuild test robot <lkp@intel.com>
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: kbuild-all@01.org, Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [linux-next:master 7522/8111] drivers/usb/dwc3/drd.c:443:19: sparse:
 symbol 'dwc3_get_extcon' was not declared. Should it be static?
Message-ID: <201805180059.3X1bJsDZ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   fbbe3b8c2c9c5f84caf668703c26154cb4fbb9d1
commit: 5f0b74e54890c354d6ac0124ea7a96adf22845d0 [7522/8111] USB: dwc3: get extcon device by OF graph bindings
reproduce:
        # apt-get install sparse
        git checkout 5f0b74e54890c354d6ac0124ea7a96adf22845d0
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/usb/dwc3/drd.c:443:19: sparse: symbol 'dwc3_get_extcon' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
