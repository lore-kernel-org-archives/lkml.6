Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A09ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6462087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bBrAXEqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6462087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeGMRjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:39:18 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:38257 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbeGMRjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:39:18 -0400
Received: by mail-wr1-f46.google.com with SMTP id m1-v6so13110138wrg.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 10:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8LDXBUaVAO65/AD4RCzWn0hrTbeIJswby1jW0uF5xVA=;
        b=bBrAXEqpUsN7yRPaVGAgZJ+/1XHfNIoJIri4E1IkW8VlvskgcO7Q4r497qgZnG23fs
         vvuBf5FtpRA3e9nmmbeCRIuGYOl5qxiXUDgDZo+7NCMNYVNGi85QpSZEKh4nDKq6vS5j
         dv38GPGcoY5FOPFJSERh7QlUIuCJ/6GCVF1F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8LDXBUaVAO65/AD4RCzWn0hrTbeIJswby1jW0uF5xVA=;
        b=oan/CFNXBl9MVfXBrhJscBRSJnAXSJTO+2YTEFiqIEfo4LYT/r9XOH7O8FkN3qcktr
         X8eQIVA2PmyBD8EPmcWwOVvrY7wWWTbcv7rxBOQMSE9t0rNVLtR99gBrqYw5b+jlpHR0
         wB60R8EFzmR++624Kcx9UQW2SC+tVeLzs70D1D6n1DhPSgtrabsjRXjPoL9eBQR9h5oU
         an25PY1MlnaCp0uZTidt7MDi1JEWSlpt0v9vxVTZPjcO26dKeP5bcrAsI1oOZ/tjrTSL
         dwc20mrzONEXSndiJ+BuxfRbCYrITi/bUkiof7wT7knZJ/lYFNl3Tqm6NzNbFSLrPVct
         bTBQ==
X-Gm-Message-State: AOUpUlHvlFOLSpR7huBE/o13KTORWombKvrgmpJSeySBVjruARNG599O
        Wr9Qmk5q2vfj0fvn90XijhMiYMhJHXQfjjDWZTzw9A==
X-Google-Smtp-Source: AAOMgpf/EV89tqU6d4PfB/al4q2waFz2s66LjwVM/XQAcVrAWUWZAZb3KyARdvrQf8LBBLsivqh9SHZq32p/qecKmOE=
X-Received: by 2002:adf:8296:: with SMTP id 22-v6mr5414296wrc.252.1531502624500;
 Fri, 13 Jul 2018 10:23:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c202:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 10:23:43
 -0700 (PDT)
In-Reply-To: <20180713120642.22147-1-omosnace@redhat.com>
References: <20180713120642.22147-1-omosnace@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 13 Jul 2018 10:23:43 -0700
Message-ID: <CALAqxLX3S5h9GETsisAWnXsJTNdmK9geiwQ660g+p9pVgVAq-g@mail.gmail.com>
Subject: Re: [PATCH 1/3] ntp: Remove redundant arguments
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 5:06 AM, Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The 'ts' argument of process_adj_status() and process_adjtimex_modes()
> is unused and can be safely removed.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Thanks for sending this set along. I'll queue them up for closer
review and testing.

thanks
-john
