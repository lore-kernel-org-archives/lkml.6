Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7E2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588CB20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XytrJVhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588CB20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbeGWO5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:57:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39699 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387801AbeGWO5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:57:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id h4-v6so1042800edi.6;
        Mon, 23 Jul 2018 06:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xhfWSThYJMriuwkKk/i6vmAtdz9cjvGClIlqhTnxW9c=;
        b=XytrJVhvK+oNKQa3fp7Rd6V4F33voBDE3ApH00ZbRc9zmytXF3Bjo5JE9rIlOYvz/b
         ejKdAI/L2rdFPWFn41Lpb8t00Po2azcClfUgDLYprPuNWKZ61Ifmll0Kd8zYAgOlZ8X9
         ZQL3GDkl154NS0/75UqhvPGmmzvVc/DxYuBGyipIjFXsRj9eH8cSFYM7Dt5J/ss5cWS9
         itOt9epqzihDJq5HGAJtz4U0UFKIpRo4CoqI3cy7QSrWyTYjkD6qkHw0wAez9+0C8DZB
         aHNOgRnVmlJGO2n2xXqQJZxZCiygqZrxPnVtlsiKmFpmEHC+O38RdeaF2uoIsNbuE7df
         oRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xhfWSThYJMriuwkKk/i6vmAtdz9cjvGClIlqhTnxW9c=;
        b=R4WAFb4y8P/7ueEQOGXJmXOndGDzElr7/O1efURyNj2RNKG5dGduKrjjktgC6gRwJv
         3zo66BTwXEsBOoMnRusEmBhhQtOO30oBYTkRm9tNl6xTaDGKodTuJ0gCT35fLnN3A+je
         80Pv0E175bCO40HiEfOH0tjk0u0MgeyepxzfpYya8L3/0InnGKVSWTF0hAQQshsGr8Vy
         TbRhdCf6c+l264yjX+xN1advaSnEjmgouxIp3jpFOhPnbVu+Xd+w+xGgZn9HPf3bJxom
         m7hrq2StfqCmkIu+vY0R4FpXN0qz9Ex/CHYZCK61Wc87eNSP4tK2GGPllvVU6ug9jllo
         pWLg==
X-Gm-Message-State: AOUpUlH90NylvqWwJErQepSveSO4wej3u2+Yne4o1lUVcBSqKKw0xJn9
        09EoKOXUn88Rim6Q4oHAu1JbXFQEXzLzTp8e+SYc0g==
X-Google-Smtp-Source: AAOMgpeWOWGvJCYw6tiQ6HbbsvQ2AMXmikeODEv1rMqom9954BBluYnfQ8ROSA1P1xDcL1ctvkVL4v4KzB7wKz6WpRE=
X-Received: by 2002:a50:d429:: with SMTP id t41-v6mr14276931edh.75.1532354168482;
 Mon, 23 Jul 2018 06:56:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:f68b:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 06:56:08
 -0700 (PDT)
In-Reply-To: <20180723132956.tcsuxychhlhiwz6v@kahuna>
References: <20180716180607.16526-1-nm@ti.com> <20180723132956.tcsuxychhlhiwz6v@kahuna>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 23 Jul 2018 19:26:08 +0530
Message-ID: <CABb+yY1_SBTDPyUNGSr8=tpU4oObz060nJ3NrgR8JyQye23cfg@mail.gmail.com>
Subject: Re: [PATCH V2 0/6] mailbox: ti-msgmgr: Add support for AM654 Secure Proxy
To:     Nishanth Menon <nm@ti.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        ", linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 6:59 PM, Nishanth Menon <nm@ti.com> wrote:
> On 18:06-20180716, Nishanth Menon wrote:
>> The V2 of the series updates a minor comment in binding and picks up Rob's Reviewed-by
>>
>> Since I have'nt seen additional comments, I am assuming things are fine for v4.19.
>>
>> The following series enables support for Secure Proxy in newest addition in TI's SoC
>> portfolio - AM654 SoC (posted previously as RFC).
>>
>> The series is based on v4.18-rc1 and is available here:
>> https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-1-am6-sproxy
>>
>> There are a couple of follow on patches to be posted as well (Kconfig changes
>> for K3_ARCH and actual dts node changes).
>>
>> Changes since RFC are highlighted in each of the patches, but overall:
>> * The K3 dependency has been broken out into a seperate series independent of
>>   this.
>> * Binding has been seperated out as it's own file (even though the driver is
>>   reused).
>>
>> Consolidated all patches (including all series) are available here:
>> https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-am6-integ
>>
>> Full Boot log  on AM654 (integrated with all patch series) is available here:
>>    https://pastebin.ubuntu.com/p/bBFmnzYtCd/
>>
>> Nishanth Menon (6):
>>   mailbox: ti-msgmgr: Get rid of unused structure members
>>   mailbox: ti-msgmgr: Allocate Rx channel resources only on request
>>   mailbox: ti-msgmgr: Change message count mask to be descriptor based
>>   mailbox: ti-msgmgr: Move the memory region name to descriptor
>>   dt-bindings: mailbox: Add support for secure proxy threads
>>   mailbox: ti-msgmgr: Add support for Secure Proxy
>>
>>  .../bindings/mailbox/ti,secure-proxy.txt           |  50 +++
>>  drivers/mailbox/ti-msgmgr.c                        | 353 +++++++++++++++++----
>>  2 files changed, 336 insertions(+), 67 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
>
>
> Jassi,
>
> I dont see this in next-20180723. You'd asked me to hold off on pings
> https://lkml.org/lkml/2017/12/16/353 -> so, held off as much as I could
> before wondering on the status.
>
I didn't ask you to not ping me. I said I didn't miss your patchset. I
still didn't.

Especially for purely platform specific changes, that I don't have
knowledge about, I leave them to cook in public as long as possible,
before pulling them in around rc7.
You submitted V2, 7days ago only and we are at rc6 today. So chill.
