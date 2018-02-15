Date: Thu, 15 Feb 2018 17:49:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org, x86@kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Borislav Petkov <bp@suse.de>, Hugh Dickins <hughd@google.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [stable-4.9] x86: fix build without
 CONFIG_X86_VSYSCALL_EMULATION
Message-ID: <20180215164922.GB6699@kroah.com>
References: <20180215151710.1473117-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215151710.1473117-1-arnd@arndb.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 04:16:56PM +0100, Arnd Bergmann wrote:
> I ran into a 4.9 build regression in randconfig testing, starting with the
> KAISER patches:
> 
> arch/x86/mm/kaiser.c: In function 'kaiser_init':
> arch/x86/mm/kaiser.c:347:8: error: 'vsyscall_pgprot' undeclared (first use in this function); did you mean 'massage_pgprot'?
> 
> This is easy enough to fix, we just need to make the declaration visible
> outside of the #ifdef. This works because the code using it is optimized
> away when vsyscall_enabled() returns false at compile time.
> 
> Fixes: 9a0be5afbfbb ("vsyscall: Fix permissions for emulate mode with KAISER/PTI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/include/asm/vsyscall.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks for these, I'll queue them up in the next round after these
kernels get released in a few days.

greg k-h
