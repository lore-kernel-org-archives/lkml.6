Date: Fri, 6 Apr 2018 09:32:32 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Guoqing Jiang <gqjiang@suse.com>, NeilBrown <neilb@suse.com>,
	Shaohua Li <shli@fb.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 63/97] md/raid10: skip spare disk as first disk
Message-ID: <20180406073232.GD15735@kroah.com>
References: <20180323094157.535925724@linuxfoundation.org>
 <20180323094201.150412201@linuxfoundation.org>
 <1522791129.2654.135.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522791129.2654.135.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 10:32:09PM +0100, Ben Hutchings wrote:
> On Fri, 2018-03-23 at 10:54 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Shaohua Li <shli@fb.com>
> > 
> > 
> > [ Upstream commit b506335e5d2b4ec687dde392a3bdbf7601778f1d ]
> > 
> > Commit 6f287ca(md/raid10: reset the 'first' at the end of loop) ignores
> > a case in reshape, the first rdev could be a spare disk, which shouldn't
> > be accounted as the first disk since it doesn't include the offset info.
> > 
> > Fix: 6f287ca(md/raid10: reset the 'first' at the end of loop)
> 
> But that commit hasn't been applied to 4.4-stable.  It probably should
> be, since it fixes another instance of the problem in the run()
> function.  Take care not to add the wrongly placed assignment
> in raid10_start_reshape().

Thanks, now fixed up.

greg k-h
