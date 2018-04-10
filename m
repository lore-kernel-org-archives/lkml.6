Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4113313-1523373257-2-10223308119052068219
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523373256; b=aApSktgGdHS/2cceH87FWIAk4D9ZMbv7Xh2xBl36sLLo9pDdwR
    6Qe7uUO7u4IUsQDZ5c84iuCcLXYiLu2LmDztXYmT+8C5yr9TUokkNeXFgGI6A2ba
    mk3dNMp/otDDQCf2dROLK5AP+ewNUan34KVAgupgRrL8gSn2RKZ8GKrf4rOhVlNN
    jfwcrN+065arqIXqe8GII5d63FdK20nC4kvVDs5WTq0wmHFz4mAx9RhK4wqBxQdM
    VFOtZhVb0ZvALfZgPqWLExJV8CYAgqcjLU7nIV0JItdFXDF+Fi7IkNkTD5dKvJmp
    U2OuHnVzVr3RIJj0IA9vZMX6V9ES748G/O9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523373256;
    bh=RuiNjVURI/aIgkCAFWRGk9X7aUMT2asovB69KdwFzEo=; b=BQLyH5ClC13J
    /+zo+BCuX1MAIHvAV6rPe0FJ1XJccskaNR79wSO0jXQRV5+Gti5lTnYVYE+qikbX
    fqyRHQLApRwVbxahGVzo6iRMpxwvSr30JNdApHVmIvzHE+Mlz738Hs5ukEVa1BzF
    p20TQnpSNOLrRAW9nspP7HhsEDltt8N73W2xwBchlFOW6cCu569QDsweFeBQiGXB
    PLO3hXoMQ0Eeti0zd0y2sRQX32JeFte0tCi/cmT9zFcsxYSzmijuMg94WF3xSUmq
    Z2plAcX15mi+xVBqFDWLntmSxpzUk9HDz3sTIshbSskdXvBPaPQIIZXDt6BOkONp
    8gCiSCLPnA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMWs8y4K0EiLcNUZo8rRwmayXVpR9vZZvwB6P/D/izW7zlDmE2y97iD1jm1oepFOMrmC64ruTWI6IWd+0H0AehxTo3PdaxC7JfDslsvYGMk1W0XZtUPg
    uhzuv7uWUoch3WrxYj1sW7AtCFHt63YmaETaM+6LAgKRA9QD+DX6aD58RxZO1cm+sJwhmoz7lDNdFxM1CZxZL+M6psrccZnlrab4Gj2YSVd87r1TxSfCATG5
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Qze4UBMhAAAA:8 a=gFFUY7aMDU9U-62Nae4A:9 a=QEXdDO2ut3YA:10
    a=30qrNVoKYyQsQ_rTTfpG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeDJPON (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 11:14:13 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:58755 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753685AbeDJPOM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 11:14:12 -0400
Message-ID: <1523373245.2654.182.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 38/97] netfilter: xt_CT: fix refcnt leak on error
 path
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Gao Feng <fgao@ikuai8.com>, Liping Zhang <zlpnobody@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Cc: stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Tue, 10 Apr 2018 16:14:05 +0100
In-Reply-To: <1522777564.2654.115.camel@codethink.co.uk>
References: <20180323094157.535925724@linuxfoundation.org>
         <20180323094159.781131756@linuxfoundation.org>
         <1522777564.2654.115.camel@codethink.co.uk>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-04-03 at 18:46 +0100, Ben Hutchings wrote:
> On Fri, 2018-03-23 at 10:54 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Gao Feng <fgao@ikuai8.com>
> > 
> > 
> > [ Upstream commit 470acf55a021713869b9bcc967268ac90c8a0fac ]
[...] 
> > @@ -249,7 +252,7 @@ static int xt_ct_tg_check(const struct x
> >  	if (info->timeout[0]) {
> >  		ret = xt_ct_set_timeout(ct, par, info->timeout);
> >  		if (ret < 0)
> > -			goto err3;
> > +			goto err4;
> >  	}
> >  	__set_bit(IPS_CONFIRMED_BIT, &ct->status);
> >  	nf_conntrack_get(&ct->ct_general);
> > @@ -257,6 +260,10 @@ out:
> >  	info->ct = ct;
> >  	return 0;
> >  
> > +err4:
> > +	help = nfct_help(ct);
> > +	if (help)
> > +		module_put(help->helper->me);
> >  err3:
> >  	nf_ct_tmpl_free(ct);
> >  err2:
> 
> This does not.  nf_ct_tmpl_free() calls nf_ct_ext_destroy() which I
> think will call back into xt_ct_tg_destroy().  So I think the module
> reference is already dropped here and we mustn't do it twice.  Am I
> missing something?

I still don't understand this code, but I have verified that the
module_put() is needed on this error path to balance the module
reference count.  I.e. this fix is good.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
