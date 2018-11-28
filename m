Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0452CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86482081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:03:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C86482081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeK2DFM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:05:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbeK2DFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:05:12 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0244385362;
        Wed, 28 Nov 2018 16:03:04 +0000 (UTC)
Received: from doriath (ovpn-116-147.phx2.redhat.com [10.3.116.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 693937C29C;
        Wed, 28 Nov 2018 16:03:02 +0000 (UTC)
Date:   Wed, 28 Nov 2018 11:03:00 -0500
From:   Luiz Capitulino <lcapitulino@redhat.com>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] KVM: VMX: re-add ple_gap module parameter
Message-ID: <20181128110300.49b3110d@doriath>
In-Reply-To: <0a2d9427-18e7-408a-d0ae-b8277cad542a@amd.com>
References: <20181123120214.174457a4@doriath>
        <8049C3CD-E816-4270-A64F-0BB92BD56338@oracle.com>
        <20181123132641.712e2695@doriath>
        <0a2d9427-18e7-408a-d0ae-b8277cad542a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 28 Nov 2018 16:03:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 15:57:53 +0000
"Moger, Babu" <Babu.Moger@amd.com> wrote:

> My bad.. Sorry about this. I think this should also go to
> stable@vger.kernel.org

No problem man, this happens. Thanks for the review!

> 
> > -----Original Message-----
> > From: Luiz Capitulino <lcapitulino@redhat.com>
> > Sent: Friday, November 23, 2018 12:27 PM
> > To: Liran Alon <liran.alon@oracle.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>; Moger, Babu
> > <Babu.Moger@amd.com>; kvm@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH] KVM: VMX: re-add ple_gap module parameter
> > 
> > On Fri, 23 Nov 2018 19:42:53 +0200
> > Liran Alon <liran.alon@oracle.com> wrote:
> >   
> > > > On 23 Nov 2018, at 19:02, Luiz Capitulino <lcapitulino@redhat.com>  
> > wrote:  
> > > >
> > > >
> > > > Apparently, the ple_gap parameter was accidentally removed
> > > > by commit c8e88717cfc6b36bedea22368d97667446318291. Add it
> > > > back.
> > > >
> > > > Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>  
> > >
> > > Weird that nobody noticed this when patch was applied… Thanks.
> > > Reviewed-by: Liran Alon <liran.alon@oracle.com>  
> Reviewed-by: Babu Moger <babu.moger@amd.com>
> 
> > 
> > I forgot to mention that I noticed this because I have systems
> > disabling ple with ple_gap=0 in modprobe.conf. In those systems
> > kvm_intel won't load anymore.
> >   
> > >  
> > > > ---
> > > > arch/x86/kvm/vmx.c | 1 +
> > > > 1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> > > > index 4555077d69ce..be6f13f1c25f 100644
> > > > --- a/arch/x86/kvm/vmx.c
> > > > +++ b/arch/x86/kvm/vmx.c
> > > > @@ -174,6 +174,7 @@ module_param_named(preemption_timer,  
> > enable_preemption_timer, bool, S_IRUGO);  
> > > >  * refer SDM volume 3b section 21.6.13 & 22.1.3.
> > > >  */
> > > > static unsigned int ple_gap = KVM_DEFAULT_PLE_GAP;
> > > > +module_param(ple_gap, uint, 0444);
> > > >
> > > > static unsigned int ple_window = KVM_VMX_DEFAULT_PLE_WINDOW;
> > > > module_param(ple_window, uint, 0444);
> > > > --
> > > > 2.17.2
> > > >  
> > >  
> 

