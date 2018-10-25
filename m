Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225FDECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE74E205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE74E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeJYJ2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 05:28:24 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:25018 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726117AbeJYJ2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 05:28:24 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9P0vWZM057043;
        Thu, 25 Oct 2018 08:57:32 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 25 Oct 2018
 08:56:10 +0800
Date:   Thu, 25 Oct 2018 08:56:10 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greentime Ying-Han =?utf-8?B?SHUo6IOh6Iux5ryiKQ==?= 
        <greentime@andestech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Zong Zong-Xian =?utf-8?B?TGko5p2O5a6X5oayKQ==?= 
        <zong@andestech.com>,
        Alan Quey-Liang =?utf-8?B?S2FvKOmrmOmtgeiJryk=?= 
        <alankao@andestech.com>, "green.hu@gmail.com" <green.hu@gmail.com>
Subject: Re: [PATCH v3 4/4] nds32: Add document for NDS32 PMU.
Message-ID: <20181025005610.GA8101@andestech.com>
References: <cover.1540350887.git.nickhu@andestech.com>
 <bdfe23ce3ded5299d7b525fcb16c353c2be31924.1540350887.git.nickhu@andestech.com>
 <20181024183247.GA12203@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181024183247.GA12203@bogus>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9P0vWZM057043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Thu, Oct 25, 2018 at 02:32:48AM +0800, Rob Herring wrote:
> On Wed, Oct 24, 2018 at 11:32:40AM +0800, Nickhu wrote:
> > The document for how to add NDS32 PMU
> > in devicetree.
> > 
> > Signed-off-by: Nickhu <nickhu@andestech.com>
> > ---
> >  Documentation/devicetree/bindings/nds32/pmu.txt | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/nds32/pmu.txt
> 
> Can you move to bindings/perf/ with other similar h/w. With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Sure, thanks!
Nick
