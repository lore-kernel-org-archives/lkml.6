Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1974169-1521041621-2-10895414983126899017
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521041621; b=HlTsXgGxf0xmGldZp72UwjJYk0CX8xhg1VfVnfLITLkJfi1
    LB2ecX92GHtF5egL1LCG90rpjpZ/xR0DZYd3tLlsE2nTwwvIxTYJC18QAzjV8dLH
    iTazJqVa8QxWsBEChxWMCndOFdHPXnYmnGp5OTizjPyvdveNEPs8tYtC3jrVPru5
    Lz9E9zTtz54hMGS+hMA3XX0peWlmvZHP/VX5nx7j6bMddcHEHGFI7nWTol7Hqu6I
    mRT5CzOZ19bEQqO6UrS+g0+YTnef4U80pFF987WdyQvCaeE07OmnXSfc2hT/D1bB
    /U312AeyNBwqPzzHs+KpJ9+WeGkm8zAmbh36H9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521041621; bh=r7QQO7yhKyWI/gKgSqzjGe1GuvLue5pbCnpOqhXGkQ8=; b=E
    Pxk4T9elPAmykrTc8P7ZXslf88v5L3UcgGEMreANbfbFGe/lG73oN4nYkFST2S+R
    XLPLxQRy/4E26oAb/xJDGcLtKc5JIwvmZbgxXzhKNm34wCg3C2kvFxrIKUC4LbLm
    P4iCIGgQKA9WPlkDXk3rtOQ7G2JK/+cCHpaJs31IJiWtvPkq2NePIz5WDXqEeuph
    dYo9uydzXxfa3HMOsiuofGif/0eG3vxPz++AqzwRtf6kVGl/6MvpSa2lRRz/XaM1
    bcTd377Ae2zj62NT8p8NmYFu5bYDDcuM8PgEunVnzvl4GzkuGU7PK6u4BqwTlvE4
    1NQbKE+1Grd1KxtFekZ6w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbeCNPd0 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 11:33:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:40590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbeCNPdZ (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 14 Mar 2018 11:33:25 -0400
Message-ID: <1521041253.4511.16.camel@suse.com>
Subject: Re: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
From: Oliver Neukum <oneukum@suse.com>
To: Richard Leitner <richard.leitner@skidata.com>,
        Richard Leitner <dev@g0hl1n.net>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org
Cc: bhelgaas@google.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org
Date: Wed, 14 Mar 2018 16:27:33 +0100
In-Reply-To: <a97cd8ba-3934-dc88-8851-465f0313162b@skidata.com>
References: <20180314102933.21367-1-dev@g0hl1n.net>
         <20180314102933.21367-3-dev@g0hl1n.net> <1521029854.4511.12.camel@suse.com>
         <a97cd8ba-3934-dc88-8851-465f0313162b@skidata.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Mittwoch, den 14.03.2018, 14:31 +0100 schrieb Richard Leitner:
> Hi Oliver,
> thank you for your feedback!
> 
> On 03/14/2018 01:17 PM, Oliver Neukum wrote:
> > Am Mittwoch, den 14.03.2018, 11:29 +0100 schrieb Richard Leitner:
> > > From: Richard Leitner <richard.leitner@skidata.com>
> > > 
> > > Replace the hardcoded PCI vendor ID of Netlogic with a definition in
> > > pci_ids.h
> > 
> > Hi,
> > 
> > in general, why?
> > Does this patch generate any benefit for any developer
> > reading the source? I don't see it. Does it cause an
> > issue for anybody who has a log file with the nummerical
> > ID and needs to grep for it? Yes it does.
> 
> I'll send a v2 where I also use this definition in 
> arch/mips/netlogic/xlp/ instead of PCI_VENDOR_NETLOGIC from
> arch/mips/include/asm/netlogic/xlp-hal/iomap.h.
> 
> Therefore it will remove this definition from the iomap.h
> and move it to pci_ids.h
> 
> This will IMHO be a clear benefit as it removes a redundant
> definition.

Well, but it does not. Removing a redundant definition is a clear
benefit. But you are not removing a definition. You are introducing
a preprocessor constant. Why?
What is its benefit?

	Regards
		Oliver

