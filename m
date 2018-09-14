Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201A3ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FBB2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FBB2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeINUiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:38:55 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35770 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbeINUiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:38:55 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1g0pwm-0008R0-J9; Fri, 14 Sep 2018 15:23:52 +0000
Date:   Fri, 14 Sep 2018 16:23:52 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Johan Hovold <johan@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/50] usb-serial: begin switching to ->[sg]et_serial()
Message-ID: <20180914152352.GB19965@ZenIV.linux.org.uk>
References: <20180913023119.GQ19965@ZenIV.linux.org.uk>
 <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-17-viro@ZenIV.linux.org.uk>
 <20180914133930.GF1362@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180914133930.GF1362@localhost>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 03:39:30PM +0200, Johan Hovold wrote:
> > +	if (port->serial->type->get_serial)
> > +		return port->serial->type->get_serial(tty, ss);
> > +	return -ENOIOCTLCMD;
> > +}
> > +
> > +static int serial_set_serial(struct tty_struct *tty, struct serial_struct *ss)
> > +{
> > +	struct usb_serial_port *port = tty->driver_data;
> 
> And here.
> 
> > +	if (port->serial->type->set_serial)
> > +		return port->serial->type->get_serial(tty, ss);

... and another cut'n'paste braino - it's set_serial, of course.
