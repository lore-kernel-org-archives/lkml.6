Date: Mon, 23 Apr 2018 15:16:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: NeilBrown <neilb@suse.com>
Cc: Oleg Drokin <oleg.drokin@intel.com>,
	James Simmons <jsimmons@infradead.org>,
	Andreas Dilger <andreas.dilger@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lustre Development List <lustre-devel@lists.lustre.org>
Subject: Re: [PATCH 08/17] staging: lustre: add container_of_safe()
Message-ID: <20180423131648.GA13997@kroah.com>
References: <152229732768.27689.4800156943561963977.stgit@noble>
 <152229760847.27689.4969508646445147289.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152229760847.27689.4969508646445147289.stgit@noble>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 03:26:48PM +1100, NeilBrown wrote:
> Luster has a container_of0() function which is similar to
> container_of() but passes an IS_ERR_OR_NULL() pointer through
> unchanged.
> This could be generally useful: bcache at last has a similar function.
> 
> Naming is hard, but the precedent set by hlist_entry_safe() suggests
> a _safe suffix might be most consistent.
> 
> So add container_of_safe() to kernel.h, and replace all occurrences of
> container_of0() with one of
>   - list_first_entry, list_next_entry, when that is a better fit,
>   - container_of(), when the pointer is used as a validpointer in
>     surrounding code,
>   - container_of_safe() when there is no obviously better alternative.

I'm loath to add a kernel.h define for a staging driver, but this does
seem sane.  Nice work.

greg k-h
