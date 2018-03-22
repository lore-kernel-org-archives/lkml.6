Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2727164-1521723097-2-14463729168350394805
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
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521723096; b=VIH6lSWxkTGzfKAnQyvncGtu7pGePMACUsc6xomtXZszoNb
    MfZXHAW+Ajgl/ywvVHVyXqFVte1q/rZX0I4cRmMcr9PQAfsivS7WYnvEY3vxelqy
    ETh8RzansHXL7zKMmZ4+NnSS+Gu2WBlBGkVpx/DDaWMaZRZQSrji/4o8UNSiMpuW
    Pta5Tff7p/NZyrLkNN/42URdWrNbQlAQLSchIID5Px2zQ9EkwFlXrdHFB1tJFxt1
    hhStHqyUQaBBd7GbL8bC8GS5qD87kvDF4Mu5cL/kWovHfmjN4CD4kAhbG7pN9i+m
    DB6ELOW9iBNM9zY+dkBQhM9DnlRE8H0y7rrAAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521723096; bh=jOcO4fDDMRDmCWVyMFMEEDSE5m
    MvYcxxP0C2hd4NiIM=; b=T/ullVaJWpVelwlpGE+xQPHQwTJ6yan46zoGR7M6Hj
    /9BwSq1LRxKsK/OHm7DMbjlbMyk8rQbLbrdqRrjtG3lC/kK9knRCCyr2CC4uZRMT
    6ot6tmvLAF+eJCi/GKOJ924WDe5jAsE3j+KPV1WtYyA5/HYT2DKAYceXzeUYqTma
    9F0DBF3stgsPVv6VfFkyFSTbcSVeI8IvzpwD8XadNu+cdmVZgsUu4JQHotI0hRom
    jh5dZdug3hpdlDk1Fv+Wpzixy4nFG3HNoBE3+lBCmcEC4WelNRkwyTKba04hTagE
    eDwRdBGvOtMf4tfBVUPNOY1bnG7T9O/TnOdjlWSDsSRg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754775AbeCVMvR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 08:51:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45146 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753796AbeCVMvO (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 08:51:14 -0400
Date: Thu, 22 Mar 2018 13:51:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>, Jun Li <jun.li@nxp.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v9 00/12] USB Type-C device-connection, mux and switch
 support
Message-ID: <20180322125111.GA15681@kroah.com>
References: <20180320125713.85465-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320125713.85465-1-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 03:57:01PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> This is version 9 of Hans' an my series introducing support for USB muxes, and
> generic device connection handling. The last version have been mostly about
> getting the first patch introducing the device connection handling right.

Nice work, all now applied to my tree.

greg k-h
