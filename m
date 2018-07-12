Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E1C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D7620883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oeAU74hR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D7620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeGLIqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:46:47 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34116 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeGLIqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:46:47 -0400
Received: by mail-oi0-f66.google.com with SMTP id 13-v6so54355528ois.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ANCuzMDOuGzWh1rGYNHuKELt8cqOFlK/eqtEdgjsPU=;
        b=oeAU74hRhWreE8llp6Q+q+ZqKNksBsWMVvPRHaphh4MZwQyciwElLkad6GLRmjH1A7
         32TaJTY6YwStkUbikcGbkvOYXgvS7+9N7Bn4CaRdbd9QDpAJZsfuHrwlopwoNkNqZzdY
         enB9fkBuQUz8BsP9Jh9V8Mor/G08fJR+axowQImlXTFan1RfA9FreNejngKPFtdmLIkZ
         UMN+3cx5o6Bp3GcKrfOgLWzQywwcSATAIdVjZFii07wRH/4S5+jZB5p4FE0S/IhV6PEY
         1V0ef8fVijNXtLEBKN5NgR6ns05Q5oWSlXKmJr+NLRAsuYbKDABgKK1EVd9Q4ExIemA0
         R4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ANCuzMDOuGzWh1rGYNHuKELt8cqOFlK/eqtEdgjsPU=;
        b=dq5o8DZA3ww1qaYLO+Yv/DQ86gXFA+Tt9THlZ4o7eURjVeN4eECXctcucrUtTpHWAU
         t02qnTMQrxLBraD55VAE8/Jo6lEnwkaTjeVwgHSoCNwL/kOO5DsrIRAQCDfEmFXemwnd
         Te9p3psgL73BYjD5Bqgygavqniv2i+2nAY8Eyl2ERc/sAtf+JV/1UFgcIT6cHhXA0wCg
         HnTH502a+P/zBqx5Fwb40bXouUAkBHQUxkz9kGoVrR5uXJcNonqy1vYc7aEhw79cKeVJ
         XXYj/wmnqEvVoV5uI5Ha602QfZJt9X7XuXiHauVIosw9SylrWmzh/cJ7fNxRpTufRmXo
         9dzA==
X-Gm-Message-State: AOUpUlHtnhIdztC6uMD8IQWbl+5L6f+/9OzsNE3+FZe1h8T3ZFalbHse
        PPrsUQRiNWGaOHsdDZCnC2130MUqpdA6Nzj+abEOEw==
X-Google-Smtp-Source: AAOMgpcBklmjoVhyKUIb3HIZbgS3APMObCZu73IcUy17/ol3YlBjvq8wVgxtzhJDIO92SFhfK7EWwJnq9ylVK3X2tc0=
X-Received: by 2002:aca:190d:: with SMTP id l13-v6mr1422996oii.216.1531384692063;
 Thu, 12 Jul 2018 01:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180702211359.30585-1-jae.hyun.yoo@linux.intel.com>
 <CAFd5g443wTQJ+0hrprOV949Sr_nRnBGpNo3Wd01xFN4GW4K2Ng@mail.gmail.com>
 <2d2f2b2b-394a-506f-c870-33520335250b@linux.intel.com> <c13fc12e859f7bdb300f08ad805cdf6d7ec09f52.camel@perches.com>
In-Reply-To: <c13fc12e859f7bdb300f08ad805cdf6d7ec09f52.camel@perches.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 12 Jul 2018 01:38:00 -0700
Message-ID: <CAFd5g47-Bq_wUkL4vP93si+urDs-A0j26ukZ+Riy24HWi5AuuA@mail.gmail.com>
Subject: Re: [PATCH] i2c: aspeed: Add newline characters into message printings.
To:     joe@perches.com
Cc:     jae.hyun.yoo@linux.intel.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com, james.feist@linux.intel.com,
        vernon.mauery@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 10:10 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2018-07-11 at 09:53 -0700, Jae Hyun Yoo wrote:
> > On 7/10/2018 10:42 PM, Brendan Higgins wrote:
> > > On Mon, Jul 2, 2018 at 2:14 PM Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
> > > > There are some log printing without a newline character. This
> > > > patch adds the missing newline characters.
> []
> > > > diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> []
> > > > @@ -431,7 +431,7 @@ static bool aspeed_i2c_master_irq(struct aspeed_i2c_bus *bus)
> > > >           */
> > > >          if (bus->master_state == ASPEED_I2C_MASTER_START) {
> > > >                  if (unlikely(!(irq_status & ASPEED_I2CD_INTR_TX_ACK))) {
> > > > -                       pr_devel("no slave present at %02x", msg->addr);
> > > > +                       pr_devel("no slave present at %02x\n", msg->addr);
> > >
> > > Unless something changed in the last couple versions of the kernel, this is the
> > > only line that actually changes anything. dev_* inserts a newline for every
> > > call.
>
> Not true.
>
> Any printk without KERN_CONT inserts a newline
> if the last character
> emitted is not a newline.
>
> dev_<level> uses can also be followed by pr_cont.
>
> So this patch does reduce the possibility of
> interleaved messages from multiple processes.

My mistake. Thanks for pointing that out.

Jae, forget what I said earlier. This looks good to me.
