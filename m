Date: Tue, 8 May 2018 16:21:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virt: vbox: Only copy_from_user the request-header once
Message-ID: <20180508142117.GB10972@kroah.com>
References: <20180508134659.20429-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508134659.20429-1-hdegoede@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 03:46:59PM +0200, Hans de Goede wrote:
> In vbg_misc_device_ioctl(), the header of the ioctl argument is copied from
> the userspace pointer 'arg' and saved to the kernel object 'hdr'. Then the
> 'version', 'size_in', and 'size_out' fields of 'hdr' are verified.
> 
> Before this commit, after the checks a buffer for the entire request would
> be allocated and then all data including the verified header would be
> copied from the userspace 'arg' pointer again.
> 
> Given that the 'arg' pointer resides in userspace, a malicious userspace
> process can race to change the data pointed to by 'arg' between the two
> copies. By doing so, the user can bypass the verifications on the ioctl
> argument.
> 
> This commit fixes this by using the already checked copy of the header
> to fill the header part of the allocated buffer and only copying the
> remainder of the data from userspace.
> 
> Reported-by: Wenwen Wang <wang6495@umn.edu>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Does this need to go into 4.17-final?  Any older kernels?  Or can it
wait for 4.18-rc1?

thanks,

greg k-h
