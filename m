Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeDIOFw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:05:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:48067 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751291AbeDIOFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:05:51 -0400
Date: Mon, 9 Apr 2018 16:05:49 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/livepatch: introduce tests
Message-ID: <20180409140549.q6jybx3zirnsl2pp@pathway.suse.cz>
References: <1522266588-11806-1-git-send-email-joe.lawrence@redhat.com>
 <1522266588-11806-2-git-send-email-joe.lawrence@redhat.com>
 <20180407023646.k3gjrgjwzhwgu6fq@treble>
 <20180408154231.ihnglqyya5nric4q@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408154231.ihnglqyya5nric4q@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2018-04-08 11:42:31, Joe Lawrence wrote:
> On Fri, Apr 06, 2018 at 09:36:46PM -0500, Josh Poimboeuf wrote:
> > On Wed, Mar 28, 2018 at 03:49:48PM -0400, Joe Lawrence wrote:
> > > Add a few livepatch modules and simple target modules that the included
> > > regression suite can run tests against.
> > > 
> > > Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> > > ---
> > >  lib/Kconfig.debug                                  |  12 +
> > >  lib/Makefile                                       |   2 +
> > >  lib/livepatch/Makefile                             |  18 +
> > >  lib/livepatch/test_klp_atomic_replace.c            |  69 +++
> > >  lib/livepatch/test_klp_callbacks_busy.c            |  43 ++
> > >  lib/livepatch/test_klp_callbacks_demo.c            | 132 ++++++
> > >  lib/livepatch/test_klp_callbacks_demo2.c           | 104 ++++
> > >  lib/livepatch/test_klp_callbacks_mod.c             |  24 +
> > >  lib/livepatch/test_klp_livepatch.c                 |  62 +++
> > >  tools/testing/selftests/Makefile                   |   1 +
> > >  tools/testing/selftests/livepatch/Makefile         |   8 +
> > >  tools/testing/selftests/livepatch/config           |   1 +
> > >  tools/testing/selftests/livepatch/functions.sh     | 202 ++++++++
> > >  .../testing/selftests/livepatch/test-callbacks.sh  | 526 +++++++++++++++++++++
> > >  .../testing/selftests/livepatch/test-livepatch.sh  | 177 +++++++
> > >  .../selftests/livepatch/test-shadow-vars.sh        |  13 +
> > >  16 files changed, 1394 insertions(+)
> > >  create mode 100644 lib/livepatch/Makefile
> > >  create mode 100644 lib/livepatch/test_klp_atomic_replace.c
> > >  create mode 100644 lib/livepatch/test_klp_callbacks_busy.c
> > >  create mode 100644 lib/livepatch/test_klp_callbacks_demo.c
> > >  create mode 100644 lib/livepatch/test_klp_callbacks_demo2.c
> > >  create mode 100644 lib/livepatch/test_klp_callbacks_mod.c
> > >  create mode 100644 lib/livepatch/test_klp_livepatch.c
> > >  create mode 100644 tools/testing/selftests/livepatch/Makefile
> > >  create mode 100644 tools/testing/selftests/livepatch/config
> > >  create mode 100644 tools/testing/selftests/livepatch/functions.sh
> > >  create mode 100755 tools/testing/selftests/livepatch/test-callbacks.sh
> > >  create mode 100755 tools/testing/selftests/livepatch/test-livepatch.sh
> > >  create mode 100755 tools/testing/selftests/livepatch/test-shadow-vars.sh
> > 
> > I love this.  Nice work!
> > 
> > As you and Petr discussed, it would be nice to get rid of some of the
> > delays, and also the callback tests will be very important.
> 
> I've got v2 WIP that minimizes the delays, cleans up build flags, and
> adds a basic shadow variable test.

Sounds great.

> Since these tests are based on top of Petr's current patchsets for
> atomic replace and shadow variables, it probably makes sense for those
> to merge first.  I can post test results to his patchsets if that helps.

Sounds good to me. We could synchronize the merge. But I think that it
will not be a big deal if we would merge the atomic replace slightly
earlier if the tests needed some more love.


> These tests are basically a mash up of some of the tedious callback
> Documentation and shadow variable sample livepatches.  Since there will
> be a lot of duplication, should we just remove redundant doc/samples in
> favor of these tests?

Yup, it does not make sense to maintain two copies of basically
the same modules.

Best Regards,
Petr
