Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E7DC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B92221A33
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfMuF/RM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B92221A33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbeGEJSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:18:32 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35389 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753070AbeGEJS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:18:29 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so15521324oik.2;
        Thu, 05 Jul 2018 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=t/2HkOSC5f+cNCiINk4BpI9r9A6kYRMxQowBDg692SM=;
        b=LfMuF/RM1id2E4qJ+9FyAdghz5bWNIZuIwueagRWgYJ/C8KIc2eNS/lMOfMZdeyUd8
         vNcgx4Y3Qo/Qy8wwgxpNCeh50qvCqmDARMZHsy4u223ml4jWihLEqCguU6O5I3WFrKdz
         N1KVI/nZGSA54s2LihXqxj3JILDpqZQusfbVbvTyA50gIuG25QFXM5+vWI3plyhXz1Vt
         D98x1S/WwUE4+5xXR+B6xiF42QNn/pF+rjYY6BRqd+QzOjI0E1Wyx/xziBflMPgRNs62
         t4dFe8c4xpUxpPTbRxMvT0vLYGZ9Udaf1q857UJtXPYHedp1n4wabzwp2zcHIRweliTE
         uVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=t/2HkOSC5f+cNCiINk4BpI9r9A6kYRMxQowBDg692SM=;
        b=hSf0dVn94c79wpZHtgt1jhr3qw8jGIRisj3qlFqX6lMNQyO0Vlrx+7J4mgu5C2qfHJ
         ATn7RxXJNIm2gB99UBMKqIWHpulK1pVssnKywTwReWC31B7vix6ww6pScNyZp9rOYfpn
         tWG7WhqQcqM6hmfnZsodIH/YK/JaFES0GMm20sYAqFptJXgWPD9PUF+41pC5k3qGhdKT
         h5ILvqlq5+EsD93s3211MKuu7wYZb5a6iMREViwh4b1u+ImKvWhdtV71PHOgFz3PHX1H
         Jw4TEWrwjSouvqsA99XYN9JeImaFBACc+fAmMV6uGDAmYx5NA802Rnva+bK4yX+Iuiwz
         hYQg==
X-Gm-Message-State: APt69E3ppVUYKFQZZQLdWmdhwqgv8nTxbxExHBn8Tdc76hrXgRRExKh0
        zqJSaoPv9ajGYCnMllW3qND4Ua8IiJgaRs6PTLw=
X-Google-Smtp-Source: AAOMgpfofdW09QuhFBrB8Xs7zvrb7D5yCuJ0h0NcpgbyDcQUJJbRE61MGewMoagnMT+KbLM9Y7QYanfdbm1AKa0/i9k=
X-Received: by 2002:aca:ecd0:: with SMTP id k199-v6mr6210968oih.227.1530782308895;
 Thu, 05 Jul 2018 02:18:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 02:18:28 -0700 (PDT)
In-Reply-To: <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <4685360.VNmeYLh0dQ@aspire.rjw.lan> <CAFgQCTusBM0-E=wAJgRJA7g-RnDi9ts==-M7KezNBwSWnyO=HA@mail.gmail.com>
 <6281446.GoJLz6Hq6C@aspire.rjw.lan> <CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Jul 2018 11:18:28 +0200
X-Google-Sender-Auth: XNQ1Dh6kmXg8q6D2dZ1Dw7XdmXU
Message-ID: <CAJZ5v0jo5-z0ZYDzdNPpn54+oAxpdG_=EvVDdz-HKxp7psu-EA@mail.gmail.com>
Subject: Re: [PATCHv3 0/4] drivers/base: bugfix for supplier<-consumer
 ordering in device_kset
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dave Young <dyoung@redhat.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 4:44 AM, Pingfan Liu <kernelfans@gmail.com> wrote:
> On Wed, Jul 4, 2018 at 6:23 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>>
>> On Wednesday, July 4, 2018 4:47:07 AM CEST Pingfan Liu wrote:
>> > On Tue, Jul 3, 2018 at 10:36 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > >
>> > > On Tuesday, July 3, 2018 8:50:38 AM CEST Pingfan Liu wrote:
>> > > > commit 52cdbdd49853 ("driver core: correct device's shutdown order")
>> > > > places an assumption of supplier<-consumer order on the process of probe.
>> > > > But it turns out to break down the parent <- child order in some scene.
>> > > > E.g in pci, a bridge is enabled by pci core, and behind it, the devices
>> > > > have been probed. Then comes the bridge's module, which enables extra
>> > > > feature(such as hotplug) on this bridge.
>> > >
>> > > So what *exactly* does happen in that case?
>> > >
>> > I saw the  shpc_probe() is called on the bridge, although the probing
>> > failed on that bare-metal. But if it success, then it will enable the
>> > hotplug feature on the bridge.
>>
>> I don't understand what you are saying here, sorry.
>>
> On the system, I observe the following:
> [    2.114986] devices_kset: Moving 0004:00:00.0 to end of list
> <---pcie port drive's probe, but it failed
> [    2.115192] devices_kset: Moving 0004:01:00.0 to end of list
> [    2.115591] devices_kset: Moving 0004:02:02.0 to end of list
> [    2.115923] devices_kset: Moving 0004:02:0a.0 to end of list
> [    2.116141] devices_kset: Moving 0004:02:0b.0 to end of list
> [    2.116358] devices_kset: Moving 0004:02:0c.0 to end of list
> [    3.181860] devices_kset: Moving 0004:03:00.0 to end of list
> <---the ata disk controller which sits behind the bridge
> [   10.267081] devices_kset: Moving 0004:00:00.0 to end of list
>  <---shpc_probe() on this bridge, failed too.
>
> As you can the the parent device "0004:00:00.0" is moved twice, and
> finally, it is after the "0004:03:00.0", this will break the
> "parent<-child" order in devices_kset. This is caused by the code
> really_probe()->devices_kset_move_last(). Apparently, it makes
> assumption that child device's probing comes after its parent's. But
> it does not stand up in the case.
>
>> device_reorder_to_tail() walks the entire device hierarchy below the target
>> and moves all of the children in there *after* their parents.
>>
> As described, the bug is not related with device_reorder_to_tail(), it
> is related with really_probe()->devices_kset_move_last().

OK, so calling devices_kset_move_last() from really_probe() clearly is
a mistake.

I'm not really sure what the intention of it was as the changelog of
commit 52cdbdd49853d doesn't really explain that (why would it be
insufficient without that change?) and I'm quite sure that in the
majority of cases it is unnecessary.

I *think* that it attempted to cover a use case similar to the device
links one, but it should have moved children along with the parent
every time like device_link_add() does.

> So [2/4] uses different method to achieve the "parent<-child" and
> "supplier<-consumer" order. The [3/4] clean up some code in
> device_reorder_to_tail(), since I need to revert the commit.

OK, let me look at that one.

Thanks,
Rafael
