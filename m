Date: Fri, 6 Apr 2018 09:29:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 52/97] mtip32xx: use runtime tag to initialize
 command header
Message-ID: <20180406072905.GC15735@kroah.com>
References: <20180323094157.535925724@linuxfoundation.org>
 <20180323094200.569562172@linuxfoundation.org>
 <1522789265.2654.129.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522789265.2654.129.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 10:01:05PM +0100, Ben Hutchings wrote:
> On Fri, 2018-03-23 at 10:54 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Ming Lei <ming.lei@redhat.com>
> > 
> > 
> > [ Upstream commit a4e84aae8139aca9fbfbced1f45c51ca81b57488 ]
> > 
> > mtip32xx supposes that 'request_idx' passed to .init_request()
> > is tag of the request, and use that as request's tag to initialize
> > command header.
> > 
> > After MQ IO scheduler is in, request tag assigned isn't same with
> > the request index anymore, so cause strange hardware failure on
> > mtip32xx, even whole system panic is triggered.
> [...]
> 
> MQ IO schedulers were introduced in 4.11, so this shouldn't be needed
> in older branches.  It also causes a performance regression (fixed
> upstream).  Please revert this for 4.4 and 4.9.

Now reverted, thanks.

greg k-h
