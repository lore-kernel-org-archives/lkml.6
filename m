Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250B4C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB2D21547
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC2Flt6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB2D21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeI0BkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:40:20 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40275 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0BkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:40:20 -0400
Received: by mail-qk1-f194.google.com with SMTP id c126-v6so76440qkd.7;
        Wed, 26 Sep 2018 12:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RdzcO5jLDXbIXlK5i6NgdjTEQF9dsc7/qhDW1U4kGR4=;
        b=MC2Flt6VaonqqsVjmdQf7LBodD9UhiB7oH/Oh6SwyOq5g+dqBx0UAAohcbsfaF3bUZ
         Dg/eM/tx03199R/Z2RmYRtG7ONTyqewMi6Cn4fAZBH+T7plc2OAuPIviw5GX7nvR9xv4
         9KSDosg/nlriGNrU/qTzEQ3OmePJSNTeBJRl+jEn7VbGRVsHj/l0s7VfZdbLOQqexVlE
         xglHNMReOWXNqKh3fn/qNAsmk1csqQ+ZyFosfU7N7CquEYZwzSTVhBH49RoX5iKKGOen
         oBJa51+dyq0e3SD/YLNvafEudGV5kf3Pc/t3vPPbS0lOMJ6rcW7I6cDjCT4QJy4X9dSh
         0vdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RdzcO5jLDXbIXlK5i6NgdjTEQF9dsc7/qhDW1U4kGR4=;
        b=LrrG3+E0nK0GF+ovI1rLnGstJVhg9oKWHQ8zc5Xv3QewgBpv3BcoO1KPwpaOxrmisr
         9m+2Nn47Adbf1Rhn64aQwIOOLHDzjaoqdisioQdo1tcrH0c2D1qHLzuNMLXYFUevVDZt
         4mma8V1yrwwV6So5d0pHnatByOhbnyNZWoL7QMA3c79At7RFpm5BNrFeJH23Q+duTrG/
         CbwiXY7kXlRWouZQqXNB7+aHPAqaZI6sBI5G2KKu030kvWtGZZIhOw8lJrFVa1BaFlrY
         cqA4tcUcNKj9g3uTyerGpNXHYmQiAW616MaOxzNrF8ECMmYqAEZUV48r9OkPiIAO/jso
         U6sg==
X-Gm-Message-State: ABuFfoh4+8wH+/TeClTJhSkYYSdwKkM1yq9WpPS9S8tjuWZw/LHv9NOb
        4dPSRzCMtr33unvQWYQvjJEd3PYVn1XyntaiTzA=
X-Google-Smtp-Source: ACcGV60Ppq7VRHSVvRBFXyUofcHJErnU7g6OnxqoXNYhLzHg0N8xtoh4vVTGWLOses3p0TbUsZqKWTCKEh8COz0ZP+U=
X-Received: by 2002:a37:27d0:: with SMTP id n199-v6mr5245128qkn.33.1537989952306;
 Wed, 26 Sep 2018 12:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <1537978258-2907-1-git-send-email-mario.limonciello@dell.com> <20180926183429.GP2664@lahna.fi.intel.com>
In-Reply-To: <20180926183429.GP2664@lahna.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 22:25:40 +0300
Message-ID: <CAHp75VeCA1riXHHGjVz78BP0je+a5a6bgpXP5qdK+QxfHQpxdg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: intel-wmi-thunderbolt: Add dynamic debugging
To:     Mika Westerberg <mika.westerberg@intel.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 9:34 PM Mika Westerberg
<mika.westerberg@intel.com> wrote:
>
> On Wed, Sep 26, 2018 at 11:10:58AM -0500, Mario Limonciello wrote:
> > Some users have been reporting issues with thunderbolt being turned off
> > before fully initialized.  This is suspected to be caused by userspace
> > turning off the Thunderbolt controller using intel-wmi-thunderbolt
> > prematurely.
> >
> > Details are available here:
> > https://bugzilla.kernel.org/show_bug.cgi?id=201227
> > https://bugzilla.kernel.org/show_bug.cgi?id=199631
> >
> > Userspace has already made some mitigiations for this situation:
>                                   ^^^^^^^^^^^^
> mitigations?

I've fixed that, but in any case I need to add your tag, thanks!


>
> > https://github.com/hughsie/fwupd/commit/ef6f1d76983c9b66
> > https://github.com/hughsie/fwupd/commit/c07ce5b4889a5384
> >
> > To allow easier debugging of this situation add output that can be turned
> > on with dynamic debugging to better root cause this problem.
> >
> > Suggested-by: Mika Westerberg <mika.westerberg@intel.com>
> > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>



-- 
With Best Regards,
Andy Shevchenko
