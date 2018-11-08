Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDFCECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD58F20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yj7OtTEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD58F20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeKIGzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 01:55:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbeKIGzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 01:55:53 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1BF020840;
        Thu,  8 Nov 2018 21:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541711913;
        bh=nHmBznSkQIWGEmS50J1iaKeG27JqrMZsi/SJhDdN8dI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yj7OtTEiJlGzBTWZ9jlnvNRLTxx5vGCBPHUL7dYnrOqmxSWxQpOeOLzrkKI3VVeu5
         moJ71YvQ2EuJxsrxdsJ48BdzndzPYnw17GWv/o3gOZ3gZ5okNYiGKH4G0+KJyMXT/v
         p8v9TGr2oByV2cjZOoNwjopswNr+YOE+q61kWxX8=
Received: by mail-qk1-f173.google.com with SMTP id 189so29109632qkj.8;
        Thu, 08 Nov 2018 13:18:33 -0800 (PST)
X-Gm-Message-State: AGRZ1gKI46nq7UEfcjUilVk6JVQ6IEHdT4WRju+YGGnTyX6QouD3uByS
        xeuMrQu6YS5p9XaiUcXVeKkCSIcD8Dk7mS/V3g==
X-Google-Smtp-Source: AJdET5diGJAQzQOHIqiD2a19Tk5ma6zlIz7Wy3Ghv9KIJJ7r3B22G3UJ4HPjxgGJ0dghFHuzH2PWaaIL8nhrYp7yt+c=
X-Received: by 2002:a0c:8c8a:: with SMTP id p10mr6396736qvb.218.1541711912898;
 Thu, 08 Nov 2018 13:18:32 -0800 (PST)
MIME-Version: 1.0
References: <20181108165156.60073-1-heikki.krogerus@linux.intel.com>
 <20181108165156.60073-4-heikki.krogerus@linux.intel.com> <CAL_Jsq+4momJb6EoXrAg2LRKzpXMFB30yhBigOiEJ16EjZ05pg@mail.gmail.com>
 <20181108192509.GW10650@smile.fi.intel.com>
In-Reply-To: <20181108192509.GW10650@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 8 Nov 2018 15:18:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLMuiUc8FW=X_OAd5P_tcfPSTOox9Vh6faEwK+Z=S2mjw@mail.gmail.com>
Message-ID: <CAL_JsqLMuiUc8FW=X_OAd5P_tcfPSTOox9Vh6faEwK+Z=S2mjw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] of/property: Add of_fwnode_name()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 1:25 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Nov 08, 2018 at 12:23:51PM -0600, Rob Herring wrote:
> > On Thu, Nov 8, 2018 at 10:52 AM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > This implements get_name fwnode op for DT.
> > >
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > ---
> > >  drivers/of/property.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index f46828e3b082..9bc8fe136fa3 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -823,6 +823,16 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
> > >         of_node_put(to_of_node(fwnode));
> > >  }
> > >
> > > +static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf)
> > > +{
> > > +       const char *name = kbasename(to_of_node(fwnode)->full_name);
> > > +       size_t len = strchrnul(name, '@') - name;
> > > +
> > > +       snprintf(buf, len + 1, "%s", name);
> >
> > This can be simplified to:
> >
> > snprintf(..., "%pOFn", to_of_node(fwnode))
> >
> > But that presents a problem with knowing the length. Not passing in
> > the buf length is not good design because you can't tell if you
> > overflow the buffer. Either you can pass in the length of buf or do
> > the allocation here. In the latter case, then you can use kasnprintf.
> > The downside to doing the allocation here is then get_name() has side
> > effect of allocating memory that the caller needs to be aware of.
>
> Agree on matter of potential overflow.
>
> I wouldn't limit users with 32 characters for node name if it's not by both
> ACPI and DT specifications.

While the DT spec says 31 characters, this has never been enforced. As
you might guess, we have node names longer than 31 characters. There's
been some discussion about what to do and the consensus seems to be
change the spec.

> OTOH allocating and freeing memory in a loop each
> time when we would like to go through the child nodes sounds much worse
> scenario to me.

Yes, I wrote that before looking at how you were using it... Of
course, if you want efficient, then you shouldn't use sprintf either
and use of_node_name_eq() as I've suggested.

> Thus, giving a length of the buffer is a good enough compromise.
>
> > However, I think the current API is better. It leaves low-level
> > details up to the firmware implementation. But as long as .get_name()
> > is not exposed to drivers I don't really care that much.
>
> I don't think this concept is changed by Heikki's patch series. It provides a
> common abstract function on top of more low-level firmware implementation which
> I consider a good approach.

Generally, I would agree that's a worthwhile goal. However, in this
case you aren't saving anything. We still have at least a DT version
of the same thing (of_get_child_by_name). Maybe there's some dream
that the fwnode API will become the only one for both drivers and
non-drivers, but I really don't see that happening. As long as both DT
and fwnode APIs are in use, it is best to keep the APIs aligned.

There's another aspect that the node name comparison is case
insensitive on powerpc (and until 4.20, was for everything but Sparc).
I changed it in 4.20 and hopefully don't have to revert. Patch 4 does
a case sensitive compare. That probably is fine (as lots of powerpc
code already does case sensitive name compares), but no one really
knows until we break users.

Another issue is how are disabled nodes dealt with by different
firmwares? It's a frequent bug that we don't honor the 'status'
property (such as in the very code we're discussing). But then there
are some cases were want to ignore it so we can't just go add that
check in and we end up needing 2 flavors of everything. You're
probably okay though. Most devices with child nodes are
enabled/disabled only in the parent device node.

Rob
Rob
