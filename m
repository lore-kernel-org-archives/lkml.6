Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933285AbeB1QgI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:36:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:57606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932656AbeB1QgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:36:06 -0500
Date: Wed, 28 Feb 2018 17:35:39 +0100
From: Borislav Petkov <bp@suse.de>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: Tony Luck <tony.luck@intel.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 0/8] Decode IA32/X64 CPER
Message-ID: <20180228163539.GC2969@pd.tnic>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
 <20180228084321.GA2969@pd.tnic>
 <DM5PR12MB1916B6CA08F0D423B3635EDDF8C70@DM5PR12MB1916.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM5PR12MB1916B6CA08F0D423B3635EDDF8C70@DM5PR12MB1916.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 03:12:09PM +0000, Ghannam, Yazen wrote:
> CPER is the format used for BERT, etc. We'll only ever see a CPER if the
> firmware creates it. And it's up to firmware policy what is shared with
> the OS.

Yap, but we should still tie it into our infra.

> My main reason for printing all the info is that it may be too difficult or too
> late to gather that info after the fact. I think this is especially true for boot
> errors, though maybe there's another way that I don't know about
> (re-reading BERT later?).

So that BERT thing is a table, AFAIR. I don't see why it would be a
problem if we read it later, at our leisure and free the record only
when we're done.

Looking at bert.c is entered with a late_initcall() which is nicely late
and we have everything up and ready to process errors then.

> Right. I want to work on getting this more integrated with our existing
> x86 infrastructure. But I don't want to wait until we figure all that out
> before we have some sort of CPER decoding.

Just keep in mind that whenever you expose stuff and userspace starts
using it, it is much harder to change it. So let's do it right pls.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
