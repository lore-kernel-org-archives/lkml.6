Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6D5C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23381206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixa1xoiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23381206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeKUDlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:41:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40824 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbeKUDlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:41:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so1875064lfe.7;
        Tue, 20 Nov 2018 09:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GtnldkNx/quPG/3MRPa2USGgB956m1vPJrQH1NspkFA=;
        b=ixa1xoiGcOLWIIrNO5/0PTt3WoUh85/Hxv/iTdjIEq+lHvslCE/UMdw9ZAWG3P/sNW
         M0ja0kcUzEh9mq32EFzJrZM9eeiT5oybz5V1zWGwwwtllbT/aLahaj7MaCB6p2Nx8ZI3
         nZzb9zAYGnOuWJKFFFAXxohu+8gxmqFpls0v1i4gUVDpqMek0r9z3PQBKbz57c0Clac6
         XHgtqVMcLwYVrhkvC1Ju6HEy+0uk6mmWpa8cQP+/vN6VFnkT4y2BxTNloB/GGe4VS+fI
         dUTYNZicm179qFT8Vwif3GTl9XGegpvoCtt7jIaWlAVEeNEr21mA3Ig1d4NPqd+nzEx5
         zCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GtnldkNx/quPG/3MRPa2USGgB956m1vPJrQH1NspkFA=;
        b=uIfawIbQCbvq+S75/SB/OBkfb2ll9QlrAJfo1ot/7TTBIcNzd5VbRY79FXEnMu/qsp
         GBDi/3HuS38BakPmq0SFzelMQfN9XPFWb527+dylGdp2TTxONrr2k2+z0jItm3fprt6D
         w2XXvkJ3J3rdgJNUzkdeZcbeb1C4pd+7uHduUBI02d1oPX6M7zSXiLWh3oXlPjPSyB+T
         Mvj2XFRLtnKmM22p7ifrV3d0RbtJvhRSMEuZ22s34N7oIziGfdWgVR2Nw/yprvMnjpMV
         WDW6QnuSRLO/0Zk8M60DmvO9DL77mYTXK5SmbWDHtgA6ZtHUOgvZBxL/Yf/a3dNgXctF
         qNbA==
X-Gm-Message-State: AGRZ1gI4SsnRTW/ns8Ldeac+C6yXadfjb6h1aXVry/7qouDvae3M0RVg
        1nLLon8CzK97vxibRXBnnuE=
X-Google-Smtp-Source: AJdET5f6/Zg+o1aRHB5NUWr8mNMJBgpd3zslzteoUj7+E8I+FT6N4PzpfRd/hxeRZbvLX+93e7wD6A==
X-Received: by 2002:a19:94d5:: with SMTP id o82mr1508543lfk.155.1542733868126;
        Tue, 20 Nov 2018 09:11:08 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 10sm6035942lff.62.2018.11.20.09.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:11:07 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gP9YJ-0003nV-N8; Tue, 20 Nov 2018 18:11:07 +0100
Date:   Tue, 20 Nov 2018 18:11:07 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] serdev: make serdev_device_write() more usable
Message-ID: <20181120171107.GI19900@localhost>
References: <20181114150904.19653-1-johan@kernel.org>
 <CAL_JsqJyTVsN1=YpeHNtTr+Tpw9Qmqd=mWfhg-d3WgzUX7DqKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJyTVsN1=YpeHNtTr+Tpw9Qmqd=mWfhg-d3WgzUX7DqKw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 09:16:35AM -0600, Rob Herring wrote:
> On Wed, Nov 14, 2018 at 9:10 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > This series make the synchronous serdev_device_write() helper more
> > usable by
> >
> >         1) allowing drivers to pass a zero timeout to indicate that they
> >            want to wait forever;
> >
> >         2) returning the number of bytes actually written (buffered)
> >            if the helper is interrupted;
> >
> >         3) make the helper use interruptible wait so that the helper can
> >            be used on behalf of user space.
> >
> > Finally, the two write functions are documented using kernel-doc.
> >
> > Turns out I was using the wrong timeout for two gnss drivers that
> > expected the helper to wait indefinitely. I've fixed up those separately
> > (by using MAX_SCHEDULE_TIMEOUT for now), but for the helper to be usable
> > when using flow control we really want it to be interruptible.
> >
> > Besides the two gnss drivers, there's currently only one other in-kernel
> > user of this helper and that driver (rave-sp) uses a non-zero timeout
> > and doesn't check the return value and therefore does not need to be
> > updated.
> >
> > Note that this series depends on the two above mentioned GNSS fixes
> > (submitted for v4.20-rc3).
> >
> > Johan
> >
> >
> > Johan Hovold (4):
> >   serdev: use zero to indicate infinite write timeout
> >   serdev: make synchronous write return bytes written
> >   serdev: make synchronous write helper interruptible
> >   serdev: document the write functions using kernel-doc
> 
> Other than the one nit, for the series:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks for reviewing.

Greg, note that these still depend on the two gnss fixes currently in
your char-misc-linus branch.

Johan
