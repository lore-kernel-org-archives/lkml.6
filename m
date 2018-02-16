Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-881694-1518810270-2-8277413982914132590
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518810269; b=WSVPxXjoGm3etIM8xMNbTCng9ObVSAv1JZs6Rv4nQsX4tD0
    OuNirmAy5NnL+oqQXNCLIWczMB6QrrMn4+7ZsvJLvhT+rgFzS5CGgsrWaGGEFRHG
    bQMv7u8MU6WeEswDfuiEMZNO6/WrIt4oeH4lAXfkyAiRXPQ6klK9eRLyak7gLQKy
    Lod1nCWxhD9nbD6ELQ58zLtZvjmp4CCmV+l5V+wRgrgCFxmCFTlVov3CbVzCOJmI
    nOVvlr3UgEkwpGiV1ivO2PYhUhhUxA9MbCEAoo2xhslu3I9VnUYBpHOpzuWmR+O/
    b/ADLuyGzQgiuDdMtHjb5qeOM+A3IxGUc4GEPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518810269; bh=48j3dd8B7700B0eSSC3uxRy0ul
    e6Wxf7wiM28eb9ZP8=; b=thzVQBbc8XNd1dK7EabM6okKMznWWosGmQi6u/Giro
    lSGx75PlsT8bNCTE+sDvnplE7OB7RLAYVl6klhiGbokjFwCybXooeYXCD1rFKfAB
    ra+qG7qYeb1zuv2LGLg7aeOKARF9fkMuqqnp0JXIpNlNRkwoioIED4uAApSk/08o
    i+8DiaZX+1tpGVVtx87C72ZkgxNHtBsjcgunZfyydcPB3IsMP4elD6RC+p/Ta683
    z2Hxh0+LBeD7QUl0wbpv69AZ7+LHXTeqDLY8sATKiQfywGPhr1hUOsNSRwUwGszO
    IVosm8PzOj2iUjeU2Nw1XAJZ84Lee1WFW4PXii+NvIxg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbeBPTne (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 14:43:34 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60184 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbeBPTnd (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Feb 2018 14:43:33 -0500
Date: Fri, 16 Feb 2018 20:12:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/108] 4.4.116-stable review
Message-ID: <20180216191221.GA5080@kroah.com>
References: <20180215151222.267507937@linuxfoundation.org>
 <47ebcf21-490e-9307-5796-6dd7bf5b95e5@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ebcf21-490e-9307-5796-6dd7bf5b95e5@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 06:12:56AM -0800, Guenter Roeck wrote:
> On 02/15/2018 07:15 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.116 release.
> > There are 108 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat Feb 17 15:11:36 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 145 pass: 145 fail: 0
> Qemu test results:
> 	total: 118 pass: 118 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Good, thanks for testing.

greg k-h
