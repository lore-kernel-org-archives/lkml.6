Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-937802-1519846806-2-16806313607212850901
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519846805; b=N/TkF/kNNMI72svalSOOkZiMqEXBJhJl+/rblL1YUv4q3Pi
    mu4p5PP/vav5JsVJDEYdCcg5XnkwcGtD3mlUlkm9lEI9GMXKlSyhXni6BOdV07dd
    sLsa7LxRQXiOiZypxTQ/WtVlS+hpgOwyCdhbPnjSOuV3W6Wkmhzk2uo+yAfbsRr5
    /KN669tSdKFQXeg+SWfG49plM6doeoxKRiZ6tzDRVmBSxowc6qAmxnYdF/2Uhhf0
    Lb0Da2RnKVn2amH1kGQqT9YYkGtZ7Pok5BPdeVuND5/dlsJSf37jI0b/fUvFTqi6
    6lEMh68Gj1TBkhH70Ty084rh8seZgQQQTdQ+wsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519846805; bh=dRCApAmiZS8IdqkSTMTpLdX1HyXrhEsyzJ7qEh
    8REWU=; b=Hf22dWCib7yspmuxAWW82JQBj4fByP9K/UmkdMzaYm1//rGzR3EtMA
    BgmknIE5UzJ26O8+MOz9WEWyczOS5ID7cwCfEkjkfqb9SXuiEZqUebEVWG7durgb
    1LgumNEpTbsI3PR2hmzQu2tsk/Tl+4QcQM1cUnTMSkb3UC7VUd0m+gty9PF6fCkT
    8S2PEHTwzLA+uACM4dZpxDwEOJGrGhUqjrsCRDMwqkI+lp6lf19NGIhS48AJP4bs
    BWdJfzqCOn61387UKDiGSzyXjhR/rA65L/kGv+EBxvQsIOaxgt7vi8r1Nuu8iRfe
    AAkmvjX50Etzw08ozATo8wU8I94OUKeg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=jXWZE4BD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bhwavtjg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=jXWZE4BD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bhwavtjg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933025AbeB1TkC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 14:40:02 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35881 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933624AbeB1TkB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 14:40:01 -0500
X-Google-Smtp-Source: AH8x227zrhmfAIKQQGvohs6H6Q5tIYuBuGKpEyKeo8d1Ow7LJ+D3YOye/x0parbMdNX8NGmh5SnmrA==
MIME-Version: 1.0
In-Reply-To: <20180217152459.GA22308@kroah.com>
References: <20180215151222.267507937@linuxfoundation.org> <20180215151235.620152736@linuxfoundation.org>
 <20180216023147.GB69988@rodete-desktop-imager.corp.google.com>
 <20180216064850.GA26224@kroah.com> <20180216181043.GA84497@rodete-desktop-imager.corp.google.com>
 <20180216185220.GA29352@roeck-us.net> <20180217134351.GB28145@kroah.com>
 <befd1dc3-32ee-bd00-876e-a59397cffd37@roeck-us.net> <20180217152459.GA22308@kroah.com>
From: Brian Norris <briannorris@chromium.org>
Date: Wed, 28 Feb 2018 11:39:56 -0800
X-Gmail-Original-Message-ID: <CA+ASDXMvsgOUkxyYuMNqNduNJR5k-jWHynfXvpEdTLGPZyD=TA@mail.gmail.com>
Message-ID: <CA+ASDXMvsgOUkxyYuMNqNduNJR5k-jWHynfXvpEdTLGPZyD=TA@mail.gmail.com>
Subject: Re: [PATCH 4.4 095/108] Bluetooth: btusb: Restore QCA Rome
 suspend/resume fix with a "rewritten" version
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On Sat, Feb 17, 2018 at 7:24 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Feb 17, 2018 at 07:12:17AM -0800, Guenter Roeck wrote:
>> On 02/17/2018 05:43 AM, Greg Kroah-Hartman wrote:
>> > On Fri, Feb 16, 2018 at 10:52:20AM -0800, Guenter Roeck wrote:
>> > > On Fri, Feb 16, 2018 at 10:10:44AM -0800, Brian Norris wrote:
>> > > > On Fri, Feb 16, 2018 at 07:48:50AM +0100, Greg Kroah-Hartman wrote:
>> > > > > On Thu, Feb 15, 2018 at 06:31:48PM -0800, Brian Norris wrote:
>> > > > > > On Thu, Feb 15, 2018 at 04:17:32PM +0100, Greg Kroah-Hartman wrote:
>> > > > > > > 4.4-stable review patch.  If anyone has any objections, please let me know.
>> > > > > >
>> > > > > > Consider this an objection:
>> > > > > >
>> > > > > > I'm currently arguing that this is unnecessarily regressing power
>> > > > > > consumption here:
>> > > > > >
>> > > > > > https://patchwork.kernel.org/patch/10149195/
>> > > > > >
>> > > > > > I'll leave it up to you what to do with this, but if this ends up in
>> > > > > > Chromium OS kernels, I'm likely to revert it there...
...
>> > Thanks, but I've now released all of these with this patch committed, so
>> > we are now "bug compatible" :)

So, is that to say that the boilerplate above about objections is
meaningless? This is the second time that this same "feature" has been
pushed (degrading the quality of my systems) despite my objections,
under the banner of "bug compatibility" [1]. The first attempt to
revert was back around Dec 20 of last year, but I see that there were
10 "stable" 4.4 kernels released in the meantime [2] where that
original bug was still present. (Commit fd865802c66b "Bluetooth:
btusb: fix QCA Rome suspend/resume" was proven undeniably buggy.)

Next: we see this current valiant attempt at a less buggy fix, by
Hans. It's an OK solution, but it still wastes power for me. I
objected above, but instead of delaying applying it, you applied it in
the same release as you finally fixed the original crap (v4.4.116). So
all-in-all, my system (if using 4.4.x directly) hasn't had decent
Bluetooth since v4.4.99.

At least things are still moving forward here, and maybe in another
month, I can expect a v4.4.x stable kernel that works well. But the
hilarious current state of things is that we're basically going back
to a no-op for the time being:

https://marc.info/?l=linux-bluetooth&m=151981547905651&w=2
https://marc.info/?l=linux-bluetooth&m=151981548105654&w=2
[PATCH] Bluetooth: btusb: Remove Yoga 920 from the
btusb_needs_reset_resume_table

(I know others are looking at properly identifying a DMI match list
still, so this won't stay a no-op.)

>> FWIW, seems to me that trying to be "bug compatible" with -rc1 upstream
>> kernels may not really be a good idea for stable releases.

I couldn't agree more.

> It's a tough trade-off.  If I dropped this patch, the normal mode of
> operation would be for it to get merged into device kernels and then
> forgotten about.  Only if/when the user with the problem moves to a
> newer release a long time later would the regression normally appear
> again, and everyone would have to remember what happened and try to
> piece it all together again as to what commit caused the issue.

Note that I didn't suggest we have to completely drop the patch. And I
also don't suspect you need to delay all -rc1 bugfixes. I'd just
suggest delaying the patch for a few weeks, when there are objections
raised. (Or, reverting and scheduling to re-queue in a few weeks if no
progress...or something like that.) Is that not something that could
work, in order to keep "stable" releases *actually* stable? In most
software release processes, buggy patches are reverted as quickly as
possible while alternatives are worked out. Not all fixes are security
fixes that need to be out the door as soon as they see the light of
day...

> By you adding the revert to your device kernel now, you have a record of
> this being a problem, how upstream isn't fixing the issue, and when/if
> you do move to a newer kernel, that bugfix will still be there in your
> patch stack to forward port.

So, you rely entirely on device kernels to manage the pain that your
release process causes? We're actively trying to stay much closer to
upstream these days, and would essentially like to eliminate the
concept of "device" kernels, at least for Chrom{e,ium} OS, if
possible. But it's crap like this that proves that we can't.

> Yeah, you all are normally better than that, and I trust that you will
> push to get this resolved, hopefully soon.  But for the most part, this
> method works best overall for the majority of the cases like this as not
> all bug reporters are persistent, and if not, the maintainer usually
> forgets about it as no one is saying anything and they have other things
> to work on.
>
> Well, bluetooth is known to not have responsive maintainers, so who am I
> kidding here, odds are it's only going to get fixed as Hans is
> involved, despite the bluetooth maintainers :)

You can't pin this completely on the bluetooth maintainers. *You*
maintain the -stable trees, yet you effectively ignored both of my
objections, forcing me to rely on said original maintainers to queue
up alternatives. Yes, yes, I know the "forcing me [and/or Hans] to
work" is basically working as intended for you, but the hard facts
show that *your* release was broken for far too long.

Brian

[1] BTW, I've had multiple people laugh at me when I mentioned this
phrase in explaining our predicament to people.
[2] v4.4.108 to v4.4.116
