Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBIMbP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:31:15 -0500
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:59486 "EHLO
        5.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbeBIMbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:31:13 -0500
Date: Fri, 9 Feb 2018 12:49:22 +0100
From: Greg Kurz <groug@kaod.org>
To: Veaceslav Falico <veaceslav.falico@huawei.com>
Cc: jiangyiwen <jiangyiwen@huawei.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        <v9fs-developer@lists.sourceforge.net>, <qemu-devel@nongnu.org>,
        <aneesh.kumar@linux.vnet.ibm.com>, Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [V9fs-developer] [RFC] we should solve create-unlink-getattr
 idiom
Message-ID: <20180209124922.3a215c34@bahia.lan>
In-Reply-To: <a1ef7be5-d368-fe31-4386-1d40762b5849@huawei.com>
References: <5A7D4976.6060407@huawei.com>
        <a1ef7be5-d368-fe31-4386-1d40762b5849@huawei.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10112832966719740358
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtfedrvddtgdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2018 08:21:52 +0100
Veaceslav Falico <veaceslav.falico@huawei.com> wrote:

> Hi Yiwen, all,
> 
> On 2/9/2018 8:10 AM, jiangyiwen wrote:
> > Hi Eric and Greg,
> > 
> > I encountered the similar problem with create-unlink-getattr idiom.
> > I use the testcase that create-unlink-setattr idiom, and I see the
> > bug is reported at https://bugs.launchpad.net/qemu/+bug/1336794.
> > Then I also see you already fix the issue and push the patch to upstream.
> > https://github.com/ericvh/linux/commit/eaf70223eac094291169f5a6de580351890162a2
> > http://patchwork.ozlabs.org/patch/626194/
> > 
> > Unfortunately, the two patches are not merged into master, I don't know
> > the reason, so I suggest if the patche can be merged into master, and
> > it will solve the create-unlink-getattr idiom.  
> 
> As a follow up - the create-unlink-setattr (mainly ftruncate and anything
> else which works on fd instead of path) isn't fixed by these patches, but
> I'm currently working on a new patch, obviously on top of those two, to
> make the setattr work too.
> 
> It's based on the same logic as the above patches though - use FIDs with
> open fd's guest side and use open fd's host side if possible with f*
> functions, otherwise path with l* functions.
> 
> It's bigger than the QEMU getattr patch, as there are no f* functions
> available for ftruncate case, for example.
> 

As I was saying to Yiwen, maybe have a look at:

https://github.com/gkurz/qemu/commits/9p-attr-fixes

It is probably too old to rebase cleanly on current master, but it gives
the general idea.

IIRC, the cause for this not moving forward was because of an issue
unveiled/introduced by patch 3/3 in the linux 9p driver:

https://sourceforge.net/p/v9fs/mailman/v9fs-developer/thread/20160704141655.GA5799%40u-isr-cdi-08/#msg35199720

and a general lack of care for the 9p code at the time... but it seems
you guys are willing to go forward, and that's cool ! :)

Cheers,

--
Greg

> So if those two patches could be merged it'd be a lot easier to then
> go forward with the setattr fix.
> 
> Thank you!
> 
> > 
> > Thanks,
> > Yiwen
> > 
> > .
> >   
> 
> 
