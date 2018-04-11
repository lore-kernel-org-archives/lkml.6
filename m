Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1882174-1523434663-2-10322396919326181459
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523434663; b=OIa8uQIaTExpcR4saracHefRO/hAQaKIN7A0m5EwTY7vAdCfvq
    xnrMh42ygjDC66KJqvS9kk8lMsamBOdwnxhcJ0l/iTrpa0QUgj/ijl+VLB2E8IsS
    Lio2G5u7uMqbJIoOJOQpcIhteCk2ObWofT8pC6aPpXn1L6/wAEwTCNdPE2IJ8YMS
    RDx4e7KIzbxWnWM/v6FzwXojQux3VyV1hLlOpJ8jnkpKTRRtPfibaaZKlAmKsoZD
    +YgeOvM40yyS8ePUn73LbQlmcgavPzeI0XDd2Ed6V9WLTYjveNEfO5nEolxdZO8l
    10udHNlLd9Rv29FwpY8y9Zdhj2GyteIsEdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523434663; bh=/6E1a
    mqLM4gBUeIP8t+HQUZQotDHerWeq+9+0vnMtls=; b=h3XGtcNxUa/miIYXPIIGr
    CgWi5gXy+T00oqsvNto20nJEz2hJmVPiSnkdT+ZOzfwtyh05y3cXcxaCSQGQGIG4
    l1jegluZaQjnQukitxVkf6PEkjZ+O26ft9j9gaU7OzFXKJp8QTTUZVfPB/29L9dK
    2hiBiOjK5Kyk1NA0Y/MftVJ9r0Fe3RDF6ohZobxocvpD+tecjZxdua+hiJyPCiAZ
    ZmvuKOJeyKAk2RAyD4fRTOdeOHGvJ1beZ9/3a6o7w1vsWFFwn/47pFBNxjE+YfPq
    2e5oscO4MotO9ZNdyOLuTANfSvoKUWdWlzsz6clo0ePakp9N42d4HY9L7JIi9twN
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPRD23sfsx2hoe/LSbmGI7V8Yf2zEYzRzpssirOzWsdQhckCwBBK81PjrBCRwtX6hJP5f3oomyT8OvaWOrVFO5eLF8/NEVcx5hvkSWH5Y/CJHiM8h77a
    vkrCvA8iPf0jUIFSYDCF37/PXhf7bI0Zb3BOzCh2ugez89mSziNHsf3uSXEkijUZW5Ld8dM2XtTjtdOzjO7pDIraWDwdGsKB7tZsZ9mH3XoI8uaw+Zzhx7/s
    l0YPK+RFglldG24UQK5JZg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=zH4cGWEkLsNuPzasswIA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 11 Apr 2018 10:17:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [PATCH 1/2] staging: irda: Replace mdelay with usleep_range in
 stir421x_fw_upload
Message-ID: <20180411081724.GA4155@kroah.com>
References: <1523410174-1553-1-git-send-email-baijiaju1990@gmail.com>
 <20180411064135.GA28354@kroah.com>
 <d65d1116-7ffd-e289-5379-cc052782700d@gmail.com>
 <20180411080311.GB2137@kroah.com>
 <ecf21a6e-0e99-55dc-54be-3bd633bedbc5@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ecf21a6e-0e99-55dc-54be-3bd633bedbc5@gmail.com>
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
Cc: devel@driverdev.osuosl.org, samuel@sortiz.org, netdev@vger.kernel.org,
 johan@kernel.org, linux-kernel@vger.kernel.org, arvind.yadav.cs@gmail.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 04:11:00PM +0800, Jia-Ju Bai wrote:
> 
> 
> On 2018/4/11 16:03, Greg KH wrote:
> > On Wed, Apr 11, 2018 at 03:17:10PM +0800, Jia-Ju Bai wrote:
> > > 
> > > On 2018/4/11 14:41, Greg KH wrote:
> > > > On Wed, Apr 11, 2018 at 09:29:34AM +0800, Jia-Ju Bai wrote:
> > > > > stir421x_fw_upload() is never called in atomic context.
> > > > > 
> > > > > The call chain ending up at stir421x_fw_upload() is:
> > > > > [1] stir421x_fw_upload() <- stir421x_patch_device() <- irda_usb_probe()
> > > > > 
> > > > > irda_usb_probe() is set as ".probe" in struct usb_driver.
> > > > > This function is not called in atomic context.
> > > > > 
> > > > > Despite never getting called from atomic context, stir421x_fw_upload()
> > > > > calls mdelay() to busily wait.
> > > > > This is not necessary and can be replaced with usleep_range() to
> > > > > avoid busy waiting.
> > > > > 
> > > > > This is found by a static analysis tool named DCNS written by myself.
> > > > > And I also manually check it.
> > > > > 
> > > > > Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> > > > > ---
> > > > >    drivers/staging/irda/drivers/irda-usb.c | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > Please, at the very least, work off of Linus's tree.  There is no
> > > > drivers/staging/irda/ anymore :)
> > > > 
> > > Okay, sorry.
> > > Could you please recommend me a right tree or its git address?
> > Have you looked in the MAINTAINERS file?  Worst case, always use
> > linux-next.
> > 
> > greg k-h
> 
> Oh, sorry, I did notice the git tree in the MAINTAINERS file.
> I always used linux-stable.

linux-stable is almost never the tree to use as it is almost always
12000 patches behind what is in Linus's tree and about 20000 changes
behind linux-next.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
