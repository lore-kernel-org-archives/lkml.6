Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-989728-1525902600-2-15052622186247886079
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525902600; b=HTXnnNf5K4tlNMGz5E5OMdIMOA/xdMRTZiTodcBIvn4NwrkGSQ
    iCv232zgK7NbRHCr7xsNpSgs/V0oZ95GdYW/xlcjKxcW3b53lkiB5HH0DzOlVG/8
    B1YSRK41shgPhQGNcr+4a9JfKc268CadFmXFcf0Jf2T86zr6n0mco9nAqLWGN/Rc
    aQOaU8IMCohLLqcNTZnI0mGdwbqoiznjFOWlXijw+V6xb9eLOwyqpd2ftfJjW2NS
    OQPlWvhFwxEZqEXkswzy2bWooL/gPqSd/2RIumIVbnaLl+HQfS0+Bi+MIKm0Dmic
    gnjeU3OtObi8QhLnJWv2cDeW2zUg6qSQE88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1525902600; bh=Ers9pJ+YKx
    wlp9kmQhH+rXrY56+81td1Um9UNcGaySk=; b=S6LooKRz2MqSw2kCusghPcWsBW
    0O/aftt6iE1Pm5Fg5lrL2JIuxKDR3E8mhOkBy0PQCvo/YXegkM91SBOIJ2ix6ABQ
    TK+RUBs1J4K7P/PjGw1m4+7+eWjYV+AX/ZlOlaMUJ1wYAccmBYq1l2ZLbd6M+nTf
    M7AY2tfISpuVrXkSnLYju7NlYA9Tdvnuu+0CrJLieLnnUC0qF/LBKg9yB5geoETv
    E75U7mTEVrg+gUvZgc1kPY9GKe4LLQ6c7+y212fM3YodF5rsk8yjflzNnlIAVXkO
    hCPF7BgdhJMp1BrBIkbrpG16U1Ytl2mJny9ienWy43y3OvntqA4P7TZ5EBjg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
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
X-CM-Envelope: MS4wfO0Nn85QQ6kJXV7RaCm+WB4rm/6hJ7MLFIX98a3NsRDP7p66h1QnrJWc4hohp6yFmhKwjhqRBgDxXHS49Jy1NjQsKs1MGfUJ0434qhToQBaUcamNS+2i
    1UpeB33Ru2g2STHDQiRYaDAlexmceybjVDG+xxayIP3HxBNnBksgcCmBhZKchmJi5/8OVH2smalo4Yw3FTeMkJ/y1phDb8JquJpOhgtBXPulvApgp70rdI+e
    MV0z35ywe3Gn8qSbzEudkw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=to6yHWgmQk0A:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=37DZ5Mzr0X8_kof3iPIA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965401AbeEIVt5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux@kroah.com>); Wed, 9 May 2018 17:49:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:34428 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965436AbeEIVty (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 9 May 2018 17:49:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,382,1520924400";
   d="scan'208";a="198091127"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: 'Jason Gunthorpe' <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "'linux-integrity@vger.kernel.org'" <linux-integrity@vger.kernel.org>,
        "'linux-security-module@vger.kernel.org'"
        <linux-security-module@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tpm: tpm_crb: relinquish locality on error path.
Thread-Topic: [PATCH] tpm: tpm_crb: relinquish locality on error path.
Thread-Index: AQHTzovCXbr+Xqq9jkSj9yBS1IttZ6P4GCYAgAGeicCAAAoXAIAAs/uQgA9COvCABkUzAIAANFFggAw0OwCAADKoEIAA6v0AgAAyhcCAAXwnAIACmuJggAWGkICAAM+UoA==
Date: Wed, 9 May 2018 21:49:49 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D895BA3@hasmsx109.ger.corp.intel.com>
References: <5B8DA87D05A7694D9FA63FD143655C1B94252945@hasmsx108.ger.corp.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B942627FD@hasmsx108.ger.corp.intel.com>
 <20180424160328.GA5119@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94272F33@hasmsx108.ger.corp.intel.com>
 <20180502133246.GA6091@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9427B083@hasmsx108.ger.corp.intel.com>
 <20180503063508.GA8702@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9427B9A6@hasmsx108.ger.corp.intel.com>
 <20180504081634.GB6373@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B9427D284@hasmsx108.ger.corp.intel.com>
 <20180509122621.GB8271@linux.intel.com>
In-Reply-To: <20180509122621.GB8271@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTllYzkyZGEtZjIzMC00ZGRlLTk4MGMtZjBjZTliMzA3YTdkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJVWTA1RHBwbXBoaGFORExkekU0eXpLZDVGYU1ieXNvMG11UEh2aDNHbHBUanNzXC9KTGxZQ3B2NVNRWlFEMUtBNCJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.252.22.129]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> 
> On Sat, May 05, 2018 at 09:07:21PM +0000, Winkler, Tomas wrote:
> > There is already one 'out' label in that function, what would you prefer for
> this new label name?
> > Thanks
> > Tomas
> 
> Aah, of course. My bad that I did not notice it but please just point me if I
> miss something obvious like that :-) I'll apply the patch today..
> 
Thanks
Tomas

