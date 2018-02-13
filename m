Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3807972-1518513604-2-10755506176834844925
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
    t=1518513604; b=w+ndwXsA3m7orfgJZXzKDrOsl2KXqeK4yy+PrnfHSjsGGDk
    WOtiNHkDKyutpeY/Kyi1OoKZQwfZKhsZO2iVjEYPlbNNsD7giqbxW0OKoTvggRqo
    CZeyOS7W45M8Fv/RAixCf22M8IMXKQV+tP95Iatd1m8YpdHkD+ohkP2ocrQuVYxW
    avN1DudlkthUCMlIIwYhM/CN9KoV6pZ6kkWpN4UJu4kiRE65jXYv5BYWWuptLT4U
    pamP76JfA+SCk6lnmAVhfBRIPfq+4VievNd65DTuDK7YCvmUqRjXRYun/FU9mXlI
    fMh0pVuewzeksFWmGKLmouHtmVH7z6a2CmGolrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518513604; bh=Ai5V3t/WLwgoMXpH10Z/FMNNCB
    Q6BUvTWHhTyhV/igs=; b=wpqM07jfFI+zdexBUFN0mygGRuJ0gnjrmz1uYkUoRA
    qCzW345/PT+CATn3VVVZ/PEsVu2eW3bcCBtU02mIH5jNQ3JsRfCj2JnAtET4Pod3
    IdgMAkRgsQHLmlB+vRznGgsCDJM/prgnySjRaRHjM44IFbWy9yiK7Pcv6t9IEQ5H
    v8sA4I5XcQ40spbtyArn+0KUJkXxaD1tnOyLtmmwMyMNJbU4UYMCZjCl1emWREc2
    S6CBSytpFT93FwKKWj7/FVQEdGPmYeQ4obqaFR5CTgoOAVl1HBvxvgbNdgexR7uj
    nBb9QPuXt7oDY1w59YLlJ2uECxmosA8aWq5UQ0fyrWmA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934474AbeBMJTL (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:19:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50410 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934331AbeBMJTI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 04:19:08 -0500
Date: Tue, 13 Feb 2018 10:19:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/22] 4.14.19-stable review
Message-ID: <20180213091908.GC13711@kroah.com>
References: <20180209133934.024795822@linuxfoundation.org>
 <21cefb90-d53e-0a8e-895c-adc42ef9a2ee@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21cefb90-d53e-0a8e-895c-adc42ef9a2ee@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 07:47:55AM -0800, Guenter Roeck wrote:
> On 02/09/2018 05:39 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.19 release.
> > There are 22 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Feb 11 13:39:12 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 145 pass: 145 fail: 0
> Qemu test results:
> 	total: 126 pass: 126 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Thanks for testing these and letting me know.

greg k-h
