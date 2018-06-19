Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88F2C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8A82075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCEVOW76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8A82075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967326AbeFSVhC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:37:02 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35726 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967205AbeFSVgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:36:48 -0400
Received: by mail-ua0-f194.google.com with SMTP id s13-v6so815347uad.2;
        Tue, 19 Jun 2018 14:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2pKyFNI5tc+t4AJpPXJ7TuEAsEx6+dV8IG+Lv1NVv30=;
        b=gCEVOW76Tp1Gq4L2pLkZd16lIs8asoKg4JlqL5Ub8DPZDDhWMSU3UBBueyyx3XsyBx
         jtMGqiJoFBF40euUGR5PgxB463xZFG9fgmdPZ8Rp0cgz3M08KasWNvwymrGXyIF4xpQF
         XxTSujm9cNbo3zmVkXGbmuvMShNtN7S7f8q2FvaDThsnbg+RxrmiLqinx6CY/AcqZBqp
         jhaqOAPF/GPzuyteOM2dUr2LSakPyNmrcuWY0jZvT1QefhFTNtbN8zeE+E0DwOSIyZI3
         kT+/p/dbESgrY7YXIxo5aZF1e5XXLekc0QVliviHFj7uM4bCdPIreL9eAwHizJUBxaXW
         NHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2pKyFNI5tc+t4AJpPXJ7TuEAsEx6+dV8IG+Lv1NVv30=;
        b=lzM7vJN2KICEKrVmVVbRD8A3+kxc01L3ixahxJ0krP2y5R30mT5f8xuGJLYVkCkBnx
         dHn6cfcHeYK3Qd80fhBBpDm2tNo7FiThlAB5sT+1IJ8jSaB3/c7a/kOEpJehbvkwvnLp
         RkBi+g/ZJswqRxyNh5cpdIMj1zw5TXkEonXtODxczyjnYzG/4s7PnA+ckP2w+RVcqlzf
         oXEKttF/4M0iqy4Qw5yaQd6Jp+Z8YtRKbyeCX2W5TPyw+x8wFcLGyKuBcUn0CPMRiby7
         hxs+OaVV6oVFjboPJVBA6gnDPsz+I8DmiLIxdXN/igf2ZduVvDAMH9bfkzGFKliGnxIs
         LMgA==
X-Gm-Message-State: APt69E3fjmCmzFIpkaPtNFqd2l4wdJfraw74V9aU/lJk1BA3EZfEz2ai
        UzFhs6GCb8Qljr1AWdhYG2wjmf6AlsJZ5QCkZEQ6TxRW
X-Google-Smtp-Source: ADUXVKLlTIG7F9/crHPfJFK8jeD45pLk+MmCg2nYyfsJn9kHIPi3IUxBYoNpPsOnCUCQbZTQ2II5ER5ISlgS7aOsFsE=
X-Received: by 2002:ab0:1b9b:: with SMTP id k27-v6mr11724476uai.122.1529444207174;
 Tue, 19 Jun 2018 14:36:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 14:36:46
 -0700 (PDT)
In-Reply-To: <1529320103-7711-2-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529320103-7711-1-git-send-email-radhey.shyam.pandey@xilinx.com> <1529320103-7711-2-git-send-email-radhey.shyam.pandey@xilinx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Jun 2018 00:36:46 +0300
Message-ID: <CAHp75VcKuqnUgynqXvACS7zY5=6aRxqymGE1w3Yh8sshehSm2g@mail.gmail.com>
Subject: Re: [PATCH 1/5] net: emaclite: Use __func__ instead of hardcoded name
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        netdev <netdev@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 2:08 PM, Radhey Shyam Pandey
<radhey.shyam.pandey@xilinx.com> wrote:
> Switch hardcoded function name with a reference to __func__ making
> the code more maintainable. Address below checkpatch warning:
>
> WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_read',
> this function's name, in a string
> +               "xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",
>
> WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_write',
> this function's name, in a string
> +               "xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",
>

For dev_dbg() the __func__ should be completely dropped away.

-- 
With Best Regards,
Andy Shevchenko
