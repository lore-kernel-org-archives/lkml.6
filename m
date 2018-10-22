Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E59BC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366EF20658
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366EF20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbeJVVfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:35:45 -0400
Received: from foss.arm.com ([217.140.101.70]:46662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbeJVVfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:35:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 028C480D;
        Mon, 22 Oct 2018 06:17:12 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 558573F627;
        Mon, 22 Oct 2018 06:17:08 -0700 (PDT)
Date:   Mon, 22 Oct 2018 14:17:05 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nick Hu <nickhu@andestech.com>
Cc:     Greentime Ying-Han =?utf-8?B?SHUo6IOh6Iux5ryiKQ==?= 
        <greentime@andestech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        Zong Zong-Xian =?utf-8?B?TGko5p2O5a6X5oayKQ==?= 
        <zong@andestech.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>
Subject: Re: [PATCH 5/5] nds32: Add document for NDS32 PMU.
Message-ID: <20181022131705.vqou7dinw47fkez4@lakrids.cambridge.arm.com>
References: <cover.1539745993.git.nickhu@andestech.com>
 <c0a80d2db642b1d9547ff412d91baa9927b68aac.1539745993.git.nickhu@andestech.com>
 <20181018143132.vhhc6qpz4sooljlj@lakrids.cambridge.arm.com>
 <20181022102308.GD24110@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022102308.GD24110@andestech.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 06:23:08PM +0800, Nick Hu wrote:
> Hi Mark,
> 
> On Thu, Oct 18, 2018 at 10:31:32PM +0800, Mark Rutland wrote:
> > On Thu, Oct 18, 2018 at 04:43:17PM +0800, Nickhu wrote:
> > > The document for how to add NDS32 PMU
> > > in devicetree.
> > > 
> > > Signed-off-by: Nickhu <nickhu@andestech.com>
> > > ---
> > >  Documentation/devicetree/bindings/nds32/pmu.txt | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/nds32/pmu.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/nds32/pmu.txt b/Documentation/devicetree/bindings/nds32/pmu.txt
> > > new file mode 100644
> > > index 000000000000..02762b850e59
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/nds32/pmu.txt
> > > @@ -0,0 +1,17 @@
> > > +* NDS32 Performance Monitor Units
> > > +
> > > +NDS32 core have a PMU for counting cpu and cache events like cache misses.
> > > +The NDS32 PMU representation in the device tree should be done as under:
> > > +
> > > +Required properties:
> > > +
> > > +- compatilbe :
> > > +	"andestech,atcpmu"
> > 
> > Which CPUs have this PMU?
> > 
> > I expected more specific strings, e.g. "andestech,n13-pmu" and/or
> > "andestech,andestech,nds32v3-pmu".
> >
> In nds32 V3, all of our CPU have PMU.
> So I will change the string to andestech,nds32v3-pmu.

That sounds good to me; thanks.

> > > +- interrupts : The interrupt number for NDS32 PMU is 13.
> > > +
> > > +Example:
> > > +pmu{
> > > +	compatible = "andestech,atcpmu";
> > > +	interrupts = <13>;
> > > +}
> > 
> > The driver tried to find multiple interrupts. Is there only a single
> > interrupt in all cases?
> > 
> There is only overflow interrupt for performance couner in nds32 V3.
> I will modified the driver and prepare another patch.

Ok.

Thanks,
Mark.
