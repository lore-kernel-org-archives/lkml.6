Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A24C43612
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4622420866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbfAPIV3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:21:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37922 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388586AbfAPIV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:21:28 -0500
Received: from mail-pg1-f197.google.com ([209.85.215.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gjgRy-0003r5-Fa
        for linux-kernel@vger.kernel.org; Wed, 16 Jan 2019 08:21:26 +0000
Received: by mail-pg1-f197.google.com with SMTP id p4so3401706pgj.21
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 00:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=R2i8PUL7ly2weAfBpz1vycpQ1SdmhQgqOzAL1abnVp4=;
        b=Hb40ZPBnGPlWVhefNBUNK8CSc1VO9QGwi5Vp2w9u4OGza+zTef+cRzGm5ko4if2c7A
         awauh6lGJ9mHXGx1DR/ia3wOJTFbUIaWlxVuvT0+ZZKXGSSdccJkm4h62e76h0Qt12ri
         zCHjytoeV8048w3eWfmvjFJ2yaOM7AQaMMgjuAhfI+Kpj51wc3c9WRVg6iJMZ379VnZL
         Tpp5JXZYZyLD8kln+8kQPCwkT3AugtcwpSY1iZj4eom/Q9DtMm8b3PKwnEJ8SBPiItwG
         x7/R1ixR35HxImGl1H5GzTiflgrV9/4i7Wt6mQfzogu3LJEWU+Rj1PLZyow7WIpDLRnH
         Urgw==
X-Gm-Message-State: AJcUukcHaFSWTHipt60KG/zW9qWynbTVzXt5A2lRyXIrPvG25abDRZo5
        dUGlJPqyfCCEhbye+C/bGb/kqM2HZOw5UA+vnh445PVHzJrQEoeb6zmT9dbd/J2Qz/TCTgMDNeP
        iofClFGAmJxjoJ6CkB1Cur7TnJUsQGdY0jQ04ERreNg==
X-Received: by 2002:a63:cb4a:: with SMTP id m10mr7517993pgi.105.1547626884879;
        Wed, 16 Jan 2019 00:21:24 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6k0pLpezZfrzcZc2GDNXOqeCgz5o6tLY4QsKSOTBzm90caJateo/XahQ50j/cFtCTcjHKi6Q==
X-Received: by 2002:a63:cb4a:: with SMTP id m10mr7517971pgi.105.1547626884543;
        Wed, 16 Jan 2019 00:21:24 -0800 (PST)
Received: from 2001-b011-380f-13aa-c92e-9fed-1d27-9897.dynamic-ip6.hinet.net (2001-b011-380f-13aa-c92e-9fed-1d27-9897.dynamic-ip6.hinet.net. [2001:b011:380f:13aa:c92e:9fed:1d27:9897])
        by smtp.gmail.com with ESMTPSA id q195sm6565637pgq.7.2019.01.16.00.21.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 00:21:23 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] HID: i2c-hid: Disable runtime PM on Goodix touchpad
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <nycvar.YFH.7.76.1901141217550.6626@cbobk.fhfr.pm>
Date:   Wed, 16 Jan 2019 16:21:21 +0800
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <663EE74C-02E8-49DB-A197-2022AFE2D863@canonical.com>
References: <20190114084734.3362-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.1901141217550.6626@cbobk.fhfr.pm>
To:     Jiri Kosina <jikos@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 14, 2019, at 19:18, Jiri Kosina <jikos@kernel.org> wrote:
> 
> On Mon, 14 Jan 2019, Kai-Heng Feng wrote:
> 
>> A Goodix touchpad doesn't work. Touching the touchpad can trigger IRQ
>> but there's no input event from HID subsystem.
>> 
>> Turns out it reports some invalid data:
>> [   22.136630] i2c_hid i2c-DELL091F:00: input: 0b 00 01 00 00 00 00 00 00 00 00
>> 
>> After some trial and error, it's another device that doesn't work well
>> with ON/SLEEP commands. Disable runtime PM to fix the issue.
> 
> Thanks, I've now applied the patch to for-5.0/upstream-fixes. I am 
> wondering though we are we seeing these at all - do other OSes not do the 
> runtime PM on i2c at all?

According to the vendor, Windows does use ON/SLEEP, but infrequently.

We can use pm_runtime_use_autosuspend() to reduce the frequency of
ON/SLEEP commands, but it’s just papering over the touchpad firmware
bug.

Kai-Heng

> 
> -- 
> Jiri Kosina
> SUSE Labs
> 

