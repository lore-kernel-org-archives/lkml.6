Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B84BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F95E20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOKDrrSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F95E20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388620AbeGXJc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:32:29 -0400
Received: from mail-oi0-f43.google.com ([209.85.218.43]:37022 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388406AbeGXJc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:32:29 -0400
Received: by mail-oi0-f43.google.com with SMTP id k81-v6so6032393oib.4;
        Tue, 24 Jul 2018 01:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1OovNaK4G4KGaeUvh+f3JGUXUtFQJe4nQ/h1dRDsnK8=;
        b=XOKDrrSt3294aU5uthoF/0iNIeYhk8gCnZEdcgy1vIJ2L6KABLDKC1/Qba5m/q1Mqj
         K7YQ4GNYnf7gd1JxrQuHdH7eQs5zvP/af/huIgiTmm99WSTsKqg8GMEJ9vuzKvFja4te
         WxmOUpJZTMtcUApFhubyd4ni9BglLdcybOgbTqO7fes1/GGVYfT6QqNEBOxXEsajswbn
         G32ic6sF9s+eX3cX9PHEk8RXyXAsgZ6c2OLw/1tTdQBHwilQQG9Bq6+IZb9BAyI6lYHz
         xLZamRQMs/F4uePU3Y3I0BcBVz4CFhSBD7++/evusOvtvTJaKxxGRGFVYXTvNCDjmqnK
         +rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1OovNaK4G4KGaeUvh+f3JGUXUtFQJe4nQ/h1dRDsnK8=;
        b=CTV5ksY+gMsrvkJ9/187JygjSVwjx+zXfhK1iIT74fFrL3t6BqjcL7BxRaqD/GQSQy
         aH5mSbth4DaCau03TAL5QEo6rhSUhTpatjJxwxivw+5dGcnh81ThzZE0uqypo+LpNBxl
         +JePB+Y17L/5p4JUi++BiLkipEVGo6jrS41UrgrUMN8/lsKh0FKaGb6/mUWaPkNIp788
         kZrvXM/OTNRfSyo/k5KnnFLuyuX8P8y5wbQps35bZ8ewkD+57ZKb4DpqGvfBChHz0dLC
         4G0USNitL0iR7Mjk8SpY5le2AuYUM43Qw2Mr1UtoUKZkSUJght31lll4FmWu5eu5EUap
         v6Sg==
X-Gm-Message-State: AOUpUlHjmMbh9YRJErb9H52C1lgvNPOwsQLnBKRM/ZAIVjxx6B26hFUM
        91g55sWx3x9BlKTVLOTYjJXv7WB/fboEqX/rh83cRetr
X-Google-Smtp-Source: AAOMgpdX6gqCEsV+qj8DcY7urWg1QZyBdwqekjI4o67LHWp8BKtYtcZXgE/E3I+pJvVVUP4rzQ+9xnuN71xQpLG5Blc=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr2381809oib.116.1532420829276;
 Tue, 24 Jul 2018 01:27:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 01:27:08
 -0700 (PDT)
In-Reply-To: <20180723214917.GA3733@amd>
References: <20180723214917.GA3733@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jul 2018 10:27:08 +0200
X-Google-Sender-Auth: sez4KU-WyfioyMA2Khy7QsxdLVE
Message-ID: <CAJZ5v0g=Ey6ZiyjA3NWS_C5zXBUydJNaKOZDbRNFYUGEc8YuaQ@mail.gmail.com>
Subject: Re: linux-next-20180723: battery status funny after bootup
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 11:49 PM, Pavel Machek <pavel@ucw.cz> wrote:
>
> pavel@amd:~$ cat /proc/acpi/battery/BAT0/state
> present:                 yes
> capacity state:          ok
> charging state:          charged
> present rate:            0 mW
> remaining capacity:      0 mWh
> present voltage:         0 mV
> pavel@amd:~$ uname -a
> Linux amd 4.18.0-rc6-next-20180723+ #141 SMP Mon Jul 23 22:11:47 CEST
> 2018 i686 GNU/Linux
>
> It will correct itself if I unplug/replug the AC adapter, I
> believe. Gnome2 battery monitor also looks confused.

There are two battery changes in linux-next now that are not present
in the mainline

2a2aad34362b ACPI: battery: remove redundant old_present check on insertion
706ac4aa536f ACPI: battery: use cache_time as cache "enabled"

Does reverting any of them help?  Or is the problem present in the mainline too?
