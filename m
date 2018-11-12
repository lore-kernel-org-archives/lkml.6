Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8047AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF5E22506
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF5E22506
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbeKMFkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:40:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:56688 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeKMFkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:40:49 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xnd2I_qq2v-Z; Mon, 12 Nov 2018 20:46:07 +0100 (CET)
Received: from zn.tnic (p200300EC2BE56F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2be5:6f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 218CF1EC03EA;
        Mon, 12 Nov 2018 20:46:07 +0100 (CET)
Date:   Mon, 12 Nov 2018 20:46:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 02/13] arch/x86: Rename the RDT functions and
 definitions
Message-ID: <20181112194600.GJ8167@zn.tnic>
References: <20181109205153.14811-1-babu.moger@amd.com>
 <20181109205153.14811-3-babu.moger@amd.com>
 <20181112175610.GI8167@zn.tnic>
 <539bf8ea-b13f-186a-f1c7-71b1eaa63aa7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <539bf8ea-b13f-186a-f1c7-71b1eaa63aa7@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 07:25:02PM +0000, Moger, Babu wrote:
> >> @@ -637,10 +637,11 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
> >>  	 *
> >>  	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
> >>  	 */
> >> -	intel_cqm_threshold = boot_cpu_data.x86_cache_size * 1024 / r->num_rmid;
> >> +	resctrl_cqm_threshold = boot_cpu_data.x86_cache_size * 1024 /
> >> +				r->num_rmid;
> > 
> > No need to break that line here.
> 
> Without the line break, checkpatch complains for "line over 80
> characters".  Do you think we can ignore those?

To quote from the tip handbook which is in preparation right now:

"+The 80 character rule is not a strict rule, so please use common sense when
 +breaking lines."

In this particular case, it is more readable IMO to leave the line unbroken:

	resctrl_cqm_threshold = boot_cpu_data.x86_cache_size * 1024 / r->num_rmid;

What is even more readable though is:

	unsigned int cl_size = boot_cpu_data.x86_cache_size;

	...

	resctrl_cqm_threshold = cl_size * 1024 / r->num_rmid;

and now you have a win-win situation. :)

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
