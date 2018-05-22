Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2247758-1526981275-2-7689867902597666003
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526981275; b=MED0H50qu2R0CNb8k18pKJN26L5bAT8rwhxBE2ahwT6y5ENhjQ
    xTeMy94yLXcvRztvVpIiXCHJdcUksaRbxb8luP1D4VwPKJatlmXjSTxJ1kLktD9P
    5VqTuTpcnwsPNUBXsp82xvFhw0LUUCXD767n4GOIW2zZoDtpd470OlNJGZn6OriJ
    6IgQYZoM6xlc9z8oW03/0UZI88k4Kk+iiX4Oaggx/1ksTu4un3dYDj8gUe0vv/en
    mxqhVNBk62H9LbJ9kI0H4N7VyJfSrCMLNgrQkmjQh2XnSCVx/mZ97x37klAgY2rj
    /H4IeURc6Sc1EQcxyGyxK9eLeCnWqLWF03Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1526981275; bh=rPWlPUYNz5
    mMfowGcXy31tipG5o3syBhfMYwULlngyI=; b=eKSjxLQRT3KBMRhtzTw92wbuyw
    1buFD4UBA/PGqlOTQ7QDvCDMDX8hDdymLoKSwWFSUvU61PKh4rp2XOzrtmYBehb6
    HWefWZVBsqpuGSbZ01EtGia1tdFMQjNkDgXMLK20A0uYTAWwhZWE/j+sYHeReL5G
    IxphQBpyT8HeXLQeEFiDuH0wSicNRuioKOzD1cKYRbNo+dxXjCinaOEHx3D7RtPJ
    QUoqK7wYt2b066OC2R0LMtUCPKRvH4qh6LZPcvbS1V9jS7OBmGxHNC6Ot8hw2sJr
    GE2UHvWw0wYo7oJmJSLiP2eZy2fJ+UTdj/k2jiIJ4OKtk6YPAfIdKJ5qELgQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
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
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJpe3guzeIi0fuPRz8+Qd8VndLUSB8roRggT52gqXkq322/A4zSD1BaWSJ3wqfZAVIXft3m20iIB/zdE+JJe9vLAu4wugQcXACUsoTg97jdsWSOTWp6b
    1xWUJbaNvk+BYnpYeSXYJZgFY75pDQT1aucQczh0CbDZ95oZ1ettDC2Q9i7foqZ7WFoGfWBH8CWXqCA/XHF792beSvSpyIqSnVSele+jQNVHsQJDx37Rchc3
    lrwzQyuZUch+2ho2cZeDvg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=94yDFCPHfFcA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=n9O6WjkMXqsRzJZPl5gA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbeEVJ1w convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Tue, 22 May 2018 05:27:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:52469 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbeEVJ1v (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 22 May 2018 05:27:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,429,1520924400";
   d="scan'208";a="230736262"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Topic: [PATCH] tpm: separate cmd_ready/go_idle from runtime_pm
Thread-Index: AQHT7VevIUY7rd7ojEqiu0sBZix5jKQ7TnMAgAAymDA=
Date: Tue, 22 May 2018 09:27:46 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D89D350@hasmsx109.ger.corp.intel.com>
References: <20180516194600.28189-1-tomas.winkler@intel.com>
 <20180522091732.GA5228@linux.intel.com>
In-Reply-To: <20180522091732.GA5228@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDUwYTJjZTMtZTc0NC00ZTRiLWI5NmUtZWJlMjgwNjM5MGZlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRTd4VXB1dHA1UUluTGlFZ1JXcEtsRGVtWDg4XC9oOGZDclwvVUhScmRhenFcL3VkSmlTNkJzZDkydE1cL0tQZWhLUUcifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.12.116.142]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> 
> On Wed, May 16, 2018 at 10:46:00PM +0300, Tomas Winkler wrote:
> > New wrappers are added tpm_cmd_ready() and tpm_go_idle() wrappers to
> > streamline tpm_try_transmit code. TPM_TRANSMIT_UNLOCKED flag is
> abused
> > to resolve tpm spaces recursive calls to tpm_transmit().
> 
> This looks good and all but I don't think we want to abuse anything in the
> driver code, do we?

It's not abuse just the flag UNLOCKED is not really named correctly 
I think this has to be backported so wanted to do less invasive change.
> 
> In other words, either
> 
> 1. New flag is to be added.
No
> 2. Rename the existing flag to something else than UNLOCKED (perhaps
>    SPACE).


Currently both TPM_TRANSMIT_UNLOCKED and TPM_TRANSMIT_RAW  servers the same purpose, to resolve
the recursion in tpm tranmit. 
What I believe should be done is to split the function into two to eliminate recursive call instead of using flags.
Please also there is clock_enable which is not protected from double call.
Thanks
Tomas

