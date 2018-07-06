Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0C5C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB522083C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB522083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbeGFIxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:53:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53778 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeGFIx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:53:28 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fbMUW-0004B5-IX; Fri, 06 Jul 2018 10:53:24 +0200
Date:   Fri, 6 Jul 2018 10:53:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     KY Srinivasan <kys@microsoft.com>
cc:     Ingo Molnar <mingo@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 1/1] X86/Hyper-V:: Fix the circular dependency in IPI
 enlightenment.
In-Reply-To: <MW2PR2101MB11131ACDDA6734BD588919F5A0470@MW2PR2101MB1113.namprd21.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1807061052410.1664@nanos.tec.linutronix.de>
References: <20180703230155.15160-1-kys@linuxonhyperv.com> <20180704161039.GA23658@gmail.com> <MW2PR2101MB111396005B0F5572C92B4CD7A0400@MW2PR2101MB1113.namprd21.prod.outlook.com> <20180705153820.GA26768@gmail.com> <MW2PR2101MB1113ABC82EC62E2C8DBA2400A0400@MW2PR2101MB1113.namprd21.prod.outlook.com>
 <20180705222302.GB5410@gmail.com> <alpine.DEB.2.21.1807060043290.1771@nanos.tec.linutronix.de> <MW2PR2101MB11131ACDDA6734BD588919F5A0470@MW2PR2101MB1113.namprd21.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jul 2018, KY Srinivasan wrote:
> > 
> > The problem is that the wreckage is in Linus tree and needs to be fixed
> > there, i.e. via x86/urgent.
> > 
> > Now we have the new bits queued in x86/hyperv already which collide. So
> > we
> > need to merge x86/urgent into x86/hyperv after applying the fix and mop up
> > the merge wreckage in x86/hyperv.
> > 
> > I'll have a look tomorrow morning unless you beat me to it.
> 
> I can rebase this patch against the latest tip and resend (tomorrow).

That doesn't help as we need to push the original fix to Linus ...
