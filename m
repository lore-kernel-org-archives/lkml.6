Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24C9C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40D52087D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40D52087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbeJVSie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:38:34 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:46004 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728448AbeJVSie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:38:34 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9MAL10h088694;
        Mon, 22 Oct 2018 18:21:01 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 22 Oct 2018
 18:19:24 +0800
Date:   Mon, 22 Oct 2018 18:19:25 +0800
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
Subject: Re: [PATCH 2/5] nds32: Fix bug in bitfield.h
Message-ID: <20181022101925.GB24110@andestech.com>
References: <cover.1539745993.git.nickhu@andestech.com>
 <6702edd2853db9a475853a9b8d00b5aacf546bb2.1539745993.git.nickhu@andestech.com>
 <20181018142622.p3hrrymexubkkuf5@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181018142622.p3hrrymexubkkuf5@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9MAL10h088694
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Oct 18, 2018 at 10:26:31PM +0800, Mark Rutland wrote:
> On Thu, Oct 18, 2018 at 04:43:14PM +0800, Nickhu wrote:
> > There two bitfield bug for perfomance counter
> > in bitfield.h:
> > 
> > 	PFM_CTL_offSEL1		21 --> 16
> > 	PFM_CTL_offSEL2		27 --> 22
> > 
> > This commit fix it.
> > 
> > Signed-off-by: Nickhu <nickhu@andestech.com>
> 
> This patch should probably be move before the patch adding perf support.
> That way, perf support isn't broken at the point it is added.
> 
> Thanks,
> Mark.
> 
> > ---
> >  arch/nds32/include/asm/bitfield.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/nds32/include/asm/bitfield.h b/arch/nds32/include/asm/bitfield.h
> > index 8e84fc385b94..19b2841219ad 100644
> > --- a/arch/nds32/include/asm/bitfield.h
> > +++ b/arch/nds32/include/asm/bitfield.h
> > @@ -692,8 +692,8 @@
> >  #define PFM_CTL_offKU1		13	/* Enable user mode event counting for PFMC1 */
> >  #define PFM_CTL_offKU2		14	/* Enable user mode event counting for PFMC2 */
> >  #define PFM_CTL_offSEL0		15	/* The event selection for PFMC0 */
> > -#define PFM_CTL_offSEL1		21	/* The event selection for PFMC1 */
> > -#define PFM_CTL_offSEL2		27	/* The event selection for PFMC2 */
> > +#define PFM_CTL_offSEL1		16	/* The event selection for PFMC1 */
> > +#define PFM_CTL_offSEL2		22	/* The event selection for PFMC2 */
> >  /* bit 28:31 reserved */
> >  
> >  #define PFM_CTL_mskEN0		( 0x01  << PFM_CTL_offEN0 )
> > -- 
> > 2.17.0
> >

Thank you for the advice !!
I will prepare another patch for it. 
