Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BF0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9320E20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 17:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfANRmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 12:42:24 -0500
Received: from mout.gmx.net ([212.227.15.18]:56327 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbfANRmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 12:42:23 -0500
Received: from homer.simpson.net ([212.114.172.8]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MY7dI-1gnTwH3L96-00UsFd; Mon, 14
 Jan 2019 18:42:17 +0100
Message-ID: <1547487736.31585.21.camel@gmx.de>
Subject: Re: 5.0-rc1 KVM inspired "BUG: Bad page state in process" spew
From:   Mike Galbraith <efault@gmx.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Adam Borowski <kilobyte@angband.pl>, kvm <kvm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Mon, 14 Jan 2019 18:42:16 +0100
In-Reply-To: <20190114154619.GA5141@linux.intel.com>
References: <1547012338.4926.11.camel@gmx.de>
         <20190109144257.erwh52326ucgc5tw@angband.pl>
         <1547046196.31155.1.camel@gmx.de> <20190109192637.GA1697@linux.intel.com>
         <1547275382.26908.7.camel@gmx.de> <20190114154619.GA5141@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:epGwAL5vNPXqQI0wAcuSFlcjK8n144qSigZrMij1FRHwSu/ezK1
 nuaqxpYL8Dn+lOldBUuat9fgZD2vmkkNSsJD8m0WuJ7ybm6l8LnjqafowYRqU2gLNl+ITcq
 GWBI9dJlwC4Xi4kBYOfWTUw/9fKQX1zt9s4sjzDvVFLz7pnrp0n7/Mavyo3NpE9vUdd+0jj
 jA5KilPVtqBZcw/tjYvmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FmiQxBm2wZ8=:4wVPuO/9PoQc+KE4ZFPK/W
 a1t22g2qBD77BcUoS4h45EfBRMJnOUIGDOkUgAP4h12U+c/LA1lYX2N2dCWkh0dlAMG4dnMrp
 lCcZKPBUG2JPMc6ELTLIT8ahDpPkwnbTNfBcng2gLIhsNQgcO2tJX7vz67Zk9Tj0qJkgKp4JG
 wqBCXT1cJx0nB8PlrbPuJwtcFW0+2my5Oklmp5OsprsbY2dNTMX7xhcTKocpHqMEYUGorlawz
 WxVJU4NKzwtnIUPSLS/BXChHGaxFEPNtxnOHaOlgs7EAdXJCVHVfhgh3tIN6V1TV/hjySulJm
 DypaPkOKYXsSmRpLYGMtdlbwSLDv5WE1/XirqaJ6znyX69cVUyhY8jlw8ZpEedaTCZZQNRVMx
 IlJbcy69cf0ckyAUwHUZQt27cgIgnbd5knyCJlMOLkZTK5gnjeKJK6JCEQlqkdOAEAIS4Y0B2
 O65JLmz2ADV3m5GUSd3GV6qfA31rXFrK27tbjV9VaERCEwY7/28eNfahOCV2XQjJEbrgW9iF4
 8rKARjEjPlBh3oqvEmp3fNSrasIzbr6OpBSfPu492OzT6F2suH8OwaF2wnAfsFLWDXnqydfCe
 oPPmelnmsUMAayYBYNttV1x8Csy7c/JFmY/bCwhlEGKrQrvg7BpTOQTEK7+4oht6AJJr25e/9
 lwpa+yecHoz0JsN3+We34VggZ/EMDmMH917pWaEdvGT0sgISphRcYX/8cMEcsa4bJ7xQ3wfWw
 kcNJAhcywUgeLPZzohVwuj9IdSpDq8J8lpkcMAR9GfgFxUMOcJO2GSdP1OdVHYzcUEsfHeMgf
 eD70hxytBW4ZL8NkmY+rifismS5gnMJ6T7n7OlS9Grgpz1yFuenuwJVk7oRAGWCcZ5wOMPRfc
 vXsSTmAd5XabaNF0zhUuj4C89DpAS3yPsTTISCzColLx/CsAiFlqVeDSM6cIKE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-14 at 07:46 -0800, Sean Christopherson wrote:
> On Sat, Jan 12, 2019 at 07:43:02AM +0100, Mike Galbraith wrote:
> > On Wed, 2019-01-09 at 11:26 -0800, Sean Christopherson wrote:
> > > 
> > > I'll try to bisect.
> > 
> > Good luck with that.  I gave it a go, but that apparently invalidated
> > the warrantee of my vm image :)
> 
> This is fixed in v5.0-rc2 by commit ba422731316d ("mm/mmu_notifier:
> mm/rmap.c: Fix a mmu_notifier range bug in try_to_unmap_one").

Good to hear.

> Nested VMs are great for bisecting KVM issues :)

I tried nesting dolls (to speed bisection.. hah!), but couldn't
reliable trigger the problem with my reproducer.  Even if it had,
nested VMs are pretty cool, but not the _least bit_ fast :)

	-Mike
