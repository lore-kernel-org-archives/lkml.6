Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8B79DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFC9208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMtcMB3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFC9208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935167AbeFMQmW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:42:22 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34155 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934941AbeFMQmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:42:18 -0400
Received: by mail-ua0-f196.google.com with SMTP id 74-v6so2173586uav.1;
        Wed, 13 Jun 2018 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NUubvUULaJdwfXmJhgtGmCyh+CBTMg8nhoPwNJ56j/U=;
        b=qMtcMB3KIzR8FAb2Ixp+F6n3iXnVwg6hc4KkOX9rPE9kV3js3utrvM1eqwXpA18FLu
         YuXXCCJL5ZCFMC6vf7R0NtUjYj0AnSPDajMhk2MJHaR2c3FhqijAQzo6Q+/9p8odjpXs
         dmA3C5BY6iiJC5Yok8ouXNQVQt58/zDZ0G05k3KDy2dllwnT63kF3WCY9033J0cQGxF7
         Ei943AiampbYAcs1HejjYZfKK+oWEJpE9VsfS8rlMcU9qlXO+zDc7tHDYEppsPyzZIMq
         1avnxg1fHD3Pla/Z2sxzPdZ3Gd1ZXrIqZsDlXXkzDmh84IEI7C1tdmse92EqZ+iXjOwc
         NCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NUubvUULaJdwfXmJhgtGmCyh+CBTMg8nhoPwNJ56j/U=;
        b=qS3A0RWLkelbK+zxzJmwLY6Zn8C9LsainXCLaaMP7F4KKZskIRSYOy9Us8uZeMPSxa
         sNw/D70VUAQ2MJbbNCvbdm4Qum4gbDEW7yXai4W5EeL30fssbB5kMp/UJArumwtWPWnL
         i/fcSWDqN51+dfXTUyuZtdmq0/mK7rskmI8LBs8Z+vP5F1ep2nCBUDREp8C0iFxVE7rr
         xm9UoVZHDHeApYHsjMH58TgH6uR8FIPsNhjsxt+8CtNqvt39WuwYePbx4vA1k92v9mBA
         vYT1RB+gy++0umcU/0kK8YZ1JD1m3wUf4yidn4c+A+rG/wN0wU2zXEtLxVJDTCbcJ/z2
         xaag==
X-Gm-Message-State: APt69E3vGsV1SBSye4Myabrz0wBdr7Qrnq6IwKW686R6TVKNFoiGsElx
        y6ubRshj33HKrkJ5dO9RAYI4+iOwqljiiTp4Xjw=
X-Google-Smtp-Source: ADUXVKJo+gR/DwmMZyOuuZ+9W2etzCoHyoj+PeOxrbKjUyQ9T7GquhZSPfXPUwg9qhKYDJGPh30+YWva6C/kbtKvVmQ=
X-Received: by 2002:ab0:4161:: with SMTP id j88-v6mr3829508uad.196.1528908137456;
 Wed, 13 Jun 2018 09:42:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:549e:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 09:42:16
 -0700 (PDT)
In-Reply-To: <20180612205619.28156-2-anchalag@amazon.com>
References: <20180612205619.28156-1-anchalag@amazon.com> <20180612205619.28156-2-anchalag@amazon.com>
From:   Balbir Singh <bsingharora@gmail.com>
Date:   Thu, 14 Jun 2018 02:42:16 +1000
Message-ID: <CAKTCnz=Lfy2vpfGs4+_N9Q9_QCxt5XjFFTEsArkCaKvAi70H_g@mail.gmail.com>
Subject: Re: [RFC PATCH 01/12] xen/manage: keep track of the on-going suspend mode
To:     Anchal Agarwal <anchalag@amazon.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com, netdev <netdev@vger.kernel.org>,
        jgross@suse.com, xen-devel <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kamatam@amazon.com, Frank van der Linden <fllinden@amazon.com>,
        vallish@amazon.com, guruanb@amazon.com, eduval@amazon.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, cyberax@amazon.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 6:56 AM, Anchal Agarwal <anchalag@amazon.com> wrote:
> From: Munehisa Kamata <kamatam@amazon.com>
>
> To differentiate between Xen suspend, PM suspend and PM hibernation,
> keep track of the on-going suspend mode by mainly using a new PM
> notifier. Since Xen suspend doesn't have corresponding PM event, its
> main logic is modfied to acquire pm_mutex and set the current mode.
>

Why do we need to differentiate between them? The changelog does not
explain how Xen Suspend is different from PM suspend. The difference
could be what is injected into the guest vs what the guest decides to
do. How do we use the new suspend_mode?

> Note that we may see deadlock if PM suspend/hibernation is interrupted
> by Xen suspend. PM suspend/hibernation depends on xenwatch thread to
> process xenbus state transactions, but the thread will sleep to wait
> pm_mutex which is already held by PM suspend/hibernation context in the
> scenario. Though, acquirng pm_mutex is still right thing to do, and we
> would need to modify Xen shutdown code to avoid the issue. This will be
> fixed by a separate patch.
>
> Signed-off-by: Munehisa Kamata <kamatam@amazon.com>
> Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
> Reviewed-by: Sebastian Biemueller <sbiemue@amazon.com>
> Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
> Reviewed-by: Eduardo Valentin <eduval@amazon.com>
> ---
>  drivers/xen/manage.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/drivers/xen/manage.c b/drivers/xen/manage.c
> index 8835065..8f9ea87 100644
> --- a/drivers/xen/manage.c
> +++ b/drivers/xen/manage.c
> @@ -13,6 +13,7 @@
>  #include <linux/freezer.h>
>  #include <linux/syscore_ops.h>
>  #include <linux/export.h>
> +#include <linux/suspend.h>
>
>  #include <xen/xen.h>
>  #include <xen/xenbus.h>
> @@ -39,6 +40,16 @@ enum shutdown_state {
>  /* Ignore multiple shutdown requests. */
>  static enum shutdown_state shutting_down = SHUTDOWN_INVALID;
>
> +enum suspend_modes {
> +       NO_SUSPEND = 0,
> +       XEN_SUSPEND,
> +       PM_SUSPEND,
> +       PM_HIBERNATION,
> +};


Why do the enums range across namespaces -- between NO, XEN and PM?
Can we please be consistent XEN_WATCH_SUSPEND, XEN_PM_SUSPEND. etc?

Balbir Singh.
