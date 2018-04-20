Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeDTSDW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 14:03:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33858 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753467AbeDTSDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 14:03:21 -0400
Date: Fri, 20 Apr 2018 20:03:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/MCE, EDAC/mce_amd: Save all aux registers on SMCA
 systems
Message-ID: <20180420180301.GF13351@pd.tnic>
References: <20180402195707.42875-1-Yazen.Ghannam@amd.com>
 <20180417172102.GA3633@pd.tnic>
 <CY4PR12MB15574493593120818D9BFE11F8B70@CY4PR12MB1557.namprd12.prod.outlook.com>
 <20180418171347.GH4795@pd.tnic>
 <CY4PR12MB155779EEC2894B501F30292EF8B40@CY4PR12MB1557.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CY4PR12MB155779EEC2894B501F30292EF8B40@CY4PR12MB1557.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 01:05:17PM +0000, Ghannam, Yazen wrote:
> Okay, I can do that. What about using mce_rdmsrl()? The value gets set to
> 0 and a user gets a single warning. This may be more clear to the user. Also,
> it shouldn't affect code that checks for non-zero values, like in __print_mce().

Hmm, good point. From the looks of it, it shouldn't be a problem and a
MSR value of 0 is of no interest anyway. I *think*.

But pls make it a separate patch so that we can revert it in case
something doesn't work as expected and we've missed a case.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
