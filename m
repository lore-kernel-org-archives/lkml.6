Date: Wed, 14 Feb 2018 14:54:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	will.deacon@arm.com, catalin.marinas@arm.com, marc.zyngier@arm.com,
	broonie@linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [GIT PULL] arm64 spectre and meltdown mitigations for
 v4.14-stable
Message-ID: <20180214135420.GB24189@kroah.com>
References: <20180212113801.2552-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212113801.2552-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 11:38:01AM +0000, Ard Biesheuvel wrote:
> Hi Greg,
> 
> As mentioned by Will, I have created the v4.14 counterpart of his stable
> backport of the arm64/ARM Spectre/Meltdown mitigations that have been pulled
> into v4.16-rc1.
> 
> Given that this is the v4.15 version backported to v4.14, I have removed any
> mention of 'conflicts' from the commit logs as they are now ambiguous. The
> patches applied surprisingly cleanly, I only needed to drop two patches that
> are already in (the same ones Will mentioned in his PR), and drop another one
> dealing with SPE, support for which did not exist yet in v4.14. I also included
> the patch
> 
>   arm64: move TASK_* definitions to <asm/processor.h>
> 
> from v4.15 to make Robin's Spectre v1 patches apply more cleanly.

I've queued these up now, but if you could pull the whole quilt tree and
verify I got things right, that would be great.  There was some
conflicts with a few previous patches I had already queued up that
touched some "Falkor" errata code.

Specifically 932b50c7c1c65e6f23002e075b97ee083c4a9e71 "arm64: Add
software workaround for Falkor erratum 1041" is the offending patch.  I
think I resolved the merge issues properly, but verifying this would be
wonderful.

thanks,

greg k-h
