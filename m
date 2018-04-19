Date: Thu, 19 Apr 2018 10:24:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Cc: netdev@vger.kernel.org, kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
	stephen@networkplumber.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, ganeshgr@chelsio.com,
	nirranjan@chelsio.com, indranil@chelsio.com
Subject: Re: [PATCH net-next v4 1/3] vmcore: add API to collect hardware dump
 in second kernel
Message-ID: <20180419082456.GA8617@kroah.com>
References: <cover.1523950321.git.rahul.lakkireddy@chelsio.com>
 <e69b49f1406d2dcd9cd68e4300939e96cd745559.1523950324.git.rahul.lakkireddy@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e69b49f1406d2dcd9cd68e4300939e96cd745559.1523950324.git.rahul.lakkireddy@chelsio.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 01:14:17PM +0530, Rahul Lakkireddy wrote:
> +config PROC_VMCORE_DEVICE_DUMP
> +	bool "Device Hardware/Firmware Log Collection"
> +	depends on PROC_VMCORE
> +	default y

Only things that require the machine to keep working should be 'default
y', please remove this, it's an option.

> +	help
> +	  Device drivers can collect the device specific snapshot of
> +	  their hardware or firmware before they are initialized in
> +	  crash recovery kernel. If you say Y here, the device dumps
> +	  will be added as ELF notes to /proc/vmcore

Which exact "device drivers" are you referring to here?

thanks,

greg k-h
