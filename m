Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeE3OEX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:04:23 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40281 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753069AbeE3OEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:04:20 -0400
X-Google-Smtp-Source: ADUXVKJESzZ7jYAZiLkEqtsvHxrRDZp9vXB+EwrDvT3fZgGTYMIv3VLDniMnnlv7x/fZY+1hNhO7iw==
Date: Wed, 30 May 2018 16:04:15 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Felipe Balbi <balbi@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] usb: gadget: ccid: add support for USB CCID
 Gadget Device
Message-ID: <20180530140415.GE2939@gmail.com>
References: <20180529185021.13738-1-marcus.folkesson@gmail.com>
 <87r2ltcopp.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2ltcopp.fsf@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Filipe,

On Wed, May 30, 2018 at 03:28:18PM +0300, Felipe Balbi wrote:
> Marcus Folkesson <marcus.folkesson@gmail.com> writes:
> 
> > Chip Card Interface Device (CCID) protocol is a USB protocol that
> > allows a smartcard device to be connected to a computer via a card
> > reader using a standard USB interface, without the need for each manufacturer
> > of smartcards to provide its own reader or protocol.
> >
> > This gadget driver makes Linux show up as a CCID device to the host and let a
> > userspace daemon act as the smartcard.
> >
> > This is useful when the Linux gadget itself should act as a cryptographic
> > device or forward APDUs to an embedded smartcard device.
> >
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> 
> this could be done entirely in userspace with functionfs, why do we need
> this part in the kernel? It does very little.

Andrzej pointed this out, and I actually do not have any good answer
more than that the userspace application could be kept small and the
important configuration of the CCID device is done with well (I hope)
documented configfs attributes.

> 
> -- 
> balbi

Best regards,
Marcus Folkesson
