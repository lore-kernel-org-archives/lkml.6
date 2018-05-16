Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-343561-1526479844-2-16935983782934995507
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526479844; b=NesXOzvxmob/M1Ni6DQ/Bxx6DPTfeBkt5uvSongMakPHMWI/We
    8lKoV0lm2N7JK9S09w5xLTegD+nTyiqMysxs0Rmo+R4t2a34u0318maqwVmF9hFt
    8xFKH3CTzIC6l1bWHUvkxNMWN7op0C2lUHUlMfUwaGYanHZ9GVModV09GwNgv3rL
    fwVxtxxTH2LYpKcnVMUod5w/2SGt2o2cIew11I9xAEkCQ3Qn+cOQo99fOmkwvxuw
    xskAVjVAIQFk+zmYX3RNxWK/a/JtVB//K0N4JGrEfKMd420uDxy2scSOuCEpvTOp
    0nKeT9ul7PlZKiGkKcA1t3jPlQYKCrad17bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526479844; bh=H0tKqb2n/weBLTI0TbGO3ss6dQDNuZ
    SpNnMUh2MsNPI=; b=mFHugYFpRCOWtFKxiNn54nvi3nm1RD5eW7pgrxmkEV/pv5
    3XjgYmCnuP+YVBZyYmiYWdS4IvqYlH4Q4gbWCAuldbye6WiuHEA9ps+Cja3oQxLk
    +3mez9mtfrSBPoxpCo0cf7A6wqAnZwsxabXcC/lFkUHEAjrOboZ+rbYi39d0bBpA
    d9u/2wLYFPunOgDWFGNb0mSvmUiN0cbd/cXF5/FXMwxII/do9nQaxh2U0XMgH1ww
    dqxszsko3d+mcPfdBRcLvwxf7EIWuYKMOWLw1SN3z9wFYv90GM58WZA2VPPFcUsP
    9y0hdK43JkfYV/iK5u2EaokUjZPEE3+JFFGSEIKg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
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
X-CM-Envelope: MS4wfJwUMjBdt1erCU4JKsaFyrio/MDzR35+QsKZ7XvevAbU5h13GAtdK6ybsCqdJEi6WqlPsPc+Zejf1AoZsZ6UDJwcBEA2+2oRf66RFo1Xbcqb3hpTXObw
    9kiJfXOMcFQcxJRyPpCWaI6MUI9DeQn1Mwur3YhPNc+0oXhuus+UcBNX3FfnPBKwhVeuReuV9VOo0CfxpUk4vdcbxZgcK/18w7k4GyRePyyKkbCEXW+IiCJt
    KZP+fmUaw7BGQOyxh0WTBA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=JOTmCZ-e0C6RMfIOS60A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeEPOKn (ORCPT <rfc822;linux@kroah.com>);
        Wed, 16 May 2018 10:10:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:16201 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbeEPOKm (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 May 2018 10:10:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,406,1520924400";
   d="scan'208";a="54872490"
Date: Wed, 16 May 2018 17:10:35 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
Subject: Re: [PATCH v4 1/2] tpm: reduce poll sleep time in tpm_transmit()
Message-ID: <20180516141035.GA10304@linux.intel.com>
References: <20180516055125.5685-1-nayna@linux.vnet.ibm.com>
 <20180516055125.5685-2-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516055125.5685-2-nayna@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 01:51:24AM -0400, Nayna Jain wrote:
> tpm_try_transmit currently checks TPM status every 5 msecs between
> send and recv. It does so in a loop for the maximum timeout as defined
> in the TPM Interface Specification. However, the TPM may return before
> 5 msecs. Thus the polling interval for each iteration can be reduced,
> which improves overall performance. This patch changes the polling sleep
> time from 5 msecs to 1 msec.
> 
> Additionally, this patch renames TPM_POLL_SLEEP to TPM_TIMEOUT_POLL and
> moves it to tpm.h as an enum value.
> 
> After this change, performance on a system[1] with a TPM 1.2 with an 8 byte
> burstcount for 1000 extends improved from ~14 sec to ~10.7 sec.
> 
> [1] All tests are performed on an x86 based, locked down, single purpose
> closed system. It has Infineon TPM 1.2 using LPC Bus.

Already applied previous version of this.

/Jarkko
