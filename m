Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0F0C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC8021B1C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HLwtflPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfBLKch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:32:37 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33711 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbfBLKcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:32:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id z39so2333273qtz.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hP3bD0/FecycY6KWyvMuhSejR3aZm0LxXnJZpTyPxg=;
        b=HLwtflPdhldC+kVUvK7Wgv52dxtzVHAlSD70fox3I32UX+f4RgM+5RqLaNC6e2c68e
         2izWcdfPhr+jvNkLwrVVBesHYDRqrYoO8Ex8lVScFvqQWslGo2IzbhQqsDTnHHs/zJNw
         aIkdLZnAuboh7fOW+GA1N23ofEnvvPy21+I59zqn7T4FrJKth5gdecW1T/JMtvFYrbCL
         QfPrOHK06J1mNtU2iTf28ji3j65ldMKDO5c3aJSAqMSrF6UEUONxHVeHwt9SyFov/MMz
         VInDwX22Sas0Z95tAjqvi4dbueS6Cnk97arQLbRZj/9lxI6cz2p3GTDFgvaQLgDq4iHO
         Aiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hP3bD0/FecycY6KWyvMuhSejR3aZm0LxXnJZpTyPxg=;
        b=odhX3xLQzN7U829v2oXBVqC7HJAyh6kQG1g5zRbAUN9qpzqBjcinjTBQ2gdV+Dmo4Y
         f+sj9BNKj7z9Bu2bfojrvhMnGVgqjvvF1qNRfNg8WEHIExhGTeBv6f+ue+u2eRvd/wc4
         Ml8ztYy2ORYWV+t8dSPWBBSMblrdVIcFZaPz/Di86tJuoB3ov9z5/kh7dXZOHYlrVQzP
         mSFC7MBGnZ1yWTb8pOPn5aOl3u787TM2oEaM1SYrcy0IOfAAE/CaK6SWbzayFpo7KKRU
         YW+9C/C/Y530uxFsor7ESvD89/Oa6R2xYe9m8KdKqm1KD2EF6BcZWj/0xtaq4CM5xz89
         gs+w==
X-Gm-Message-State: AHQUAua4KpCNpZ0+qMqG1mD+lLjhVEP4NID7PmbmNXBuFSlqGcXWULD4
        CBnHzvX7qMfwk181No2D3DDPudcmGz3Y7vhWIEP0vw==
X-Google-Smtp-Source: AHgI3IabkRMDyoXQzjv+BsludDRDkRBPH9kbz6yfT2BC2M12imnpu2mtnt4JpQDIp48Br1MX2sTTf+7vW0bgt2q9Yho=
X-Received: by 2002:a0c:ade7:: with SMTP id x36mr2023514qvc.66.1549967555218;
 Tue, 12 Feb 2019 02:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20190131035411.53576-1-kyletso@google.com> <20190131070238.GA4500@kroah.com>
In-Reply-To: <20190131070238.GA4500@kroah.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Tue, 12 Feb 2019 18:32:24 +0800
Message-ID: <CAGZ6i=3vMWkOQiRNzpLtiTHELyBLmRmPGEGx+uB-V-HJOi6CHQ@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Export partner Source Capabilities
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 3:02 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jan 31, 2019 at 11:54:11AM +0800, Kyle Tso wrote:
> > Provide a function to get the partner Source Capabilities.
> >
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 23 +++++++++++++++++++++++
> >  include/linux/usb/tcpm.h      |  1 +
> >  2 files changed, 24 insertions(+)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index f1d3e54210df..29cd84ba9960 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -4494,6 +4494,29 @@ int tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
> >  }
> >  EXPORT_SYMBOL_GPL(tcpm_update_sink_capabilities);
> >
> > +/*
> > + * Don't call this function in interrupt context. Caller needs to free the
> > + * memory itself.
> > + */
> > +int tcpm_get_partner_src_caps(struct tcpm_port *port, u32 **src_pdo)
> > +{
> > +     unsigned int nr_pdo;
> > +
> > +     if (port->nr_source_caps == 0)
> > +             return -ENODATA;
> > +
> > +     *src_pdo = kcalloc(port->nr_source_caps, sizeof(u32), GFP_KERNEL);
> > +     if (!src_pdo)
> > +             return -ENOMEM;
> > +
> > +     mutex_lock(&port->lock);
> > +     nr_pdo = tcpm_copy_pdos(*src_pdo, port->source_caps,
> > +                             port->nr_source_caps);
> > +     mutex_unlock(&port->lock);
> > +     return nr_pdo;
> > +}
> > +EXPORT_SYMBOL_GPL(tcpm_get_partner_src_caps);
>
> We don't add new functions that no one uses :(
>

This function is useful if the PD Device Policy Manager is implemented
outside of TCPM.
In this situation, Device Policy Manager needs to know the partner
capabilities to optimize
the charging process.

Take existing functions in TCPM for example:
Function "tcpm_update_sink_capabilities" and
"tcpm_update_source_capabilities" are exposed
as well. And no one uses them now.
