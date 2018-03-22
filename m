Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3335693-1521741181-2-13001163285639811396
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521741180; b=KXxka6HJWfzLlGoSJe56wXFJ2FW1TzAB3WH3aZMFGZgqyU2
    49PtDbeH+wvFHwkL3VcJIsQupWoMAfpYx4IRvxu9vZZgk4gYJcS2g2vlK61VuJJo
    b1aETofJnAvCK1OqrqDk5HqiAtbDTz6YX2w/xj39K+7MO1JUsRK54Ya104JYBhAK
    zPqaO8qeNLFQNF/EjjsmpO0dUJJ3ZfWw1jQIHhV5akoHibuoKv1DCqXvnCvU5+ko
    nkgKLxma3B2dVgINMz33fgzmEQuPIHvhuTh1a13mVo+lhJL7OJk64/I3AfhQ19xo
    fZt0WlEEhkI218Vfi/rIepu9PgZGER8j3PXB4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521741180; bh=igCsfzhr3u1dFZ3Ja86YFq7YPm
    kdptDwJJbMktVVbR8=; b=JJkQOlUwD+2SL4D48z4mQWNxmEEjAXXE5BuFcUlQnS
    N+UDoz9E0rK2Qkbru6JJbcD2CP/plVxoWvA5kUrvB79TFUrMmqApaHkmVUKvu6WN
    GbFrYKbWlD7/wcbmu4iBtX7hPzOXkCDGWwz258KvRRyRlJHlGRvvM5nnhBDELiJZ
    lIaPc6gBXHz1s33v4yfOmllfQsV//h5MQ3DJpwZcGi/48573dU8LwbvYkzAAnlcg
    e7EyvAN0PrWKgdNZ3HWC0/VpdNUGEagAEjRm51RsiEnBXefK6wQpSwbn6zSIIVJ/
    GlP4JnbEfHuUnVs39A8vSDwKqxt+h48uL5kwLh1ZAqCQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeCVRw6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 13:52:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36698 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751551AbeCVRw5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Mar 2018 13:52:57 -0400
Date: Thu, 22 Mar 2018 18:52:51 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4.4 095/108] Bluetooth: btusb: Restore QCA Rome
 suspend/resume fix with a "rewritten" version
Message-ID: <20180322175251.GA24850@kroah.com>
References: <20180215151222.267507937@linuxfoundation.org>
 <20180215151235.620152736@linuxfoundation.org>
 <20180216023147.GB69988@rodete-desktop-imager.corp.google.com>
 <20180216064850.GA26224@kroah.com>
 <20180216181043.GA84497@rodete-desktop-imager.corp.google.com>
 <20180216185220.GA29352@roeck-us.net>
 <20180217134351.GB28145@kroah.com>
 <befd1dc3-32ee-bd00-876e-a59397cffd37@roeck-us.net>
 <20180217152459.GA22308@kroah.com>
 <CA+ASDXMvsgOUkxyYuMNqNduNJR5k-jWHynfXvpEdTLGPZyD=TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ASDXMvsgOUkxyYuMNqNduNJR5k-jWHynfXvpEdTLGPZyD=TA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 11:39:56AM -0800, Brian Norris wrote:
> Hi Greg,

Hi,

Sorry for the delay, wanted to think about this one for a while...

> ...
> >> > Thanks, but I've now released all of these with this patch committed, so
> >> > we are now "bug compatible" :)
> 
> So, is that to say that the boilerplate above about objections is
> meaningless? This is the second time that this same "feature" has been
> pushed (degrading the quality of my systems) despite my objections,
> under the banner of "bug compatibility" [1]. The first attempt to
> revert was back around Dec 20 of last year, but I see that there were
> 10 "stable" 4.4 kernels released in the meantime [2] where that
> original bug was still present. (Commit fd865802c66b "Bluetooth:
> btusb: fix QCA Rome suspend/resume" was proven undeniably buggy.)

Sorry, I know you were frustrated, but for some subsystems/minor devices
like this, regressions happen and getting them fixed properly can take a
few weeks.

And yes, something doesn't feel "minor" when it affects your devices but
really you have the control here to revert the change on your side (more
on that below...)

> Next: we see this current valiant attempt at a less buggy fix, by
> Hans. It's an OK solution, but it still wastes power for me. I
> objected above, but instead of delaying applying it, you applied it in
> the same release as you finally fixed the original crap (v4.4.116). So
> all-in-all, my system (if using 4.4.x directly) hasn't had decent
> Bluetooth since v4.4.99.

I'm amazed bluetooth works at all at times, given the mess of the
hardware involved, and the horrid spec and all of the intermediate
pieces.  Luckily 4.15+ seems really good for me now, but I know you
can't upgrade :)

That being said, some subsystems have problems with stuff like this due
to crazy hardware that one fix breaks another and the like.  There is
also the issue of maintainers that don't work on the subsystem "full" or
even "part" time.  From my side, I submitted a known-security-bugfix and
it was ignored by the bluetooth maintainers for weeks, so I had to route
around them and push it directly to Linus just to get it fixed.  So I
feel your pain, but we are dealing with people with different
priorities, none of which we directly control, so we have to handle it
the best we can.

In the end, it's amazing any of this works at all, but it does, it just
sometimes takes longer than we all like :)

> > It's a tough trade-off.  If I dropped this patch, the normal mode of
> > operation would be for it to get merged into device kernels and then
> > forgotten about.  Only if/when the user with the problem moves to a
> > newer release a long time later would the regression normally appear
> > again, and everyone would have to remember what happened and try to
> > piece it all together again as to what commit caused the issue.
> 
> Note that I didn't suggest we have to completely drop the patch. And I
> also don't suspect you need to delay all -rc1 bugfixes. I'd just
> suggest delaying the patch for a few weeks, when there are objections
> raised. (Or, reverting and scheduling to re-queue in a few weeks if no
> progress...or something like that.) Is that not something that could
> work, in order to keep "stable" releases *actually* stable? In most
> software release processes, buggy patches are reverted as quickly as
> possible while alternatives are worked out. Not all fixes are security
> fixes that need to be out the door as soon as they see the light of
> day...

Having the "bug compatible" stable kernels is controversial.  And I
don't always follow that rule, depending on the subsystem/bug involved
(see a recent btrfs bug for one such example.)  That being said, I have
found that it is the best thing to do overall, as it provides the needed
pressure on the developer/maintainer/user to get the bug fixed and
pushed to Linus as soon as possible.

And in the meantime, if you, as a user, knows the patch in problem, you
can always revert it on your own.  We all have local patches, you more
than me, but that's just part of dealing with open source projects. Not
a big deal at all, add the revert to your stack, when the bug gets
fixed you drop your patch and all is good/fine.

If you aren't using tools to make this easier, well that can be fixed (I
strongly recommend quilt, not git, to work with a device kernel, but
that's another long rant/email for another time...)

> > By you adding the revert to your device kernel now, you have a record of
> > this being a problem, how upstream isn't fixing the issue, and when/if
> > you do move to a newer kernel, that bugfix will still be there in your
> > patch stack to forward port.
> 
> So, you rely entirely on device kernels to manage the pain that your
> release process causes? We're actively trying to stay much closer to
> upstream these days, and would essentially like to eliminate the
> concept of "device" kernels, at least for Chrom{e,ium} OS, if
> possible. But it's crap like this that proves that we can't.

Oh come on, you all have _thousands_ of graphic driver patches in your
tree on top of mainline.  Dealing with 2-4 device-specific patches is a
total drop in the bucket.

Yes, it takes testing and finding the problem, but look at the benifit!
You are getting 10 patches a day that are currated and hopefully tested
and maintained by the community.  If you only have 1 failure a week,
your odds are still way in your favor of having more bugs fixed
(security and otherwise) than if you ignored the stable patches
entirely.

And that't the point to drive home here.  If you stay away from updating
to stable patches, you have a huge boatload of KNOWN SECURITY HOLES in
your product.  If you take them, you have the _possiblity_ of some bugs
added, but overall, the rate is _VERY_ small.  Guenter has numbers of
2-4 patches per year cause problems.  That's lower than ANY other
development model I have ever seen anywhere.

So, stick with known buggy/insecure devices?  Or take the updates and
handle the 1-2 problems a year they provide you.  I think the
cost-analysis is easy to make here :)

And don't try to say "I'll just cherry-pick the security patches."  It
never works.  I have audited a ton of device kernels, from loads of
companies that say they know what they are doing.  All of them were full
of holes and missed obvious bugs.  As proof of that, I can get root
and/or crash almost every single major Android device on the market
right now due to them not taking updated kernels.  It's a sad state, and
one that I am working with the OEMs and Google to resolve.

> > Yeah, you all are normally better than that, and I trust that you will
> > push to get this resolved, hopefully soon.  But for the most part, this
> > method works best overall for the majority of the cases like this as not
> > all bug reporters are persistent, and if not, the maintainer usually
> > forgets about it as no one is saying anything and they have other things
> > to work on.
> >
> > Well, bluetooth is known to not have responsive maintainers, so who am I
> > kidding here, odds are it's only going to get fixed as Hans is
> > involved, despite the bluetooth maintainers :)
> 
> You can't pin this completely on the bluetooth maintainers. *You*
> maintain the -stable trees, yet you effectively ignored both of my
> objections, forcing me to rely on said original maintainers to queue
> up alternatives. Yes, yes, I know the "forcing me [and/or Hans] to
> work" is basically working as intended for you, but the hard facts
> show that *your* release was broken for far too long.

That's fine, it's my _job_ to push back on the maintainers here, as they
are the ones that are doing the wrong thing, I'm not going to do their
job, just like they aren't going to do mine.

And I don't scale, they do, as they only have to maintain a single
subsystem, I have the whole stable tree to worry about.

And again, just revert and move on, I think we have taken more time with
these emails about the whole process than it would have taken to do this
on your side :)

> [1] BTW, I've had multiple people laugh at me when I mentioned this
> phrase in explaining our predicament to people.

Those people have no understanding of how this whole thing is developed,
that they rely on for their job, which is sad on so many other levels...

thanks,

greg k-h
