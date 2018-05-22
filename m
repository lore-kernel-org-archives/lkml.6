Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2274571-1526981258-5-12037421414191628346
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526981258; b=VebZuAjijFwgpUsRQtogdI3k+5rxWevHTl7Q4XyO05r7wkHvf6
    hCGc265AC3BIMFUhf8v5A+aVYC33W7OjHW6hFgx9+iv9sB6/YSjFk2Jo6HPc/kP7
    4r1IXd8l1oSZm+vqlqRxmqz/x5zLJPTxJ6O85zlje+uhdfes7FNh7THsu4rO2dIU
    qxJYBNPJHnzRrimRoQApTKhflUFd5WbcgRtfGLlK19Uyv4kSlpmlYdQkyyiqgS8S
    7vjx62bIq0ymtP0Vox3wqzsEIx6YY5Pf+WRTdBowqB7jeUV79LuDAl2fVB9+li7R
    m/fdQpVymvvaJTxO/bXmWy9mVB7inb+eTqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526981258; bh=ohb+oJkFQuPVWe8pItUC8Omi6eyJLB
    684yvJZMeOBGo=; b=c1NqcPjQe61Zuxj8WxDSxbAzQ0lpGE8BGJ5x4za/1A/1Ad
    VDj/fM0Kwfo5K9Rf9PLV3APkIibjAd/Ua6TYJEyWGoSacJt+x2m32fn6v0O05dCD
    8LixliVJDn466Xf+Q/3v/6XCWX4P/Sn2ANe6V2vdccZBae0OEBjO+mzVxclx+3Th
    iRkJBnGNzFv6TqjHrWpOZMMKpISi9Gh33VacQCN4L5t3Kr70VRQmLVQfjDK8AV4g
    IAYIUzktifZVun24n3BJuCvCQl9Jruze6U84Q/eJNtjeWPOXipvduK09ZmWtTZkZ
    PJawoaVINF8vxWDT5BZ+pfBED2mmoYMpgeMx1BQQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=sGliqEPm x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=sGliqEPm x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKO+I+NUk/fmJzTwWyaOTqDBUXtTVmwnqChnK3tqP+6nqMncL1uhSr7mUDIfJZ5AIHpDuPI+ZE5xxAeDrFmVO//16bCKIcXU3+JSNMwFYcrP3EKEIg6M
    zhynUZpC3HYgfm5I5ZZ+cHfP76W9f/EtTBEVCicXy5Z2/116P/iuw6YyXferxmADnFk8mW8OeD48pilXdsI+NOaE4hs6MZMP6sxRdGZQLlK/i5FKk88jsj+J
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=e5mUnYsNAAAA:8 a=ewmiK5UvoZQ4ywtmSkcA:9 a=CjuIK1q_8ugA:10
    a=Vxmtnl_E_bksehYqCbjh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751229AbeEVJ1f (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 05:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEVJ1f (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 05:27:35 -0400
Date: Tue, 22 May 2018 11:27:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Martin Peres <martin.peres@free.fr>
Cc: linux-kernel@vger.kernel.org, Oscar Mateo <oscar.mateo@intel.com>,
        Michel Thierry <michel.thierry@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        stable@vger.kernel.org,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        mesa-dev@lists.freedesktop.org
Subject: Re: [Mesa-dev] [PATCH 4.16 039/110] drm/i915/gen9: Add
 WaClearHIZ_WM_CHICKEN3 for bxt and glk
Message-ID: <20180522092716.GB2440@kroah.com>
References: <20180521210503.823249477@linuxfoundation.org>
 <20180521210507.389445775@linuxfoundation.org>
 <f70c125c-605c-db9b-9c3b-2e3abf1359f9@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f70c125c-605c-db9b-9c3b-2e3abf1359f9@free.fr>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 22, 2018 at 01:09:07AM -0700, Martin Peres wrote:
> Sorry for top-posting, but why is this email on mesa-dev, and not on
> intel-gfx? I mean, the latter is for the kernel driver while the former
> is the userspace 3d driver, so intel-gfx@lists.freedesktop.org is
> definitely the prefered mailing list for these discussions.

My scripts are picking up the following line in the patch:

> > Cc: mesa-dev@lists.freedesktop.org

That's all.

thanks,

greg k-h
