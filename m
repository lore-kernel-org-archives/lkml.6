Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB34C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8072075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8072075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbeKTWyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:54:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48072 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728375AbeKTWyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:54:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 895E080D;
        Tue, 20 Nov 2018 04:25:07 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 996853F5B7;
        Tue, 20 Nov 2018 04:25:05 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:24:58 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "mick@ics.forth.gr" <mick@ics.forth.gr>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "zong@andestech.com" <zong@andestech.com>,
        "alankao@andestech.com" <alankao@andestech.com>
Subject: Re: [RFC PATCH] Documentation: DT: arm: add support for sockets
 defining package boundaries
Message-ID: <20181120122458.GA13255@e107155-lin>
References: <20181107171344.983-1-sudeep.holla@arm.com>
 <5bea0ecf.1c69fb81.7820a.2052@mx.google.com>
 <e599eaf5-381b-e2e0-067a-4225bb348b80@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e599eaf5-381b-e2e0-067a-4225bb348b80@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 05:18:42PM -0800, Atish Patra wrote:
> On 11/12/18 3:37 PM, Rob Herring wrote:
> > On Wed, Nov 07, 2018 at 05:13:44PM +0000, Sudeep Holla wrote:
> > > The current ARM DT topology description provides the operating system
> > > with a topological view of the system that is based on leaf nodes
> > > representing either cores or threads (in an SMT system) and a
> > > hierarchical set of cluster nodes that creates a hierarchical topology
> > > view of how those cores and threads are grouped.
> > > 
> > > However this hierarchical representation of clusters does not allow to
> > > describe what topology level actually represents the physical package or
> > > the socket boundary, which is a key piece of information to be used by
> > > an operating system to optimize resource allocation and scheduling.
> > > 
> > > Lets add a new "socket" node type in the cpu-map node to describe the
> > > same.
> > > 
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >   .../devicetree/bindings/arm/topology.txt      | 52 ++++++++++++++-----
> > >   1 file changed, 39 insertions(+), 13 deletions(-)
> > > 
> > > (Note patch generated with -b option to avoid 60+ of whitespace changes)
> > > 
> > > Hi Rob,
> > > 
> > > You had expressed your interest to generalise the CPU topology bindings
> > > accross multiple architectures. Do you want to move to the generic
> > > bindings before adding this $subject socket support or is it OK to
> > > finalise on this and then move the majority(based on the agreement)
> > > to generic binding.
> > 
> > Doesn't really matter to me as long as Risc-V folks are in agreement.
> > 
> > Otherwise, this looks fine to me.
> > 
> > Rob
> > 
> > 
> I can apply this patch in my unify topology series and resend everything
> together as one series.

Thanks for that. You can drop RFC when reposting. Remember to use -b
for ignoring space changes on this patch along with -M for renames in
your original patch series.

--
Regards,
Sudeep
