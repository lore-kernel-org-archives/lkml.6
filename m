Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5262AC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E6421A49
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5HQw67b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfBKLwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:52:47 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35656 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfBKLwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:52:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so5216090plo.2;
        Mon, 11 Feb 2019 03:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bLRKQrsaNLy1Dh5l353LDKWm7bimiixlTL8gv5L3/P0=;
        b=K5HQw67bJ7qNRDTh7g5Gm9dyuo02nO3XPvrATBhxGUKeR7Jpje39zW1zvqBkHms89u
         HPmOTckHbaBJ9MTYxKogckuKf8b6Ed9jt9jr0/m5DOkV1mLTGxty1EotI+0BHMpZDJk/
         hWnxPw/aUi37TSRumZ6EE2UAjrk/bPy+My0KL3DElHrEpIaww8+oARxhRUQgphfplLF3
         iRI6wxzX74jH5iAVDtmA/dYvyu639yxXOdF8/sW+l69jot1llbK/c2Gj9ZMC6sf0eCUc
         MpZQ6jANC7s8tH2QvZG1Zf2+YiaYlYOUevceARFflqokGEYcGvsqxDSEn7hr8IiEPp5I
         vZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bLRKQrsaNLy1Dh5l353LDKWm7bimiixlTL8gv5L3/P0=;
        b=fFCpJFWog9e+8XTzOqghQ4q854JDM8izAHGA3QhKZbqZ/JjgU4BpRydJidb08Zv0IZ
         D0HNRnL0uHEjjO/g7CSL0xARoO54PvMC/shlnNqT8aWfh8LaYiLs2xNGPykB/krvlxzm
         8CsKE7pdZlBKsxRDnlCu1JNNEk5HcUOStgXfzJvcl9TBtuOsdfCFMKcZC+N8a8EAzkx9
         Em7HAMIltrH25Dfk0cOkSbECm/ywszee79yjF0pdzExPSRN0xgj6HpEqr18MeIE7b6b8
         rC9QHgqguy/mZnNjFdrr36OL28P6gLqN9RnDEIMEPbqoY6HJSqnvxmyCF2tuxkI4iCRO
         Krjw==
X-Gm-Message-State: AHQUAubUmJ9vkKNpyixH72SSdXECONovrTVN+dHEUVplc0+YuMIBV7fA
        ZfBRwLMTcON67QS6LqfpJ8eEMJtddlLjJrOrZyA=
X-Google-Smtp-Source: AHgI3IY/DU8R04w8kLli7QbWaR9nFBsjmQugSa6b0PaOUYik1S/9Z1Lb7753CqEyYefUofg/VEenmft+C+jq4ENLoYY=
X-Received: by 2002:a17:902:2468:: with SMTP id m37mr37083584plg.314.1549885966484;
 Mon, 11 Feb 2019 03:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
 <20190130160259.46919-8-heikki.krogerus@linux.intel.com> <CAHp75Vdq+T4vKsihhUJjV85-mkWfY2G=npJLPaGiGjbzD_m32w@mail.gmail.com>
 <20190131133537.GA13072@kuha.fi.intel.com> <20190211083929.GD16987@kuha.fi.intel.com>
In-Reply-To: <20190211083929.GD16987@kuha.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 11 Feb 2019 13:52:35 +0200
Message-ID: <CAHp75VeP6aoiaERWdFJkNyGRwSVJqj_BBg6Tc4+aMjRNYff-MQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] usb: typec: Find the ports by also matching
 against the device node
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:39 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> On Thu, Jan 31, 2019 at 03:35:37PM +0200, Heikki Krogerus wrote:
> > On Wed, Jan 30, 2019 at 06:51:56PM +0200, Andy Shevchenko wrote:
> > > On Wed, Jan 30, 2019 at 6:03 PM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > > >
> > > > When the connections are defined in firmware, struct
> > > > device_connection will have the fwnode member pointing to
> > > > the device node (struct fwnode_handle) of the requested
> > > > device, and the endpoint will not be used at all in that
> > > > case.
> > >
> > > > +       /*
> > > > +        * FIXME: Check does the fwnode supports the requested SVID. If it does
> > > > +        * we need to return ERR_PTR(-PROBE_DEFER) when there is no device.
> > > > +        */
> > > > +       if (con->fwnode)
> > > > +               return class_find_device(typec_class, NULL, con->fwnode,
> > > > +                                        typec_port_fwnode_match);
> > > > +
> > > > +       dev = class_find_device(typec_class, NULL, con->endpoint[ep],
> > > > +                               typec_port_name_match);
> > > > +
> > > > +       return dev ? dev : ERR_PTR(-EPROBE_DEFER);
> > >
> > > Just  to be clear, this one takes a reference on dev. Is it taken into account?
> >
> > Yes. That is what we want it to do.
>
> Gentle ping. Is the series OK?

From my prospective it's okay, so, FWIW
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


-- 
With Best Regards,
Andy Shevchenko
