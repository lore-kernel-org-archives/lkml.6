Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9B3C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D8027E87
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eS4CQgV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D8027E87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755610AbeF2UiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:38:22 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:39260 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbeF2UiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:38:17 -0400
Received: by mail-ua0-f194.google.com with SMTP id n4-v6so6574026uad.6;
        Fri, 29 Jun 2018 13:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ezubZYHDD0tYZ9v6z+xObLDAXWgSFAiQKJ+czgNxrhk=;
        b=eS4CQgV6m7qDE6UulQtLgPfKqQgdVD5ft/RjKRSYg+OGg8ziYR77hXlD7Sqx2yV3Fz
         rFGFWys9WxRkxFMYHbwRhACEkLPgEIYEh4hEppaJFApP8z9HWBCBdnfXEvfPrDrwxRVP
         bIoS48hsBCUirZyjqzWuS1yjsRC1XWAV9MTwSJQmcdu/mWdVuuwCYATPlOdL5Phlp7vm
         H0CpTfiL3IZWjXe5hSymi34czh8eHeyErF4vqMGUoPr7HVUJXwe0xs7la9xoPwcHUpuW
         HrD57egYoc36+slTMcORhkE6/3wOmxMNOG4JuGW3ysxW1Wb1Q4D2qC4ysPW4soqO4AbC
         wIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ezubZYHDD0tYZ9v6z+xObLDAXWgSFAiQKJ+czgNxrhk=;
        b=LoYxZMB/av4piQOwlry5dSfVTfrfH4GxtMtWm+9YcfqbyEA7SBRJBhiM1A2Tnfp9VD
         nPp0a9H9ZRdXigos+5x950gnVXYfWWbC0iHXdTbO9EKYLbhP6VnHdHba7D5usTl5dykj
         DJaoaIwN6pnVmaT6ABO8ZBiGJS7nVgaBBWCZWreC4QKiAkoMqWyhf+o3p6rDnOD1Cg5E
         +j+YLWzTGDRYi7SK+w3xcXy7JhhS8pTTI4Rg9Scqaa7cUzY4Na2Ww1w7rrRX1yPxWpLZ
         nAfc9I5wT6HHbb5XPPxBNcmxinBwX2EK/GE4CPDNN7tnwyZl2rWyIfcNbLdjrQCWDRcV
         VeyA==
X-Gm-Message-State: APt69E2m7Nm1MeEq3g4W5I7hjPnmNX/1gXcfRL6TFX+fV8YRkwds6Qs2
        nr6R5VQXhluc97HhsKo8NJhSFd307TrhbUYKlIE=
X-Google-Smtp-Source: AAOMgpfevX9uahFdm82HN+uPDmz5ACGZMsWRIq6RlFaJ7I/vqWa2hdbJoAiaD/evtTxwBsGCpvJrA+RUkE1VSOy4y0I=
X-Received: by 2002:a9f:3613:: with SMTP id r19-v6mr10571355uad.49.1530304696895;
 Fri, 29 Jun 2018 13:38:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 13:38:16
 -0700 (PDT)
In-Reply-To: <20180629182541.6735-3-pasha.tatashin@oracle.com>
References: <20180629182541.6735-1-pasha.tatashin@oracle.com> <20180629182541.6735-3-pasha.tatashin@oracle.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jun 2018 23:38:16 +0300
Message-ID: <CAHp75VdQsrxS5=Jb_+Wfu=JL0-AR1B=p8Jp3psEqH5ApmpewGA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] drivers core: prepare device_shutdown for multi-threading
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev <netdev@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Duyck <alexander.duyck@gmail.com>, tobin@apporbit.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 9:25 PM, Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
> Do all the necessary refactoring to prepare device_shutdown() logic to
> be multi-threaded.
>
> Which includes:
> 1. Change the direction of traversing the list instead of going backward,
> we now go forward.
> 2. Children are shutdown recursively for each root device from bottom-up.
> 3. Functions that can be multi-threaded have _task() in their name.

> +/*
> + * device_children_count - device children count
> + * @parent: parent struct device.
> + *
> + * Returns number of children for this device or 0 if none.
> + */
> +static int device_children_count(struct device *parent)
> +{
> +       struct klist_iter i;
> +       int children = 0;
> +
> +       if (!parent->p)
> +               return 0;
> +
> +       klist_iter_init(&parent->p->klist_children, &i);
> +       while (next_device(&i))
> +               children++;
> +       klist_iter_exit(&i);
> +
> +       return children;
> +}

Looking at another patch in LKML (for gluedir children counting) I
would suggest to consider to cache children value.
Would it  make sense?

(So, basically you would update that value on children registered / removed)

-- 
With Best Regards,
Andy Shevchenko
