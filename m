Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2543453-1524554814-2-18365420997366447341
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524554813; b=VvvNZ8rcWdK5R4CpxYavnNEGS8Mq7LAaI8BhMYsAthe44ZhID3
    1j+NiW0R0rjijPhkORFtbrEGdX1egg5AIAQMTH1K+GPlJoJsrJGsjnBZyD9iuSnx
    awUaJgY8PXp7Hz6WMCFZA3B2GpL27NzQzQdmYjo7Oiyqc1WrKKcyO+ccxRDSYOES
    ky9s0AWEUVPTMOk5OW/0WNwfNKAhFaPPRZl+k/NfVL1+Upo/d3UcZj5KQe3CTT3X
    nGKYapjwI/oBzjmqL6JcPwC/Q5mEKdlZNMY0XEKZdP1/cVffJVstKh1xub1o/FKJ
    Oo+69iWEMYIjX6/XajJ9pbwN5a6ZiTAbHnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524554813; bh=CaMcSGZGVXr
    rJ2MkwrQtGSMFlY4a6fQ6GAfcjDKF0lU=; b=GKKZjJccqx536Hb/wgBExaao8xp
    obMKTXwxbpP8RzKEEBMMumyJFUQxfXM2WZ8vXtutAaQ6JninE8y1VBAhRbEUGjI5
    RcR/5XKBN4/gpWt+nxN37NGul7N7Qq9xnfanPcRbAfzrAC3MRZj0l/3u1llVON12
    6OphrA9owvT2La6BbJz8WwA//IwN2YWVeeyobF9B29h63n4WGWsznSzBmr96IWre
    63ewRMgcbAp8xdmdwvQo92cZNdYyFgo9cqHCfMy4aA1O1wAI3QQRA9epVHWEA583
    e8LGykNiFj5dDT3fpvAY52XMbYPCsKAb5oXwacorZ7sAwfwwZm67yxaUF7g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL3txOY3bMRkVnVMJlhYPs04Naf4/PPO9TM/BNmDozf5z5+9JIVbig4CMOViR60bMHmJ+JmlyqAM+0bb8FmNVn/thTtwfPBFwgJJ8hFenT3+lRTvFcEL
    9qSOwVIpeSSHk3gG78JnywogaKjq+c7BluXMe5/GjmWBFwm7exzmhaFChWDmxXngCGIbD/yPseOW7znImsWVQ7o+tKnmMIFC7xFaHv46x62FEe1wAF+BAs11
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=RMlRvZAwo0AA:10
    a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=f5Lq38d1z1ojJbnHYTYA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756434AbeDXH0u (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 03:26:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39398 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756429AbeDXH0q (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Apr 2018 03:26:46 -0400
Date: Tue, 24 Apr 2018 09:26:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, tytso@mit.edu
Subject: Re: [PATCH 4.9 00/95] 4.9.96-stable review
Message-ID: <20180424072635.GD18419@kroah.com>
References: <20180422135210.432103639@linuxfoundation.org>
 <CA+G9fYt_OKQOx7xFPsbgj8+vXDJGR0Oc3XWJ8iQfMM=UkFVAeQ@mail.gmail.com>
 <20180423165750.GA27986@kroah.com>
 <20180423180137.GA26974@kroah.com>
 <20180423222553.lbxx3cwly2fbvabs@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180423222553.lbxx3cwly2fbvabs@xps>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 05:25:53PM -0500, Dan Rue wrote:
> On Mon, Apr 23, 2018 at 08:01:37PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 23, 2018 at 06:57:50PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Apr 23, 2018 at 10:23:49PM +0530, Naresh Kamboju wrote:
> > > > On 22 April 2018 at 19:22, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > This is the start of the stable review cycle for the 4.9.96 release.
> > > > > There are 95 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Tue Apr 24 13:51:53 UTC 2018.
> > > > > Anything received after that time might be too late.
> > > > >
> > > > > The whole patch series can be found in one patch at:
> > > > >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.96-rc1.gz
> > > > > or in the git tree and branch at:
> > > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > > > > and the diffstat can be found below.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > > 
> > > > Regression detected on arm64 devices Hikey and Juno.
> > > > 
> > > > Here is the list of bad commit patches to be reverted.
> > > > git bisect found first bad commit as "3"
> > > > but reverting 3 patch failed.
> > > > so i have to revert all four patches and boot test and the boot PASS on hikey.
> > > > 
> > > > 1)
> > > > Theodore Ts'o <tytso@mit.edu>
> > > >     random: add new ioctl RNDRESEEDCRNG
> > > > 2)
> > > > Theodore Ts'o <tytso@mit.edu>
> > > >     random: crng_reseed() should lock the crng instance that it is modifying
> > > > 3)
> > > > Theodore Ts'o <tytso@mit.edu>
> > > >     random: set up the NUMA crng instances after the CRNG is fully initialized
> > > 
> > > This is the one I need to revert anyway.
> > > 
> > > Let me see if I can just drop that one and do a -rc3.  Give me a few
> > > hours...
> > 
> > Ok, I've dropped just patch 3 from 4.16.y, 4.14.y and 4.9.y and pushed
> > out -rc3 versions of all of these.  Let me know if that works or not for
> > you.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Great!

> I made a few comments inline regarding the reported failures. Also, as
> this report is pushing 200 lines now with all of our tests and
> environments (about 8*22 test runs), I'm planning on making some changes
> in the next few weeks to make it more concise and useful. Any
> suggestions or feature requests are most welcome.

How about only reporting problems?  Having tests "pass" is the norm and
should always happen, right?  That would make the reports smaller.

thanks,

greg k-h
