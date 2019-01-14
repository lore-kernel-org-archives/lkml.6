Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92E2C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8859D206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="w0NgeKN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfANQnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:43:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38487 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfANQnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:43:24 -0500
Received: by mail-ot1-f68.google.com with SMTP id e12so19880600otl.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=spY+n4PPaHQr8ZQ7suL7kBuBZZWkoftmoBXsvHbEXt4=;
        b=w0NgeKN5v7HV+U7+x/VTBmVltWVPpjj3kc6hMNWA1jzUk0VSAokTjwLX++sE/0vx1W
         +LsdCm6yK0QopFlIzOxNlo7WQC/D/mPPyPAsTUe0xitV+HvE2zuu5O30nqmMoOMy557O
         PPiyAxIRBlFnTP2aR9ejqYZTHmRMvRcn1rVsZZ6ZDwQAsVW3FBjyKS1upXmNJsRZ+/2U
         I+ljUyJjyvZU6q9YLB244BKvXyGC7wz8+3vcG43qXXDMN2cPgpGH8YIuQMYm3jBaiCGA
         HRODr559w9bSYQIYJ7UUfk5YIerKew2O/v3K+jyjo2Dts+RpoFOA8u0lYvivgAK523WC
         f9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=spY+n4PPaHQr8ZQ7suL7kBuBZZWkoftmoBXsvHbEXt4=;
        b=d3gdIaPJlzMqhRwnEEsoGUuEsqWcusUVXiWMe3nDzw8OXauViIXBB6DoTCndXgYQnG
         cnQY+YzzCnU1XobTqhCIQysjKNh0VwutoBPdVVcMQsbPdeZgVcbwvCD8xLRztDawOxkb
         /DFKa2WAxV+uSi5SgupzeRDgj2Yr+PUZ8Fo1ndZciRQDXGhp3IIzKBmMJpuTCB5NokT0
         nWfXR3ae55bapL6cu/FTrIE9Mp8qgD6MQ1G/mCp8ivTvDc1DClrFBu8AL13S1rjadSyB
         nysqpybsoqmAP7rG4Yfv8RM6CYgnCHPTYQcqLdLWZJi8n4Z4agSoXH11obfvZMutkD7i
         C3Xg==
X-Gm-Message-State: AJcUukdUNylbAYwlqvL8EuMUEB3nd50MN2R0SArfeia5ZvW6WGNkghZI
        SmDdaAKSyaT6Qtubg3xgI1cXA5a0RHJ8Rx3gm2AKsQ==
X-Google-Smtp-Source: ALg8bN6Yu+YLQcZEt7jqT1zNlPi+ZMYskcEEhKnJD+IPHoDJMUB9L6qoH61AuADN5xeCUsesjjppDt/hxy4ufXXYlLk=
X-Received: by 2002:a9d:775a:: with SMTP id t26mr16374945otl.32.1547484203410;
 Mon, 14 Jan 2019 08:43:23 -0800 (PST)
MIME-Version: 1.0
References: <154725096972.1367907.12968253382302127133.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49sgxvclmu.fsf@redhat.com>
In-Reply-To: <x49sgxvclmu.fsf@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 14 Jan 2019 08:43:12 -0800
Message-ID: <CAPcyv4hLGB-=UcHykgAO5X3Oakp_erw_62_gpUD2cqXLXKpJVQ@mail.gmail.com>
Subject: Re: [PATCH] acpi/nfit: Fix command-supported detection
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Sujith Pandel <sujith_pandel@dell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 7:19 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > The _DSM function number validation only happens to succeed when the
> > generic Linux command number translation corresponds with a
> > DSM-family-specific function number. This breaks NVDIMM-N
> > implementations that correctly implement _LSR, _LSW, and _LSI, but do
> > not happen to publish support for DSM function numbers 4, 5, and 6.
> >
> > Recall that the support for _LS{I,R,W} family of methods results in the
> > DIMM being marked as supporting those command numbers at
> > acpi_nfit_register_dimms() time. The DSM function mask is only used for
> > ND_CMD_CALL support of non-NVDIMM_FAMILY_INTEL devices.
> >
> > Fixes: 31eca76ba2fc ("nfit, libnvdimm: limited/whitelisted dimm command...")
> > Cc: <stable@vger.kernel.org>
> > Link: https://github.com/pmem/ndctl/issues/78
> > Reported-by: Sujith Pandel <sujith_pandel@dell.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Sujith, this is a larger change than what you originally tested, but it
> > should behave the same. I wanted to consolidate all the code that
> > handles Linux command number to DIMM _DSM function number translation.
> >
> > If you have a chance to re-test with this it would be much appreciated.
> >
> > Thanks for the report!
> >
> >  drivers/acpi/nfit/core.c |   43 +++++++++++++++++++++++++++++--------------
> >  1 file changed, 29 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index 790691d9a982..d5d64e90ae71 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -409,6 +409,29 @@ static bool payload_dumpable(struct nvdimm *nvdimm, unsigned int func)
> >       return true;
> >  }
> >
> > +static int cmd_to_func(struct nvdimm *nvdimm, unsigned int cmd,
> > +             struct nd_cmd_pkg *call_pkg)
> > +{
> > +     struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>
> Minor nit: Seems like the function could take an nfit_mem parameter instead of an nvdimm.

I was making it symmetric with payload_dumpable()... but not for any
good reason, will change.

>
> > +
> > +     if (cmd == ND_CMD_CALL) {
> > +             int i;
> > +
> > +             if (call_pkg && nfit_mem->family != call_pkg->nd_family)
> > +                     return -ENOTTY;
> > +
> > +             for (i = 0; i < ARRAY_SIZE(call_pkg->nd_reserved2); i++)
> > +                     if (call_pkg->nd_reserved2[i])
> > +                             return -EINVAL;
> > +             return call_pkg->nd_command;
> > +     }
> > +
> > +     /* Linux ND commands == NVDIMM_FAMILY_INTEL function numbers */
> > +     if (nfit_mem->family == NVDIMM_FAMILY_INTEL)
> > +             return cmd;
> > +     return 0;
>
> Function zero?  Is that really the right thing to return here?

Yes, function zero is never set in n
>
> Cheers,
> Jeff
