Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4834C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CDC22360
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 12:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0zRf3+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CDC22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbeKMWvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 17:51:04 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37835 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732728AbeKMWvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 17:51:03 -0500
Received: by mail-qk1-f195.google.com with SMTP id 131so19074283qkd.4;
        Tue, 13 Nov 2018 04:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RlNk1V4QvtITtLBTRJS0OVPkGGM8GmKHujXQrgFGtv0=;
        b=X0zRf3+QtvbARX+IyzMSsjhXoCyr3VTw8+h9HJJ3rPaOaNG1iCOd+rL2GvyzmZefXq
         yDQsdCt9G3i28SExoFfXo+5smyIqCnxd1ZvHcOHs1PWtcgYtubNWHU4o34qQfsZ58Xwt
         P2uAA9+NqD6QcAcnSqT7ToLCg7M5ITWi9OAAF6FIHw9iHg+AFrqjqscNUNWA4mwZLWDt
         AflCB0XIwVzCyq0vDSKXh4+ScEZG3hYRIl/yEJMQPycEPeOGtRjNPnYm1w0xzX0jHikj
         6RrojX/6AkH6vsaZvKW4g3bwpq3RoPeyE8PaaPTMrBaYXzVe5hGbywlFc4gg1S5F2v2W
         tPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RlNk1V4QvtITtLBTRJS0OVPkGGM8GmKHujXQrgFGtv0=;
        b=guGH/2qKjPNbP4eLpAWilPeFy8Tk+lA6vGe0eDQnDKszYzmD+QurFIHH3A+mw2ojrX
         /nJULJP4LNDveTa92tdrCkL3/QzcgaEe9qXeLJdqRupvZbMterqsT/gcbju7WbqXwBHb
         IhF5RXMzDyFOa5xscFaUWKgXu5HKjbnOJKvAX1xOG1cj/F7wutbmbrxppKDSk+FhNVI+
         ui3G1cSQkb5Wfl9jmM+gkBcd/m+Z72qU+CGzKt0c7Qd+4+GYirBTIE6V1GBOl49olC2d
         EPXNzQ6wjEctbixpPRxVJK9fsvjayqWoUkIx5Uw8zz2ZGA7dWtSYDIoPmjvkXrpUEAQa
         b22A==
X-Gm-Message-State: AGRZ1gK65AiJroGjaItPlRRJ8ZBlcOZ9bChqsja+LbpDpOjLI+fXeXF9
        YaiEUu3Cisa8Y+oFGc0TiQF4rBGwaMwsIj5RnJk=
X-Google-Smtp-Source: AJdET5fChqQAbuizCpquV8Xa+frzZdaD4VEHikrox43T3SAPnpa54Y8HjrEaphcIMhTU8h0zFNgeRs+JwNITFzUwekE=
X-Received: by 2002:aed:2d42:: with SMTP id h60mr4827578qtd.373.1542113581898;
 Tue, 13 Nov 2018 04:53:01 -0800 (PST)
MIME-Version: 1.0
References: <20180516011741.18010-1-loic.wyn@gmail.com> <CAHp75VfY3nYgoUD3kjkZrMHzg2MZVNhgWiXJtxZAfpx_3ZGELQ@mail.gmail.com>
 <CAJxRB+DUzxf2dAwBSPP2FTLkwXHGM22WvUM0yrLGB4inPE3O5A@mail.gmail.com> <CAJxRB+C3xzL_m755ifoVzPugCg=bCbb-_mMOvkoH7iUvs3MV8w@mail.gmail.com>
In-Reply-To: <CAJxRB+C3xzL_m755ifoVzPugCg=bCbb-_mMOvkoH7iUvs3MV8w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 13 Nov 2018 14:52:50 +0200
Message-ID: <CAHp75VcDYDsFCO-s=-QqwC-U0_a42qELoGeStX0JCKr1HHEhZA@mail.gmail.com>
Subject: Re: [PATCH] ideapad-laptop: Add Lenovo Yoga 2 13 to the no_hw_rfkill
 DMI list
To:     Loic Wei-Yu-Neng <loic.wyn@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Ike Panhc <ike.pan@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jiri Kosina <trivial@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: mailing lists

On Tue, Nov 13, 2018 at 5:21 AM Loic Wei-Yu-Neng <loic.wyn@gmail.com> wrote:

> Here you go,
> I attached my patch.

Thanks, though in a kernel we have not using attachments. Moreover,
since you forgot to include mailing lists the patchwork doesn't catch
this either.

Can you send it in a regular way, i.e. using `git format-patch ... &&
git send-email ...` ?

> I rebased it on top of today's latest:
> * 7946462d31a0 (HEAD -> test) ideapad-laptop: Add Lenovo Yoga 2 13 to the no_hw_rfkill DMI list
> * ccda4af0f4b9 (tag: v4.20-rc2, origin/master, origin/HEAD) Linux 4.20-rc2
> *   7a3765ed66d1 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
> |\
> | * 7236ead1b149 act_mirred: clear skb->tstamp on redirect
> | * a9049ff9214d net: dsa: mv88e6xxx: Fix clearing of stats counters
> | * 7ab412d33b4c tipc: fix link re-establish failure
> | * 63c82997f5c0 net: sched: cls_flower: validate nested enc_opts_policy to avoid warning
> | * fbd1d5245372 net: mvneta: correct typo
> | * 62230715fd24 flow_dissector: do not dissect l4 ports for fragments
> | * d02854dc1999 net: qualcomm: rmnet: Fix incorrect assignment of real_dev
>
> Loic
>
> On Fri, Oct 19, 2018 at 7:10 AM Loic Wei-Yu-Neng <loic.wyn@gmail.com> wrote:
>>
>> Hello Andy,
>> Sure let me do that.
>> Loic
>>
>> On Fri, Oct 19, 2018, 4:29 AM Andy Shevchenko <andy.shevchenko@gmail.com wrote:
>>>
>>> On Wed, May 16, 2018 at 4:18 AM Loic WEI YU NENG <loic.wyn@gmail.com> wrote:
>>> >
>>> > Some Lenovo ideapad models lack a physical rfkill switch.
>>> > On Lenovo models Yoga 2 13, ideapad-laptop would wrongly report all
>>> > radios as blocked by hardware which caused wireless network connections
>>> > to fail.
>>> > Add these models without an rfkill switch to the no_hw_rfkill list.
>>> >
>>>
>>> I'm very sorry, but by some unclear reason this patch is missed in the
>>> tree and in our patchwork.
>>> Does it still actual?
>>>
>>> May you resend it rebased on top of our for-next branch?
>>>
>>> > Signed-off-by: Loic WEI YU NENG <loic.wyn@gmail.com>
>>> > ---
>>> >  drivers/platform/x86/ideapad-laptop.c | 7 +++++++
>>> >  1 file changed, 7 insertions(+)
>>> >
>>> > diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
>>> > index 535199c9e6bc..0a843c4ca4fc 100644
>>> > --- a/drivers/platform/x86/ideapad-laptop.c
>>> > +++ b/drivers/platform/x86/ideapad-laptop.c
>>> > @@ -1114,6 +1114,13 @@ static const struct dmi_system_id no_hw_rfkill_list[] = {
>>> >                         DMI_MATCH(DMI_BOARD_NAME, "Yoga2"),
>>> >                 },
>>> >         },
>>> > +       {
>>> > +               .ident = "Lenovo Yoga 2 13",
>>> > +               .matches = {
>>> > +                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>> > +                       DMI_MATCH(DMI_PRODUCT_VERSION, "Yoga 2 13"),
>>> > +               },
>>> > +       },
>>> >         {
>>> >                 .ident = "Lenovo Yoga 3 1170 / 1470",
>>> >                 .matches = {
>>> > --
>>> > 2.17.0
>>> >
>>>
>>>
>>> --
>>> With Best Regards,
>>> Andy Shevchenko
>
>
>
> --
> Loic WEI YU NENG
> US phone: +1 408 218 2826
> FR phone: +33 674201069
> email: loic.wyn@gmail.com



-- 
With Best Regards,
Andy Shevchenko
