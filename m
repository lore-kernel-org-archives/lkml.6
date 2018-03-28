Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754136AbeC1Por (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:44:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55492 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753970AbeC1Poq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:44:46 -0400
Date: Wed, 28 Mar 2018 17:43:49 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] EDAC/amd64: Print ECC enabled/disabled for nodes
 with enabled MCs
Message-ID: <20180328154349.GD20533@pd.tnic>
References: <20180321191335.7832-1-Yazen.Ghannam@amd.com>
 <20180328130028.GB20533@pd.tnic>
 <DM5PR12MB191699DD131B3EB4C11579DAF8A30@DM5PR12MB1916.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM5PR12MB191699DD131B3EB4C11579DAF8A30@DM5PR12MB1916.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 02:38:11PM +0000, Ghannam, Yazen wrote:
> In either of those cases we won't get to debug_display_dimm_sizes*
> because we won't initialize the instance.

So you move that code which accesses csrows up so that it has the
required information to query DIMM state/presence.

>                 /* Assume UMC MCA banks are enabled. */
>                 nb_mce_en = true;

Also, I don't like that assumption.

> This would work for Fam17h. For older systems I think we can look at
> D18F2x94_dct[1:0][DisDramInterface]
> 
> Or maybe we have a separate function to check for enabled memory controllers
> before we check for ECC?

The best would be to have a function which checks whether DIMMs are
present on the node and act accordingly. You can pull up some of the
work of caching registers which are used in debug_display_dimm_sizes*
and use that info to get the required DIMM state upfront.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
