Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id QfVuBwdxGVtdaQAAmS7hNA
	; Thu, 07 Jun 2018 18:00:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 905C06074D; Thu,  7 Jun 2018 18:00:59 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XTH1QN2n"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 18378601C3;
	Thu,  7 Jun 2018 18:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 18378601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935063AbeFGSAm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:00:42 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:40641 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933126AbeFGSAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:00:40 -0400
Received: by mail-wm0-f47.google.com with SMTP id n5-v6so20873908wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bSThr/Wzb/iXXPsZ3PXcPSOZ0vljyPrk4SSgppfj2ac=;
        b=XTH1QN2n1FvuJo1tCjdRj64lftJTonddhavePGW3+WJEPaYvVQhjh6y8thjlHR31Pc
         RlJE32wEVZmBHSAQRy6PqoBSpOWfkiJdmuExE8xoiK23dh2ARfpDn2vH/0/PLaU0glG1
         6WONwem0mlyMb/8uf+aGgDj2+L8DbtvTEXmB45JzBcwhzcPSbiwS+o6FvDKPWpmJjaRJ
         JZMOhGDJxF6wX7kFHRwU63aM6PS6igs9OlOmRA58GeBNdonDX8y1GasEXeA4E/91sGUX
         V9DM0MfnYJqMs3Uz6jCZAkfUVwe7tnYEEvzVUx1PJDV2RFYKlDGYGZ71n8OBySeEVPTq
         JdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bSThr/Wzb/iXXPsZ3PXcPSOZ0vljyPrk4SSgppfj2ac=;
        b=PQ9ytpsnx5WJ1LXQjfyyrbi5y9wFjRJKfcTnJidzaRnZBFITqGvfBETFDmjQ+7rsvK
         Qy07bIqihHbqjwAKa2hCM4yi/lG7TV29E0Sba0wejX0GWqAomyuNdklKJYl9fCtlzn6B
         iWVbCRwTrkDEm0o09gTREYJ8jmA138dFjE4rK7878oNAeXzdf9KCX8/t8MnBBGvEczTe
         OLfyiSCqh3M+v14rtqWmg4DLYmcW6X1s1K8kzxH6WFoOsHxpX+Mny+XiML00csXoV8I+
         fDx6Q7X8YAs9i0gBtRzsEcnBiX1DS/dYJ32WRlrpZ3RehLqbQGs9lBZa2r0xIt6oiKac
         rSgQ==
X-Gm-Message-State: APt69E09YXXe69gG7aQ5lQzPgRh4BoZR740wmZCC30/NqO3oEH0PZTai
        5NzWGNHsaNmm/NeSBxy9Y5n8fA==
X-Google-Smtp-Source: ADUXVKK9Z2QthIcjfutu84t9h9/saxguFiedhvknizR8hQoZvJC7i0FJ8IWynbC3VxYO1eZeYnYvjg==
X-Received: by 2002:a1c:443:: with SMTP id 64-v6mr2505952wme.140.1528394439233;
        Thu, 07 Jun 2018 11:00:39 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 76-v6sm3108944wmj.0.2018.06.07.11.00.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:00:38 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fQzD8-0002Xf-EV; Thu, 07 Jun 2018 12:00:34 -0600
Date: Thu, 7 Jun 2018 12:00:34 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Greg Thelen <gthelen@google.com>
Cc: Doug Ledford <dledford@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        swise@opengridcomputing.com, swise@chelsio.com,
        yuval.shaia@oracle.com, linux-rdma@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Tarick Bedeir <tarick@google.com>
Subject: Re: [PATCH] iw_cxgb4: add INFINIBAND_ADDR_TRANS dependency
Message-ID: <20180607180034.GD14583@ziepe.ca>
References: <20180530220405.GH30754@ziepe.ca>
 <0be4e0fb-8d8e-b337-fc8d-550c90829d8c@opengridcomputing.com>
 <20180530222520.GJ30754@ziepe.ca>
 <d2472443-3ae6-63f4-59ad-d6367b837038@opengridcomputing.com>
 <CAK8P3a3HZXTR60ua=cjBHnB5FWWKve9F-JqcNwn0ujks+=FsNg@mail.gmail.com>
 <20180530230136.GK30754@ziepe.ca>
 <CAHH2K0ZLDmsPNw=sOobL=+R54yRFrnG4syWcW43UEbwxsvFehw@mail.gmail.com>
 <d23e215a30f1277c941973043262cdfc60c71315.camel@redhat.com>
 <20180604230745.GG24926@ziepe.ca>
 <CAHH2K0baMto7A75YxvP9LWtR9wgAFY76n_2q3fX_b=qcnuX1mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHH2K0baMto7A75YxvP9LWtR9wgAFY76n_2q3fX_b=qcnuX1mw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 01:10:39AM -0700, Greg Thelen wrote:
> > > I don't really think I like this approach though.  At a minimum if you
> > > are going to make iWARP totally dependent on rdmacm, then there is zero
> > > reason that iw_cm.o should be part of the obj-$(CONFIG_INFINIBAND)
> > > Makefile recipe when ADDR_TRANS is disabled.
> >
> > This makes sense, Greg, can you send a followup patch with these
> > items? I know this series has been tough..
> >
> > Thanks,
> > Jason
> 
> Ack.  Sorry for delay.  I'll take a look at this in a day or two.  Let
> me know if it's more urgent.

No rush, sometime in the next several weeks is fine

Jason
