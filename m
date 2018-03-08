Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1437685-1520499660-2-17112962592974553254
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
    t=1520499660; b=YYCwcbhIUoFe1BAXTf9lDWVkvKUtlWU6fBHdLd+AFvlqWxK
    2tkA5SmyjiYSZz2XZCEc12c0TTmqBssouuRt0Ih8bqgleManrRuaZw50LgkIvKnT
    IIJsoY+o4sacO96LLHjl8lk572Pmg20PMphsD9zq9SVT2NvFOadV8To9O1hmcyz1
    SGeegrmtnu/efMX0VB5AYI8a31vaXE1SvO18KzyeHnQ4m0yrQa5hX0K/iiNDxCkv
    MUpI/1OknqO6lul6JvVl9yVVly9GKu8eAb6IepivGlwGpJcpHsCqzILxPBaaVhM3
    Zv+sV77mUBRJ03sc1ERKmWoEakjIqbGs9c76BAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520499660; bh=NEiYbpGlJB1VS4yMymM+T5sUkfC0qPnRZYumnRW17N8=; b=M
    XYSBje6isLWx3eORrFVhyZDvc0KqqQEX42++PvvFLfmji3/gQB5IhYY1cuZU1n8V
    PQkEvoSITDJUycPw+o3oHba7YTnULbSLvXiw+/GCvYbXjFP4BVcyj4X8H6ZYlsz4
    FUYAbe4l2lEZ2klLmq+r0GVefjjhxkMUSbXRgqE3g8aZIugIXzsn/nAouG6kNcwS
    AdZQBKxIQ34tpcI8x/2TkWfmA1LLEWfTftxML709hzIMPIzoxt7VeyUdJOXP2XPM
    EzNoRqv2JsGfUtqWkV422TUCKHBLzg45eB+pU3ODVy1jCRbb5GGjkdc4WBJdoPjx
    oI+z1KXNY3CMDlEzY7ZQg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S1755304AbeCHJAn (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 04:00:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:42022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751971AbeCHJAm (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 8 Mar 2018 04:00:42 -0500
Message-ID: <1520499297.2983.3.camel@suse.com>
Subject: Re: [PATCH v1 1/1] USB: serial: Add boundry check for read_urbs
 array access
From: Oliver Neukum <oneukum@suse.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com,
        Greg KH <gregkh@linuxfoundation.org>
Cc: johan@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Date: Thu, 08 Mar 2018 09:54:57 +0100
In-Reply-To: <0055f93b-8497-5dfc-4233-9cc72bf690fc@linux.intel.com>
References: <f48feae7582a5669422066b4821a9e310eebc9ba.1520454192.git.sathyanarayanan.kuppuswamy@linux.intel.com>
         <20180307205840.GA6242@kroah.com>
         <0055f93b-8497-5dfc-4233-9cc72bf690fc@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Mittwoch, den 07.03.2018, 13:41 -0800 schrieb sathyanarayanan
kuppuswamy       :
> 
> On 03/07/2018 12:58 PM, Greg KH wrote:

> > So I don't see why your check is needed, what other code path would ever
> > call this function in a way that the bounds check would be needed?
> void usb_serial_generic_read_bulk_callback(struct urb *urb)
> 
> 385         for (i = 0; i < ARRAY_SIZE(port->read_urbs); ++i) {
> 386                 if (urb == port->read_urbs[i])
> 387                         break;
> 388         }
> 
> In here, after this for loop is done (without any matching urb), i value 
> will be equal to ARRAY_SIZE(port->read_urbs). So there is a possibility 
> of usb_serial_generic_submit_read_urb() getting called with this invalid 
> index.

If this happens the function was called for a stray URB.
Your check comes to late. We have called set_bit with an invalid index
and other shit.
We definitely do not just want to return an error in that case.

	Regards
		Oliver

