Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932586AbeCOPDy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:03:54 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:59446 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752725AbeCOPDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:03:21 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::::::::::,RULES_HIT:41:69:355:379:541:599:800:960:973:981:988:989:1042:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:3872:3873:3874:4321:5007:6742:7576:7903:9040:10004:10400:10848:10967:11026:11232:11658:11914:12043:12438:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30012:30054:30070:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: wren78_1cd6a2629cd26
X-Filterd-Recvd-Size: 2422
Message-ID: <1521126196.22221.10.camel@perches.com>
Subject: Re: [PATCH] powerpc: Use common error handling code in
 setup_new_fdt()
From: Joe Perches <joe@perches.com>
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>,
        Josh Sklar <sklar@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Thu, 15 Mar 2018 08:03:16 -0700
In-Reply-To: <20180315115753.rjejlkrp3fhdxbyk@mwanda>
References: <0dd9d938-8d89-f0e0-f05f-9a3e5dc42a57@users.sourceforge.net>
         <87fu52jqtc.fsf@morokweng.localdomain>
         <20180315115753.rjejlkrp3fhdxbyk@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-15 at 14:57 +0300, Dan Carpenter wrote:
> On Wed, Mar 14, 2018 at 06:22:07PM -0300, Thiago Jung Bauermann wrote:
> > 
> > SF Markus Elfring <elfring@users.sourceforge.net> writes:
> > 
> > > From: Markus Elfring <elfring@users.sourceforge.net>
> > > Date: Sun, 11 Mar 2018 09:03:42 +0100
> > > 
> > > Add a jump target so that a bit of exception handling can be better reused
> > > at the end of this function.
> > > 
> > > This issue was detected by using the Coccinelle software.
> > > 
> > > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > > ---
> > >  arch/powerpc/kernel/machine_kexec_file_64.c | 28 ++++++++++++----------------
> > >  1 file changed, 12 insertions(+), 16 deletions(-)
> > 
> > I liked it. Thanks!
> > 
> > Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> > 
> 
> You know that compilers already re-use string constants so this doesn't
> actually save memory?

And modern compilers create their own jump labels
so this doesn't change object code either?
