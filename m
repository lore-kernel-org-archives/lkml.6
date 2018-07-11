Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E592C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA36C208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 05:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lrMVfpcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA36C208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbeGKFuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 01:50:13 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38570 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeGKFuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 01:50:13 -0400
Received: by mail-oi0-f65.google.com with SMTP id v8-v6so47095359oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 22:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DbR/PI6cy7UPcmUfX0yu0GnrPCYrYwbD/VPJe5UuE3U=;
        b=lrMVfpcbl70bjsebEAO2N6goLM6shzVNFBMbjw2ic4kYVSk1t62mS5nBzQroAnEm8G
         HeecK/CAAPJ44fuxvcOoRM+DBubnJHYBWDSjpYFrHkm8/5g9zkfZJDmLCsv/r8Z8ixK/
         +iC70zqriHk1q+0f5z6rmUb+ppmaJ8JokoeI9dnOdobGY3QHKgOxU+Tm4eI2llqVBQIu
         lYC8kAFV8Ls3u2M/TVBe32PF9WNuScO48sC3cptqZsr2fDeF3zE+TwIdse/rQ1yzWyTf
         jfoqcrmXHbVdGehw7/WjkWymZIy+fEKMBkHHz7MuUu5QLIIVvye9SRe1RZppsqcLGIdW
         9Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DbR/PI6cy7UPcmUfX0yu0GnrPCYrYwbD/VPJe5UuE3U=;
        b=l3LSmOajsAsYksjeiVXcgGp/Bbqqzh86UzfMBzYzabslgy54Rz3k3tV+foF+JlsrGD
         uJpSY0m0SChD09kdl/8mev0TxKaX9zP1FA3EprC31Jy2aXdkvrUQirTjacUbOJu7twvj
         xiKZpGGW9BFPpp+LY2N3scP/rGWvwyBFEyhsgLzEPCmafQyRhXIRDNAzQwiPwaY03yUU
         LEKvbX7hSQjOqua4btcG+H6O0/4z/CMAKDqRfEUUzarXUXNJ3Rl4DalKfboyVAy4iQoR
         gL0UDviNttbDY0z2JSdqBknyGaiCYsNkwNJhXgPCuFwiXg1OA0qeeOnR9I5xT9lprrWu
         NPlA==
X-Gm-Message-State: AOUpUlFBBrqYcjYXYEx/41E1Psb7Ny8Oca0eChGF2OEWsVBTC9vhQSBg
        nzOYKouQDo/uxcEwAbJsh+gtQwQ2NWSh08YUzSXnMw==
X-Google-Smtp-Source: AAOMgpe03eGFBikhCQWao9zE3jO4COBF4tN8ADy2V0ShvdZfud92/gOXA5KgZhBf320U9H/PAGMMR3RycWz1rkS9Ewc=
X-Received: by 2002:aca:c2c1:: with SMTP id s184-v6mr13960190oif.117.1531288059008;
 Tue, 10 Jul 2018 22:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180702212028.30824-1-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20180702212028.30824-1-jae.hyun.yoo@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 10 Jul 2018 22:47:28 -0700
Message-ID: <CAFd5g45=SkyLWRy=DnYOZCXcmHkrbTdOSBi=n=kUgyvRPoU8Mg@mail.gmail.com>
Subject: Re: [PATCH] i2c: aspeed: Fix initial values of master and slave state
To:     jae.hyun.yoo@linux.intel.com
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com, james.feist@linux.intel.com,
        vernon.mauery@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 2:20 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> This patch changes the order of enum aspeed_i2c_master_state and
> enum aspeed_i2c_slave_state defines to make their initial value to
> ASPEED_I2C_MASTER_INACTIVE and ASPEED_I2C_SLAVE_STOP respectively.
> In case of multi-master use, if a slave data comes ahead of the
> first master xfer, master_state starts from an invalid state so
> this change fixes the issue.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> ---
>  drivers/i2c/busses/i2c-aspeed.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-aspeed.c b/drivers/i2c/busses/i2c-aspeed.c
> index 60e4d0e939a3..2714c7fbe7c9 100644
> --- a/drivers/i2c/busses/i2c-aspeed.c
> +++ b/drivers/i2c/busses/i2c-aspeed.c
> @@ -111,22 +111,22 @@
>  #define ASPEED_I2CD_DEV_ADDR_MASK                      GENMASK(6, 0)
>
>  enum aspeed_i2c_master_state {
> +       ASPEED_I2C_MASTER_INACTIVE,
>         ASPEED_I2C_MASTER_START,
>         ASPEED_I2C_MASTER_TX_FIRST,
>         ASPEED_I2C_MASTER_TX,
>         ASPEED_I2C_MASTER_RX_FIRST,
>         ASPEED_I2C_MASTER_RX,
>         ASPEED_I2C_MASTER_STOP,
> -       ASPEED_I2C_MASTER_INACTIVE,
>  };
>
>  enum aspeed_i2c_slave_state {
> +       ASPEED_I2C_SLAVE_STOP,
>         ASPEED_I2C_SLAVE_START,
>         ASPEED_I2C_SLAVE_READ_REQUESTED,
>         ASPEED_I2C_SLAVE_READ_PROCESSED,
>         ASPEED_I2C_SLAVE_WRITE_REQUESTED,
>         ASPEED_I2C_SLAVE_WRITE_RECEIVED,
> -       ASPEED_I2C_SLAVE_STOP,
>  };
>
>  struct aspeed_i2c_bus {
> --
> 2.17.1
>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!

BTW, sorry for the delay, just got back from vacation. I will review
the rest tomorrow.
