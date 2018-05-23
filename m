Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932207AbeEWJXe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 05:23:34 -0400
Received: from foss.arm.com ([217.140.101.70]:51426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932111AbeEWJXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 05:23:25 -0400
Subject: Re: [PATCH 02/14] arm64: Call ARCH_WORKAROUND_2 on transitions
 between EL0 and EL1
To: Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Cc: Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180522150648.28297-1-marc.zyngier@arm.com>
 <20180522150648.28297-3-marc.zyngier@arm.com>
From: Julien Grall <julien.grall@arm.com>
Message-ID: <0b03ce12-510e-464b-63de-cd481d7cb1c5@arm.com>
Date: Wed, 23 May 2018 10:23:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522150648.28297-3-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 05/22/2018 04:06 PM, Marc Zyngier wrote:
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index ec2ee720e33e..f33e6aed3037 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -18,6 +18,7 @@
>    * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#include <linux/arm-smccc.h>
>   #include <linux/init.h>
>   #include <linux/linkage.h>
>   
> @@ -137,6 +138,18 @@ alternative_else_nop_endif
>   	add	\dst, \dst, #(\sym - .entry.tramp.text)
>   	.endm
>   
> +	// This macro corrupts x0-x3. It is the caller's duty
> +	// to save/restore them if required.

NIT: Shouldn't you use /* ... */ for multi-line comments?

Regardless that:

Reviewed-by: Julien Grall <julien.grall@arm.com>

Cheers,

-- 
Julien Grall
