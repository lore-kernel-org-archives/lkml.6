Date: Wed, 21 Mar 2018 11:02:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build failure after merge of the akpm tree
Message-ID: <20180321100208.GA18281@kroah.com>
References: <20180321191727.4d421df3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321191727.4d421df3@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 07:17:27PM +1100, Stephen Rothwell wrote:
> Hi Andrew,
> 
> After merging the akpm tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> drivers/base/firmware_loader/fallback.c: In function 'map_fw_priv_pages':
> drivers/base/firmware_loader/fallback.c:232:2: error: implicit declaration of function 'vunmap'; did you mean 'kunmap'? [-Werror=implicit-function-declaration]
>   vunmap(fw_priv->data);
>   ^~~~~~
>   kunmap
> drivers/base/firmware_loader/fallback.c:233:18: error: implicit declaration of function 'vmap'; did you mean 'kmap'? [-Werror=implicit-function-declaration]
>   fw_priv->data = vmap(fw_priv->pages, fw_priv->nr_pages, 0,
>                   ^~~~
>                   kmap
> drivers/base/firmware_loader/fallback.c:233:16: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>   fw_priv->data = vmap(fw_priv->pages, fw_priv->nr_pages, 0,
>                 ^
> drivers/base/firmware_loader/fallback.c: In function 'firmware_loading_store':
> drivers/base/firmware_loader/fallback.c:274:4: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
>     vfree(fw_priv->pages);
>     ^~~~~
>     kvfree
> drivers/base/firmware_loader/fallback.c: In function 'fw_realloc_pages':
> drivers/base/firmware_loader/fallback.c:405:15: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
>    new_pages = vmalloc(new_array_size * sizeof(void *));
>                ^~~~~~~
>                kvmalloc
> drivers/base/firmware_loader/fallback.c:405:13: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>    new_pages = vmalloc(new_array_size * sizeof(void *));
>              ^
> 
> Maybe caused by patch
> 
>   "headers: untangle kmemleak.h from mm.h"
> 
> Anyway this file should explicitly include linux/vmalloc.h since it uses
> stuff in there, so I have added the following patch for today (I think
> this could just be applied to the driver-core tree ...):

Patch is now queued up, thanks.

greg k-h
