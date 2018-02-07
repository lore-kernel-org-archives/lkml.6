Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753721AbeBGLz0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:55:26 -0500
Received: from foss.arm.com ([217.140.101.70]:49860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753470AbeBGLzZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:55:25 -0500
Date: Wed, 7 Feb 2018 11:55:21 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: Expose Arm v8.4 features
Message-ID: <20180207115521.GO5862@e103592.cambridge.arm.com>
References: <20180201103838.14702-1-suzuki.poulose@arm.com>
 <20180201103838.14702-2-suzuki.poulose@arm.com>
 <20180207104320.GM5862@e103592.cambridge.arm.com>
 <336948e9-62c4-1ca0-c832-045095eda229@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <336948e9-62c4-1ca0-c832-045095eda229@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 10:51:55AM +0000, Suzuki K Poulose wrote:
> On 07/02/18 10:43, Dave Martin wrote:
> >On Thu, Feb 01, 2018 at 10:38:38AM +0000, Suzuki K Poulose wrote:
> >>Expose the new features introduced by Arm v8.4 extensions to
> >>Arm v8-A profile.
> >>
> >>These include :
> >>
> >>  1) Data indpendent timing of instructions. (DIT, exposed as HWCAP_DIT)
> >>  2) Unaligned atomic instructions and Single-copy atomicity of loads
> >>     and stores. (AT, expose as HWCAP_USCAT)
> >>  3) LDAPR and STLR instructions with immediate offsets (extension to
> >>     LRCPC, exposed as HWCAP_ILRCPC)
> >>  4) Flag manipulation instructions (TS, exposed as HWCAP_FLAGM).
> >>
> >>While at it get rid of the RES0 entries in the cpu-feature-registers.txt
> >>documentation.
> >
> >Should we write somewhere than fields that are not described here are
> >implicitly RES0, or would that be too strong a statement?
> 
> Dave,
> 
> We already have the following description in the file :
> 
> "The following rules are applied to the value returned by the
> infrastructure:
> 
>  a) The value of an 'IMPLEMENTATION DEFINED' field is set to 0.
>  b) The value of a reserved field is populated with the reserved
>     value as defined by the architecture.
>  c) The value of a 'visible' field holds the system wide safe value
>     for the particular feature (except for MIDR_EL1, see section 4).
>  d) All other fields (i.e, invisible fields) are set to indicate
>     the feature is missing (as defined by the architecture).
> "
> 
> So we don't have to bother if the fields are RES0 or they get
> some definitions in the future, as long as we don't expose them.

Agreed, that does seem sufficient:

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

[...]

Cheers
---Dave
