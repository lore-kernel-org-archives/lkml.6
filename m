Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2147157-1519756440-2-4020229829778438601
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519756439; b=IPxxxa+CgNdGslOjmmyxL2nEuQajlaMZfrGEUp1ec57RsYq
    gQ8C0JmQyEVB04vFCctlD9H4FpoTJf8HZY8KTBl3VchKEaNj0eDWVAUbPWAh9CAs
    P+FUVyJkfQB+Rz5IZWvjVq3zKEbdsCATsmtogNkYvr68FDdcTR5As71SxjTpPzQZ
    BBU6ioqdV/eQICRnrrl1voQaDYpYTJosNmZJlqt6dFxFD54u2Mj69D99q+vZ9vlp
    Ms5k+7H8SMuTO9kJV0KnjKtZ4gKVU/7rdtji9azaXSGlLKv5cCjrB+0VRAiJ6lMI
    cRiP94nO5Kgh4kI61bZCZQfq+UDQJEl+Rm/J98Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519756439; bh=Lr4fKpc
    2msEqPJ6XbZKJu4ExfreTdInhMqZRgh8zxmc=; b=uESFRZWMJyqlqBwXnk19P9Z
    MaVvxmn40Xzdueq639hYnidP1ktpnUxCRxlKQG9dMQ6cfe7KQQrMtJjnHir32DVZ
    N8YAS9B/xlemap+KuoZLHlGHyRW/bSMrXwB1YErwS6cWMSEB7m0xvzQHEDRiYKgY
    VqE29HSbJ+jN/QMsnQPJFTJm/rulx/K+gVQwqwUaLG5tFyTn0/kXcfDt5X2cYruY
    qDUhwH9pO5d6SmSDEArEZhoaTPdWQtCFC96y6FXZaI4DCZJRFOdJ7Bt7TDw+thZv
    odchuoErbrqDxlzFTYot51CWBYNARKjzLzDIcKW36wp/JGaqX3SL3j2UGMBwANQ=
    =
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeB0Sd6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 13:33:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56954 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeB0Sd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 13:33:57 -0500
Date: Tue, 27 Feb 2018 19:33:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/22] 4.4.119-stable review
Message-ID: <20180227183358.GD20601@kroah.com>
References: <20180226201558.681421374@linuxfoundation.org>
 <83e6d140-bf24-0d20-5e0b-e442b6419e9a@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83e6d140-bf24-0d20-5e0b-e442b6419e9a@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 02:56:34AM -0800, Guenter Roeck wrote:
> On 02/26/2018 12:16 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.119 release.
> > There are 22 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb 28 20:15:48 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> xtensa:
> 
> arch/xtensa/mm/init.c: In function ‘free_highpages’:
> arch/xtensa/mm/init.c:335:2: error: implicit declaration of function ‘for_each_memblock’
> 
> and several additional errors in the same file.
> 
> 3.18 is also affected.

xtensa patch is now dropped, thanks.
