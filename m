Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3236600-1527029093-2-18340146842372459097
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527029093; b=er5VYAbU5MowFj3KZ8S/Vbtw3gDD2pXBD/RbzG1tixZvoUVj13
    yNqzd0xb5cmwfzQRw7kq4XfLbwLpKrvzQMe1Jf4sjEOWDKVyAHf0YwMBXv5kEoIE
    UbzHADWkk0ThIv6+jKsrOayuQ/89tzaDbYIa6C2p6nTIl4s9tZUhez+qPJRbHV77
    er0iXTyzFmYBsHe9FD9H594luv6O9OgVqJcBAGyUN7BJ5Ve7GUG3XwKUy9B8P24k
    uM036br+gPVQtq09EVS2Eu7EjgkjU5wC5WyuFoZ3J3rLBMEmEw7cMpszrOvt4/Mw
    9aZnmvUY5Y2qZsTT2exc0lxkrDPJrfxFLs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1527029093; bh=qToCAN35oR
    QxzXo0exd04BV/WU8Lo1O4nn3BRNQdlv4=; b=QMC3CuevpqvBcJkHz7gohaUxdc
    FW0LWUsMYz5QJm6bMQCkL2nBH/JCIoBuCU34tIBbH2J+ngJvZvLmbvHIUxkaxD1Y
    XXLpf92A3gwhR9G94BLBRHfRfKA5UnBYObhVPSx7wlCcHLfo9L1OdtoJu6/cNbDe
    sxa1BvZBpTShzFxkrID4cECbuYMxPZAchTsC7piX5le0Axpk8JtsRPWrSDddD35D
    bmuwILzOi5GgkPr7Zs5qWGdaFnLYmQ3HWEJv6nQOXax1sqj/BOjYuI0pRbILs5AH
    4p4qLa2pS2IHPReyS/U41AIveC9VbFt6N/zDd9ckJyPwI4OnZ78VSEDRUPaQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPMtk7dO9oF43wQp2UaBpep94C9qkO6gDqrtDLam2sGps167/kRrhbHyZJ0QEjHS4lMTwLTv7WUnd61riA2SHvOT8fsh4qErfTBNpJ+QBo/eD2uGJUMo
    xgnoHkefqrF0Ove3WLarMbkaAgfrSgYxcQB9FMtze5CMRKe5DhzXDHUHB2sN70bfVLYZyXo4E2lsYgGfg1vBkhCFzK3+c2PzgvnvHC0bnshEg8tl48p8q0pL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EbVHfS3oRaoA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=vvbzST6LdJHV6ldtU2UA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbeEVWov convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Tue, 22 May 2018 18:44:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:3625 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753004AbeEVWou (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 22 May 2018 18:44:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="56718197"
From: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Matt Fleming" <matt@codeblueprint.co.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: RE: [PATCH V3 2/3] efi: Introduce efi_queue_work() to queue any
 efi_runtime_service() on efi_rts_wq
Thread-Topic: [PATCH V3 2/3] efi: Introduce efi_queue_work() to queue any
 efi_runtime_service() on efi_rts_wq
Thread-Index: AQHT8XrbhGhvSb7r8EKxY2QzcAy/FKQ70YcAgAB8rzA=
Date: Tue, 22 May 2018 22:44:46 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F392AE61C@ORSMSX114.amr.corp.intel.com>
References: <1526958784-14688-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1526958784-14688-3-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180522073618.GN12198@hirez.programming.kicks-ass.net>
In-Reply-To: <20180522073618.GN12198@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDFkODNjMDktMmNkZS00NGZiLWFlMzUtMGVlMTMxYzUwOGUyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZGN4amRMZVVCNDBMeUg3dUwybE1abjdwTmNxTEo5REp4ZkFsUFdCRStqRDd0Yk93NUNXV3ByamY1b0JPOUtwVSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> On Mon, May 21, 2018 at 08:13:03PM -0700, Sai Praneeth Prakhya wrote:
> > +	/*								\
> > +	 * queue_work() returns 0 if work was already on queue,         \
> > +	 * _ideally_ this should never happen.                          \
> > +	 */								\
> > +	if (queue_work(efi_rts_wq, &efi_rts_work.work))
> 	\
> > +		flush_work(&efi_rts_work.work);
> 	\
> 
> Since you're _always_ going to wait for it, it is _much_ cheaper to put a
> completion in your actual work and wait for that.

Sure! I will change it.
I also noticed that flush_work() in turn calls wait_for_completion().

Will also wait for a couple of days before posting V4.

Regards,
Sai
