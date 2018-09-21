Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3A6ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AE521545
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="KVS+LGbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AE521545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389161AbeIUJb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:31:59 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34820 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeIUJb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:31:59 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so10326399ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 20:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0HfKV2mOqReJfv9LNppZ4x9y4mG82Y/5HA1fyG2E/Q=;
        b=KVS+LGbrA9pldPBCQsnh0mb/zWQmJQKSPwBU3Onk8rCz76jgx7WxMql3IFBVotsU9C
         dV/diPL0lH0XeJlftIqqpbPHFvXiMRkLojoBlYlEA+docKpo6pzlTheYBIZvp9xvIFgS
         Natv5bXpZ8mhr1Tdhm6S5k0fWPX9DmDu6XNUkWvfHMfzkI1Em9ZvZiZCmzZ+Y2jsEWRb
         YXTTmwrP1sYpZMVFq6i06l3vD1fMlLqU16LlMGtfqJ92zKIOJ86++ffA140+13yUG9R5
         rEqfcCYjbPOgZzpDEnAWcEgBpS9cbYJsUN9Za0xgtA/GEjTYqhKj5bMrUS/yvQP+bn4g
         zaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0HfKV2mOqReJfv9LNppZ4x9y4mG82Y/5HA1fyG2E/Q=;
        b=M67E2YcbSu66KnoFhA6mjguruwq1Q6mttljznSf9tnM1VC0DjZl1RWnOeZq0AuMahF
         LCbvD9XDGgp8nxuUA3D8Dsgi08Vd1CZ9WULnjWgtVEGJnzmoaSBQIrWiQsMvHuAQ7WAj
         BB2NxRbX1b8GQUNDtv6fYTJ5POYeORCtXYrr17TgDRAMqkNMGpU7b79pO1bvtfV5e7F8
         ALKjt8K+b9AxyrIvUgSASIlN9noRfjFuwOk3OLpIDtp5FpWdAVHeZzKjf+LcT1eexzym
         NsIcGzwCe3oJyGlJ0hbpkS3FhvTqFaD/TYsBu/OiaxCeT+U2bdipUEvnIHNan07/NNZZ
         kfIw==
X-Gm-Message-State: ABuFfogwBjlVkUoLQsI2iJEyv/9hQpnqnG6nruehlUNozzSCbHSMjcbQ
        Vju6ExUq98lnIIjDF5ouOkvEzsPbSXjrxa+T01GWSg==
X-Google-Smtp-Source: ANB0VdZu95iFxS0NbWhazQEQj1A+ACQYGvEiAJfMvHKQbDtDuFE+J8OTU2GS0d0zfkAGZV3MOAUnkdD7t93GttLPkiw=
X-Received: by 2002:a2e:9bc9:: with SMTP id w9-v6mr190875ljj.33.1537501505573;
 Thu, 20 Sep 2018 20:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <1537422122-6166-1-git-send-email-svellattu@mvista.com> <CAJZ5v0j05v+69cCJ1jzekdC_2kqXu6SQaNLeOhk=04b08pT6YQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0j05v+69cCJ1jzekdC_2kqXu6SQaNLeOhk=04b08pT6YQ@mail.gmail.com>
From:   Silesh C V <svellattu@mvista.com>
Date:   Fri, 21 Sep 2018 09:14:57 +0530
Message-ID: <CALabi0HOSbsemnw=v7h+arstXMMqaAYGmRPFNQDSE_U0+Kg0KQ@mail.gmail.com>
Subject: Re: [PATCH] Driver core: add bus_find_device_by_of_node
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rafael,

On Thu, Sep 20, 2018 at 1:06 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Sep 20, 2018 at 7:43 AM Silesh C V <svellattu@mvista.com> wrote:
> >
> > Similar to bus_find_device_by_name, but finds the device having a
> > specific of_node.
>
> First, what do you need it for?  Please describe your use case in the changelog.

This will be useful for drivers that do not register a platform_driver
(but retrieve the "simple-bus" device_node using
of_find_compatible_node etc.) but are still interested in the struct
device.

>
> Second, what about a more generic bus_find_device_by_fwnode() ?

If you think that the above requirement warrants the inclusion of
bus_find_device_by_of_node, I can try implementing this in v2.

Thanks.

Regards,
Silesh
