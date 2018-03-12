Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-629743-1520868493-2-15048444635537982075
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
    t=1520868492; b=v+hklHoNslXAZCS19JmOoM1BKdo7sXS9vv+wjsnZMCkMhw0
    LbhZh8FJK0rgBzj7zsSQe/e5TY7FwFG4tC31pZhcO7WkJGpvZyJEXswqTJk2VdLG
    5Y/CQ/GH6Z916dgtkmkwakkP3Ar2KYfooZwW0FSgJ399Lu42d4bhdUWDLzXZIgCz
    1EU0KRud0madMhB+PhhWanl2sk4fpzpDkznrPzfpYsrFfRNr/hk0jux/2sXChbHb
    fCon3iA2zIOV62ecXh/sc8Cu27AZ0Ce3eyUbBTHYROu2JmTienwZr9mJ5PNot4YT
    64fzyPtNyMCEoUBdxrM8tckZli8tFHCwR55P+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520868492; bh=2G8OFbuIyxZvNnBVLHku+LydQm
    Q7zVh4QGEhGrvWjXU=; b=S4mVebXbNr5aECHjMBCjsz3g9Yv78oQbkhW6gImlvW
    vlIdNXRbey4Aqb2Ce/zFPWerOeWKAckWnUzi40fEKhb1yySlmeLEynTNB8mcfPla
    oOKYlgi1DF/8uaOkjnCve7v9m9S20JS4IJQS0WC6gCNXyq1i4oU5EWDo60luxMze
    wtiA/sQ5RhJuK42I3P9TPy+kRQPk2VC97oqSyOqR297uF8XjE5VuswyPwdDh9tw/
    LvVo48fQ54wnLZEw3CCIv8M2IqfpDITT9HdfytCU5Jw7tUTDEpl4p5P219l9n7qp
    mQshrgwUsO13JkS1YG0Qx75YpZCDHBDSPqA6+uiWjvvw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751431AbeCLP2L (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 11:28:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50488 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeCLP2K (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 11:28:10 -0400
Date: Mon, 12 Mar 2018 16:28:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Pavel Machek <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness
 setting when setting delay_off=0
Message-ID: <20180312152811.GB16944@kroah.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-65-alexander.levin@microsoft.com>
 <20180203203525.GA5860@amd>
 <20180204003029.2lkcmh6wvzpnlrls@sasha-lappy>
 <20180204090531.GA29468@amd>
 <20180204111500.GB14797@kroah.com>
 <20180204171736.GA1388@amd>
 <20180206020210.m6gl7vai4p6azb6s@sasha-lappy>
 <713113d8-7662-d80c-c62f-af020469d0bf@gmail.com>
 <f072a5c1-95f1-e81b-c629-ebdea723e6f4@universe-factory.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f072a5c1-95f1-e81b-c629-ebdea723e6f4@universe-factory.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 04:00:01PM +0100, Matthias Schiffer wrote:
> On 02/06/2018 09:44 PM, Jacek Anaszewski wrote:
> > On 02/06/2018 03:02 AM, Sasha Levin wrote:
> >> On Sun, Feb 04, 2018 at 06:17:36PM +0100, Pavel Machek wrote:
> >>>
> >>>>>>>> *** if brightness=0, led off
> >>>>>>>> *** else apply brightness if next timer <--- timer is stop, and will never apply new setting
> >>>>>>>> ** otherwise set led_set_brightness_nosleep
> >>>>>>>>
> >>>>>>>> To fix that, when we delete the timer, we should clear LED_BLINK_SW.
> >>>>>>>
> >>>>>>> Can you run the tests on the affected stable kernels? I have feeling
> >>>>>>> that the problem described might not be present there.
> >>>>>>
> >>>>>> Hm, I don't seem to have HW to test that out. Maybe someone else does?
> >>>>>
> >>>>> Why are you submitting patches you have no way to test?
> >>>>
> >>>> What?  This is stable tree backporting, why are you trying to make a
> >>>> requirement for something that we have never had before?
> >>>
> >>> I don't think random patches should be sent to stable just because
> >>> they appeared in mainline. Plus, I don't think I'm making new rules:
> >>>
> >>> submit-checklist.rst:
> >>>
> >>> 13) Has been build- and runtime tested with and without ``CONFIG_SMP``
> >>> and
> >>>    ``CONFIG_PREEMPT.``
> >>>
> >>> stable-kernel-rules.rst:
> >>>
> >>> Rules on what kind of patches are accepted, and which ones are not,
> >>> into the "-stable" tree:
> >>>
> >>> - It must be obviously correct and tested.
> >>> - It must fix a real bug that bothers people (not a, "This could be a
> >>>   problem..." type thing).
> >>
> >> So you're saying that this doesn't qualify as a bug?
> >>
> >>>> This is a backport of a patch that is already upstream.  If it doesn't
> >>>> belong in a stable tree, great, let us know that, saying why it is so.
> >>>
> >>> See jacek.anaszewski@gmail.com 's explanation.
> >>
> >> I might be missing something, but Jacek suggested I pull another patch
> >> before this one?
> > 
> > Just to clarify:
> > 
> > For 4.14 below patches are chosen correctly:
> > 
> > [PATCH AUTOSEL for 4.14 065/110] led: core: Fix brightness setting when
> > setting delay_off=0
> > [PATCH AUTOSEL for 4.14 094/110] leds: core: Fix regression caused by
> > commit 2b83ff96f51d
> > 
> > For 4.9 both above patches are needed preceded by:
> > 
> > eb1610b4c273 ("led: core: Fix blink_brightness setting race")
> > 
> > The issue the patch [PATCH AUTOSEL for 4.14 065/110] fixes was
> > introduced in 4.7, and thus it should be removed from the series
> > for 3.18 and 4.4.
> > 
> 
> It seems only "led: core: Fix brightness setting when setting delay_off=0"
> was applied to 4.9. Could we get the regression fixes backported to 4.9 as
> well?

What exact fixes were they?  I'll be glad to apply them if I have a git
commit id.

thanks,

greg k-h
