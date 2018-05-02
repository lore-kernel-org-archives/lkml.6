Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-507227-1525255066-2-6583646734749365019
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525255066; b=nBZLF5sGZfcTNC6672Bc/U9mCRwLo0ZyzGGMzPGKxhxKSR7US0
    aNC3jZsdyVzQIGfR50uz3vuOskYWrhBVajBOJGvyoSuE41aIgQzWj2VlYvaI0uxW
    ylrlpP05odJYGl1NwlSJwYdFUtbg/KHYluIEgWbYASnthFd4HVI4LneoTzWL4L/V
    ZH/92FpqyS+0ofn4a2nrG6inc27eZZvPRbsJNQOZkrNxHeCbbenUCE6zPXgyd2VB
    T9B5uxaYRPya1jAHUnQQiZdsqsUGsD07oOZ8puKrD7AeBvafO5OewCWgRoKrOEy4
    te44miSTTym8ycqLvSAcxbaMoygm08AzWT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525255066; bh=lk3g7
    0f5lfPw8pF8gzs1OB//wncmXD9/2ceYWtHkRfA=; b=ML8QMkLFPtQIKU04en5MS
    DsWPkMQGxsi7prwaR4JTY1Tv7PbXahsofuBtXLGO8lQTdDZpboPrIW6OS+t7uWaj
    XOgo7iDbcHN5024VxGaSHRJvEachXRmn3JpXKdNKxITQFRE7mpy+j+LTqngqeo55
    aaXLc+bpOOo/uLTHuXLb0EBw+NZUK7SQv/avZ/Okx/jalyLR7uvMd5jMgyMRVDFP
    hmo+5wpEfu2hKJ4fdzFir4EP4sqQb6H4VO7sEPQkpLOEunF78xbNf0SCbasHK6Wu
    EWnERU1HmuhNaas42URywz0aC91hfxfpgu1RF+nq1GwfnOiZFVdOMtUIUFsgNWyo
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=p76GCXOL x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
    header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=nuoaGto+;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=p76GCXOL x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine)
      header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=nuoaGto+;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=kernel.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLE0BVFz7m/gEkXHb5bgeS4YWVeXkjzt6NzcrxZYoogxHsz5GT/HnOb7BxbbYtvkHhP6Lpypzbh9qd544a7cRP+jpWNMLp2KJO5PjcqQN/uljSUehWHz
    u3HhZeZd/MGHbEJ6m7hTk+O0k19JSjLZ8og/7IEJXqSxavDSE70RHm5AvXcvXxHcK6ObrR06IYUQTDv3I+UDOIXwOScDFjNYdTP6wO+9zTXj8MheewmkGtl9
    J3viBMSfebi4Pmacdl+n1w==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=Bhfm3AHOYCFKeVqMSyUA:9 a=1QUbm1086V6joMye:21 a=H1CyoYKW-Lp8VubH:21
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqbLBBznm8d7sWM+Q/vPwTRtenfeVlqZmtRZoHLsFID/z5b/ZLFTimDFVDblNnj+kQU3Nj1Rg==
Date: Wed, 2 May 2018 11:57:37 +0200
From: Johan Hovold <johan@kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v2] staging: greybus: Use gpio_is_valid()
Message-ID: <20180502095737.GG2285@localhost>
References: <5c8c96b1971bc09a2a2bfa62c343973ab986aec8.1524889296.git.arvind.yadav.cs@gmail.com>
 <20180502084308.GF2285@localhost>
 <2aa263ef-1bbc-69fc-c007-303e59517081@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2aa263ef-1bbc-69fc-c007-303e59517081@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 greybus-dev@lists.linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 02, 2018 at 03:15:05PM +0530, Arvind Yadav wrote:

> On Wednesday 02 May 2018 02:13 PM, Johan Hovold wrote:
> > On Sat, Apr 28, 2018 at 10:05:39AM +0530, Arvind Yadav wrote:
> >> Replace the manual validity checks for the GPIO with the
> >> gpio_is_valid().
> >>
> >> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> >> ---
> >> chnage in v2 :
> >>               Returning invalid gpio as error instead of -ENODEV.
> >>
> >>   drivers/staging/greybus/arche-platform.c | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> >> index 83254a7..c3a7da5 100644
> >> --- a/drivers/staging/greybus/arche-platform.c
> >> +++ b/drivers/staging/greybus/arche-platform.c
> >> @@ -448,7 +448,7 @@ static int arche_platform_probe(struct platform_device *pdev)
> >>   	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
> >>   							"svc,reset-gpio",
> >>   							0);
> >> -	if (arche_pdata->svc_reset_gpio < 0) {
> >> +	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
> >>   		dev_err(dev, "failed to get reset-gpio\n");
> >>   		return arche_pdata->svc_reset_gpio;
> >
> > I'm sorry, but I don't this change is desirable. of_get_named_gpio()
> > returns a valid gpio number or a negative errno, so there's no need to
> > use the legacy gpio_is_valid() helper here.
> >
> > If you grep for of_get_named_gpio() you'll find that some drivers indeed
> > use that helper this way, but they are in a clear minority.
> >
> > And ultimately, we want to move to using gpio descriptors anyway.
> 
> We need to check gpio validity. If we are using of_get_named_gpio() or
> not.  of_get_name_gpio() will read a device node and fetch the value.
> But it'll not check that gpio is valid or not valid.

No, I believe you're mistaken here. of_get_named_gpio() does not return
an arbitrary gpio number, unlike what you could possibly find in
legacy board files and for which the gpio_is_valid() helper made sense.

Johan
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
