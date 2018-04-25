Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1320563-1524691464-2-3215406374651999377
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524691464; b=MsebovZeDI20OzyzTGsbwzUVLKWZwgIKelZzv7S8RRewaDmJOp
    iof0TnADqO6MiIAM+7i8rzZKmyvzmE9w6rZKXtXDiS7vQScbMq/zPmA5cFs1rz2q
    Qnx86g9EsmYRd4PkTAIyGwWZo5nt7UPOQyx+eab7UfNYJ9UxLUb9sAdM8REorA9n
    3JC7GyPWDYGH5Q2dsSHAA1mAdFNtIq0EGjiWdT4P1XbP8PmmjuI4WB3EnGdC8gKT
    NzHLfBkm7UXWR2nm6ck9wYZVhVxqs5umbnp2MbEeRF2JyxcLFJB8Vzz6r6fuYIVT
    yVWGL+WoHBXNyPCzyqWrjFBHcuDAaQa9WDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524691464; bh=1xedJ
    /wv1fqa9295bpT0IpZ90n6H+pKObrEukvl1GoA=; b=AI+LbEO/4bZIJauTTc+aD
    DTgFeX4VWI9HI6L1+caJMSAdxnGe6J5sKl6kiN95gp/PSrPt1hxl7Pk3ocrgsBHH
    xeScNGFMxsxUcmi4FjfiHY89HF1fFxnntpMyqOLSZLf+wceGOwLtlF/nBVrVjhAl
    4K+5b12+PFcq8dTvVqaoZ+28zPIHhcoMtZgUx1MI8b0iommyCJRgM1WsK6bd3MIU
    H559Fe0SBEAQqoa560iwsdR8Jgzxyrsqsy6A+HJyT0XMqRkmf2upzuaHG3jMa6w1
    Ak0hf9PkKNbNZf93etlZkPQ66vNLW3IBvL/DG7whWJjXs5pYqhkr66tOMPpriAcw
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ew2irQle x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=f7dMwZta;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Ew2irQle x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=f7dMwZta;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHwrsi2dnC+4P9+ApVNujdiSABjPnzlRcXrQok0+4QCJElaG/Z4/9AyiaAc86O99dw7tAcFHJk8UGF4yf3134kWaxU41ShFsbdel7/aD3uNjJ1tvq7XU
    tdcJioq/joJKJKy5n8D6iJCzZ6II2n6YfYnnq7kLb/Ivrc0kwFj5bm4HP9lVWKT6uzIsJfBa3vQ5r7pwosP4afbGQ6bQS4xcEoHXhcMDyhAluD/17rp7Z9KW
    qcK36IoAOTP3DjQq/7ZnqQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=aLjZf_mOksQA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=DDOyTI_5AAAA:8 a=G_zXn08LeiAvzSe7aLwA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+6Vm0n2yJ14+kXV5uyC8PysmWNeauHiVfOaKzC3dOT3MFtnJiLBg5HmUfYTS03MZj2dI4bDg==
Date: Thu, 26 Apr 2018 00:24:11 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: simplify procfs code for seq_file instances
Message-ID: <20180425212411.GB9020@avx2>
References: <20180419124140.9309-1-hch@lst.de> <20180419185750.GD2066@avx2>
 <20180424142304.GE26136@lst.de>
 <20180424081916.e94ca8463fb3c39ebc082bdd@linux-foundation.org>
 <20180424160652.GA28483@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180424160652.GA28483@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-scsi@vger.kernel.org, Corey Minyard <minyard@acm.org>,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 06:06:53PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 24, 2018 at 08:19:16AM -0700, Andrew Morton wrote:
> > > > I want to ask if it is time to start using poorman function overloading
> > > > with _b_c_e(). There are millions of allocation functions for example,
> > > > all slightly difference, and people will add more. Seeing /proc interfaces
> > > > doubled like this is painful.
> > > 
> > > Function overloading is totally unacceptable.
> > > 
> > > And I very much disagree with a tradeoff that keeps 5000 lines of 
> > > code vs a few new helpers.
> > 
> > OK, the curiosity and suspense are killing me.  What the heck is
> > "function overloading with _b_c_e()"?
> 
> The way I understood Alexey was to use have a proc_create macro
> that can take different ops types.  Although the short cut for
> __builtin_types_compatible_p would be _b_t_c or similar, so maybe
> I misunderstood him.

That's correct.

I also think that several dozens kmalloc signatures are a problem.

And there will be more with pmalloc* stuff and more 2D/3D array
checked allocations and who knows what.
And I want to add typed kmalloc!
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
