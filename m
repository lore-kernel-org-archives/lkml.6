Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7281CC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347AF2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347AF2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeJELzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 07:55:42 -0400
Received: from namei.org ([65.99.196.166]:35746 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbeJELzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 07:55:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id w954wDR7011060;
        Fri, 5 Oct 2018 04:58:13 GMT
Date:   Fri, 5 Oct 2018 14:58:13 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     John Johansen <john.johansen@canonical.com>,
        Jordan Glover <Golden_Miller83@protonmail.ch>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
In-Reply-To: <CAGXu5j+3HqqBa_ogQqGJYubeZr9uCrbKzEoKO3Or=71e4c_=Gw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1810051449110.2590@namei.org>
References: <20181002005505.6112-1-keescook@chromium.org> <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com> <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com> <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org> <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com> <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com> <alpine.LRH.2.21.1810040416500.13517@namei.org> <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org> <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com> <alpine.LRH.2.21.1810040723320.16168@namei.org> <CAGXu5jJDBhFrdCBHH4MZVDmG88mMxSaSx0w9anCcyx24YHLO5w@mail.gmail.com>
 <alpine.LRH.2.21.1810050338470.14095@namei.org> <CAGXu5j+3HqqBa_ogQqGJYubeZr9uCrbKzEoKO3Or=71e4c_=Gw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018, Kees Cook wrote:

> On Thu, Oct 4, 2018 at 10:49 AM, James Morris <jmorris@namei.org> wrote:
> > On Wed, 3 Oct 2018, Kees Cook wrote:
> >> Then someone boots the system with:
> >>
> >> selinux=1 security=selinux
> >>
> >> In what order does selinux get initialized relative to yama?
> >> (apparmor, flagged as a "legacy major", would have been disabled by
> >> the "security=" not matching it.)
> >
> > It doesn't, it needs to be specified in one place.
> >
> > Distros will need to update boot parameter handling for this kernel
> > onwards.  Otherwise, we will need to carry this confusing mess forward
> > forever.
> 
> Are you saying that you want to overrule Paul and Stephen about
> keeping "selinux=1 secuiryt=selinux" working?

Not overrule, but convince.

At least, deprecate selinux=1 and security=X, but not extend it any 
further.

> > In my most recent suggestion, there is no '!' disablement, just
> > enablement.  If an LSM is not listed in CONFIG_LSM="", it's not enabled.
> 
> And a user would need to specify ALL lsms on the "lsm=" line?
> 

Yes, the ones they want enabled.

> What do you think of my latest proposal? It could happily work all
> three ways: old boot params and security= work ("selinux=1
> security=selinux" keeps working), individual LSM enable/disable works
> ("lsm=+loadpin"), and full LSM ordering works
> ("lsm=each,lsm,in,order,here"):
> 
> https://lore.kernel.org/lkml/CAGXu5jJJit8bDNvgXaFkuvFPy7NWtJW2oRWFbG-6iWk0+A1qng@mail.gmail.com/
> 

I think having something like +yama will still lead to confusion.
Explicitly stating each enabled LSM in order is totally unambiguous.

If people are moving away from the distro defaults, and there is no 
high-level interface to manage this, it seems to me there's a deeper 
issue with the distro.


-- 
James Morris
<jmorris@namei.org>

