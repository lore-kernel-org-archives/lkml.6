Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF4DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C707214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="poWJSR2I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C707214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbeLFPhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:37:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35556 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeLFPhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ec2sGWfH2YxunsjK4iQ19kl/2O5cfAXHuth37RafTjk=; b=poWJSR2IyLEugQxQdIL+3sOZp
        ATogC1ZEnIKkMT+M5PU0ym5WJWK+QIJobobAVDMGk/AJtW7fC9zCX4sfN7fYsMVpuY+vpsLk/NWQA
        CDQZF/yMOEDoys3MeOOJrgbd9VXEeWxhurdDxgf9VtqUDGB2FjLorGUg5QFFJQeHpf+PJchX4FAzU
        nIekDPrXKEajcu6SdegA5TVjz2kaOmuA6bXl8NCMyrvH6xiALv2hRPmiiusq9usa6fCAnrE8zzRtT
        5GNLNakxxz0eiPTO6LXVLZTnIBxAk0Pjf2wMdVNbIhvKRRqtDFiBPST1NJPHeQWNuyMUyrds5nr0T
        dhn6jKGjA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUviI-0000mn-82; Thu, 06 Dec 2018 15:37:18 +0000
Date:   Thu, 6 Dec 2018 07:37:18 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Eric Sandeen <sandeen@sandeen.net>, jeffm@suse.com,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>,
        Felix Guo <felixguoxiuping@gmail.com>,
        Petr Mladek <pmladek@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC v3 11/19] kunit: add Python libraries for handing KUnit
 config and kernel
Message-ID: <20181206153718.GD24603@bombadil.infradead.org>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-12-brendanhiggins@google.com>
 <841cf4ae-501b-05ae-5863-a51010709b67@ideasonboard.com>
 <CAFd5g47x-UNja72k-CWPmWz9+LTn8pF8Wj5Poq+2FJ93E=vymA@mail.gmail.com>
 <20181204204701.GT28501@garbanzo.do-not-panic.com>
 <f8722f4a-44c8-24c2-c433-5178f9f40b82@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8722f4a-44c8-24c2-c433-5178f9f40b82@ideasonboard.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 12:32:47PM +0000, Kieran Bingham wrote:
> On 04/12/2018 20:47, Luis Chamberlain wrote:
> > On Mon, Dec 03, 2018 at 03:48:15PM -0800, Brendan Higgins wrote:
> >> On Thu, Nov 29, 2018 at 5:54 AM Kieran Bingham
> >> <kieran.bingham@ideasonboard.com> wrote:
> >>>
> >>> Hi Brendan,
> >>>
> >>> Thanks again for this series!
> >>>
> >>> On 28/11/2018 19:36, Brendan Higgins wrote:
> >>>> The ultimate goal is to create minimal isolated test binaries; in the
> >>>> meantime we are using UML to provide the infrastructure to run tests, so
> >>>> define an abstract way to configure and run tests that allow us to
> >>>> change the context in which tests are built without affecting the user.
> >>>> This also makes pretty and dynamic error reporting, and a lot of other
> >>>> nice features easier.
> >>>
> >>>
> >>> I wonder if we could somehow generate a shared library object
> >>> 'libkernel' or 'libumlinux' from a UM configured set of headers and
> >>> objects so that we could create binary targets directly ?
> >>
> >> That's an interesting idea. I think it would be difficult to figure
> >> out exactly where to draw the line of what goes in there and what
> >> needs to be built specific to a test a priori. Of course, that leads
> >> into the biggest problem in general, needed to know what I need to
> >> build to test the thing that I want to test.
> >>
> >> Nevertheless, I could definitely imagine that being useful in a lot of cases.
> > 
> > Whether or not we can abstract away the kernel into such a mechanism
> > with uml libraries is a good question worth exploring.
> > 
> > Developers working upstream do modify their kernels a lot, so we'd have
> > to update such libraries quite a bit, but I think that's fine too. The
> > *real* value I think from the above suggestion would be enterprise /
> > mobile distros or stable kernel maintainers which have a static kernel
> > they need to support for a relatively *long time*, consider a 10 year
> > time frame. Running unit tests without qemu with uml and libraries for
> > respective kernels seems real worthy.
> 
> I think any such library might be something generated by the kernel
> build system, so if someone makes substantial changes to a core
> component provided by the library - it can be up to them to build a
> corresponding userspace library as well.
> 
> We could also consider to only provide *static* libraries rather than
> dynamic. So any one building some userspace tool / test with this would
> be required to compile against (the version of) the kernel they expect
> perhaps... - much like we expect modules to be compiled currently.
> 
> And then the userspace binary would be sufficiently able to live it's
> life on it's own :)
> 
> > The overhead for testing a unit test for said targets, *ideally*, would
> > just be to to reboot into the system with such libraries available, a
> > unit test would just look for the respective uname -r library and mimic
> > that kernel, much the same way enterprise distributions today rely on
> > having debugging symbols available to run against crash / gdb. Having
> > debug modules / kernel for crash requires such effort already, so this
> > would just be an extra layer of other prospect tests.
> 
> Oh - although, yes - there are some good concepts there - but I'm a bit
> weary of how easy it would be to 'run' the said test against multiple
> kernel version libraries... there would be a lot of possible ABI
> conflicts perhaps.
> 
> My main initial idea for a libumlinux is to provide infrastructure such
> as our linked-lists and other kernel formatting so that we can take
> kernel code directly to userspace for test and debug (assuming that
> there are no hardware dependencies or things that we can't mock out)
> 
> I think all of this could complement kunit of course - this isn't
> suggesting an alternative implementation :-)

I suspect the reason Luis cc'd me on this is that we already have some
artisinally-crafted userspace kernel-mocking interfaces under tools/.
The tools/testing/radix-tree directory is the source of some of this,
but I've been moving pieces out into tools/ more generally where it
makes sense to.

We have liburcu already, which is good.  The main sticking points are:

 - No emulation of kernel thread interfaces
 - The kernel does not provide the ability to aggressively fail memory
   allocations (which is useful when trying to exercise the memory failure
   paths).
 - printk has started adding a lot of %pX enhancements which printf
   obviously doesn't know about.
 - No global pseudo-random number generator in the kernel.  Probably
   we should steal the i915 one.

I know Dan Williams has also done a lot of working mocking kernel
interfaces for libnvdimm.
