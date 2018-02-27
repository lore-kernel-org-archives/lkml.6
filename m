Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1435288-1519735453-2-9425298373692645697
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: to='ISO-8859-1', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519735453; b=ZqMmLTkOiNB16VfU67gezh0N466urnUz0kXHA6iRyJSEyT2
    AZZQD+Pei2H4vz7KbO8epW1C3HtouPdH2/h8IKOfUAI9deaEwqP4ezoWneN3agfO
    TmexKytPGy4uXKS2Ts6t1UDGovxkVc94+o8rJ79lHl0ecYuaJbdXKBJ151w+xXCd
    8X3fSEJIZgoqKHlLV/WBYBGfQ5Ma7QwAVVujHbmpcpsoODTbsFOBm3Ul8kTU9HVK
    y2YMExrYFCuOV71KenQAN8X2R5pDuAqR7maiqHNyhUHlbKZKrrOMtPDxEB7LS8JS
    hmbk2rTKVKZtTYSVlU1NTK8C5n014mLzmLKWU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519735453; bh=urCaXNvQkhXkQuqnAERtFDyzV+Jj/tMrWfL3qlIX5xU=; b=f
    J+gf+g2Y8Nycnv65YXgV+2B4278ePKOBTPorMkN4gjjskEu0qqN+rtR/Up/DwA4o
    ETNXsrd5vByLUHKNl9EbThVL5HAYTzCXqYjP67Ov3QS9tkkkXDnp7ni1MACBIQbX
    ggPSjPEHC5Rm4/UOA9YHAIiAPrWFIpZ89CdYlyaaYAQLtYNDoAs3ZZ+kjulgackV
    e/KmYZSyOQhch/Vy5MqRV2HPv1t+xRZkPxOtb6NXuV1pOPtHb7B6hnuQnemkkcAp
    0QrFD4Is7b2h3ex3nidnSE4Q5DVcHRmCjBGpmg3+jrxCBpGmHNAjHDp+yo7i6IOO
    yWfq2TQmwkQ5yLFL7YlSg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeB0Mnp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 07:43:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:50672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752225AbeB0Mnn (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 27 Feb 2018 07:43:43 -0500
Message-ID: <1519735406.18525.9.camel@suse.com>
Subject: Re: [PATCH] cdc_ether: flag the Cinterion PLS8 modem by gemalto as
 WWAN
From: Oliver Neukum <oneukum@suse.com>
To: =?ISO-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Bassem Boubaker <bassem.boubaker@actia.fr>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Date: Tue, 27 Feb 2018 13:43:26 +0100
In-Reply-To: <878tbebopw.fsf@miraculix.mork.no>
References: <1519732192-29332-1-git-send-email-bassem.boubaker@actia.fr>
         <878tbebopw.fsf@miraculix.mork.no>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Dienstag, den 27.02.2018, 13:29 +0100 schrieb Bjørn Mork :
> Bassem Boubaker <bassem.boubaker@actia.fr> writes:
> 
> > 
> > +#define GEMALTO_VENDOR_ID	0x1e2d
> 
> This is defined as CINTERION_VENDOR_ID in drivers/usb/serial/option.c.
> 
> I have no idea which defintion is most correct, but I believe the macros
> should be kept identical whatever you decide. Anything else is just
> unnecessarily confusing.
> 
> IMHO the company name tracking macros have grown beyond useful a long
> time ago. They just make it harder to grep for the IDs without adding
> any useful information whatsoever. And because you have cases like this
> where the same number end up having different names, they sometimes hide
> information which a plain number would have revealed.

Hi,

I concur. Could you redo the patch and just use a plain number?

	Regards
		Oliver

