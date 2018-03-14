Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeCNPGa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:06:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:38631 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751402AbeCNPG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:06:29 -0400
Date: Wed, 14 Mar 2018 16:06:27 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, rdunlap@infradead.org,
        sfr@canb.auug.org.au
Subject: Re: + headers-untangle-kmemleakh-from-mmh-fix.patch added to -mm tree
Message-ID: <20180314150627.GL23100@dhcp22.suse.cz>
References: <20180306234907.8-AwjmNNh%akpm@linux-foundation.org>
 <20180314121704.GA23036@dhcp22.suse.cz>
 <20180314075055.353f2d975defb2af34f65d2b@linux-foundation.org>
 <20180314145724.GJ23100@dhcp22.suse.cz>
 <20180314080328.500c93123727a9528b5bfb8a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314080328.500c93123727a9528b5bfb8a@linux-foundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-03-18 08:03:28, Andrew Morton wrote:
> On Wed, 14 Mar 2018 15:57:24 +0100 Michal Hocko <mhocko@kernel.org> wrote:
> 
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> > > > index 6f9e4ce568cd..9bb0a7f2863e 100644
> > > > --- a/security/integrity/digsig.c
> > > > +++ b/security/integrity/digsig.c
> > > > @@ -18,6 +18,7 @@
> > > >  #include <linux/cred.h>
> > > >  #include <linux/key-type.h>
> > > >  #include <linux/digsig.h>
> > > > +#include <linux/vmalloc.h>
> > > >  #include <crypto/public_key.h>
> > > >  #include <keys/system_keyring.h>
> > > 
> > > hm, current linux-next.patch already has this change.  What happened here?
> > 
> > OK, I see. This is usuall inter tree mess. It didn't fly through your
> > tree:
> > commit 120f3b11ef88fc38ce1d0ff9c9a4b37860ad3140
> > Author: Randy Dunlap <rdunlap@infradead.org>
> > Date:   Mon Feb 12 17:26:20 2018 -0800
> > 
> >     integrity/security: fix digsig.c build error with header file
> >     
> >     security/integrity/digsig.c has build errors on some $ARCH due to a
> >     missing header file, so add it.
> >     
> >       security/integrity/digsig.c:146:2: error: implicit declaration of function 'vfree' [-Werror=implicit-function-declaration]
> >     
> >     Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> >     Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >     Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> >     Cc: linux-integrity@vger.kernel.org
> >     Link: http://kisskb.ellerman.id.au/kisskb/head/13396/
> >     Signed-off-by: James Morris <james.morris@microsoft.com>
> > 
> > And that is why I haven't noticed that.
> 
> I can jiggle things to prevent this, but the
> security/integrity/digsig.c fix is actually in mainline now so things
> should sort themselves out OK.

Sure, I have done essentially the same with in my mmotm git tree.
-- 
Michal Hocko
SUSE Labs
