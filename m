Date: Thu, 12 Apr 2018 18:56:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org,
	Nicolas Dechesne <nicolas.dechesne@linaro.org>,
	Anibal Limon <anibal.limon@linaro.org>,
	Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4.9 000/102] 4.9.93-stable review
Message-ID: <20180412165650.GD23951@kroah.com>
References: <20180406084331.507038179@linuxfoundation.org>
 <20180406222524.dzzyzh3su3ytgh3u@xps>
 <20180407061118.GF18744@kroah.com>
 <45305b36-b5fb-5016-4948-38a7465691af@linaro.org>
 <20180412122305.GA19236@kroah.com>
 <5195ccd4-1a9d-b1e5-3cb4-1b6b6243f3ed@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5195ccd4-1a9d-b1e5-3cb4-1b6b6243f3ed@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 02:32:09PM +0200, Thierry Escande wrote:
> On 12/04/2018 14:23, Greg Kroah-Hartman wrote:
> > On Thu, Apr 12, 2018 at 02:17:50PM +0200, Thierry Escande wrote:
> > > Hi Greg,
> > > 
> > > On 07/04/2018 08:11, Greg Kroah-Hartman wrote:
> > > > On Fri, Apr 06, 2018 at 05:25:24PM -0500, Dan Rue wrote:
> > > > > On Fri, Apr 06, 2018 at 03:22:41PM +0200, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 4.9.93 release.
> > > > > > There are 102 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > > let me know.
> > > > > > 
> > > > > > Responses should be made by Sun Apr  8 08:42:55 UTC 2018.
> > > > > > Anything received after that time might be too late.
> > > > > 
> > > > > Results from Linaro’s test farm.
> > > > > No regressions on arm64, arm and x86_64.
> > > > > 
> > > > > There is a new test failure on dragonboard 410c (arm64) in
> > > > > kselftest/cpu-on-off-test. However, it looks like the test was failing
> > > > > but giving a false "PASS" on previous versions of 4.9. This -RC seems to
> > > > > have changed the behavior enough to cause the test to actually mark a
> > > > > failure.
> > > > > 
> > > > > In any event, this looks like a db410c-specific pre-existing issue that we have
> > > > > already escalated to our Qualcomm team. Details can be found at
> > > > > https://bugs.linaro.org/show_bug.cgi?id=3723 for those interested.
> > > > 
> > > > Thanks for testing these and letting me know.
> > > 
> > > The test failure on dragonboard 410c comes from [1] to fix a possible
> > > deadlock related to the hotplug rework. It's been reverted in v4.12 by [2]
> > > because the cpu hotplug rework was not ready yet at that time. Since the
> > > hotplug rework has not been backported to v4.9.y, the splat cannot be
> > > reproduced and so [1] can be reverted or [2] applied on v4.9.y.
> > > 
> > > [1] https://lkml.org/lkml/2018/3/23/452
> > > [2] https://lkml.org/lkml/2017/5/7/124
> > 
> > Hm, so I need to drop some patch, but what one?  lkml.org does not work
> > for me, please be specific and use the git commit ids, or at the
> > very-least, the subject of the patches.  Never make someone have to rely
> > on the existance of a random web site not under kernel developer's
> > control to figure out what to do...
> 
> So the commit to be reverted is [1], introduced in v4.9.90. Or you can apply
> [2] from v4.12 that actually reverts [1].
> 
> [1] 18dd7b964c01ac44497471f4ea3f4c0c663eab55
> [2] 51d638b1f56a0bfd9219800620994794a1a2b219

You do know about the "nice" way to display git ids, right:
	$ alias gsr
	alias gsr='git show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"'
	$ gsr 18dd7b964c01ac44497471f4ea3f4c0c663eab55
	18dd7b964c01 ("block/mq: Cure cpu hotplug lock inversion")
	$ gsr 51d638b1f56a0bfd9219800620994794a1a2b219
	51d638b1f56a ("block/mq: fix potential deadlock during cpu hotplug")

It makes it easier to read, footnotes suck for something that you have
to act on and not just want to read after-the-fact.

Anyway, I'll revert this for the next round after these releases come
out.

thanks,

greg "everyone deserves a copy editor!" k-h
