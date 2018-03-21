Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3618868-1521625361-2-18223697352187651747
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521625360; b=GODSS1jDdp8me3iSBjNHyuXyC7LSw9RHIEem1S728kZgZrI
    A1XJvcsiy/WkV9yjsyU7mLczAZiGGcnqUq9SCqzf4gtLEtuQN5T3TDDwwJOE5Opg
    BiUORT1uZLOhesQkV+4UKBgokW9sjxEdm6Ml/mRDcb6DSnYpqIQyVqBSKcXSAqKz
    LdPXyi9mGDAPRP8xi45P580EBqWQ5METK6WtH3y5CiLyrpdBDOBi0Qt19g2tqRKL
    +va/uTTnRzPjQ4ImYuBXGi5nTaaKYNatEE6Fc5kBdFt4KxExrOllsgD8WcVcbijW
    +odWIx0Kn+t/6gslDuZZmVLgID/Ulc8GdY6QxeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521625360; bh=dFJis3GJNSmGRahcS6fWkSl9wt
    X7nQlbgvsyL7q3k5w=; b=ivqRwsVoIqsnw7QKTfQzaH/KgtJf7ockTg48hAPQGq
    WQRbycRcCWQgNHCGCigmbiG2Wu8N4aOArSopH3gTGemrcbeSJWPzworIJVvMmJRi
    nW26aHuGIPIcLaGHTz1zTNGrSUSPwNdTDMlVI9x/0EijrLbOn8Uh740lclxn/Tcf
    2PKbsnLzQZvYK21U05kj6pOa19qMtw5ea8IUZPs4K2MlsS6GIdgx9Lzv5GAN7VJQ
    ouq07Y+X27+NCXmuVhGLv0m3AzTMrbfBkDnz7yjRGibBY4mjYdmqEKq4pVUNHXv5
    SEokmwydvR5URG7geKmszWZWc7HuWlNIpxfP70XvKq2Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeCUJmj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 05:42:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42350 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751459AbeCUJmi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 05:42:38 -0400
Date: Wed, 21 Mar 2018 10:42:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/52] 4.15.12-stable review
Message-ID: <20180321094235.GA16947@kroah.com>
References: <20180319180734.976730813@linuxfoundation.org>
 <a5af1d4f-1ad8-4cc9-65ec-a05022a99b7c@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5af1d4f-1ad8-4cc9-65ec-a05022a99b7c@osg.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 02:11:59PM -0600, Shuah Khan wrote:
> On 03/19/2018 12:07 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.12 release.
> > There are 52 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 21 18:07:15 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.12-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No mdesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
