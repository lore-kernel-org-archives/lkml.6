Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF13BC3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A532F24069
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 02:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcsMGSy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A532F24069
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753311AbeGECpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 22:45:11 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51768 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbeGECpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 22:45:08 -0400
Received: by mail-it0-f65.google.com with SMTP id o5-v6so9959890itc.1;
        Wed, 04 Jul 2018 19:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fPXzw8C7NGM/c70DjDO+9kZmZRhYEZAVdhKJhUyfInU=;
        b=UcsMGSy5wWSloQ4i3auy2diiy4rpaItvK6pRoKkPbwkeDySWDie62yAm9RNsqhPjry
         J8VEkYlgIGyWlFt7Lk2oKRv/mbmyFfRYc7JxVsg5FWYiYcIivZ6M3pxzdWhQWQjVU7CI
         fB9qgErJKrHnDkMabSM7rMdD1qYbHhlSrOOm/r24J4eG2rbqTVMU1Hhsz84FF899OVmq
         lOoNtQnJqCMlF9mtB6ZEEtPyrEN4po1OweLC1p1OotPDJwr5d0K3A0PL1RISDQICYMqb
         4vyNg4pJDjggEL6lxTXPo7U9v4gtQo4KYAf0fXpwF3pEEeuJATF6Pbn0ynhLsjgtkmHY
         Q+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fPXzw8C7NGM/c70DjDO+9kZmZRhYEZAVdhKJhUyfInU=;
        b=mFGcEe91ut8C69nI8dOqaMlMVzBNRNRx9Ze3OyBBVGRbJxk3vZIHDWSaTQo6IZVeLL
         jx58TAq3NQu+iuJv9R9vyZ77Yudp05cdObqGJgu8J7toDUt4je9QKBnPW8eAn8Vtgwvf
         aPUC0YmYDj9KKamvIUAHb782+/P3/069Wkw4ldwi9PP/vSowRuzQ7kDoh5Xz9o0PXBUw
         yMGWlGaW9ws+/Er5RkbbghCU4kSViXVulNbYIFuFSYmeILnP/ZeD2P/wToHM6d7mUE3d
         wSnkmbtUOBuPaBFsXtSLZxo0oSzw3+cCAroU0BetCb1WAoPe5WRoQlFFKkUdYwC5mUMV
         8VIA==
X-Gm-Message-State: APt69E0+T57HAoMEwtxmNgzFBr4MirvHaecSkKG15o4mVnfhANx3mAlb
        GU5tBlsPL2yTAjfK7DqLFfBzslOr9v0RZDTKbw==
X-Google-Smtp-Source: AAOMgpczhLpZ4TNf4QwINn5jJWaL1s5BI9m7ZR8eJiRLAXq4ny8fUFYBcRtGhQQA3BvZw5h4l646i17wUKpaKuW+5Qc=
X-Received: by 2002:a24:7686:: with SMTP id z128-v6mr3493157itb.34.1530758708205;
 Wed, 04 Jul 2018 19:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan> <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
 <6281446.GoJLz6Hq6C@aspire.rjw.lan>
In-Reply-To: <6281446.GoJLz6Hq6C@aspire.rjw.lan>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 5 Jul 2018 10:44:57 +0800
Message-ID: <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To:     rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 6:23 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, July 4, 2018 4:47:07 AM CEST Pingfan Liu wrote:
> > On Tue, Jul 3, 2018 at 10:36 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > On Tuesday, July 3, 2018 8:50:38 AM CEST Pingfan Liu wrote:
> > > > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
> > > > places an assumption of supplier<-consumer order on the process of probe.
> > > > But it turns out to break down the parent <- child order in some scene.
> > > > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
> > > > have been probed. Then comes the bridge's module, which enables extra
> > > > feature(such as hotplug) on this bridge.
> > >
> > > So what *exactly* does happen in that case?
> > >
> > I saw the  shpc_probe() is called on the bridge, although the probing
> > failed on that bare-metal. But if it success, then it will enable the
> > hotplug feature on the bridge.
>
> I don't understand what you are saying here, sorry.
>
On the system, I observe the following:
[    2.114986] devices_kset: Moving 0004:00:00.0 to end of list
<---pcie port drive's probe, but it failed
[    2.115192] devices_kset: Moving 0004:01:00.0 to end of list
[    2.115591] devices_kset: Moving 0004:02:02.0 to end of list
[    2.115923] devices_kset: Moving 0004:02:0a.0 to end of list
[    2.116141] devices_kset: Moving 0004:02:0b.0 to end of list
[    2.116358] devices_kset: Moving 0004:02:0c.0 to end of list
[    3.181860] devices_kset: Moving 0004:03:00.0 to end of list
<---the ata disk controller which sits behind the bridge
[   10.267081] devices_kset: Moving 0004:00:00.0 to end of list
 <---shpc_probe() on this bridge, failed too.

As you can the the parent device "0004:00:00.0" is moved twice, and
finally, it is after the "0004:03:00.0", this will break the
"parent<-child" order in devices_kset. This is caused by the code
really_probe()->devices_kset_move_last(). Apparently, it makes
assumption that child device's probing comes after its parent's. But
it does not stand up in the case.

> device_reorder_to_tail() walks the entire device hierarchy below the target
> and moves all of the children in there *after* their parents.
>
As described, the bug is not related with device_reorder_to_tail(), it
is related with really_probe()->devices_kset_move_last(). So [2/4]
uses different method to achieve the "parent<-child" and
"supplier<-consumer" order. The [3/4] clean up some code in
device_reorder_to_tail(), since I need to revert the commit.

> How can it break "the parent <- child order" then?
>
As described, it does not, just not be in use any longer.

Thanks and regards,
Pingfan
