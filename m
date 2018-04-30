Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1553610-1525101820-2-6683454473195691038
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525101819; b=T4sIlQWq/bzMpjFKTKPp+LzuEaJwD6KBUKDeUCi+YyfGioDXm7
    MfwadLxnbIz/HuRED64w1FGpZO+EDGsL5/VFJGmU/9wglPBas++u8C1Biq2S4Pqt
    W8jhAn2SsXSxuRsNJFR4Lnb+H3pZKNJXtesOj/BrCbHZLrwDHGipAXIxAEAQIVic
    r6/ZNnnaX8roaC2XUlCeqZBt9fG+VcAoEKS8MjJqHGkIZridCHDm5KSuWplcOt4T
    CwF+A03nzuE1CHOlvITQ/OtbqCoCxiw87lgzK4cODklFSBL/+dmAJoYuWUcMHDe1
    pJEphQiH2k+WTDnJn2BJenIyGYlCvgSH33dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525101819; bh=hB1G3
    eSh5WsdqdEiXLwDIZoHqyIufpsO2D93UX/cnes=; b=T1qDxSK3YFSFRhtvWobZQ
    xjf2Kn7jNHjAJGue7YuNT987m4W3/OnIxKB0L0dgs8HKKbKQNgJnN87vItZ9se25
    2ojBYGSbma/lIXXAcBcuI2oLYG2yk7r9dek27U1phB0/uM6FEDm0TQIePRhpH/1H
    nzxDsaO9fgaEN/a1MrVmGCee2L/JeVjEZL6kgOrwNyi9Qr0dFtAFrl+K03UkQstf
    2ZICIb4LuE7EbEvoMgd0pO1byhRAj5wMYFR/f53wh2G7FLcl4yNCs5vwN1uA1kec
    Ld0TNPfhOctivUxVkHxWPJ5Qtsa6tMTVl6LYpaOKxRamlXoaLxeoir0pfNkmYl0m
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=COxEOhL4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=COxEOhL4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBAfTr3f0pDnlzht2jCys0NH4R2QhMFOI2maiCPxSc2MSkNdE5XWERwEhmeCDzGuAc5yxMNSD96CzyRuoxWHLQXfTY0BdEDKje92Jemnhcku3L7S0iCG
    /oiQDWmMrimvEvseCVHp5gqm/dX+Rllw+9rO+YCzMBxKysrTrOQN85erQse89BTl+0XqnwTHplzVn5My+MndAuh7o1dL6PgMKhfz3TSsMfdUcLnqmSGR59Oh
    Tg0X/iFolcIXHBY/8E/cbQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=XYAwZIGsAAAA:8 a=_Wotqz80AAAA:8
    a=DDOyTI_5AAAA:8 a=9iFesQeejcWJy_MSFeQA:9 a=CjuIK1q_8ugA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=buJP51TR1BpY-zbLSsyS:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 30 Apr 2018 18:23:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ajay Singh <ajay.kathat@microchip.com>
Subject: Re: [PATCH] staging: wilc1000: fix infinite loop and out-of-bounds
 access
Message-ID: <20180430152321.7pq4ol2ed7tzsrl4@mwanda>
References: <20180430125040.GA19050@embeddedor.com>
 <20180430195916.596a93eb@ajaysk-VirtualBox>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180430195916.596a93eb@ajaysk-VirtualBox>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8878
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=808
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804300147
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
 linux-kernel@vger.kernel.org, Ganesh Krishna <ganesh.krishna@microchip.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 07:59:16PM +0530, Ajay Singh wrote:
> Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>
> 
> On Mon, 30 Apr 2018 07:50:40 -0500
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> 
> > If i < slot_id is initially true then it will remain true. Also,
> > as i is being decremented it will end up accessing memory out of
> > bounds.
> > 
> > Fix this by incrementing *i* instead of decrementing it.
> 
> Nice catch!
> Thanks for submitting the changes.
> 
> > 
> > Addresses-Coverity-ID: 1468454 ("Infinite loop")
> > Fixes: faa657641081 ("staging: wilc1000: refactor scan() to free
> > kmalloc memory on failure cases")
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> > 
> > BTW... at first sight it seems to me that variables slot_id
> > and i should be of type unsigned instead of signed.
> 
> Yes, 'slot_id' & 'i' can be changed to unsigned int.
> 

A lot of people think making things unsigned improves the code but I
hate "unsigned int i"...  I understand that in certain cases we do loop
more than INT_MAX but those are a tiny tiny minority of loops.

Simple types like "int" are more readable than complicated types like
"unsigned int".  Unsigned int just draws attention to itself and
distracts people from things that might potentially matter.  We have
real life subtle loops like in xtea_encrypt() where we need to use
unsigned types.

And look at the function we're talking about here:

drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
   577  static inline int
   578  wilc_wfi_cfg_alloc_fill_ssid(struct cfg80211_scan_request *request,
   579                               struct hidden_network *ntwk)
   580  {
   581          int i;
   582          int slot_id = 0;
   583  
   584          ntwk->net_info = kcalloc(request->n_ssids,
   585                                   sizeof(struct hidden_network), GFP_KERNEL);
   586          if (!ntwk->net_info)
   587                  goto out;
   588  
   589          ntwk->n_ssids = request->n_ssids;
   590  
   591          for (i = 0; i < request->n_ssids; i++) {

request->n_ssids is an int.  It can't possibly be INT_MAX because the
kcalloc() will fail.  Ideally the static analysis tool should be able to
tell you that if you seed it with the knowledge of how much memory it's
possible to kmalloc().  So it's just laziness here is why the static
checker complains, it should see there is no issue.  Smatch fails here
as well but I'll see if I can fix it.

Anyway let's say it could be negative then 0 is greater than negative
values so the loop would be a no-op.  I've seen code where the user
could set the loop bounds to s32min-4 but because it was "int i" instead
of "unsigned int i" then it meant the loop was a no-op instead of being
a security problem.  In other words, unsigned can be less secure.

I honestly have never seen a bug in the kernel where we intended to loop
more than INT_MAX times, but there was a signedness bug preventing it.
That's the only reason I can see to change the signedness.  Am I missing
something?

   592                  if (request->ssids[i].ssid_len > 0) {
   593                          struct hidden_net_info *info = &ntwk->net_info[slot_id];
   594  
   595                          info->ssid = kmemdup(request->ssids[i].ssid,
   596                                               request->ssids[i].ssid_len,
   597                                               GFP_KERNEL);
   598                          if (!info->ssid)
   599                                  goto out_free;
   600  
   601                          info->ssid_len = request->ssids[i].ssid_len;
   602                          slot_id++;
   603                  } else {
   604                          ntwk->n_ssids -= 1;
   605                  }
   606          }
   607          return 0;
   608  
   609  out_free:
   610  
   611          for (i = 0; i < slot_id ; i--)
   612                  kfree(ntwk->net_info[i].ssid);
   613  
   614          kfree(ntwk->net_info);
   615  out:
   616  
   617          return -ENOMEM;
   618  }

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
