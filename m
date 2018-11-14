Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705F5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C582175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 20:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C582175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbeKOGka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 01:40:30 -0500
Received: from mout.gmx.net ([212.227.15.19]:42501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725756AbeKOGka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 01:40:30 -0500
Received: from dhcp-41-57.bos.redhat.com ([66.187.233.206]) by mail.gmx.com
 (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0M3j17-1fWRGI3a9R-00rD6X; Wed, 14 Nov 2018 21:35:28 +0100
Message-ID: <1542227722.12945.39.camel@gmx.us>
Subject: Re: WARNING: CPU: 26 PID: 64391 at lib/vsprintf.c:2193
 set_precision+0x84/0x90
From:   Qian Cai <cai@gmx.us>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Date:   Wed, 14 Nov 2018 15:35:22 -0500
In-Reply-To: <20181113142317.379dbaf7@vmware.local.home>
References: <1542128132.12945.19.camel@gmx.us>
         <20181113172920.GI10650@smile.fi.intel.com>
         <1542135498.12945.20.camel@gmx.us>
         <20181113142317.379dbaf7@vmware.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UbqCwO1j2USZq3zil76Xg5dhkrJIAmE5el9Cn59Oi7wkiWLJ9Or
 c52xJhmJdN72XmIOJDfc4UmJ/QSrsd5/duJJ4fHtssi+fKYIw66CCWeJWKeb+389qoJFHYa
 i9XMoVqeYhg3W+JuMhYg3HYzpqmvsOVn/0lXkr9YShQmOTrDqYe1Ke0U6Vjui4BqH3Jg92d
 /QTrGsfSwVeKplDCXWDrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UgQgye/yRI0=:25ItMZjWjQeZp/OQJuCpri
 X3puWRxxyJCZZ65AkbztopJYR9oF4I3M8S9EmuF8tWh1eVge8QA/qZyxlQ/m9QzKEkcVfeAfQ
 bhuFqcw6VZ9RUCEhs5dHZ6KDwMhqUUTuHbbMddPaR/ECoVRy6V3+BDy0kcN1RsdhBgKEPRg5p
 7d+EjpbLd2ijUtG/jznbnOozJ6C10EZN2Q+6wTaoeqF6IfLstvN0u4zWffmwbyZs5kGfr0dbW
 Z94N0K19A1qLrOnHFRXrPfAkADbAONn1FCxY7vwCppiBosfhonFfh7sDk+ugyJXU9R/VtBMB0
 0RJ4YnKpXYx+WY/Iu+y6eAX/mIT1Iddg1uiwreeRSkfTwAgoHZDTW4clMGMaHDOlBUbOCi4LR
 jeKzdbN7da9Kj8gnsSyvmu3veaj5HN8ybYYpV+z1ViTnm7xD9whAQ/LbxhVUy2vtY8fKUh9zZ
 X+G4UiMyIdv+pzbTmFSi+IS/u0Fzqiozehabd+ENZknBGp8JO7pjM1C9YgCsMEk9kwK+t/QyL
 DmvyPdJtSKHbzq3TWap9EV10IgdScyWtjHGrRuCKSWBz1MUSTcb4ALVOTfkYC3XkpQrTNneAI
 KDojz1iZuOCsml27PobsO6dtfizf2E+Dlwb9J0xhE1jHFLl//8weyKEklgXusUlyKfKAUIVpE
 Qq9Mv0n7TbyiioXholviD4lt9D3el2hq4/ZFtpaE991z/UgbIZaPzyKneA2yE6Gue1Cyvu+3S
 rXDR9glZfalFQvnOwDkvtSv+aYjcP5PZKIvzwZf7DeFtF05Wya56GgARok3OLmICAs6zGzAOw
 mXjkniwxcjt+oPnT3SHT/AAjzBGWIQo+9kSE6sZbTCDHzhpcUASM1b6IFtSPivF/jrwJszVF8
 eeqwL+kOTcY57gThyG9ZR/D0Q6TIRDYCaETspCtSrd9cKDRBEBJyDgSkGGibC/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-11-13 at 14:23 -0500, Steven Rostedt wrote:
> On Tue, 13 Nov 2018 13:58:18 -0500
> Qian Cai <cai@gmx.us> wrote:
> 
> > > Care to print the len and name parameters before this line?  
> > 
> > len = 60612; name =
> 
> How big are pages on arm64? Because we shouldn't get to this path if
# getconf PAGESIZE
65536
> the string is bigger than PAGE_SIZE. But I know that on PPC64,
> PAGE_SIZE can be 64K, and 60612 is less than that. Thus, if we get
> there, the test is against signed int:16 (16 bit signed integer) that
> can go up to most 32768. If the string size is bigger than that, you
> would get this error.
> 
> I would just say to ignore it. The only thing that can happen if
> someone does this is to trigger the warning. Unless if it is considered
> a form of DOS, where userspace just bombards the console by triggering
> this waring. But I don't see a problem with the actual design. There's
> no reason we should be processing string variables bigger than 32768 in
> vsprintf.
> 
> -- Steve
> 
> 
> > %d%d%d%d%d%d%s%s%s%d%s%d%d%d%s%s%s%s%s%d%s%d%s%s%s%d%s%d%d%s%s%d%s%s%d%d%s%s
> > %s%s
> > %s%d%s%d%d%s%s%s%d%d%d%d%d%s%s%s%s%d%s%s%s%s%d%d%d%d%d%d%d%s%s%s%s%d%s%d%s%d
> > %s%d
> > %s%s%d%s%d%s%s%s%s%d%s%d%s%s%d%d%s%s%d%s%d%s%s%d%s%d%d%s%s%s%s%d%s%s%s%s%d%d
> > %s%s
> > %s%d%s%d%s%s%d%d%d%d%d%s%s%s%s%s%s%s%d%d%d%s%d%s%d%d%s%d%d%d%s%s%d%d%d%s%s%d
> > %s%d
> > %s%s%s%d%d%d%s%d%s%s%d%s%d%s%s%d%s%d%d%s%d%s%s%d%s%s%s%s%s%d%s%d%d%d%s%d%d%d
> > %d%s
> > %d%s%d%d%d%s%s%s%s%s%d%s%s%s%s%d%d%d%s%d%s%d%d%s%d%s%s%d%d%d%s%d%s%d%d%s%s%s
> > %d%s
> > %s%d%d%d%d%d%d%d%d%d%d%s%d%s%d%s%d%d%s%d%d%s%d%s%s%s%d%d%d%d%s%s%d%d%s%d%d%d
> > %s%d
> > %d%s%d%d%d%d%s%s%d%s%s%d%d%d%s%s%s%s%s%s%s%s%s%d%s%d%d%s%d%s%s%d%s%s%s%s%d%d
> > %d%d
> > %s%d%s%s%d%d%d%s%d%d%d%s%s%s%s%d%d%d%s%d%s%d%s%d%d%d%d%d%d%d%d%d%d%s%s%d%d%d
> > %s%d
> > %d%d%s%s%s%s%s%s%s%d%d%d%d%s%s%d%s%s%d%s%s%s%s%d%d%s%d%d%s%d%d%s%d%d%d%s%s%s
> > %s%d
> > %s%s%d%s%d%s%d%s%d%d%d%d%s%d%d%d%s%d%d%d%d%s%s%d%s%s%d%d%d%s%d%s%d%d%d%d%d%d
> > %s%d
> > %s%s%d%d%s%d%d%d%s%s%d%s%d%s%d%s%d%d%s%d%s%s%s%s%s%d%s%s%d%d%d%s%s%d%d%s%s%d
> > %s%d
> > %s%d%s%s%s%
> > [  833.044728] ------------[ cut here ]------------
> > [  833.137184] precision 60612 too large
> > > 
