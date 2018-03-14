Date: Wed, 14 Mar 2018 19:25:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Or Idgar <idgar@virtualoco.com>, linux-kernel@vger.kernel.org,
	arnd@arndb.de, oidgar@redhat.com, ghammer@redhat.com,
	Or Idgar <oridgar@gmail.com>
Subject: Re: [PATCH v5] drivers/misc: vm_gen_counter: initial driver
 implementation
Message-ID: <20180314182536.GA14504@kroah.com>
References: <20180301142215.11812-1-idgar@virtualoco.com>
 <20180313190617-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313190617-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 07:40:51PM +0200, Michael S. Tsirkin wrote:
> I think it's a good idea to use sysfs for this. However,
> there are a couple of missing interfaces here:
> 
> 1. Userspace needs a way to know when this value changes.
>    I see no change notifications here and that does not seem right.

How can these change?

> 2. Userspace needs to be able to read these without
>    system calls.

Ick, what?  Why not?

> Pls add mmap support to the raw format.

For a single integer?  Why do you need mmap for this?  What is so
"performant" that needs to touch a sysfs file?

>    (Phys address is not guaranteed to be page-aligned so you will
>     probably want an offset attribute for that as well).

Ick ick ick, that's why it's good to just stick with a sysfs file.

Have you tested just how long this takes to see if the open/read/close
is really the bottleneck, or if the io on reading the value is the
bottleneck?

thanks,

greg k-h
