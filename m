Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2601871-1521718926-2-2277301560133463618
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='ISO-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521718926; b=tuvKUpJ7p7C6YmkPz7g5Wpw3X8sj97gIEoxDnF2Gv4FTK9s
    fxOLW9jCOorEah3LS01kleps4+MuuZOZ2lwp9392NkPuGDzhK/bGMj9Zix6VY9kg
    ZxprA8JmMwRn4c1SFXq6wcVrEjjpaHsgRpG+4aoqClh+GfSaLumqXdq2bgGMHfYc
    RLzBt3Bovy51qlOTWO1Mg9dLJfGX3JuTY8Zix9RHjGXogmCHki9YNTmdHk1rzEWo
    h4+sJqjwYsEFm9Pi4ffRvHLEJwJjfaXGzXhl8dhbHx9VJYk6SZH0TMPFrLyDeAc5
    fVPhH52BJ5bmeop9WPAfosr8SuyZrqIXK+zIqLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=arctest; t=1521718926; bh=0s6LAw
    U5x5OwEzNLAKuXiPTdetW5bClYqTEUuY27I8k=; b=CrWe2+/iX8pk32dgr4Bw0Y
    fjF2mKXe9JLpZ/QNi+OwJyXdT6WzuGb/0An2j2NGXdjRSPmh61Wo+bjdgR71Slng
    coBZof/pARiQPIwvj+Cjb4n4I0PaG2PRTHtap94O0PGp9WNI3rQqZjvEmwGsW1Ys
    Q9Wo9VJ37qAkfzl41qyA/mzAC6VJAzQZZJOXVU6cMWxn5wC6WQUZbPvaD7bXpJOL
    HMTn8CzB8sJ0zCU5wXQQN0b7z6+YqrWLlnv+3K4sEsp7rFnABMqBysZL7Qo3sets
    bQ2Kf0mgsYdtr459uAyBh0+YpufspDUz1PGBNPqYupfLCoJ6eOUAmT/AAVXGUQFQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sntech.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sntech.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sntech.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=sntech.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752199AbeCVLlu convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 22 Mar 2018 07:41:50 -0400
Received: from gloria.sntech.de ([95.129.55.99]:55480 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbeCVLlu (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 22 Mar 2018 07:41:50 -0400
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: dwc2: dwc2_vbus_supply_init: fix error check
Date: Thu, 22 Mar 2018 12:41:38 +0100
Message-ID: <3806387.a3O5bOALIr@diego>
In-Reply-To: <1711886.RiDBCvOSMq@diego>
References: <20180322093943.49717-1-tomeu.vizoso@collabora.com> <1711886.RiDBCvOSMq@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tomeu,

Am Donnerstag, 22. März 2018, 12:39:13 CET schrieb Heiko Stübner:
> Am Donnerstag, 22. März 2018, 10:39:43 CET schrieb Tomeu Vizoso:
> > devm_regulator_get_optional returns -ENODEV if the regulator isn't
> > there, so if that's the case we have to make sure not to leave -ENODEV
> > in the regulator pointer.
> > 
> > Also, make sure we return 0 in that case, but correctly propagate any
> > other errors. Also propagate the error from _dwc2_hcd_start.
> > 
> > Fixes: 531ef5ebea96 ("usb: dwc2: add support for host mode external vbus
> > supply") Cc: Amelie Delaunay <amelie.delaunay@st.com>
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 
> Thanks for catching that oops in your tests.
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

I take that back :-)
see below

> > ---
> > 
> >  drivers/usb/dwc2/hcd.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> > index dcfda5eb4cac..4ae211f65e85 100644
> > --- a/drivers/usb/dwc2/hcd.c
> > +++ b/drivers/usb/dwc2/hcd.c
> > @@ -359,8 +359,13 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg
> > *hsotg) static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
> > 
> >  {
> >  
> >  	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
> > 
> > -	if (IS_ERR(hsotg->vbus_supply))
> > -		return 0;
> > +	if (IS_ERR(hsotg->vbus_supply)) {
> > +		hsotg->vbus_supply = NULL;
> > +		if (PTR_ERR(hsotg->vbus_supply) == -ENODEV)

hsotg->vbus_supply is already NULL here

