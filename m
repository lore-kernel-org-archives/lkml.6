Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752155AbeEQNoh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:44:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:38370 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752030AbeEQNoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:44:34 -0400
Date: Thu, 17 May 2018 15:44:15 +0200
From: Borislav Petkov <bp@suse.de>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: Johannes Hirte <johannes.hirte@datenkhaos.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 3/3] x86/MCE/AMD: Get address from already initialized
 block
Message-ID: <20180517134415.GC27738@pd.tnic>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
 <20180201184813.82253-3-Yazen.Ghannam@amd.com>
 <20180414004230.GA2033@probook>
 <20180416115624.GA1543@probook>
 <CY4PR12MB1557FB8EB5C17E55A9B405D8F8B70@CY4PR12MB1557.namprd12.prod.outlook.com>
 <20180515093953.GA1746@probook>
 <20180516224641.GA31929@pd.tnic>
 <20180517064930.GA26421@probook>
 <20180517104124.GA25595@pd.tnic>
 <CY4PR12MB1557AB31F5F9D1ECBDAC2DA6F8910@CY4PR12MB1557.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CY4PR12MB1557AB31F5F9D1ECBDAC2DA6F8910@CY4PR12MB1557.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 01:04:19PM +0000, Ghannam, Yazen wrote:
> Yes, you're right. I thought using the existing data structures would work, but it
> seems I messed up the implementation.

Not only that - your idea wouldn't fly because the per-CPU stuff you
were using gets torn down when the CPU goes offline so you can't use
them on resume because they're not there yet.

> Banks 15 and 16 should have an address for block 1 also. Do you have PFEH
> enabled on your system? That would cause MISC0 to be RAZ so we won't
> get the MISC1 address. I'll try it myself also and let you know.

I check PFEH is enabled how?

> I think this good for now. We'll probably need to change it in the
> future, but maybe we can clean up all the thresholding blocks code and
> make it simpler when we do change it.

Ok.

> This hunk could go above the !block. Though maybe the macro is lighter than the
> array lookup. It'll work either way, but I'm just thinking out loud.

Yeah, it doesn't matter in that case.

> Since we're caching the values during init, we can drop all the
> *_on_cpu() calls. What do you think?

Well, if they're all the same on all CPUs, sure. That's your call.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
