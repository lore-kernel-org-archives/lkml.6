Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2422763-1526378412-2-2701544786066156791
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526378411; b=eBDapF/N4P8mpFt00BX/E0Xlv3PdBSxkRECEfsM8KFZwNfCeru
    2sPWQc/zWUxK2JOTwHjHLZU4pmxU39H60/yWM8MdTvmTQ0CE+FFeYFiWUGdZWx0+
    Oj1jTrE5gVAkrEU6dcTNB2hZnWA02IuMWe9fX/4j4t0S1COo+DspcTVWVjUAIxTc
    bBAg0T4OGGHtQhlUQ/VhyuLEEF5E51JUOAz9LBxsWjFNZPw++nR94c7EMeJMuOcr
    FoRpJJB2ssCOkYGn4snJ/ejgM4JWy29CRxJ6hkIUG0PPPalQ7OMylc4MN+XAod1N
    sp/z/7Zjt7I7PhYNJLKuDKMEklhf4dx8OGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526378411;
    bh=P4Z6LbAtUh90kaDJq19WkwuxFLZhvccgiPlYwH7ra0o=; b=jTeZPyYVYbU1
    wxxVGmUwJFnH+pDkvhmZXYz1OjQsOCzb+IEGjosdnR16DQBSgUIOVpUGP6a85vrN
    M2gbB6XGkb94w+v5YfddbaRhQV/JBFxSpMR6kdGZLct0EVqzw1/Aw90mIMkaJIPM
    XTdL85O8hmPVddIUk8y5QGF/Cyvk8bYmIDnok2pDTzMDMsCjGqoo0kNUc0JIjmh8
    NLsLSOCvHueH42pwJpM1VYwQbJ5PxAfAsPrONdfL+PDQtszFCJQ0vTS4mWi1+arr
    /pSAtPRwwjK/cvDP/EjrnTeS7udJq+Oq+r1VUVcokgfWHYga2PeDNAd3q8zSn9Su
    HRqTW+JZCQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCPNXKKA8mcWT9KDxR14JhOt2QYktPoGkQEuSENwc3M5sGm8YmUejfbwnqvhQFtUrZAaMzKkltCBS4SAs4nliPLQOA/JvSWCOYQ76qvFZyHvcPufQFOQ
    c7yZoTaRz3uCpjYq0SXjU/IhHGO1aabdbsdW/bQh6UFUHKVn+e8QtpMEtOOLj4evP65ypIzHqw3pNSmibL8DEf9ONakYMYVajNj09UWp4YfDc18ECD8yzO6B
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Fv8ztFUvdHPspAkbbXgA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeEOKAI (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 06:00:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:58271 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752453AbeEOKAI (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 15 May 2018 06:00:08 -0400
Message-ID: <1526378007.2724.2.camel@suse.com>
Subject: Re: [PATCH 4.4 49/72] media: usbtv: prevent double free in error
 case
From: Oliver Neukum <oneukum@suse.com>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Tuba Yavuz <tuba@ece.ufl.edu>,
        GregKroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Date: Tue, 15 May 2018 11:53:27 +0200
In-Reply-To: <1526319669.9159.20.camel@codethink.co.uk>
References: <20180406084305.210085169@linuxfoundation.org>
         <20180406084309.317246829@linuxfoundation.org>
         <1526319669.9159.20.camel@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Montag, den 14.05.2018, 18:41 +0100 schrieb Ben Hutchings:
> 
> Shouldn't this bump the V4L2 device's reference count, i.e.:
> 
> 	v4l2_device_get(&usbtv->v4l2_dev);
> 

<censored>

You are right. Mixing refcounting sucks. I am preparing a patch.

	Regards
		Oliver
