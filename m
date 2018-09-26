Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311F7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38822152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPtYDhxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38822152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbeIZX5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:57:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43592 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeIZX5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:57:07 -0400
Received: by mail-qk1-f193.google.com with SMTP id v18-v6so6652892qka.10;
        Wed, 26 Sep 2018 10:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0qYwNUSw2h9iWL31BwwVDHKRvAvKSe0aqFQWbUZbA8=;
        b=sPtYDhxXMQTWtUTYegsuwOQbo6AhplMuB/Mk1WHN/WKtcWHRj4U/v3aLXVep0HUToc
         xBz/AGugL9Yovuiw0f9R2cEfiW2mkozj/uhzUIH3jPHTRBKp3c+7dS9/00igZ/rBEcQO
         H06NydRwJ8hkvi53LVDU83P5L8lphVAZUYDbvl00s47UOGeJiqSqXt7DtyNmGt/RuBAO
         KbOhADuZtyyhx4FUpbPvHeMuDCkrvp3e1SiusivY0eQs/5fPaU2sHg3tyoKkSQM9OS5T
         I63WzD28pHNygsxpaGUZS3fEAA/IZBpX5YNstyGhs6tne5vYVsw0Rtn8kVgLKIhi0Dgt
         9Fkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0qYwNUSw2h9iWL31BwwVDHKRvAvKSe0aqFQWbUZbA8=;
        b=ZjZuooIP/3uvWYEk2X59f9/SNgg6+0QnDDOX5LDNdyewryJ5nvBh15ChtnOIqpiI6Y
         FkfaaL7EsxRZArFs1n1nXWv5/eMlhJmOm4JARwhJzwf6N0URLD8kD2UyQs6h+mh4/S7F
         k1Fc65ZTKI0Mqx+MhmuP5gzW5N2fanulKRj8sdbPsQ+2HkAHermKLKRdOb6zJ0GGTZ7x
         RgEEGwSQr/9DpBxQOpi6WSrYxwzTmbENnBcD6T5GjH0ep69ieomACEXnXCKEIv733UYN
         DubbKFIRngB9x9xfXW1vIJScWaKDvxfKNgJpyyNxr0U99K+/SeoAR3609D5OJmQqFSo+
         meDA==
X-Gm-Message-State: ABuFfogxaBzB4T3nsYmpZY88SlsW/CQRP5Qnpvo5qvc/hEdO2FOjHY9i
        CPbBX+wfgpsFcBg4SEqxlldXQlPPF1XEPng2NZ0=
X-Google-Smtp-Source: ACcGV62RdQcEz921taj8M1eY93q1n7KoIgcx1P6mrJpPpsYzQcrdxNBTJRg8glTZfdgKWwxQ6ZByyjh5N2wQN8z3GnY=
X-Received: by 2002:ae9:d885:: with SMTP id u127-v6mr4938527qkf.219.1537983784919;
 Wed, 26 Sep 2018 10:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180903180415.31575-1-rajneesh.bhardwaj@linux.intel.com>
 <20180903180415.31575-3-rajneesh.bhardwaj@linux.intel.com>
 <CAHp75VcKSVJQ54qFV1BwqnwUu4dkS6sOACT3nTntJV+Ww56Oag@mail.gmail.com> <d8df94fd-cf7d-197f-0532-24e2da8116a7@linux.intel.com>
In-Reply-To: <d8df94fd-cf7d-197f-0532-24e2da8116a7@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 20:42:53 +0300
Message-ID: <CAHp75Vd96+3cB7PwhftpsTOb8WYg-9WLEQvGYt3rYNB7djX3dg@mail.gmail.com>
Subject: Re: [PATCH 3/4] platform/x86: intel_pmc_core: Decode Snoop / Non
 Snoop LTR
To:     rajneesh.bhardwaj@linux.intel.com
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 5:19 PM Bhardwaj, Rajneesh
<rajneesh.bhardwaj@linux.intel.com> wrote:
> On 26-Sep-18 7:23 PM, Andy Shevchenko wrote:
> > On Mon, Sep 3, 2018 at 9:05 PM Rajneesh Bhardwaj
> > <rajneesh.bhardwaj@linux.intel.com> wrote:

> >> +static void get_ltr_scale(u32 *val)
> > What's wrong to return converted value? Actually the name should
> > reflect what it does, ie *convert* value.
>
> I can change it as per your suggestion.

Please do.

> >> +union ltr_payload {
> >> +       u32 raw_data;
> >> +       struct {
> >> +       u32 snoop_val : 10;
> >> +       u32 snoop_scale : 3;
> >> +       u32 snoop_res : 2;
> >> +       u32 snoop_req : 1;
> >> +       u32 non_snoop_val : 10;
> >> +       u32 non_snoop_scale : 3;
> >> +       u32 non_snoop_res : 2;
> >> +       u32 non_snoop_req : 1;
> >> +       } bits;
> >> +};
> > Just use normal masks and shifts.
>
> I chose union over masks and shifts to reduce code size and ensured
> correct endian-ness.

How do you ensure endianess in union if you do nothing to it here? It
just would reflect CPU endianess.

> Just for my understanding, can you please let me
> know why you feel masks/shift are better suited here?

First of all, in the very same driver shifts and masks / standalone
bits are already in use.
Like you mentioned an endianess, it would make it more clear here,
though it's still require to get a value in a proper one in the first
place.
On top of that, a compiler which might generate an awful code out of
bits defined as above.

Btw, there are helpers for that like those in bitfield.h.

--
With Best Regards,
Andy Shevchenko
