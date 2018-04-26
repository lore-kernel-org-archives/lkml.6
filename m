Date: Thu, 26 Apr 2018 17:27:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	hpa@zytor.com, Michal Hocko <mhocko@suse.com>,
	Borislav Petkov <bp@suse.de>, Matthew Wilcox <willy@infradead.org>,
	stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Toshi Kani <toshi.kani@hpe.com>, Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] Revert "x86/mm: implement free pmd/pte page interfaces"
Message-ID: <20180426152712.GA17729@kroah.com>
References: <1524755647-18695-1-git-send-email-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524755647-18695-1-git-send-email-joro@8bytes.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 05:14:07PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> This reverts commit 28ee90fe6048fa7b7ceaeb8831c0e4e454a4cf89.
> 
> This commit is broken for x86, as it unmaps the PTE and PMD
> pages and immediatly frees them without doing a TLB flush.
> 
> Further this lacks synchronization with other page-tables in
> the system when the PMD pages are not shared between
> mm_structs.
> 
> On x86-32 with PAE and PTI patches on-top this patch
> triggers the BUG_ON in vmalloc_sync_one() because the kernel
> and the process page-table were not synchronized.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/mm/pgtable.c | 28 ++--------------------------
>  1 file changed, 2 insertions(+), 26 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
