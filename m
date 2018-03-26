Date: Mon, 26 Mar 2018 10:15:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] zram: idle memory tracking
Message-ID: <20180326081511.GA15432@kroah.com>
References: <20180326064951.123940-1-minchan@kernel.org>
 <20180326064951.123940-2-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326064951.123940-2-minchan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 03:49:51PM +0900, Minchan Kim wrote:
> +static int zram_debugfs_register(struct zram *zram)
> +{
> +	struct dentry *ret;
> +
> +	if (!zram_debugfs_root)
> +		return -ENOENT;

No need to care, you should not error out if debugfs is not enabled or
not working, your code path should be identical either way.  debugfs is
not required for any functionality, so don't treat it like it matters :)

> +	zram->debugfs_dir = debugfs_create_dir(zram->disk->disk_name,
> +						zram_debugfs_root);
> +	if (!zram->debugfs_dir)
> +		return -ENOMEM;

No need to check the return value of any debugfs call, you can always
either use it for future debugfs calls, or ignore it.

> +	ret = debugfs_create_file("access_time", 0400, zram->debugfs_dir,
> +				zram, &proc_zram_access_operations);
> +	if (!ret)
> +		return -ENOMEM;

Again, you shouldn't care :)

> +
> +	return 0;

just return void, no need to test any of this.

thanks,

greg k-h
