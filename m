Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-88466-1525240076-2-5878571315655470805
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525240075; b=YLBXxVsG/Cr+bjz2f5mPw9q6ZdwwA60+lS8PZlifE/gCPKKjvK
    CzaS5JyC/G66KEoJNl5jrKNv/cMj1WZ9vl5xAnWUtgBGXlB9eTWS6hd9qQxj1o+R
    7Lqk/IqSEGBEJQjdOjLQMXr1Ug1APXnY18O3MQqW1LhxLlLu+3YZA5qnWAEqxIKP
    h762V1dRUilI1P+kcC1zgwTv+J6QVAS7zIGcr6AnjsH9wdeMaq/EEZ69H9bb7cyK
    t6Fr2sxTBTB4YPmAt/osmROBZbyW4n71JeUmYAcxg6hpwKm/VchsJiXPLC1zVc/K
    hvdc/YEPJasXOxsViZs1MsW/SSWCdcutOcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525240075; bh=z9LDh
    6f9giPxFEv5D2MMCpTsuBR9ef3iFdFpT61gK7U=; b=gudowTHJd3QCqFDRSoelV
    uxsml4bF+0S2Uz51duS//wI7vOxaHbsX8sEl/HsXrJ/l1FqiiTPxaZcA8P0oCq8m
    B7MvxVNiR8dQZL5MOvHdVN1x2aij+GnwtYKhWCukPzawILEWS8SiYHayEZLFoqB2
    2ckP9JZek5u5c3jvUhw5QnTEQoqLHYizX/+QvYGK5kh+X05l8w1Jbs2B42l07CE4
    DuOtUmtomogjVIzkMavE0qnXAgbqIeg/Qs5+9xpWJ8jSyoMHoTWw0x1Ul1VSY5Qi
    t8u+bgu/mBoHYU+4eYqaQyYmiovaCqp9xXc2XuQuCX7MzbhdGNdrt4+P5NcrqGPP
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=microchip.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=microchip.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHUpjTBuLunVi493KTcZDd8HU/6dR+/F2rS3sB2Ri7S+0kltKfwtkkQPrz9iRI+VUsqXHOFEfni8J70SsSPdOpqMmXU10R7hj6ddJVxhfNhRnjhjlxWl
    C0W5EZ4Zl29gfEAWSg8UWwW3LPOFB47MTVkb62oW1x6c6I7pLkW3HOlxDEziwbCZpHgfLb+OFuYC0Ss871gcu/Ncrxk+w9zpPGZb67PvspZ1cjunHg6iK8R1
    UqSWeyS02uKMuA7+CeuShg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yPCof4ZbAAAA:8 a=XYAwZIGsAAAA:8
    a=_Wotqz80AAAA:8 a=DDOyTI_5AAAA:8 a=-84WmH7ae1a1t-CTV3UA:9 a=CjuIK1q_8ugA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=buJP51TR1BpY-zbLSsyS:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.49,353,1520924400"; d="scan'208";a="11611640"
Date: Wed, 2 May 2018 11:17:35 +0530
From: Ajay Singh <ajay.kathat@microchip.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: wilc1000: fix infinite loop and out-of-bounds
 access
Message-ID: <20180502111735.5a2c6faa@ajaysk-VirtualBox>
In-Reply-To: <20180430152321.7pq4ol2ed7tzsrl4@mwanda>
References: <20180430125040.GA19050@embeddedor.com>
 <20180430195916.596a93eb@ajaysk-VirtualBox>
 <20180430152321.7pq4ol2ed7tzsrl4@mwanda>
Organization: Microchip Technology
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ganesh
 Krishna <ganesh.krishna@microchip.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 30 Apr 2018 18:23:21 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Mon, Apr 30, 2018 at 07:59:16PM +0530, Ajay Singh wrote:
> > Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>
> > 
> > On Mon, 30 Apr 2018 07:50:40 -0500
> > "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> >   
> > > If i < slot_id is initially true then it will remain true. Also,
> > > as i is being decremented it will end up accessing memory out of
> > > bounds.
> > > 
> > > Fix this by incrementing *i* instead of decrementing it.  
> > 
> > Nice catch!
> > Thanks for submitting the changes.
> >   
> > > 
> > > Addresses-Coverity-ID: 1468454 ("Infinite loop")
> > > Fixes: faa657641081 ("staging: wilc1000: refactor scan() to free
> > > kmalloc memory on failure cases")
> > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > ---
> > > 
> > > BTW... at first sight it seems to me that variables slot_id
> > > and i should be of type unsigned instead of signed.  
> > 
> > Yes, 'slot_id' & 'i' can be changed to unsigned int.
> >   
> 
> A lot of people think making things unsigned improves the code but I
> hate "unsigned int i"...  I understand that in certain cases we do
> loop more than INT_MAX but those are a tiny tiny minority of loops.
> 
> Simple types like "int" are more readable than complicated types
> like "unsigned int".  Unsigned int just draws attention to itself
> and distracts people from things that might potentially matter.  We
> have real life subtle loops like in xtea_encrypt() where we need to
> use unsigned types.
> 
> And look at the function we're talking about here:
> 
> drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
>    577  static inline int
>    578  wilc_wfi_cfg_alloc_fill_ssid(struct cfg80211_scan_request
> *request, 579                               struct hidden_network
> *ntwk) 580  {
>    581          int i;
>    582          int slot_id = 0;
>    583  
>    584          ntwk->net_info = kcalloc(request->n_ssids,
>    585                                   sizeof(struct
> hidden_network), GFP_KERNEL); 586          if (!ntwk->net_info)
>    587                  goto out;
>    588  
>    589          ntwk->n_ssids = request->n_ssids;
>    590  
>    591          for (i = 0; i < request->n_ssids; i++) {
> 
> request->n_ssids is an int.  It can't possibly be INT_MAX because
> the kcalloc() will fail.  Ideally the static analysis tool should
> be able to tell you that if you seed it with the knowledge of how
> much memory it's possible to kmalloc().  So it's just laziness here
> is why the static checker complains, it should see there is no
> issue.  Smatch fails here as well but I'll see if I can fix it.
> 
> Anyway let's say it could be negative then 0 is greater than
> negative values so the loop would be a no-op.  I've seen code where
> the user could set the loop bounds to s32min-4 but because it was
> "int i" instead of "unsigned int i" then it meant the loop was a
> no-op instead of being a security problem.  In other words,
> unsigned can be less secure.
> 
> I honestly have never seen a bug in the kernel where we intended to
> loop more than INT_MAX times, but there was a signedness bug
> preventing it. That's the only reason I can see to change the
> signedness.  Am I missing something?
> 

Hi Dan,

Thanks for providing the detailed explanation.

I understand your point, but what's your opinion about variable
'slot_id', as this variable is added to take only the positive
value(i.e from 0 to maximum number of filled elements), so for more
readability should we keep it same.

BTW in my opinion 'request->n_ssids' should have been unsigned
because it is suppose to hold only positive values along with 
smaller data type(may be u8 or u16, as the range might be enough to
hold the value of n_ssids). So we have advantage of size reduction
not just the increase in value range.

Suppose we get negative value for "request->n_ssids" & kmalloc is 
pass then we have to add some more extra code to free data and
return error code in wilc_wfi_cfg_alloc_fill_ssid(). In your opinion
should this condition be handled as the received 'request->n_ssids' is
of 'int' type.


Regards,
Ajay

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
