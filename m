Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2099817-1527599177-2-7600965590839212642
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527599177; b=ArcniDvnFOzOgCRCEi8Nlcvo2NGLWmBBIzJuy8O79vOYHitNwy
    npoqbqk0EC0oBDRQwC7jba5UVHyF79kVu0MACLiWBxi9ya1rwYNPIiyiYgbk43yQ
    FFWUH+imacZJFNnZfu2sIpbXnlTzbG4cU4CBE/wMo3NMVL2KAuCgWEqr/NouKlIq
    qzgDIVtmgFSIbIM17lLTuA6Ls5HrCrAibaheJSULl34S3D8xn9e4haLtX0FGiH3P
    ftCkuM/TLfaYSBiAZ+3Pkarp8o4D7554TDHNytW5uUPUN7v9GcBZjjNL6m/1QWrA
    FbnMSClytLWvx22cip2IeVSAIg+qc4Bb1tbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527599177; bh=N3nRpF2nwNpmES901V7jXijRHY3d3+
    /prjxL76+Ccnw=; b=XmqK1dvPdUiRass0xK5etIjROTxWheTSn+VWzd4k6ttLxR
    dYnWqyTRVWHidWu5/guao8bKuQ8SoaCzv1Hi+zhz1oi0lYKCFwVFfGpX1tCQBqiv
    8iunR/NljlEGVknx7G0Ijx8YhdU1ErodMYUi6wycL1YFpSTtkQiIE3tLpLHKGSDb
    OKOPpUq/urNCMY0iH9FEUWTNwAcgSx+IKHANt3tDpgrhhj5/HeEb8hL+RPWCz0uT
    WiLcwUSrQtTqAZhp1CMtmuG0+0zFBYwtf15z3tNMO9/oiN47yQpR78LYdMzgICyJ
    PG8yNd/mprv7aW+p/Fzl0u4KgkD4khh0kaQToIcw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAfW9CBFZSOlcRs8uiFUBqOE5wL7PeWxhbvmAnVIB44x40UmL8cgVrWTOMn2hpvpyy3dClgp+pk/8RzF48NtjKEO70MEAqTlotIhQ86/8NagiRnwD68Y
    fm4wN7k6zWOEiABHktQanTvLUws06onu+l4BgYl0vT+kEg8+nwwS2XSIbxPdJBB/9Nukt+tjM2gTkZmh84iOeu+NqG9OTn1pgNVI448ly2CkEZxLqvbtBCMg
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=pmXoHKXgDsPllcgIPbgA:9 a=CjuIK1q_8ugA:10 a=N8N-558xWu8A:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933754AbeE2NGF (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 09:06:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933548AbeE2NGE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 09:06:04 -0400
Date: Tue, 29 May 2018 09:06:01 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Shaohua Li <shli@kernel.org>, Alasdair Kergon <agk@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dm: writecache: add DAX dependency
Message-ID: <20180529130601.GA31628@redhat.com>
References: <20180528153834.2268557-1-arnd@arndb.de>
 <CAPcyv4gpMhBaUdy=UY9M0-2QomycGZCo+K6o+Dzjdc4jmPjrkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gpMhBaUdy=UY9M0-2QomycGZCo+K6o+Dzjdc4jmPjrkg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 28 2018 at  2:18pm -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Mon, May 28, 2018 at 8:38 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The new dm-writecache driver inconditionally uses the dax
> > subsystem, leading to link errors in some configurations:
> >
> > drivers/md/dm-writecache.o: In function `writecache_ctr':
> > dm-writecache.c:(.text+0x1fdc): undefined reference to `dax_read_lock'
> > dm-writecache.c:(.text+0x2004): undefined reference to `dax_direct_access'
> > dm-writecache.c:(.text+0x21cc): undefined reference to `dax_read_unlock'
> >
> > It seems wrong to require DAX in order to build the writecache
> > driver, but that at least avoids randconfig build errors.
> >
> > Fixes: bb15b431d650 ("dm: add writecache target")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/md/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> > index 852c7ebe2902..f8ecf2da1edf 100644
> > --- a/drivers/md/Kconfig
> > +++ b/drivers/md/Kconfig
> > @@ -338,6 +338,7 @@ config DM_CACHE_SMQ
> >  config DM_WRITECACHE
> >         tristate "Writecache target"
> >         depends on BLK_DEV_DM
> > +       depends on DAX
> 
> This should probably be depends on DAX && DAX_DRIVER as we at least
> need pmem or dcssblk enabled to provide a dax capable block device for
> DM to claim.

But dm-writecache is meant to be used for normal SSD even if PMEM isn't
available in the kernel.
