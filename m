Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbeCIJhG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:37:06 -0500
Received: from smtprelay0226.hostedemail.com ([216.40.44.226]:44600 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750883AbeCIJhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:37:05 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3870:3871:3872:3874:4321:4605:5007:6119:7576:7903:9121:10004:10400:10848:11026:11232:11657:11658:11914:12043:12296:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:30012:30054:30060:30065:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: spoon03_206a9170b4c39
X-Filterd-Recvd-Size: 3125
Message-ID: <1520588221.11634.26.camel@perches.com>
Subject: Re: [PATCH 12/12] efi: make const array 'apple' static
From: Joe Perches <joe@perches.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Fri, 09 Mar 2018 01:37:01 -0800
In-Reply-To: <CAKv+Gu-h9pZLxf6tp++UDy4LCjSu-3uUQDRFS3=HcTjnBdZ2Vg@mail.gmail.com>
References: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
         <20180308080020.22828-13-ard.biesheuvel@linaro.org>
         <1520507105.11634.5.camel@perches.com>
         <CAKv+Gu8iMvzvSP9-YPe+ms4qVMjcQqNQ25Wa16JW_tEG7P+jtQ@mail.gmail.com>
         <CAKv+Gu-h9pZLxf6tp++UDy4LCjSu-3uUQDRFS3=HcTjnBdZ2Vg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-09 at 07:44 +0000, Ard Biesheuvel wrote:
> On 9 March 2018 at 07:43, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 8 March 2018 at 11:05, Joe Perches <joe@perches.com> wrote:
> > > On Thu, 2018-03-08 at 08:00 +0000, Ard Biesheuvel wrote:
> > > > From: Colin Ian King <colin.king@canonical.com>
> > > > 
> > > > Don't populate the const read-only array 'buf' on the stack but instead
> > > > make it static. Makes the object code smaller by 64 bytes:
> > > > 
> > > > Before:
> > > >    text          data     bss     dec     hex filename
> > > >    9264             1      16    9281    2441 arch/x86/boot/compressed/eboot.o
> > > > 
> > > > After:
> > > >    text          data     bss     dec     hex filename
> > > >    9200             1      16    9217    2401 arch/x86/boot/compressed/eboot.o
> > > > 
> > > > (gcc version 7.2.0 x86_64)
> > > > 
> > > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > > ---
> > > >  arch/x86/boot/compressed/eboot.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> > > > index 886a9115af62..f2251c1c9853 100644
> > > > --- a/arch/x86/boot/compressed/eboot.c
> > > > +++ b/arch/x86/boot/compressed/eboot.c
> > > > @@ -423,7 +423,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
> > > > 
> > > >  static void setup_quirks(struct boot_params *boot_params)
> > > >  {
> > > > -     efi_char16_t const apple[] = { 'A', 'p', 'p', 'l', 'e', 0 };
> > > > +     static efi_char16_t const apple[] = { 'A', 'p', 'p', 'l', 'e', 0 };
> > > 
> > > Perhaps
> > > 
> > > static const efi_char16_t apple[] ...
> > > 
> > > is better.
> > > 
> > 
> > Why would that be any better?

It'd be more like the the style used
in the rest of the kernel.
