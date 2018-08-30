Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3168C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E68B20837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTyeCRuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E68B20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeHaBjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:39:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52834 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeHaBjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:39:40 -0400
Received: by mail-wm0-f67.google.com with SMTP id y139-v6so3300186wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oX49PoSjiNLV6aev76S5msVEqsgo4EoYV1fqYZdBu8g=;
        b=rTyeCRuPuFGkQwaDLJN+y0seP2pAG7cLB6FsgH4PuIpPKVWpwvYZOND50OU0YaIboU
         XSsWkQTRIPKau45y0IRFv0cm3H29nqACrGSC26gyacM9hSp5EecWyPwV6pV9SvedM6X7
         S2jy56Mc6/4gC+THzQo7qfWC0/JiPZEzY3ou1jzQngqBnYZqtNYoztS3JeknvucFAE+t
         rg8DKzFjwt8/zTmUwaZW7JP4ySSpAsUlcDGSNfA/8N1f7Ov1sS2q1Lxha93mz3gICzw9
         rT9IF5RbwDi7WjSf+nLsNjwkFlRu7nUr7yCpZ/hEPs1cCRgGNKBCZKpGEJfRzxCQjW3t
         54Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oX49PoSjiNLV6aev76S5msVEqsgo4EoYV1fqYZdBu8g=;
        b=pwJQPxdBa45xIsqm9I2kEDEOZ8XwJLE+yV+mX9wcDv7eSRuZ1Mqtg3X7bXcwVEv+Eo
         Nwg/e2OD3CRJa52zjb6aN0kU791qn1NV+4yw7oCvO9+YEB9aarZ/g/aiMxj0M1hcfVqq
         XHwK0x8Tdbyzu5iXMhdevI7Fu1es1MDxZTwYb2MBE10B2HkuWpkc7J6UxnHASKEPUeIw
         BLtwYHRZZwWkyGINt/zpJN0XqTQjQpVVMs7O5emGglhycoSxROwZqXgxMIScSKTQaEFG
         eKupxWRLaGh2uAHoEcxbv0CoIa41tmp6hB+uyhDe/szuJv5/dP1dMDqhVuMvRNWI1lHd
         fP+Q==
X-Gm-Message-State: APzg51DzqbyLnw7sr1epSqZJQd59+XDjxrQPfIXbucR014mnbAEheTGi
        cfPF4t9qDc3G8YeeORmqINE=
X-Google-Smtp-Source: ANB0VdYgUxABUseEnRKf4nOzQSUfaMcJWHYzrTERzPXw5shFUT3pn0n8BGKDG9HnVZ1TmB8GQ+cL8Q==
X-Received: by 2002:a1c:7305:: with SMTP id d5-v6mr2938995wmb.53.1535664928880;
        Thu, 30 Aug 2018 14:35:28 -0700 (PDT)
Received: from xux707-tw (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id h73-v6sm7407359wma.11.2018.08.30.14.35.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 14:35:28 -0700 (PDT)
Date:   Thu, 30 Aug 2018 22:35:37 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/21] staging:rtl8192u: Rename AdvCoding - Style
Message-ID: <20180830213536.GA2904@xux707-tw>
References: <20180829203547.15650-1-johnfwhitmore@gmail.com>
 <20180829203547.15650-2-johnfwhitmore@gmail.com>
 <20180830082305.umqtq3fdexlyvn65@mwanda>
 <20180830082628.ff5x3tzvd2wdrbir@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830082628.ff5x3tzvd2wdrbir@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:26:28AM +0300, Dan Carpenter wrote:
> On Thu, Aug 30, 2018 at 11:23:05AM +0300, Dan Carpenter wrote:
> > On Wed, Aug 29, 2018 at 09:35:27PM +0100, John Whitmore wrote:
> > > Rename the bit field element AdvCoding, as it causes a checkpatch issue
> > > with CamelCase naming. As the element is not actually used in code it
> > > has been renamed to 'not_used_adv_coding'.
> > > 
> > > The single line of code which initialises the bit has been removed,
> > > as the  field is unused.
> > > 
> > > This is a purely coding style change which should have no impact
> > > on runtime code execution.
> > > 
> > > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > > ---
> > >  drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h     | 2 +-
> > >  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 1 -
> > >  2 files changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > > index 64d5359cf7e2..66a0274077d3 100644
> > > --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > > +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
> > > @@ -39,7 +39,7 @@ enum ht_extension_chan_offset {
> > >  
> > >  struct ht_capability_ele {
> > >  	//HT capability info
> > > -	u8	AdvCoding:1;
> > > +	u8	not_used_adv_coding:1;
> > 
> > I can't review any more of this patchset when this is the first line...
> > 
> 
> That email wasn't very clear.  If you think some of your patches are
> going to be more controversial than others, put them at the very end so
> we can at least apply part of the patchset.
> 
> regards,
> dan carpenter
> 

Thanks for the clarification, I needed it ;)

I'm not sure I consider any of the patches in the series as being
controversial. They are all just simple name changes of member
variables. As a number of the variables are not used in code the names
have been changed to reflect that fact. If I'd renamed them and left out
the 'not_used_' prefix would the changes not be controversial? I
don't think the fact that the members are unused is a biggy.

What might appear to be controversial is that I didn't simply remove
the members. I haven't done that because I'm not yet satisfied that
the structure's size is insignificant. As soon as I am happy that the
size of the structure is not important, to runtime code execution,
there'll be a patch which removes a number of 'not_used_...' members
from a structure.

Alternatively if the size if important there might be a patch which
renames a number of unused bitfield members to reserved_1, reserved_2,
reserved_3....

Perhaps I should have held off this patch set until I had satisfied
myself that the size either, does or does not, matter and combine all
changes into one series of patches. On the other hand I've added an
extra step which can be reviewed and clearly see the incremental
changes. I'm happy enough for the whole patch set to be rejected
for the moment, but I'd be even happier if on review somebody pointed
out that a member which I have decided is unused in the code is
actually used and a patch gets rejected on those grounds. If
everybody accepts this series, that asserts that members are unused,
the next step is easy either way.

jwhitmore

