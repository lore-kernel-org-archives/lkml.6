Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2C5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A218A2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qX5+Vrla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbfBLKd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:33:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33655 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfBLKd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:33:57 -0500
Received: by mail-qk1-f195.google.com with SMTP id x9so8381236qkf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GMp23AgSoT/MoD52DueN6r2g7Edyg9sRa2l4h5O+Nf4=;
        b=qX5+VrlaVMhmalp/VbGGMyGV3aSvVFMkyQRCI+HBNE80awcN+TrCpuBtts19sMwf0T
         zGTj8WzNL5KyV0H3p+DVTVdxBExcUU9LkKV0Dr7rVQwKcBgIMX8rFsx2L4P39vbv1PdH
         /dVW3vS+xbVgyn9jj1eRThDbv/xGlSWhEXaQP1wXzZA3L4269iyUvqy7Tz6AkLNh+G9n
         FP1EF/vlBK1LblsBdNDIeZA7BqolnhT0XqaWEFeL7Lf2todn9YscRkItvH9xAgmqOPZb
         sWc0zolqNllYXt9QP0erwzD1efEZftBjsOseKTDZuvzdDRAyDOJJLO9Eq2LWr/8l2VvF
         boSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GMp23AgSoT/MoD52DueN6r2g7Edyg9sRa2l4h5O+Nf4=;
        b=t+0Lpg2kcBvonmtSZggHZUo8vX+lCBmbkwkKWy0vZTP80h1YNqGxSId0i29Q9Mh9PB
         841tAjSXwLzyG/hmyN6rercST2k9JrXhwAnw13L4H7YL4HTK5yb4lPcMokU93/T5m/JN
         NX2MpJ079yNIwZ0L9c9csuLf6u+NL68FYWEEyO2q8ryWbRGkIajmgcV7cvfoez88xIwo
         3/AZ7Qz5mOAlLtUGhlURIFlD4STARWYqgtkd6/Glf3idaNfhOKQLSqli2PgQEceWLJki
         1dlm8nR6DyHBfp2w1lTYkkzCLxyq9cKtSpO75bBLKsIo3wDk+L1mlx1O1TGvnNMsd3t+
         si6Q==
X-Gm-Message-State: AHQUAubOn+KAkcNRXO2qgaz2aDRcMc2BMXz3xHKAFxppj0rMsFgDPEz3
        L7EmSQiAZiRMmR7D0Q03B3nf2cH8ootJYXUBqIxu7g==
X-Google-Smtp-Source: AHgI3Iat8DhJxa2hj7hH2PfGT3L+VZIVHcqrADmF8Jso3+20xn/9v/NSw2GrpvAUO/wU2Ss+rN/yz1Krrgig7tF4UIA=
X-Received: by 2002:ae9:f809:: with SMTP id x9mr2072092qkh.84.1549967636208;
 Tue, 12 Feb 2019 02:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20190131035411.53576-1-kyletso@google.com> <20190131070238.GA4500@kroah.com>
 <20190131182213.GB17285@roeck-us.net>
In-Reply-To: <20190131182213.GB17285@roeck-us.net>
From:   Kyle Tso <kyletso@google.com>
Date:   Tue, 12 Feb 2019 18:33:45 +0800
Message-ID: <CAGZ6i=1pjxETqcJG8Czv91Hv3tuWowLmYTqseqhAn=wuFP-Y6A@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Export partner Source Capabilities
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 1, 2019 at 2:22 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Jan 31, 2019 at 08:02:38AM +0100, Greg KH wrote:
> > On Thu, Jan 31, 2019 at 11:54:11AM +0800, Kyle Tso wrote:
> > > Provide a function to get the partner Source Capabilities.
> > >
> > > Signed-off-by: Kyle Tso <kyletso@google.com>
> > > ---
> > >  drivers/usb/typec/tcpm/tcpm.c | 23 +++++++++++++++++++++++
> > >  include/linux/usb/tcpm.h      |  1 +
> > >  2 files changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > > index f1d3e54210df..29cd84ba9960 100644
> > > --- a/drivers/usb/typec/tcpm/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > @@ -4494,6 +4494,29 @@ int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
> > >  }
> > >  EXPORT_SYMBOL_GPL(tcpm_update_sink_capabilities);
> > >
> > > +/*
> > > + * Don't call this function in interrupt context. Caller needs to free the
> > > + * memory itself.
> > > + */
> > > +int tcpm_get_partner_src_caps(struct tcpm_port *port, u32 **src_pdo)
> > > +{
> > > +   unsigned int nr_pdo;
> > > +
> > > +   if (port->nr_source_caps == 0)
> > > +           return -ENODATA;
> > > +
> > > +   *src_pdo = kcalloc(port->nr_source_caps, sizeof(u32), GFP_KERNEL);
> > > +   if (!src_pdo)
> > > +           return -ENOMEM;
> > > +
> > > +   mutex_lock(&port->lock);
> > > +   nr_pdo = tcpm_copy_pdos(*src_pdo, port->source_caps,
> > > +                           port->nr_source_caps);
> > > +   mutex_unlock(&port->lock);
>
> The mutex use here suggests that the data can be updated while being
> copied. But that suggests that port->nr_source_caps can change as
> well and may no longer be current after mutex_lock().
>

Thanks for pointing out the bug. I will fix this in the next version.

> > > +   return nr_pdo;
> > > +}
> > > +EXPORT_SYMBOL_GPL(tcpm_get_partner_src_caps);
> >
> > We don't add new functions that no one uses :(
> >
>
> I am also concerned about the API itself; passing a pointer to be freed
> by the caller invites memory leaks.
>
> Guenter

What is the better way to implement this? How about providing a function
(say "tcpm_put_partner_src_caps") for the caller to free the memory?
