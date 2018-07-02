Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B82BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AB825DA6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lexmark.com header.i=@lexmark.com header.b="b/D69F9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AB825DA6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lexmark.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbeGBNcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:32:45 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:45245 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752073AbeGBNci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:32:38 -0400
Received: by mail-lj1-f170.google.com with SMTP id g3-v6so12580017ljk.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 06:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lexmark.com; s=lxk-google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f1scTJqg+dwNDLC0NnHDWB9narjcM0q/MvkCTh7IFPE=;
        b=b/D69F9T9OeRHyCMR7MVD4uuAqTJlcPQnJPmUctENipIhuq1JAGWACxksaPtXEV9zx
         ppE9AevBingYJ+cWDWExpgnAdhX7xDPoxSAUgvnAwAJQraiaKgnv0dTZ89ofQ/K/huDx
         WHAROC3Wi5RTPS4fiUpeaZRGcxPRlRojRd+KoQSQV4rlFKrbpbD13CEtJoCHifQ9Kvo/
         5wTZAW/fndaFzEKzmvYUWHVFuHKt9fgGfMw1+zEqDxbDlEmvRrOtyCwpNfYNnXKdc/KX
         HpfcTsytCupcVAzz4foPlHd9ykJweX6mbNOnGpXWoRlXY0WZx1hSZAZ5E8efu8XjT1KB
         BBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f1scTJqg+dwNDLC0NnHDWB9narjcM0q/MvkCTh7IFPE=;
        b=l7vXDNiKGBccr7qES+vN9lLqXT/kIV5dHAUQUnHuCQP0m8dXi14hWKCrzCp7JJPsuj
         iIzMNeyOy1HBZczB3J6ZdUw5WL6UTSDMqx/GQG1o6DPx1QKW9TAaD5UkUIfZhreUDjxr
         JbXyxwI5/eQZma7WBw/JgnluvI1EG3DCbVd6ilXuFVGmKjMixTl7dJZxRm+Pnp5ZE1qk
         zsVVJ7UWNBZ67EybX89XVxNKgA0xy3BGoMyLeIllE1vd3TUoXiAje1vPwFbMsGm7l/02
         LXwLc5YvU1RgBomxfqJ3MwBqsh/Ds1xuFt8UM1Xpjl6Jxc1WU6roCjReSFL31yAO22Yl
         AmDw==
X-Gm-Message-State: APt69E373SGC+U2ZW7+vCWOzIPrmLJYoZGO/uzYBPZUdkCul6eCfetKU
        R0AUXfjRbVZlrgDOhez0iuZ8LwFQWOXlDwp+a5m3iw==
X-Google-Smtp-Source: AAOMgpeAe4s81GYjmbEwFWrL8zVi4iJnOKG11O5RhYZX60Q6TynFQNTNYo6thDLF7CXSGMsd7+K/6y4adXWPl2OSRHE=
X-Received: by 2002:a2e:5243:: with SMTP id g64-v6mr9071102ljb.144.1530538357263;
 Mon, 02 Jul 2018 06:32:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9a4e:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 06:31:56 -0700 (PDT)
In-Reply-To: <20180702093243.GO112168@atomide.com>
References: <CA+G9fYuKW_jCFZPqG4tz=QY9ROfHO38KiCp9XTA+KaDOFVtcqQ@mail.gmail.com>
 <20180620102904.GC112168@atomide.com> <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
 <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com>
 <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com> <CAFY_6qq3=+hMLKr0VtCe-witPtV2LTeBSQb3pwqdzysbyiYtMQ@mail.gmail.com>
 <5206d66d-56d0-2edc-8dd0-00eedbaac3db@ti.com> <20180702093243.GO112168@atomide.com>
From:   Samuel Morris <samorris@lexmark.com>
Date:   Mon, 2 Jul 2018 09:31:56 -0400
Message-ID: <CAFY_6qo83Ui6_xRkuTYZUduUJSK2dLKhzd+B_nQ-XW5ciDH-7A@mail.gmail.com>
Subject: Re: 4.18.0-rc1-next-20180619 boot failed on beagle board x15
To:     Tony Lindgren <tony@atomide.com>
Cc:     Roger Quadros <rogerq@ti.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Tejun Heo <tj@kernel.org>, linux-omap@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, ssantosh@kernel.org,
        Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 5:32 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Roger Quadros <rogerq@ti.com> [180621 14:56]:
>> On 21/06/18 17:31, Samuel Morris wrote:
>> > On Thu, Jun 21, 2018 at 3:58 AM, Roger Quadros <rogerq@ti.com> wrote:
>> >> +Rafael
>> >>
>> >> On 20/06/18 18:30, Samuel Morris wrote:
>> >>> On Wed, Jun 20, 2018 at 8:58 AM, Roger Quadros <rogerq@ti.com> wrote:
>> >>>> Tony,
>> >>>>
>> >>>> On 20/06/18 13:29, Tony Lindgren wrote:
>> >>>>> Hi,
>> >>>>>
>> >>>>> * Naresh Kamboju <naresh.kamboju@linaro.org> [180620 05:55]:
>> >>>>>> Linux next (4.18.0-rc1-next-20180619) boot failed on beagle board x15.
>> >>>>>
>> >>>>> Bisect points to commit aece27a2f01b ("ata: ahci_platform: allow disabling of
>> >>>>> hotplug to save power").
>> >>>>>
>> >>>>> Reverting the patch makes things work again. Any ideas what
>> >>>>> might be going wrong here? Things clearly idle but then there
>> >>>>> seems to be some register access with clocks disabled.
>
> So this issue is still happening as of next-20180702. Can you guys
> please revert the commit above while working on a better solution?

That's fine with me. I'm not very familiar with the process here, does
this require anything on my end? And would that require the
accompanying patch to be reverted: "ata: ahci: rpm_put port on
port_stop to match rpm_get in port_start"? There shouldn't be any
problem leaving that one in, but I just want to know before submitting
my next patch set.

>
> Regards,
>
> Tony
