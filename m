Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1914214-1518457203-2-17668035622478185238
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518457202; b=jyGluv7RMQgN88lKF8aEas3Bblj7tjkOWvvjRDkr/O2jiEt
    C/MjVPwO58DESDgVwhBJdiYk1VT+zovcHOOtvwFDL7ihlpqUlNDvdkkk7nXx59D2
    IBGlJ98A5pkS43ETq3mpmyk/J01Z7U60pi3q1vYF707QCWDSG7NNdftnLdg2zYPi
    KZI5PRYIDdiyvxI71uGjCA2zmLJNuczXPxtfBjjZgUWr5WH2XV9aUH3cvl2VxB7S
    TvI3bJtlJRDcgDpXjQX0FADOen+AofM3Ov2qXS1rrsRWJNAAFLhmoXrS+vBKfLoU
    RuBKrPrXTf5Jb3CPgLhZnNspbavy5L0dw9gL6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518457202; bh=xszDX/N7euzRbzybxW9FMVOnSR
    Z02oXX7b1BPlub7cs=; b=HFizoIDAaNr2uDO0jmGj50YVntQ3lCuEPRbwZUFiOu
    q5xM0wIzymnt353oppOu0t0+5d6fO4xvJZnD1wkFSbM5K9+lqHMxPvaDFvRWuDJW
    9LfV0EbiG87/fOGzum8feIr+hqC5sfD1rJVV7RyFfxmr7diGyB2pz2CwypbyuuVz
    v1e2Fa1NphKkUSc1MbAC/lRjyRqyynAzmuLKnwY0nTxlvLv25W6O1GzJ8JkjDD1s
    LjVVAaSNHmC0LNlHRewI/tF5KrUe9uOo285UsNIdJg96cGIETiuVj5U27UMMKGU/
    xVLRKVd2EBgAz32EBIDg92ZHZbvIS4L6nfBAuxpctNHA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=stgolabs.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeBLRj7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 12:39:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:60212 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751063AbeBLRj6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 12 Feb 2018 12:39:58 -0500
Date: Mon, 12 Feb 2018 09:30:37 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Waychison <mikew@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: shmctl(SHM_STAT) vs. /proc/sysvipc/shm permissions discrepancies
Message-ID: <20180212173037.oruxafinai5tkv6t@linux-n805>
Mail-Followup-To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Waychison <mikew@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20171219094848.GE2787@dhcp22.suse.cz>
 <CAKgNAkjJrmCFY-h2oqKS3zM_D+Csx-17A27mh08WKahyOVzrgQ@mail.gmail.com>
 <20171220092025.GD4831@dhcp22.suse.cz>
 <CAKgNAkisD7zDRoqJd6Gk1JMCZ8+Huj5QPV04nh2JXHMA+_R0-A@mail.gmail.com>
 <20171221080203.GZ4831@dhcp22.suse.cz>
 <CAKgNAkjSF9fXhKCxPMp92zftA4Qtq91WBt8L5UR50oQO8HgRxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKgNAkjSF9fXhKCxPMp92zftA4Qtq91WBt8L5UR50oQO8HgRxw@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 21 Dec 2017, Michael Kerrisk (man-pages) wrote:

>Hi Michal,
>
>On 21 December 2017 at 09:02, Michal Hocko <mhocko@kernel.org> wrote:
>> On Wed 20-12-17 17:17:46, Michael Kerrisk wrote:
>>> Hello Michal,
>>>
>>> On 20 December 2017 at 10:20, Michal Hocko <mhocko@kernel.org> wrote:
>>> > On Tue 19-12-17 17:45:40, Michael Kerrisk wrote:
>>> >> But, is
>>> >> there a pressing reason to make the change? (Okay, I guess iterating
>>> >> using *_STAT is nicer than parsing /proc/sysvipc/*.)
>>> >
>>> > The reporter of this issue claims that "Reading /proc/sysvipc/shm is way
>>> > slower than executing the system call." I haven't checked that but I can
>>> > imagine that /proc/sysvipc/shm can take quite some time when there are
>>> > _many_ segments registered.
>>>
>>> Yes, that makes sense.
>>>
>>> > So they would like to use the syscall but
>>> > the interacting parties do not have compatible permissions.
>>>
>>> So, I don't think there is any security issue, since the same info is
>>> available in /proc/sysvipc/*.
>>
>> Well, I am not sure this is a valid argument (maybe I just misread your
>> statement).
>
>(Or perhaps I was not clear enough; see below)
>
>> Our security model _might_ be broken because of the sysipc
>> proc interface existance already. I am not saying it is broken because
>> I cannot see an attack vector based solely on the metadata information
>> knowledge. An attacker still cannot see/modify the real data. But maybe
>> there are some bugs lurking there and knowing the metadata might help to
>> exploit them. I dunno.
>>
>> You are certainly right that modifying/adding STAT flag to comply with
>> the proc interface permission model will not make the system any more
>> vulnerable, though.
>
>Yep, that was my point. Modifying _STAT behavior won't decrease security.
>
>That said, /proc/sysvipc/* has been around for a long time now, and
>nothing bad seems to have happened so far, AFAIK.
>
>>> The only question would be whether
>>> change in the *_STAT behavior might surprise some applications into
>>> behaving differently. I presume the chances of that are low, but if it
>>> was a concert, one could add new shmctl/msgctl/semctl *_STAT_ALL (or
>>> some such) operations that have the desired behavior.
>>
>> I would lean towards _STAT_ALL because this is Linux specific behavior
>> (I have looked at what BSD does here and they are checking permissions
>> for STAT as well). It would also be simpler to revert if we ever find
>> that this is a leak with security consequences.

So I took a crack at this, and my only doubt is whether or not the lsm
security hooks should be considered or not. Specifically, should the
SHM_STAT_ALL case consider security_shm_shmctl()?

While the relevant persmission checks that allow for the discripancies
between 0444 procfs and a 0600 via creating the ipc object are done in
ipcperms() returning -1, is there a scenario where some lsm policy could
change the /proc/sysvipc/ interface? If not, I think we can avoid it, but
I'm not a security person.

Thanks,
Davidlohr

>
>Oh -- I was unaware of this BSD behavior. At least on the various UNIX
>systems that I ever used SYSVIPC (including one or two ancient
>commercial BSD derivatives), ipcs(1) showed all IPC objects. (On
>FeeBSD, at least, it looks like ipcs(1) doesn't use the *_STAT
>interfaces.)
>
>Cheers,
>
>Michael
>
>
>
>-- 
>Michael Kerrisk
>Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
>Linux/UNIX System Programming Training: http://man7.org/training/
