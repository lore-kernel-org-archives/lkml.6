Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3581790-1519282662-2-2052580874313827994
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519282662; b=q8YyaWJKys9HligDzcEhNQInwvhhDuh9uQNUQCbp4G+ZdIi
    TeKHPWMb+VfGmx8f4OxXVUzJZoQG6ap/ar6uZDMqOKuk40+zaQNUpMjA0YnZMSfN
    Ga3fGOyK+aiARK9SsNnIWskSnnL1vK0hJ5F2+o+ZZC14bxmd93X6e/6DT0zAg+TI
    b634RbSszNbxIVa+ISznUvt7YIEsojffW3rx5ZfN/nVpguybn43u5H41cjWUffEX
    F9Ow613apKw0fQ6z2oVJQOfU5ObCDidb/2LYbUKkg8aATQ3wDld12lT2IsM3X6Qm
    dUqUzSW2P6gNSGTP/Rq7iIR5W5B+EJiWpYrlpcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519282662; bh=wYWStBJMh3pv2SB0OD6XJ5gW0F
    ldmTSwsEWKXpxBqU0=; b=rCipwFIiQaWYASs5/1jhiHeDDjHJXjAXBBZp2Wf/ne
    XOs0ISCrfIN21ZMRjQmbt/Zv/bOLWLAX7drC2CPbBSg7u761VqjLTjTNt4qiDYnZ
    RiyWCz0zfyxDcsCKBrgk11mWX0BQPxB+BZplrzD2ri5lTDBSEWN+pmBigv9F2Hu4
    mLTifCmQErMXW7CgpLWIzte8TftjqMzQKxlwCM9X3DsUrQki66zntYowQsGGWSq4
    ya03g6VZxw+fFW92zNI6QI1JH8jH1es/gn7Mqauk81C+LuHgjQ8oAZYEAEldsREv
    73COR0mYjfPWn6VCsOwLMvPuzAs28nwDwl6Zr99EVFHw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbeBVG5l (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 01:57:41 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:33698 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751594AbeBVG5k (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 01:57:40 -0500
Date: Thu, 22 Feb 2018 07:57:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Yves-Alexis Perez <corsac@debian.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4.9 34/77] powerpc: fix build errors in stable tree
Message-ID: <20180222065738.GB2428@kroah.com>
References: <20180221124432.172390020@linuxfoundation.org>
 <20180221124433.618725458@linuxfoundation.org>
 <87k1v5rg66.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1v5rg66.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 12:01:21PM +1100, Michael Ellerman wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Nicholas Piggin <npiggin@gmail.com>
> >
> > This is just the first chunk of commit
> > 222f20f140623ef6033491d0103ee0875fe87d35 upstream.
> 
> That should have been back ported in full?
> 
> Oh I see now Greg took my 4.4 series and applied it to 4.9 but this one
> didn't apply.
> 
> So I guess this patch is OK for now, but we do need a full back port of
> 222f20f to 4.9.

Sure, that would be great to have, I'll gladly take those patches :)

thanks,

greg k-h
