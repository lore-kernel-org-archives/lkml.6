Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1528056-1521028214-2-16784283526072097894
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
    t=1521028214; b=Y9RemGQ6I3/GUzED1I8+cBC4/Np3KHBdcVwjvboqaJAdlaE
    SF0LY9o7MGsXIB91eMwJG2YT3wPFOkprhZyvB9FfNLEpfFj1C8xZW6UFwzsiqPAk
    ukQ0+WRlGdqJS58PmL0JgHlZogNgwmoTqJONZuT8Bc6tPBWYfewUQmRgXzXkGssQ
    CNKpxRkZm18FQ20ndjkuKxxBJzDq4wEGpxHKb6Tp+DEmVfY8aBnWXkVIRhZEUb3I
    5GMyGZMjMDoQuMWdYJThJavbM6s8vMZLuVZxTwGrge11ttMTIg+F6W1Dd4xmInyd
    T3XLO7oIHfiWGm6QLlJXN0C4KSEhPOt7ViuCKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521028214; bh=f7X0mJrT8bNOp+w6C+3jr97aIg
    cZ7d5GR0EGyIEZiS4=; b=tNO9AjnIxa/tw9VH4MvTrtjiozTOHL7Bl6iDx1wQW4
    svcTPxtZdp0CdJ6XyihPyaiwoSdOm2JUHWwmP3L4xdx9y8qCYcu4FJ82ebxe04v6
    u6flSDRLFwTrCUQNAFDAgAoofqn1y5qJKU5Bn8K08cUWm+Bd19shTOLlVsUqSqto
    1Lt3UEvtlkbARdYri7O4Lt39pghLXyui1hQiBWQiKz/8+WzVABJuw75lQZDFucA6
    dDt+9rjlhDSRObSWoHr5IXuge0GSYKvuiqJUbJXsN/jqUxFVEx4o/ngR3Kw8/WPS
    FG4weX9mpCE6rcNzHqfc78rFQg49pjZXwugrXVqjrc9g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbeCNLt4 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 07:49:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeCNLtt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 07:49:49 -0400
Date: Wed, 14 Mar 2018 12:49:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Leitner <richard.leitner@skidata.com>
Cc: Richard Leitner <dev@g0hl1n.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mathias.nyman@intel.com, bhelgaas@google.com
Subject: Re: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
Message-ID: <20180314114948.GA25368@kroah.com>
References: <20180314102933.21367-1-dev@g0hl1n.net>
 <20180314102933.21367-3-dev@g0hl1n.net>
 <20180314104849.GB32615@kroah.com>
 <d755d623-2bb3-460f-45a0-2be6ab6f47ea@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d755d623-2bb3-460f-45a0-2be6ab6f47ea@skidata.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:36:17PM +0100, Richard Leitner wrote:
> 
> On 03/14/2018 11:48 AM, Greg KH wrote:
> > On Wed, Mar 14, 2018 at 11:29:32AM +0100, Richard Leitner wrote:
> >> From: Richard Leitner <richard.leitner@skidata.com>
> >>
> >> Replace the hardcoded PCI vendor ID of Netlogic with a definition in
> >> pci_ids.h
> > 
> > Why?  It's only being used in one file, so it should not be in
> > pci_ids.h, right?
> 
> It's also used as PCI_VENDOR_NETLOGIC in arch/mips/netlogic/xlp/.
> 
> Should this be replaced with PCI_VENDOR_ID_NETLOGIC from pci_ids.h?

Yes, if you are going to add it to pci_ids.h, it had better be used by
multiple files, otherwise it does not belong in there.

thanks,

greg k-h
