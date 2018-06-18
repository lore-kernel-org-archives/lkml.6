Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77026C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237052075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 23:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxJcdxls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237052075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935681AbeFRXGj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 19:06:39 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:38129 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755344AbeFRXGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 19:06:37 -0400
Received: by mail-ua0-f196.google.com with SMTP id 59-v6so11836401uas.5;
        Mon, 18 Jun 2018 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dboFUCsRjY4HUtCafVSbJvDAvEuo64xakQ4GD34SN8U=;
        b=kxJcdxlsnfbdY9RTVKiwpoJKA/mFWVHw9zqXCjEdnYjg2sjVuW912RmyPRXy9fQGBp
         E6SjIV4cJvStueKrWrVc4GLpaWxNcS/J9JhLIO14HAfYhCCe6IhnPVlslcQ4uTSJQcua
         0bK63ejM9cqZQrODEOKBmyFZUCFJ3hjgSLvGEyBTp/oiNqEvSMCKIEWavDyyWgErTwgq
         ryRiR5iQy1Z43/OFxs5qTYjk3iznVHqeWHAhUn0C3hirA3P7BEXRpzRNduMgeuF2+ePX
         ph3mgQGkNG5691yKOVEMB8yrZBFqsHvoxbfHtKm/7BrfxyOPA4ctCFnGH5g9/px05enD
         zXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dboFUCsRjY4HUtCafVSbJvDAvEuo64xakQ4GD34SN8U=;
        b=TUQYSyfLxX2ecSMOj8bz7Lcglhyr6iTHMagGO9DUJebkw1Wbmx87X9sdeL66x9NDVR
         ZlAPdcmmewrxtspI8H1bDL7audyPykCtMu+4IrtWSRZyp9+owL0Gi8Ral4fEOn+q+lwk
         j8kxsYikT8kM3UpGnnpt6aR2YT1PWrj/3YFtxS67uZsNOf9S1t63+Fj0OBqTTVcES+if
         KXrJEXSZpg8WsMn8onhTUtAYMXFXtGnRDkxQxukPjeNDNP7mAyHimv0ivVgS2sFv1aJY
         7cdSruFV2VcFG1A4Y+FKsYoKn+3lztgN7Cei1pHyYt7yTp6WuYjbjZO8+O5A+oZMEa/W
         2EKw==
X-Gm-Message-State: APt69E3oMv8b6AfQtxn/srFzqz3YNSrDEPSpUQjwxwz74pOvV0Zp7RCK
        WxA5+JwL/aYnXk+9YSK/sbSGRRgvV3Qg1RzELWA=
X-Google-Smtp-Source: ADUXVKLbjW2ZtjhnpXwmUDL3vFVhKuvX7z8zzElFfh0g3NTyuFGj0K+tu3I4pukofW9MeRWQ/8QuiSHbd1cfzNXLfEE=
X-Received: by 2002:ab0:1b9b:: with SMTP id k27-v6mr9032964uai.122.1529363196789;
 Mon, 18 Jun 2018 16:06:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 16:06:36
 -0700 (PDT)
In-Reply-To: <20180618154430.1af3d42f@t450s.home>
References: <20180618193636.16210-1-logang@deltatee.com> <20180618193636.16210-2-logang@deltatee.com>
 <20180618154430.1af3d42f@t450s.home>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Jun 2018 02:06:36 +0300
Message-ID: <CAHp75VefSEvpUvsdi=W6rEiOX01zaJeMtxQMDqmSthPJP3uJFA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PCI: Make specifying PCI devices in kernel
 parameters reusable
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 12:44 AM, Alex Williamson
<alex.williamson@redhat.com> wrote:
> On Mon, 18 Jun 2018 13:36:34 -0600
> Logan Gunthorpe <logang@deltatee.com> wrote:

> I realize this is not a change in behavior, but since we're spelling it
> out in a proper comment rather than burying it in the implementation,
> using 0 as a wildcard is rather questionable behavior.  It always
> surprises me when I read this because pci_match_one_device() uses
> PCI_ANY_ID (~0) as a wildcard and as a result of struct pci_device_id
> using __u32 for these fields, we actually need to specify ffffffff on
> the commandline to get a wildcard match for dynamic ids.  The latter is
> tedious to use, but I think it's more correct, and the use of a __u32 is
> probably attributed to the fact that 0xffff is only reserved for vendor
> ID, the spec doesn't seem to reserve any entries from the vendor's
> device ID range.
>
> There's probably really no path to resolve these, but acknowledging the
> difference in this comment block might be helpful in the future.

...or introduce a parser part to allow user supply "any" instead of
numeric value.

>> +                     pr_info("PCI: Can't parse resource_alignment parameter: pci:%s\n",

> The "pci:" prefix on %s doesn't make sense now, it was used above when
> the pointer was already advanced past this token, now I believe it would
> lead to "pci:pci:xxxx:yyyy" or "pci:xx:yy.z".  Thanks,

I'm just wondering if we can use pci_info() here, Or it makes no sense?
Also, the original loglevel was an "error".

-- 
With Best Regards,
Andy Shevchenko
