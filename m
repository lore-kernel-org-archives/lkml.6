Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C28FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15034240E5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nc3ZRlWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15034240E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933925AbeGDKYS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:24:18 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45024 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753262AbeGDKYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:24:16 -0400
Received: by mail-ua0-f196.google.com with SMTP id v15-v6so3125250ual.11;
        Wed, 04 Jul 2018 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VQXQS+yyhmQSgZgLhlQ3uKR5ZzWrXmRF7yCFipTMdiA=;
        b=Nc3ZRlWwDNSNCngCdWthiJGUngE7BKuiZzfs4CfKpzGNCYBkOIxVZvt//Q95ch3w7O
         nLHUPTx+LNWYDGvhIIkEUOs1TmWyDQ3tJcrthOLMTD5zkwIT8JddvTP8okGWet2cMmcz
         LoObBiTMDFlOgfWuN2npA8FMBQzx3ceiw3/0+Z3D9XoSTF8yHYDlZTg+WK9J5nJGeRyD
         DHP4OYlo15HbvVf1v96C9jEfC/ocV4odN0hc88Y+MOSVq3UcJ5x29ERR348JFDlBs43O
         eY2UxzJmTzTHIDOFBezf6qEsq5ZZ8EHv+GsU0ndbX3CCfnPA90Pxss6bsWjatB+pFHOn
         s8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VQXQS+yyhmQSgZgLhlQ3uKR5ZzWrXmRF7yCFipTMdiA=;
        b=Q5SZOmBeez912IJwwsD+aYIr7GmYRE/kn0xw729QPjyB/I8dKQzvuHdTD+hOIYVm7H
         uTOKVu5869bXEUTBf38HJuc8UCylT7yQ+pnfS1KgjqgZSPKEQc9q6Y+m7DoyD9GJRYqt
         EdZxyovX1wFHT+xF4YwYsPpCdL88mZB/CxWpPL7eaWB6GxODaZEsdlBH+efbTJ2TLElt
         YAaHPzVGBvc2ImzsS9YHpIgji47rlejKSguBR68nseNlliJn04P/adAR0eCynqhSXyTp
         AhXyzaRCjN++f4SzQOqHFgUXfV2OYX0yz6qTjGuzXIv2yvhxsuSRfMaooJX98x0te+ms
         VRLw==
X-Gm-Message-State: APt69E2a4NCk8qeO8wohW+eyQdupcVS4rEZRVzWjD7ZXDJrKeoYOLAu8
        mSa+o3IqcMNC3YiR936uOypNocG3TLvOyEVnfac=
X-Google-Smtp-Source: AAOMgpeuYrDj5CScyxKE9R5SJoRZICFdNPUZ8XMKcxNThAF3nIkpwwR5JTMeUBjCiWtaAWMZXs4hIEYBnuWpbuU09nQ=
X-Received: by 2002:a9f:2187:: with SMTP id 7-v6mr831391uac.49.1530699855487;
 Wed, 04 Jul 2018 03:24:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 03:24:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1807041205290.8629@fox.voss.local>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
 <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com>
 <CABe79T7EeyzKS97zeQ5akoSaZX0=hMgHxw4XkLCQW15eRR=14Q@mail.gmail.com>
 <CAHp75Vef97XB-M=+xUxsGqzgPrADcUmLTLRdWE+PcVxtTQLN4g@mail.gmail.com>
 <8518137d-c859-657e-844f-51720f6ef8dd@arm.com> <alpine.DEB.2.20.1807041205290.8629@fox.voss.local>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 13:24:14 +0300
Message-ID: <CAHp75VeuoTM=RoUgk0qWyiRJYk2AncVhxKDvms_2Hv0yE=g8uQ@mail.gmail.com>
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        "Voss, Dr. Nikolaus" <Nikolaus.Dr.Voss@loewensteinmedical.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nv@vosn.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 1:17 PM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> On Wed, 4 Jul 2018, Sudeep Holla wrote:
>> On 04/07/18 10:32, Andy Shevchenko wrote:
>>> On Wed, Jul 4, 2018 at 6:37 AM, Srinath Mannam
>>> <srinath.mannam@broadcom.com> wrote:

>> +1 on NACK for this and anything else that abuse PRP0001 as a short cut
>> approach.
> This is no abuse but exactly what PRP0001 is meant for. The basic idea of
> PRP0001 is to reuse DT "compatible" strings in ACPI namespace, see
> Documentation/acpi/enumeration.txt. Reusing also means getting access to the
> of_device_id.

The idea was for almost DIY and / or manufacturer to develop a
prototype without modifying match code and faking ACPI IDs.
That's why the target of PRP0001 is almost sensors connected to I2C and SPI.

That's why I agreed on your patch to help with this. But! The proper
solution for the devices (device manufacturer) is to allocate an ACPI
ID and provide a corresponding table to the driver.

This is my understanding of that exercise. Rafael can correct me.

> Allocating an ACPI id for an already existing DT driver is redundant, isn't
> it?

It is not.

-- 
With Best Regards,
Andy Shevchenko
