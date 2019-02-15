Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561C6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1BF21917
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392010AbfBOJGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:06:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:37662 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387491AbfBOJF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:05:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49F21ABAC;
        Fri, 15 Feb 2019 09:05:58 +0000 (UTC)
Date:   Fri, 15 Feb 2019 10:05:56 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     "chenzefeng (A)" <chenzefeng2@huawei.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "sjenning@redhat.com" <sjenning@redhat.com>,
        "vojtech@suse.com" <vojtech@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0g=?= =?utf-8?Q?=5D?= x86: livepatch:
 Treat R_X86_64_PLT32 as R_X86_64_PC32
Message-ID: <20190215090556.teicmayhnbxjhw7n@pathway.suse.cz>
References: <79A62BFA453EFB42B7A4E40AD8F3A2264F2A872D@DGGEMA503-MBX.china.huawei.com>
 <nycvar.YFH.7.76.1902150826400.11598@cbobk.fhfr.pm>
 <79A62BFA453EFB42B7A4E40AD8F3A2264F2A889B@DGGEMA503-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79A62BFA453EFB42B7A4E40AD8F3A2264F2A889B@DGGEMA503-MBX.china.huawei.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-02-15 08:17:36, chenzefeng (A) wrote:
> HI, Jiri Kosina,
> 
> On Fri, 15 Feb 2019, Jiri Kosina wrote:
> >On Fri, 15 Feb 2019, chenzefeng (A) wrote:
> 
> >> On x86-64, for 32-bit PC-relacive branches, we can generate PLT32 
> >> relocation, instead of PC32 relocation. and R_X86_64_PLT32 can be 
> >> treated the same as R_X86_64_PC32 since linux kernel doesn't use PLT.
> >> 
> >> In linux 4.4 commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as
> >> R_X86_64_PC32") been fixed for the module loading, but not fixed for 
> >> livepatch relocation, which will fail to load livepatch with the error 
> >> message as follow: relocation failed for symbol <symbol name> at 
> >> <symbol
> >> address>
> >> 
> >> Signed-off-by: chenzefeng <chenzefeng2@huawei.com>
> 
> >What kernel version is this patch based on? We've got rid of x86-specific module loading stub and offloaded all the relocation handling to generic kmod loader long time ago.

The livepatch-specific code has been removed in v4.7, see
the commit 425595a7fc2096ab46c ("livepatch: reuse module
loader code to write relocations").

> The patch is based on kernel version Linux 4.4.174.

The patch would make sense only for 4.4 stable kernel
and it looks fine for this purpose.

Please, send the patch to stable@vger.kernel.org if
Greg misses it in this thread.

Best Regards,
Petr
