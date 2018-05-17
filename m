Date: Thu, 17 May 2018 09:06:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Gargi Sharma <gs051095@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Rik van Riel <riel@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <treding@nvidia.com>, Todd Kjos <tkjos@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] coresight: allow to build as modules
Message-ID: <20180517070643.GC13919@kroah.com>
References: <20180508140650.c070e6aa0eb1a6690e6d9607@arm.com>
 <f299d0be-f1a6-46ca-3d8a-13d7d89a007d@infradead.org>
 <20180508153756.09f6fa8066bc23a0d11ec670@arm.com>
 <3826d737-c180-7b9e-8013-be54f6d7302d@infradead.org>
 <20180516143322.0eaecaa72f8a65f19fd7dabf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516143322.0eaecaa72f8a65f19fd7dabf@arm.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 02:33:22PM -0500, Kim Phillips wrote:
> Allow to build coresight as modules.  This greatly enhances developer
> efficiency by allowing the development to take place exclusively on the
> target, and without needing to reboot in between changes.
> 
> - Kconfig bools become tristates, to allow =m
> 
> - MODULE_* macros added:  Please correct me if I'm wrong:
>   - assume LICENSE is "GPL v2"
>   - tried to get as close to original authors for MODULE_AUTHOR
> 
> - The 'select' Kconfig statements are replaced with 'depends on'
>   clauses, to specify the dependencies between the modules including
>   other fixes, e.g., coresight-stm unconditionally calls
>   stm_register_device, it therefore depends on STM.
> 
> - use -objs to denote merge object directives in Makefile, adds a
>   coresight-core nomenclature for the base module.
> 
> - add a coresight_exit() that unregisters the coresight bus, add remove
>   fns for most others.
> 
> - fix up modules with ID tables for autoloading on boot, add missing
>   __exit attributes
> 
> - move coresight_vpid_to_pid to an externed, single instance in
>   coresight-core, to be used by all submodules.

That's a ton of different things to be doing all at once in this patch.
Please break it up into logical steps (like you describe here!) which
will make it much easier and trivial to review.

As it is, I'm not even going to look at the mess-of-a-diff that I
imagine the above results in :)

thanks,

greg k-h
