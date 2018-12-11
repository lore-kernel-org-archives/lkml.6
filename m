Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1ECC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FE820849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:30:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FE820849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeLKPaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:30:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbeLKPaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:30:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E21B53082DDA;
        Tue, 11 Dec 2018 15:30:23 +0000 (UTC)
Received: from redhat.com (ovpn-112-59.ams2.redhat.com [10.36.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EFA45D717;
        Tue, 11 Dec 2018 15:30:20 +0000 (UTC)
Date:   Tue, 11 Dec 2018 15:30:17 +0000
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Eduardo Habkost <ehabkost@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Andre Przywara <andre.przywara@arm.com>,
        kvm ML <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Eric Blake <eblake@redhat.com>
Subject: Re: kvm: RDTSCP on AMD
Message-ID: <20181211153017.GN921@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181210181328.GA762@zn.tnic>
 <20181210183730.GJ4669@habkost.net>
 <20181210184153.GB5482@zn.tnic>
 <20181210190600.GK4669@habkost.net>
 <20181210194258.GD5482@zn.tnic>
 <20181210200843.GN4669@habkost.net>
 <20181211103839.GC921@redhat.com>
 <20181211115546.GQ4669@habkost.net>
 <e4d9a943-2de2-34a7-3f52-ee3d64ea889a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4d9a943-2de2-34a7-3f52-ee3d64ea889a@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 11 Dec 2018 15:30:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 04:23:51PM +0100, Paolo Bonzini wrote:
> On 11/12/18 12:55, Eduardo Habkost wrote:
> >>   - Debian Jessie: 4.5
> >>   - Debian Stretch: 4.5
> >>   - RHEL-7: 3.10
> >>   - Ubuntu LTS (Xenial): 4.5
> >>   - OpenSUSE Leap 15: 4.12.14
> >>
> >> So we can't require Linux 4.5 as a minimum version at this time.
> > I'd like us to take a step back and consider what exactly
> > "support" means here.  QEMU will still work on older kernels if
> > we add RDTSCP to the CPU models, but at the same time I would
> > like to document that our strict runnability guarantees may not
> > be kept if running Linux < 4.5.
> 
> Anyway RHEL does have RDTSC support for AMD, and a bunch of other stuff.
>  The frankenkernel's KVM is somewhere between 4.5 and 4.10, with a dash
> of 4.20 of course. :)

Great, then, this is a non-issue - we just need to mention that fact
in the commit that sets the min version for the kernel 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
