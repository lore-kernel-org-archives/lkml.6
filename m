Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9278AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4B02147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 15:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546873363;
	bh=zSv1iOrzMgPo2fh4rz0MB0rFy/dH44bZNW65Nm4W7uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OXT5LH8f8/W2qLbrh6yfAZ8nVzc9aKQNsv2TLRmgO42VSjkudfnRn286WLJXPSLJM
	 AgEPmpuU5DOEttQ3cE8ZVK3D8mlLjQJsvoHJNZMdrneGNyQutyNfcpffPkZMlSrEIl
	 WAj16lBxQ7lam5ti+EAy6YOyc+2ChvXutPqN+WAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfAGPCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 10:02:42 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34042 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbfAGPCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 10:02:42 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so520360lfc.1;
        Mon, 07 Jan 2019 07:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BelAoWLhd6eqdV3svpnJcJgq4uMhwMzt4AqEIwHU6Es=;
        b=DgKEGqRTA/3LarypFLKG9SMaUzyfTV+5GX7J6mWOCkYP5HmLtZUhpmbESWhxXM2YTd
         mNIwT22sjz69ZG2sD7JTltDGKQ+MshklncYnNXqkIohpPpWEzg9bhAbOUzoiP1XNbroq
         oEV23mHVqHDFL+mrhtiyb0NEyTNG15HEshHZdS7QTwSJGCnAsGXytTxSHuqDp2B7ADSR
         yc6OFGziShnqRt7zknVpUfgrjJXztm2dA16REqxEbAoBszw3WCqcD4bojXKlEy5qWExU
         EyNfyFuxy+DdO5l84MZYCJfd7OSyZjWEFLmiR2Vdd3+bKMRdoLHX824yDGyZon79dTHz
         8zPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BelAoWLhd6eqdV3svpnJcJgq4uMhwMzt4AqEIwHU6Es=;
        b=tYkNy6hYAZqttX6qwRbkhPvZkRNiDKZnyFCRgliZ3DoMwONOrBgbAhvXXQYoxTnO7E
         GSdW3SGzZCQxVhCrLW1yMq5YfZQtRY+I5BR7UVx0YT7q588evdQQgvgg9cEUE76ahp6h
         2pqVPrerb/iH8890zSuelhc7DsM4uIBUNmJG0H2uSYBx1AAa+U1p9zGIfghczVwSEuUs
         IFTw4IyMSASVcrX1csWKI8C1WpY/t/QIOO6z/W3uIfrisol5unzTHR3CCH04eJfZaDVc
         SmWTl+vyYAGMk+8/JvBA+0kRD2It6m97cTEsbAUDr3By2f06q6c0zq5QPC+cQtIEzd5a
         e6jA==
X-Gm-Message-State: AA+aEWZiCQHxWQoWyelHJP9o0IlNkLJ34f9zQMIjMqqw+RJhE883SwC0
        TNaHzceLTdeXMapf7307s3uTwB/Z
X-Google-Smtp-Source: AFSGD/XV77ie+/6Pq+vD0+xfF91+7jS1tW6nj9TXQNMlyoqqvmE5cG9kaIcQriO57sB97FrEBOhJEg==
X-Received: by 2002:a19:4402:: with SMTP id r2mr28390442lfa.111.1546873359612;
        Mon, 07 Jan 2019 07:02:39 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id x29-v6sm13823084ljb.97.2019.01.07.07.02.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 07:02:38 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ggWQJ-0003Ms-08; Mon, 07 Jan 2019 16:02:39 +0100
Date:   Mon, 7 Jan 2019 16:02:38 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-lpwan@lists.infradead.org, linux-serial@vger.kernel.org,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH RFC 4/5] usb: cdc-acm: Enable serdev support
Message-ID: <20190107150238.GB14782@localhost>
References: <20190104112131.14451-1-afaerber@suse.de>
 <20190104112131.14451-5-afaerber@suse.de>
 <1546868906.3037.37.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1546868906.3037.37.camel@suse.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:48:26PM +0100, Oliver Neukum wrote:
> On Fr, 2019-01-04 at 12:21 +0100, Andreas Färber  wrote:
> > Switch from tty_port_register_device() to tty_port_register_device_serdev()
> > and from tty_unregister_device() to tty_port_unregister_device().
> > 
> > On removal of a serdev driver sometimes count mismatch warnings were seen:
> > 
> >   ttyACM ttyACM0: tty_hangup: tty->count(1) != (#fd's(0) + #kopen's(0))
> >   ttyACM ttyACM0: tty_port_close_start: tty->count = 1 port count = 0
> > 
> > Note: The serdev drivers appear to probe asynchronously as soon as they
> > are registered. Should the USB quirks in probe be moved before registration?
> > No noticeable difference for the devices at hand.
> 
> That is quite drastic a change.
> Johan, how complete in terms of features is serdev?

serdev doesn't support hangups yet, and that's precisely why it's not
enabled for hotpluggable buses. That would need to be fixed before
accepting something like this.

Johan
