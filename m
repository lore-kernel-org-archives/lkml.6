Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556BEC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18728214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 01:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwJSKGOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18728214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389170AbeKPLpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 06:45:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46529 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbeKPLpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 06:45:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id s9-v6so10555601pfm.13;
        Thu, 15 Nov 2018 17:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ayGo4v+DliufNSqgz1k1qfF5PRguotHdX7wl25usIg=;
        b=NwJSKGOdUhYfHVKpYoYM5xxuJE4WvNS0eGSFt4pNeBaNrxarRNkJZVAK/T/yN+Nk7K
         LMgXmSTG2A3C68vfB4KZmjnhNaXZsRM5uthLFXVJz3Ea/G2B/s5/T/Dg7XU2v2XOehH7
         U3YN5sHuYH5kBe6vQQjlWXndfZpVL3at0dwTRknli2ig5c4g0X7RpHdXV9b1R8zEBy2x
         kHqft28V3eqIJDWgp2PwxCLV1ulmxmVZFxxs33S4oxDP5uVDTo1JPhLDwzblhpKH12DF
         WvjUHwgo8OHUzOd5vONvDaCwsp8c4MbhdSVccQXxJPtE1nzc1s2KJA1IdE6tbgOv+noI
         iBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ayGo4v+DliufNSqgz1k1qfF5PRguotHdX7wl25usIg=;
        b=IE7MiOyDNXqfkBFs8nd2GbREENrJR2/gSZJQFGQ5doN7Ne/uEIRNKr3jLJq2Kb+xf5
         wjgw7e47+7+/omg5GAVpxYOcek9itqkOGtk7qddyiayHF6Ulz8qBsOxqopXfhXpmjYTN
         KrIrl3zNNzh26fKsJDkkHnL1R+MIoErxL7RcxDjPChZw+QlWE8f9BO45+MGE7d+i0rxZ
         fLG1OLk1dq7UDqeQxxigRYLJLHeaYP3YGdo7AWityRjCv5Rt8XqFcm4IXhm2ELxRaJhC
         ejnxKJNJjrdNvB9WSmhXVV+S4YmpnkjjJ2ykQK85FotdTxFBDIMTgZf8A1UQ7IEPk415
         rcvw==
X-Gm-Message-State: AGRZ1gJlmlL7+nHvhcaA9oaf1dfBk8keq+hXRd/SvDtgtzMFSquObUD9
        rtn/F+6lCzZzWhvfY3iOp0UuDranfhVnaY0r07E=
X-Google-Smtp-Source: AJdET5e+pvYJIx/tFzUMue37XYJwpXxU7mnF5Pnwu4VPTOQeVWibbOUSr74xSxsK06NC5k+5Olr0eJ2mXCnA4EIrIZE=
X-Received: by 2002:a63:2c82:: with SMTP id s124mr7866298pgs.73.1542332085056;
 Thu, 15 Nov 2018 17:34:45 -0800 (PST)
MIME-Version: 1.0
References: <20180418222905.10414-1-robh@kernel.org> <e7a2f4ca-40c2-05ef-097c-2cecd31fb731@gmail.com>
 <CAL_JsqKVCdk8nFwmtfNt4mMOVYFVxefgafP6JtXThvFhROFB8w@mail.gmail.com>
 <CAKON4OxwAmmPv2+CEtT+eO3Uu8duCKD8OqyWj8+w2Y5SZ4bfOQ@mail.gmail.com> <CAL_JsqJd7F7=yyW5X0P4W0N+0UDA8MLPDGvbBBK+VqMKqajC7Q@mail.gmail.com>
In-Reply-To: <CAL_JsqJd7F7=yyW5X0P4W0N+0UDA8MLPDGvbBBK+VqMKqajC7Q@mail.gmail.com>
From:   "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date:   Thu, 15 Nov 2018 20:34:32 -0500
Message-ID: <CAKON4OwdwVUtX+ZvXUCs-RLo0V=KKKNKzrtRM5GxejaQEL+NRA@mail.gmail.com>
Subject: Re: [RFC PATCH] dt-bindings: add a jsonschema binding example
To:     robh@kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        devicetree-spec@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>, grant.likely@arm.com,
        Mark Rutland <mark.rutland@arm.com>, geert+renesas@glider.be,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        sboyd@kernel.org, jic23@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 6:42 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Nov 14, 2018 at 1:39 PM jonsmirl@gmail.com <jonsmirl@gmail.com> wrote:
> >
> > On Fri, Apr 20, 2018 at 9:36 PM Rob Herring <robh@kernel.org> wrote:
> > > I share the concern as I doubt most kernel developers don't know
> > > jsonschema. But then the alternative is us defining and writing our
> > > own thing which is C like 'cause that's what kernel developers
> > > understand. My hope is to simplify and restrict things enough that it
> > > writing a binding doc is straightforward without being jsonschema
> > > experts. That was the intent of this patch without going into all the
> > > details behind it.
> >
> > When schemas were first discussed long, long ago the idea was to have
> > a n arbitrator who controls the schema (like Grant/Rob) so there is no
> > need for general schema design knowledge in random kernel developers.
> >
> > First a developer should try and build their device tree using the
> > existing schema. Then only if they find that impossible to do so
> > should they propose schema changes. The schema arbitrator would then
> > look at those changes and work them into the existing schemas as
> > needed. Doing this via an arbitrator will ensure consistency in the
> > overall schema design while eliminating redundancy with slight
> > variations (like we have now).
> >
> > Another side effect of schemas is that as they evolve and enforce
> > commonality among driver implementation it will become possible to
> > turn those in-common pieces into driver libraries.
>
> If we replace 'schemas' everywhere above with 'bindings', then this
> pretty much describes the status quo today. Most device specific
> bindings are a collection of standard bindings. Occasionally, we have
> new common bindings. All the bindings get reviewed by me. The only
> real change here is submitters have to have some level of
> understanding of json-schema instead of just English (for writing free
> form text). I think it will continue to largely be following existing
> examples of other bindings.

What used to happen is that drivers would be written out of tree
without review of their bindings until mainline submission (if they
submit them at all).  With schema a driver writer who is working out
of tree can use the schema to validate their new device tree entries
before submitting them. That way they will know ahead of time if they
are making up something non-standard. It will also give them the heads
up that they can't just make up anything they want in the device tree
and that they are going to have to defend their design when asking for
the schema to be changed to support it. An example of where schema
would have been initially valuable is in the i2c bindings which
contain significant variation but the function is the same.

Maybe we are thinking about schema differently. I had envisioned
starting from a base generic schema that is capable of validating all
possible legal Linux device trees. This schema is more strict that
YAML syntax, but it obviously can't validate in detail.  Someone
working out of tree would always be able to validate against this
schema.

As this generic schema validates the device tree it will discover that
it can utilize more strict schema fragments. So by providing these
fragments you can validate to any desired level of conformance. The
end of that process is the json-schema bindings file. But if those
fragments are missing you can still validate, just not at a detailed
level.

A large set of schemas that work like this are used in ONVIF (security
cameras). A flavor of SOAP.
https://www.onvif.org/profiles/specifications/
These schemas are using XML stylesheets to make them pretty, use view
source to see the actual schemas.

The ONVIF schemas define points where vendors are allowed to insert
arbitrary items (ANY elements) and then they will use a vendor
supplied schema to validate the fragment if one is available. If not
the generic schema is used to validate the basic structure of the
vendor fragments.

>
> Rob



-- 
Jon Smirl
jonsmirl@gmail.com
