Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-610692-1526294433-2-6896955084368447936
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
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526294433; b=WG21lPMvIgUcdXw48o/14QdUcRVrsrRvoVrS313KmTDmCzTTex
    7Vuqw30KY4iW4pon6mmMLOcwMUXq6++fybsHVsorFYLxdYJnly5b3q2n62V2zfmQ
    /Jl2+L7W7T27d5zwde1nTOiqkwqptHFOOPUVS/ymsw1yg12oM0fiQEWyjBOL96cV
    JKFnYlcqd6JrCf0TeNIISpUORada7e2uwKFN22MTwKtOv6JbCIqBNxc1rmJ5l+wM
    fASOX7gEk6yObdnCttN5qDAH3Pk4lWwt5VFVc8ma3aQHA4j55at1ShwTPVdqOHAQ
    fkGTJnWVpVGBUdbgD4bbkOTl95Ij/kxxFMyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526294433; bh=JA+ykG9Nk2F1eyrjvbY4CtE0HuM6PU
    ufWf4ssF+QM54=; b=G0K8fIEgt6zhIXjm4SR1W2NS76meupxFNAEukSTZiLeZEm
    qHZlQInhimJYdfCzA8b+1czjuc0pgujpAhvcmvqP2xBsp8D/T9DqqNEweKAu4ft+
    77gFcGhew16n+ckPp9fImemENEKEwZfTMi4qZxR4xfSWcGzlz053MsIHIycoPFuZ
    FTU+tTvmLSoTyP+JEiIXFXL6sDjZI1AlftldXjP8o27wOAySw9TGGg8csv4tRJrO
    nM8Wx7NeYqVeclbN5Kxmmf025I6NZKRDMmHqLd2dpoFlUApasbeBRfeDw9EKosHg
    PZL/S1B3rpR3Tjyoy49votV54Za4WRnIvmDI1guA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
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
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
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
X-CM-Envelope: MS4wfMKgLMYz8nqGzO+pxESfPeGK7K04VyJaaV8sdC751vaxYXEigr6Fj1/rGJ50NpZHTo13WmFezkjM0W+Qzaqr4pGqFrlI+xGDhs4VG4Oelko2YlL7PUcr
    67sWSlHfNpok0TR9RI/RzNF2xLbvOrfPfEkkEOV2M9cW9lgjB00ipqwQqfpuAyNmnhvfckjecaiDMlSyroLyCDtmRUs5VQwKnTgo1IR3dDFndfFG3n9JpZCp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=Wb4fPrt1ZLswVWefs8cA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeENKkT (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 06:40:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:2141 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752024AbeENKkS (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 14 May 2018 06:40:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="54981925"
Date: Mon, 14 May 2018 13:40:14 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 5/5] usb: typec: tcpm: Support for Alternate Modes
Message-ID: <20180514104014.GB21435@kuha.fi.intel.com>
References: <20180511131838.62064-1-heikki.krogerus@linux.intel.com>
 <20180511131838.62064-6-heikki.krogerus@linux.intel.com>
 <CAHp75VfFPiWM8LRwmXU-jugouBWStTnQBqU=FyyPP2s9dnY97g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfFPiWM8LRwmXU-jugouBWStTnQBqU=FyyPP2s9dnY97g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, May 13, 2018 at 12:30:51AM +0300, Andy Shevchenko wrote:
> On Fri, May 11, 2018 at 4:18 PM, Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> > This adds more complete handling of VDMs and registration of
> > partner alternate modes, and introduces callbacks for
> > alternate mode operations.
> >
> > Only DFP role is supported for now.
> 
> > +       for (i = 0; i < cnt; i++)
> > +               p[i] = le32_to_cpu(payload[i]);
> 
> I would recommend to consider to use le32_to_cpu_array().
> 
> Though, actually we have slightly different API for BE and LE cases.
> For LE existing would be renamed to rather le32_to_cpus_array() and
> establishing the former one in the similar way how be32_to_cpu_array()
> is implemented.

OK. I'll check it.


Thanks Andy,

-- 
heikki
