Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeEBIt5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 04:49:57 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52519 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbeEBItx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 04:49:53 -0400
X-Google-Smtp-Source: AB8JxZoH7nbIL9W0wwC5nuEp7ESbkoFUizDBtfTTFTqN7cMPlIc2ogWi4WYctfXhh+SFRmdWQT9D6BKSvx6iNCafzi0=
MIME-Version: 1.0
References: <20180425132641.106385-1-tweek@google.com> <20180501114940.GD20978@linux.intel.com>
In-Reply-To: <20180501114940.GD20978@linux.intel.com>
From: Thiebaud Weksteen <tweek@google.com>
Date: Wed, 02 May 2018 08:49:41 +0000
Message-ID: <CA+zpnLdasAFPKRXB=5SgiAi5=W08tgkbQTjO26V=PxjphJai=w@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] tpm: Add explicit endianness cast
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Nayna Jain <nayna@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 1, 2018 at 1:49 PM Jarkko Sakkinen <
jarkko.sakkinen@linux.intel.com> wrote:

> On Wed, Apr 25, 2018 at 03:26:41PM +0200, Thiebaud Weksteen wrote:
> > Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> > ---
> >  drivers/char/tpm/tpm_eventlog_of.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_eventlog_of.c
b/drivers/char/tpm/tpm_eventlog_of.c
> > index 96fd5646f866..ea0f16f19d73 100644
> > --- a/drivers/char/tpm/tpm_eventlog_of.c
> > +++ b/drivers/char/tpm/tpm_eventlog_of.c
> > @@ -56,8 +56,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
> >        * but physical tpm needs the conversion.
> >        */
> >       if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0) {
> > -             size = be32_to_cpup(sizep);
> > -             base = be64_to_cpup(basep);
> > +             size = be32_to_cpup((__force __be32 *)sizep);
> > +             base = be64_to_cpup((__force __be64 *)basep);
> >       } else {
> >               size = *sizep;
> >               base = *basep;
> > --
> > 2.17.0.484.g0c8726318c-goog
> >

> Repeal and replace, right (no change log)?

Yep, that's right. Thanks.


> /Jarkko
