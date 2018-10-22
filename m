Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E6CC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517E720652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517E720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbeJVSoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:44:06 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:60998 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728389AbeJVSoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:44:05 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9MAOjDP089048;
        Mon, 22 Oct 2018 18:24:45 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 22 Oct 2018
 18:23:06 +0800
Date:   Mon, 22 Oct 2018 18:23:08 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Greentime Ying-Han =?utf-8?B?SHUo6IOh6Iux5ryiKQ==?= 
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
Message-ID: <20181022102308.GD24110@andestech.com>
References: <cover.1539745993.git.nickhu@andestech.com>
 <c0a80d2db642b1d9547ff412d91baa9927b68aac.1539745993.git.nickhu@andestech.com>
 <20181018143132.vhhc6qpz4sooljlj@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181018143132.vhhc6qpz4sooljlj@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9MAOjDP089048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Oct 18, 2018 at 10:31:32PM +0800, Mark Rutland wrote:
> On Thu, Oct 18, 2018 at 04:43:17PM +0800, Nickhu wrote:
> > The document for how to add NDS32 PMU
> > in devicetree.
> > 
> > Signed-off-by: Nickhu <nickhu@andestech.com>
> > ---
> >  Documentation/devicetree/bindings/nds32/pmu.txt | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/nds32/pmu.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/nds32/pmu.txt b/Documentation/devicetree/bindings/nds32/pmu.txt
> > new file mode 100644
> > index 000000000000..02762b850e59
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/nds32/pmu.txt
> > @@ -0,0 +1,17 @@
> > +* NDS32 Performance Monitor Units
> > +
> > +NDS32 core have a PMU for counting cpu and cache events like cache misses.
> > +The NDS32 PMU representation in the device tree should be done as under:
> > +
> > +Required properties:
> > +
> > +- compatilbe :
> > +	"andestech,atcpmu"
> 
> Which CPUs have this PMU?
> 
> I expected more specific strings, e.g. "andestech,n13-pmu" and/or
> "andestech,andestech,nds32v3-pmu".
>
In nds32 V3, all of our CPU have PMU.
So I will change the string to andestech,nds32v3-pmu.

> > +
> > +- interrupts : The interrupt number for NDS32 PMU is 13.
> > +
> > +Example:
> > +pmu{
> > +	compatible = "andestech,atcpmu";
> > +	interrupts = <13>;
> > +}
> 
> The driver tried to find multiple interrupts. Is there only a single
> interrupt in all cases?
> 
There is only overflow interrupt for performance couner in nds32 V3.
I will modified the driver and prepare another patch.
Thanks!

> Thanks,
> Mark.

Thank you for replying the patch set so quickly.
I will prepare the next patch set for it.
Thanks,
Nick
