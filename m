Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71814C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C98520864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WADP2CkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C98520864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755289AbeFRPyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:54:20 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39320 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbeFRPyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:54:17 -0400
Received: by mail-io0-f195.google.com with SMTP id f1-v6so17270951ioh.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kR64JuxiPEqajCbq3a4ZRhr/5YNhAG40WQeOAJ8mYCM=;
        b=WADP2CkMzJso99qu+Zo6l1oZogru9Lj2VViwmkxAdWwxeZqMwc0zxWazyI/f3BmN6O
         89m25cSIM7PUmHIQkBHq8sktGqATQf74joHB25imU/hLYG1CZjwGFJRZIkfQQ28Ob407
         I0EYF0daxjgOyVaAWT3nS7PCL0ggs0ODgXzJKPeagRPdwlPwCS+vR+kQTqyTtHm+UvEv
         fHmLgRGpoABTDIxeocOvkzq1V1gS1DTLKsPNQOsDCkbCQXqSUPmWOXZVmHHo05eD9qGv
         wmqL4CKk3dE+egZ4AN9+E0WCiBQwIsmK5PFbylPbwJKeikYhJPVFxOUtu556GvpOpcB/
         JxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kR64JuxiPEqajCbq3a4ZRhr/5YNhAG40WQeOAJ8mYCM=;
        b=A5a97MLmakt8I2gBTLJHDEKNrFFV7GCjQYHOM5XDcOY0gs0GhuBGXFJUY4TJXhr3Ov
         f9PfjxQC0oSoMNtKGBysePq6ewbvcM2seD+hEwHgq34iADzRv6BeNyOOtGc3eV/juyRe
         P7hu/jrxtorfiRMmCEVyQ0xXg0upfaEn4IB42r1Y3TdYKzAetAZXALoHG6rF+qzq5/g8
         N5LqW8fEpgzdnv0SogxdOFx+qLV+1t5sDufPpe1xtA8ySW158VDqVO/09VpLJR1YqmVc
         mCasfoxXiqbe8EHP4KHdt7NMwWOHhXV7rC4jnGS0i2APDBP4gynt05JEVPP3bf4aaZZL
         ysnA==
X-Gm-Message-State: APt69E2iCMY2eriMSlN5OeWonrnaap1763BE7Aw+zawUNTMaCCOZqhhq
        yar5lljA92RzPfsSZIgSCbaq1eAEl3iAmXE1mKZmzVGJ
X-Google-Smtp-Source: ADUXVKJCGFStZN8mIAJgBX32H1HUgkllyQbk5Np+AA5g5UST0KyPTr5aE8L1QkPX+Z1JbpQSC9BjGYQCh0TeDUemo80=
X-Received: by 2002:a6b:88aa:: with SMTP id s42-v6mr10430422ioi.146.1529337257365;
 Mon, 18 Jun 2018 08:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180618144404.21055-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20180618144404.21055-1-mika.westerberg@linux.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Mon, 18 Jun 2018 18:54:00 +0300
Message-ID: <CA+CmpXuACmU_S69tQmtC1CGbx-jn0g5NJF_p1dNTTaRMPCp+5g@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Notify userspace when boot_acl is changed
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, christian@kellner.me,
        Mario Limonciello <mario.limonciello@dell.com>, lukas@wunner.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 5:44 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> The commit 9aaa3b8b4c56 ("thunderbolt: Add support for preboot ACL")
> introduced boot_acl attribute but missed the fact that now userspace
> needs to poll the attribute constantly to find out whether it has
> changed or not. Fix this by sending notification to the userspace
> whenever the boot_acl attribute is changed.
>
> Fixes: 9aaa3b8b4c56 ("thunderbolt: Add support for preboot ACL")
> Reported-by: Christian Kellner <ckellner@redhat.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/thunderbolt/domain.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
> index 6281266b8ec0..a923ebdeb73c 100644
> --- a/drivers/thunderbolt/domain.c
> +++ b/drivers/thunderbolt/domain.c
> @@ -213,6 +213,10 @@ static ssize_t boot_acl_store(struct device *dev, struct device_attribute *attr,
>                 goto err_free_acl;
>         }
>         ret = tb->cm_ops->set_boot_acl(tb, acl, tb->nboot_acl);
> +       if (!ret) {
> +               /* Notify userspace about the change */
> +               kobject_uevent(&tb->dev.kobj, KOBJ_CHANGE);
> +       }
>         mutex_unlock(&tb->lock);
>
>  err_free_acl:
> --
> 2.17.1
>

Acked-by: Yehezkel Bernat <yehezkelshb@gmail.com>
