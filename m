Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1146574-1526319683-2-2020246546360814549
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
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
    1526319682; b=CYFAlTecouB3t80nW0FMNu1DrJoqxNnoDK845Zt/Cmv4ypM4BD
    IVuraptUZzz4KbqJMZT66vtjWKesduHA3jnHfUgJsINmYS31AQtXQ97YfGMw5J9c
    OkqTLilDSAHfRzxDwVBsROQ3UwhQff1Fz3fxd/Tf1p0QjaPl9lpmhorSZag5I2kA
    qKxrOvK9Eu8lUxb7zmquavLUcwyi33QaO9M67TyEb7n9O2PcxD5SAhBxN88M8bKJ
    NpkkSC25izgdyiZYMv+ZIlpIvirDXUuGG/fvkh2lSxKB1u5sTcwbMubOjPA6kS7w
    jWFzA727i/dKZWETan0EJV77BdupCRJ5euEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526319682;
    bh=T+PelwW9to3LvwSTtIrRWgzj27PXOFlXvOTMkVlQr04=; b=jh2/q21ceEkR
    N+35kaIYsf8dbhY+WLfcppPHNZhWDegAO0BkMb9jQR/GWvQB0X7lo1QKE34ulcp3
    pgj+KXWA9fqOyt6TkIldQclA3I3ruEeU2kcZMXjxBl3MCtslAQLHOKpyK8u21p3K
    RwKWLAPy2FBEdF9KsZ2G9g46tGnSqaL7tYI3yjPssfiunayKBN+d+yjVh8O7UBgs
    nrZryiQy4SlKoJJiMBuplQPl2i8eDvf4wYk7UwHOJUTU8ArGrFli33C6IS1mP6Kc
    OUi4KOR8UeyIJ+3J83VDHFMXCX1sLuIY5ey1SjEgXV3r0Zjmxo9P5iXWsOChUqN+
    U0Q8qhJ0dg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codethink.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codethink.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPvRjWenaW8qjp4saZ8J8FJeWJwHMsHZJaXxTkDcCXfGe3MQ28PzeKtBpmr2C8FpbJntQWxmwpKEj6fwz4znwsxjVhnuMn5gYsYPK2te7q2t5SDORU8u
    cxJf6z1UkdGY3hBKLA5PfyH0RIjfTCOPfOuz0KpRMdDfReZh4GUEyvfCASDY8XatyNu+0Ky7LExKUcn6X2SnfIPHZCZ0Yft3xDstc0+46VJ0wEDWWTHTqfUd
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=iox4zFpeAAAA:8 a=fWfLe_FpeS8IlqZGbsEA:9 a=QEXdDO2ut3YA:10
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeENRlS (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 13:41:18 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:35065 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeENRlR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 May 2018 13:41:17 -0400
Message-ID: <1526319669.9159.20.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 49/72] media: usbtv: prevent double free in error
 case
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Oliver Neukum <oneukum@suse.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: stable@vger.kernel.org, "Yavuz, Tuba" <tuba@ece.ufl.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 14 May 2018 18:41:09 +0100
In-Reply-To: <20180406084309.317246829@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
         <20180406084309.317246829@linuxfoundation.org>
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

On Fri, 2018-04-06 at 15:23 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Oliver Neukum <oneukum@suse.com>
> 
> commit 50e7044535537b2a54c7ab798cd34c7f6d900bd2 upstream.
[...]
> --- a/drivers/media/usb/usbtv/usbtv-core.c
> +++ b/drivers/media/usb/usbtv/usbtv-core.c
> @@ -95,6 +95,8 @@ static int usbtv_probe(struct usb_interf
> >  	return 0;
>  
>  usbtv_audio_fail:
> +	/* we must not free at this point */
> +	usb_get_dev(usbtv->udev);

Shouldn't this bump the V4L2 device's reference count, i.e.:

	v4l2_device_get(&usbtv->v4l2_dev);

?

Ben.

>  	usbtv_video_free(usbtv);
>  
>  usbtv_video_fail:
> 
> 
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
