Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6F6C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03D820989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="jrmkeiyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbfA3S5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:57:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40586 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732343AbfA3S5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:57:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so548041oth.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 10:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4H+MWh/dES/Ms4FXiZklCwn4GhqLleEMus9FXGLxxo=;
        b=jrmkeiyJv5z21YXhH0wtf1bxDLIqRek/IsthQLmaoMF6mvxiKFCfRdXM7emIDs4p1s
         terTzTZ+/0OgAFz3KcFtoGLp0BRUljSsZo9eUX4UouJDv4NJ80xmbbcE1kliKnMeNd1z
         XF9fiNkIfAQnXIZw/Kujryh+hV+lvgzhVpLcaKuCX2xhXe8dAvbEIxUlODE0/7v3h0JL
         Ifli0fyzCEi0qQPkde68j2BaqfI6l2F4jalfs1TVS4VDRhMsjTMbS1+ceeMsRUqkxsG/
         DDLjK3zkHiBxQLc5njnxT5NTb+PbW/oLdDD3BwZDYqqUzy7nWQBf8XPcn7mnE/kyS381
         WmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4H+MWh/dES/Ms4FXiZklCwn4GhqLleEMus9FXGLxxo=;
        b=cY28POYhw3+DQD6gfyPSPs4wF0oQkS5P+Pqo/RoyGVH0UwxJVCWt/Y9cowZ0j2vm49
         uQvzlobkkvBy5gw/nrfPnYx5ecwhsu+wniw+XDj/uzWrxCbLod/+lI1GTmVab/F9GhrE
         ENLqe+3cfyOvJqjRJZXp+GdfFcueDDgWM8yFII6ZS0AHk4C85eTUakNFcR9UgOHRd3zk
         G4gL12tI4AbmdByLOznVBVhUYPJnYv4Wx/kWEgVjR6yh5LKU9fszHPlhKs9Eh9xtQ+vG
         7X7vRoHK5vSmloMp2/uzZ8K2xJJtjUNExAQ/rJlFByAx39wnR26NP3N+V9Snpnt6/GNs
         Rx0A==
X-Gm-Message-State: AJcUukfFTxKblf3mW6l4XskLofWUcg1qLKu6/J2t3VOawJPAJWUEe6C/
        KqIezbbWBAOZe0s5fmFrk2OmXdO1gqgglEA1pnEiaw==
X-Google-Smtp-Source: ALg8bN6DFEV6xmP/DaqnEQTaHxLxgfr3pTUoo02Ez3lwnmUvU2wTGLxCDeMbvYBXSYAf2l2hRv9Wlpe1KrTZH04zdHI=
X-Received: by 2002:a9d:775a:: with SMTP id t26mr22254635otl.32.1548874661692;
 Wed, 30 Jan 2019 10:57:41 -0800 (PST)
MIME-Version: 1.0
References: <PU1P153MB01691690696D8F83FC1872C7BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB01691690696D8F83FC1872C7BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 30 Jan 2019 10:57:30 -0800
Message-ID: <CAPcyv4g_dmR77ofqCR3Zy_V2inD_0WTgLLJOqTcB6=SSZZjp8w@mail.gmail.com>
Subject: Re: [PATCH] nfit: Collect shutdown status for NVDIMM_FAMILY_HYPERV
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Josh Poulson <jopoulso@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "driverdev-devel@linuxdriverproject.org" 
        <driverdev-devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:49 AM Dexuan Cui <decui@microsoft.com> wrote:
>
>
> See http://www.uefi.org/RFIC_LIST ("Virtual NVDIMM 0x1901"):
> "Get Unsafe Shutdown Count (Function Index 2)".
>
> Let's expose the info to the userspace (e.g. ntctl) via sysfs.
>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/acpi/nfit/core.c   | 51 ++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/nfit/hyperv.h | 26 +++++++++++++++++++
>  2 files changed, 77 insertions(+)
>  create mode 100644 drivers/acpi/nfit/hyperv.h

Looks ok to me, but if we grow any more of these "shutdown count"
retrievals I'll want to take a look at being able to call
acpi_nfit_ctl() earlier in the init process so that this data
marshaling can be unified.
