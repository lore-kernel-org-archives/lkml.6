Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66719C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416BC21479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfBBAGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:06:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:53116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726121AbfBBAGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:06:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1BEBAF03;
        Sat,  2 Feb 2019 00:06:28 +0000 (UTC)
Date:   Sat, 2 Feb 2019 01:06:15 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Babu Moger <babu.moger@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>
Subject: Re: [PATCH] x86: avoid confusion over the new RESCTRL config prompt
Message-ID: <20190202000615.GA15335@zn.tnic>
References: <20190129225218.15441-1-hannes@cmpxchg.org>
 <20190129230845.GG28773@zn.tnic>
 <20190130164626.GA17841@cmpxchg.org>
 <20190130171933.GC21221@zn.tnic>
 <20190130195621.GA30653@cmpxchg.org>
 <3908561D78D1C84285E8C5FCA982C28F7D4E216D@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D4E216D@ORSMSX110.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 07:18:35PM +0000, Luck, Tony wrote:
> For now.  But very soon we will also have ARM_CPU_RESCTRL, and some of
> this code will become generic.  Will we need an arch-independent name for the
> bits of code shared by arm and x86?

Yes. The idea still is to have the arch-specific stuff under
X86_CPU_RESCTRL and ARM_CPU_RESCTRL respectively, and the arch-agnostic
pieces under CPU_RESCTRL.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
