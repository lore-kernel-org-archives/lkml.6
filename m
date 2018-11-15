Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CD6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DFFD2089D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 08:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFFD2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeKOSKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 13:10:09 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:39561 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbeKOSKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 13:10:09 -0500
Received: by mail-vs1-f67.google.com with SMTP id h78so11170583vsi.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 00:03:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9bTj0HwMLigp/8T77P7V8Sz0mL77rEtS1p1GHvmMoRE=;
        b=t6qI4kJIArCd9mhDsdTtuCmH6QLWbhwlWEMQI34Dv5/dujwcFnjzXIdI1SuFo25SJz
         4ago8bz2FU7iursXAp8iCCnhinu9J1qRIRJVYUvh/nttrdcJHBjQnlAT4ZH0eve1K9fL
         nDNLYnlfMKXov4c8/qdfaK5phBpbxc6KnSvhgcJhszqKoipKFiEgDwX2oTlbRgQVTSJq
         PJT0svwE88ccQE6qvl+OaMeLnK5/f0/ubVGKxnLsWll5oP0/wUkZpMvrf2dMiOmCqFFI
         yf22pUkyV8fT4IE5XWh1G6I2wA8vtg/yK6yiR8zgvVabgfCitF/26BhNX9Gyhr9fjsxm
         CrhQ==
X-Gm-Message-State: AGRZ1gKoAqS6N8kGD9nfHJM5lUqCQv4JycQi56mt/BrucYBxek4+UWfV
        7PpaN8hzSUAwWs03ARY/6rGes4DmaibH/LWRCxo=
X-Google-Smtp-Source: AJdET5c+tJSn4M50VEUjDOY6LA2xAcN3wv43F7JH2LOhYrBX/0uWE4pgdE3bnq6qz3AudY7HSLqU86c2VN7y75UPP24=
X-Received: by 2002:a67:f43:: with SMTP id 64mr2292226vsp.166.1542269002955;
 Thu, 15 Nov 2018 00:03:22 -0800 (PST)
MIME-Version: 1.0
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Nov 2018 09:03:11 +0100
Message-ID: <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        vishal.l.verma@intel.com, zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Thu, Nov 15, 2018 at 6:06 AM Dan Williams <dan.j.williams@intel.com> wrote:
> Document the basic policies of the libnvdimm subsystem and provide a
> first example of a Subsystem Profile for others to duplicate and edit.
>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/nvdimm/subsystem-profile.rst

> +Trusted Reviewers
> +-----------------
> +Johannes Thumshirn
> +Toshi Kani
> +Jeff Moyer
> +Robert Elliott

Don't you want to add email addresses?
Only the first one is listed in MAINTAINERS.

> +Time Zone / Office Hours
> +------------------------
> +8:00am to 5:00pm Pacific Time Zone

UTC-???

People are not familiar with all time zones.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
