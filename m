Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4C2C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B542177E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547200067;
	bh=RwTGqC0ZNDGGuS9uSs4IEPvaTiNO/rC4cyFReSfkiNg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tGGbIlQJpj4H/W3XvNUqJIEGni30NNwcO6yed7Gm9/HEOz2A+UvUd86DkAp1z+nzW
	 5PZGww2u9cvV3+x0x9woeCR5TqJSE9remClq5J7PEnhx4VsjEuIEeT6Wl2ctunidmY
	 qnW/O7y11aGe2KIuR4dDINhM9MzhfiBwioGeOoCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbfAKJrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:47:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfAKJrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:47:45 -0500
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64EC8217F9;
        Fri, 11 Jan 2019 09:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547200064;
        bh=RwTGqC0ZNDGGuS9uSs4IEPvaTiNO/rC4cyFReSfkiNg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=feyzz4iF8OTgvrMJsz0fih1teANSLTlSAF9ZfEO1lgXlDMhi7CftcMSDQII4DmUcz
         LGjzKnwdhQbrt7SR63demryhDiOtiQ5P6gQ39neq3xshia7Ggk1pPT0gDDLlZLdeKf
         rvcu4tZo+Vjj9a1KDHxwXVMmzrX1gJ7By43c/C/8=
Received: by mail-lj1-f182.google.com with SMTP id x85-v6so12380813ljb.2;
        Fri, 11 Jan 2019 01:47:44 -0800 (PST)
X-Gm-Message-State: AJcUukclqj3Eu8RJeiow9cwteM9L+ou80eHTSrUXf79T8cOg+zZAYdH/
        eEdKgFaIKh6BD+Au60Zj7do/54OYO7BExrZv2s8=
X-Google-Smtp-Source: ALg8bN59D7wP7OBsr8D6l9siYq4VQsyJeyGiNUUpnwJ4LNrIRtRTnFZCZuUMJGT/qIDceNuBN2im/tPh1pq2BJ/bWdc=
X-Received: by 2002:a2e:990e:: with SMTP id v14-v6mr8771787lji.60.1547200062579;
 Fri, 11 Jan 2019 01:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
 <20190110205215.22030-2-pawel.mikolaj.chmiel@gmail.com> <CAJKOXPcWOtTh5nDpZuX=NfrcOcQDPUXoFJLc8JtLs6UEY9LL6w@mail.gmail.com>
 <20190111094120.6dcnspccp6ufxd4y@vireshk-i7>
In-Reply-To: <20190111094120.6dcnspccp6ufxd4y@vireshk-i7>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 11 Jan 2019 10:47:31 +0100
X-Gmail-Original-Message-ID: <CAJKOXPehsZV30Nhak3opcME6sceiF3s6MkGAbKKoxerGYmX57g@mail.gmail.com>
Message-ID: <CAJKOXPehsZV30Nhak3opcME6sceiF3s6MkGAbKKoxerGYmX57g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: s5pv210: Add dmc nodes
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jan 2019 at 10:41, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 11-01-19, 09:32, Krzysztof Kozlowski wrote:
> > On Thu, 10 Jan 2019 at 21:53, Pawe=C5=82 Chmiel
> > <pawel.mikolaj.chmiel@gmail.com> wrote:
> > >
> > > This commit adds dmc nodes, which are needed by s5pv210 cpufreq drive=
r
> > > to work.
> > >
> > > Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/s5pv210.dtsi | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> >
> > Thanks, applied (actually I applied v1 - I hope there were no changes).
>
> Would you like to Ack the other patches so that I can apply them ?

Sure, let me take a look. Anyway, I will take patch 4/4 (defconfig). I
left it for later because of ongoing discussion.

Best regards,
Krzysztof
