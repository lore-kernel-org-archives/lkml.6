Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032068AbeEXK1Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 06:27:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40292 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030987AbeEXK1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 06:27:11 -0400
Date: Thu, 24 May 2018 11:27:38 +0100
From: Will Deacon <will.deacon@arm.com>
To: Laura Abbott <labbott@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCHv2] arm64: Make sure permission updates happen for pmd/pud
Message-ID: <20180524102735.GA28425@arm.com>
References: <20180523184346.487-1-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523184346.487-1-labbott@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laura,

On Wed, May 23, 2018 at 11:43:46AM -0700, Laura Abbott wrote:
> Commit 15122ee2c515 ("arm64: Enforce BBM for huge IO/VMAP mappings")
> disallowed block mappings for ioremap since that code does not honor
> break-before-make. The same APIs are also used for permission updating
> though and the extra checks prevent the permission updates from happening,
> even though this should be permitted. This results in read-only permissions
> not being fully applied. Visibly, this can occasionaly be seen as a failure
> on the built in rodata test when the test data ends up in a section or
> as an odd RW gap on the page table dump. Fix this by using
> pgattr_change_is_safe instead of p*d_present for determining if the
> change is permitted.
> 
> Reported-by: Peter Robinson <pbrobinson@gmail.com>
> Fixes: 15122ee2c515 ("arm64: Enforce BBM for huge IO/VMAP mappings")
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v2: Switch to using pgattr_change_is_safe per suggestion of Will
> ---

Thanks for re-spinning so quickly. I'll queue as a fix with the relevant
tags.

Will
