Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C62BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 084B420852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrrA1ZGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084B420852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbeGXK0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:26:53 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33153 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388182AbeGXK0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:26:53 -0400
Received: by mail-oi0-f48.google.com with SMTP id l10-v6so6300622oii.0;
        Tue, 24 Jul 2018 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PgGmu8rZ1+8joALR8uyHh3Rj8sp7wqCVeFgW6gXks5M=;
        b=HrrA1ZGoLdXphHvZNs08APl6VPfYHaOwtuy8cEAHnhzVsf9fihfBIwysGwF2L3Y1+M
         pg+KfXm8/xjkwlerWtAY8OT669NmaLaEC4SuLGk52M0PuVgu4ka5F73GAFCxODimV7e2
         CF6wq/dHnFWvtPMsQtXX8b3vHz77lFian1npRR0dK051Gm4xrmAJm49Nt9u4Z8ZgiFcP
         3dGFsYOXx/h57dAB8gCOqeg5zoqkeW2QTNMsZmYNp8uo0qeEn1Y+f5ikyBaR+pUROkqh
         S3mbSdQ6VdWofhrQJnfACi3oDBJ/HfEr/+8NjHFpUiFoittiiYXdh7kzgH1QwJ6GW9IV
         074A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PgGmu8rZ1+8joALR8uyHh3Rj8sp7wqCVeFgW6gXks5M=;
        b=V4KWoFSgQscf3bmGzegpOXAII6Poq+1K1WqCYX7tPcm/YWBZFDYMsrHYZXUUV+j1tO
         mAdcJPPbxjlQJkdjE8etMDohRj0NxGMXPTOEA/g09K9axFZzc8j+Wq6VKM1/MZHZPjK2
         flKxiDUTEdvTeqm1xIkpm43Fv5tbSTSnyvFr2Qh8Q9v9KHxzv2WojNDak00AmAZN7ADP
         vUbn3Lf2Gm7IR/zKrvTO/c+XXOchvQJtj1bAEp0NN7Uc1bLoLG3lUtUfSNt3yLmx7zxJ
         ppIyHMOQqP1h9WT6UlQfOWp97lLarj1S05nnrqE9dEg5hdAT81resS4xdpqdk5rKd5CW
         jwRA==
X-Gm-Message-State: AOUpUlGj8MtMUA7RgHIKvSnyFsoRhg6rE1o2fpPQvoBjCvFtVH3ztGYN
        INdQ89lvxcUmxWA8OVP4i1tpqBx00hemmTdVkDc=
X-Google-Smtp-Source: AAOMgpfyXqSuTsGFEzX+MZz1rn8DFSyEOqVKw1mkf/xTRuP4UQLYvY7WzNsYYznFL16bW1QoZV2Sg5MeOA7myvUMMNs=
X-Received: by 2002:aca:6285:: with SMTP id w127-v6mr2255012oib.120.1532424080954;
 Tue, 24 Jul 2018 02:21:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 02:21:20
 -0700 (PDT)
In-Reply-To: <20180724091226.GB22465@amd>
References: <20180723214917.GA3733@amd> <CAJZ5v0g=Ey6ZiyjA3NWS_C5zXBUydJNaKOZDbRNFYUGEc8YuaQ@mail.gmail.com>
 <20180724091226.GB22465@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Jul 2018 11:21:20 +0200
X-Google-Sender-Auth: jj-vifumRZ6bxdm7DxrZU_H_GGc
Message-ID: <CAJZ5v0g0b2ucGEn3+hhEgw4FVJP4oV1D+99a3jTNjq4av_qsDg@mail.gmail.com>
Subject: Re: linux-next-20180723: battery status funny after bootup
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, lucas.magasweran@ieee.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 11:12 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Tue 2018-07-24 10:27:08, Rafael J. Wysocki wrote:
>> On Mon, Jul 23, 2018 at 11:49 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> >
>> > pavel@amd:~$ cat /proc/acpi/battery/BAT0/state
>> > present:                 yes
>> > capacity state:          ok
>> > charging state:          charged
>> > present rate:            0 mW
>> > remaining capacity:      0 mWh
>> > present voltage:         0 mV
>> > pavel@amd:~$ uname -a
>> > Linux amd 4.18.0-rc6-next-20180723+ #141 SMP Mon Jul 23 22:11:47 CEST
>> > 2018 i686 GNU/Linux
>> >
>> > It will correct itself if I unplug/replug the AC adapter, I
>> > believe. Gnome2 battery monitor also looks confused.
>>
>> There are two battery changes in linux-next now that are not present
>> in the mainline
>>
>> 2a2aad34362b ACPI: battery: remove redundant old_present check on insertion
>> 706ac4aa536f ACPI: battery: use cache_time as cache "enabled"
>>
>> Does reverting any of them help?  Or is the problem present in the
>> mainline too?
>
> Thanks for pointers! Not it mainline, I'd notice that.
>
> I reverted 706ac4aa536f , and on the next boot:
>
> pavel@amd:~$ cat /proc/acpi/battery/BAT0/state
> present:                 yes
> capacity state:          ok
> charging state:          charged
> present rate:            0 mW
> remaining capacity:      37150 mWh
> present voltage:         16400 mV
>
> ..plus icon was ok from the start.

OK, I'll drop 706ac4aa536f then, thanks!
