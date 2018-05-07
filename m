Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-863953-1525697049-2-4779434723590369004
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525697048; b=F4JIO1MSZxHW5f4dbVqQyzyqsBRc1u/7A+vfDAxPPydQd4v70L
    kpACYIfMNLd2eQ0kjuIbgkWfuOLR2kB7/o9m+/4Q4bldElKvd9T0z+9iHMlxX/0j
    Gf4slpDo/mlCMdtrDfdXKv8ZtCNwnkMXj+1OsVDYSp5e/zoM0hmNp6IrG3nYOPeJ
    vvkXCh8LRroWBuwVDnSrPSxvLaW+Y7i6Nxvrzs1JVVx7ScMzj5vAkRT18zqq8gK6
    quV77ZkhO4U74hplndhc2tUQSE1iwmhm6Ott9ZRyJulwlqrqREwA5UJxvawFDLjL
    rMAdwk7+y9x2ws9jZFceXcDbfufsU0XVU5VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525697048; bh=MVnyYPJsXErF0QDVEWoLtYMiHqEmi9
    1rT+zPSeoF3xU=; b=mbwBvTCoCwG5h3idIIFl/8Eaol+Z3EervB6/qYV01Kg3JC
    sOIFOsBz7vykOYKpxzVVWVG7SS9LBupmxo4y5TE18f0RGZblxvj99k4CrBnYFSBO
    MQIfC5Rr1h34NZIsz1JA5yahI+PZG+L/UxYIVXezzrlo92hm9J1gyk0uklsElab5
    jcWf0ESVEEHU4MVLbU7F0qw6Br5wOMauWdluZPTHefrBZpzGMO+bwYek7g8fTkPZ
    ohsQAhphotcHxjsNEzauw6cFxpLgInq7NSj8GJEIwJkiRwZLUzIr1NGPOpO8gNv+
    Rbn+5NfegaUKaa+oOuhW5mcdP3OqDRIfekS/r+tQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOR/6zd/fPhKWKtVs+5uzyF7fs0wYUvmWFupM/BkuvqlD+PWVHb6qfXcNqNzxtnpVoP2xnsylS+XV39wWWsqTdTsHIQEh7uMSGTnpmZL6ylOqXfPgo7a
    qupapJcImYOGTPviVe+fKhLC0dKZUBqeQjtjxY+ct7vTTZicW+v9P7w7GFPXKsk/Qd4X+8OqIqC6wOQnalDr97LNxZNHUNx6cP9R6dmNAp1VFTIA0vTo8erk
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=LpQP-O61AAAA:8 a=QyXUC8HyAAAA:8 a=VlY2xpLGrncLVpXGvk4A:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=pioyyrs4ZptJ924tMmac:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeEGMn5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 08:43:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:44043 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751848AbeEGMnz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 7 May 2018 08:43:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,373,1520924400";
   d="scan'208";a="39030297"
Date: Mon, 7 May 2018 15:43:49 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Keith Busch <keith.busch@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: pciehp: Add quirk for QDF2400 Command Completed
 erratum
Message-ID: <20180507124349.GC2879@lahna.fi.intel.com>
References: <1525602662-1873-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525602662-1873-1-git-send-email-okaya@codeaurora.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 06, 2018 at 06:30:53AM -0400, Sinan Kaya wrote:
> The QDF2400 controller does not set the Command Completed bit unless
> writes to the Slot Command register change "Control" bits.  Command
> Completed is never set for writes that only change software notification
> "Enable" bits.  This results in timeouts like this:
> 
> pciehp 0000:00:00.0:pcie004: Timeout on hotplug command 0x1038
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
