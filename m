Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2524BC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22752183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547246571;
	bh=CfAol0B+tVMQi12SK9FhFLCPzj/Pb6v7K49c93vP9pI=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=VJZpq0aT56pD+4zV4RZ7nztsFMX8O/2hQA+Y39Fl81MHKq0bErlZO82/qonACPN26
	 n0uqVrgmMgQrziaMEy1wqKrym4TsoMJFFlQ/dFxojkLiISGIH2aQ/saB5chX+Qljhg
	 jvDBInBWFiYMO0X0MbF76zZaR8g+D9G2n7bvlmAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfAKWmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:42:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:48130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfAKWmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:42:50 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E99B20878;
        Fri, 11 Jan 2019 22:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547246569;
        bh=CfAol0B+tVMQi12SK9FhFLCPzj/Pb6v7K49c93vP9pI=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=L5GtNfP2HCOBaFrMlQCeAtPlsWsWGb51IjbkdGFWM1b0+jzU2ZCZzqbAkne+xWdIX
         wR8LnHWMytyYwwiPzVzgwH6Pzo3+oz4krNg40xQ/30/wY2oizI+gAp2wfSFa/4Wd0Y
         IDK8UmmC/23CFJGPsxanHHiPswS5xuJCgCA/69sM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] dt-bindings: clock: Convert fixed-clock binding to json-schema
User-Agent: alot/0.8
In-Reply-To: <CAL_JsqJFyC3AXwbd8PoJS1wZ5BSokAPcFi=4FF2DQ6yFi0XwCw@mail.gmail.com>
References: <20190110221903.3990-4-robh@kernel.org> <154722865051.169631.16957443589975628047@swboyd.mtv.corp.google.com> <CAL_JsqJzNBYCMWbZtR37eZd4yx2kc590V+q3603Hg=kG2bZwhw@mail.gmail.com> <154723284041.169631.6622751321828044091@swboyd.mtv.corp.google.com> <CAL_JsqJFyC3AXwbd8PoJS1wZ5BSokAPcFi=4FF2DQ6yFi0XwCw@mail.gmail.com>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>
To:     Rob Herring <robh@kernel.org>
Message-ID: <154724656826.169631.7419387360923471292@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 14:42:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2019-01-11 12:49:04)
> On Fri, Jan 11, 2019 at 12:54 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Rob Herring (2019-01-11 10:27:48)
> > > On Fri, Jan 11, 2019 at 11:44 AM Stephen Boyd <sboyd@kernel.org> wrot=
e:
> > > >
> > > > Any pointer to the full schema?
> > >
> > > https://github.com/robherring/yaml-bindings/blob/master/schemas/
> > >
> > > And the clock schema in particular:
> > > https://github.com/robherring/yaml-bindings/blob/master/schemas/clock=
.yaml
> >
> > Awesome. Thanks for the pointers! Is the clock schema posted to the list
> > somewhere?
>=20
> No. Happy to post things, but I'm struggling to find anyone that cares.

Ok. I can review that document too if you post it to the list.

>=20
> > > > Why does title have a full stop?
> > >
> > > Because it was there in the original. My script to extract just takes
> > > the first line of alphanumeric text.
> >
> > Ok. I think it would be good to treat them like commit subjects that
> > don't have the full stop either, so if the script is able to drop the
> > full stop it would be great.
>=20
> I can just write a meta-schema to enforce that. :)

Sounds good.

>=20
> Yes, the meta-schema enforces this at least to the extent there is a
> meta-schema defined for a standard property. Even if not something for
> a specific property, we limit things to a subset of json-schema
> keywords. Also, you also can't define something contradicting a core
> schema (e.g. { reg: { type: string } }), but that wouldn't be found
> until you check actual DTs.
>=20
> The meta-schema check is run with:
> make dt_binding_check
>=20
> This is all documented in Documentation/devicetree/writing-schema.md.
>=20

Ok I'll read that document now. Would be cool if the build robots (and
myself) can somehow run the dt_binding_check on a single YAML file so we
can quickly validate the binding. Maybe even make C=3D2 or C=3D1 do that?

If the robots can then complain if the single file fails to build it
will save us tons of time. I just tried to run it but it seems to only
care about running on all the YAML files.

