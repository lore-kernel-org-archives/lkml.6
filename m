Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FB1C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69BE26857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69BE26857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932118AbeF1ELM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:11:12 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:32780 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbeF1ELJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:11:09 -0400
Received: by mail-qt0-f195.google.com with SMTP id l10-v6so3631583qtj.0;
        Wed, 27 Jun 2018 21:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=63FjX8/Lp8zUpdTzvr/i4TngrssoilA97lbPMie0R8g=;
        b=cq1Fh1jPnNljPHQ+e5WMzo1XsMlVyOXS3v/URCy34IBQg2rWFw1UrqoZXCSSYmoQnz
         Axq1yD8CxKmRc/OmMFk9wHPgKoU0L6JdLzZKJIvVQhLJNs0nyDASM3eUtE62TY9ahTQ1
         1oaU8/dWvnuQnWxX2A+WI7tw2gGZmvZNTxK7cQJ5GJ8ku5ZjlQOQfIkOGvBQ5HtVtwOR
         sWqMT69amtb2Pt+VpcInZTVyDO4lIm7mEFiPxS6CxWoxFIcEoS9RlbOY6B5ifFr1l+F/
         vqhcXSFyoFss5TeuWMo0xyCEpqkuTfC4Y2In7UQQkzr7jSLG7MHay0w2m5z9oh0OKfws
         tnTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=63FjX8/Lp8zUpdTzvr/i4TngrssoilA97lbPMie0R8g=;
        b=AKHLUik8k5/ZUbkQowLoGTOJfRI7fV21itE3kxcvCYta8xM+kcSE+32b8SuEsx0YtN
         o+vMbd/l67Dn5pWiYF7ELzLmsYSGHPy0r1dX9GbGpK0PNr2+ZzSBLeW/kJ3NrQgVQiGm
         4fAIC+CqXHVk2HsVHrs8JWFLopvZ9dIv2I4eg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=63FjX8/Lp8zUpdTzvr/i4TngrssoilA97lbPMie0R8g=;
        b=Omzi6v4AO6BXjVuMY3ykmtDzEhuzbi+kPrxa6sApEYlMtGNru/XnxNk6s1qEIq7q4e
         /BLTpUPmD0oMZhcCDHCTgv/dghkLXII7SS7hdb2LkZn07oGVQqPXekV5gA1Xl2HYfw/r
         CCT+cMR38wL08Pt8/CX2bVlY1hLU3Egcl3esOFwWAoqe8I5nWvaKu2osRpQZBPKW/hwR
         ELAtjcxUClD+4sYB9W61JVIAf8q4lfT+9pjMrq8oz9y3Ss4/VxVtcqFIh/ueChAh4+7p
         5wsWcQ3pyMq1axL1g5h0pK1OOsSSa23FcZIpXMib8q9yS67+k3pxgA3zS173J3CK5970
         E4tg==
X-Gm-Message-State: APt69E1B44Q+3y6JrADm1DkUXB2d8UiwAWrox629NjGh0TSVBt/ltNUJ
        asdQ7c+BFAx4sGeVw4Zjt9cKSlck7TCwH6DSf0U=
X-Google-Smtp-Source: AAOMgpfGXW7ywdV9Ne5HwLCNkYO5UIGU4Mqz6lesJCVez9qUpfwirlxGVuXVZBotu8DbQe6sm9ZerFI4Hu5Tv2TqV+0=
X-Received: by 2002:ac8:322:: with SMTP id q34-v6mr8030072qtg.342.1530159068884;
 Wed, 27 Jun 2018 21:11:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 21:10:48
 -0700 (PDT)
In-Reply-To: <20180626232605.13420-4-benh@kernel.crashing.org>
References: <20180626232605.13420-1-benh@kernel.crashing.org> <20180626232605.13420-4-benh@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Jun 2018 13:40:48 +0930
X-Google-Sender-Auth: t-uHfmHljyQ0W6N2rwpp_cpC8CA
Message-ID: <CACPK8XdRk+qgomCV3wZfje_SzLEV12jnqfD_idXOwH=qoZOXZg@mail.gmail.com>
Subject: Re: [PATCH 03/14] fsi: Add mechanism to set the tSendDelay and
 tEchoDelay values
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 08:55, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Those values control the amount of "dummy" clocks between commands and
> between a command and its response.
>
> This adds a way to configure them from sysfs (to be later extended to
> defaults in the device-tree). The default remains 16 (the HW default).

We should add these to  Documentation/ABI/testing/sysfs-bus-fsi.

> This is only supported if the backend supports the new link_config()
> callback to configure the generation of those delays.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
> ---
>  drivers/fsi/fsi-core.c   | 109 ++++++++++++++++++++++++++++++++-------
>  drivers/fsi/fsi-master.h |   2 +
>  2 files changed, 93 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
> index 2f6f9b8c75e4..1ae5be31b4bf 100644
> --- a/drivers/fsi/fsi-core.c
> +++ b/drivers/fsi/fsi-core.c
> @@ -81,6 +81,8 @@ struct fsi_slave {
>         int                     id;
>         int                     link;
>         uint32_t                size;   /* size of slave address space */
> +       u8                      t_send_delay;
> +       u8                      t_echo_delay;
>  };
>
>  #define to_fsi_master(d) container_of(d, struct fsi_master, dev)
> @@ -239,15 +241,15 @@ static inline uint32_t fsi_smode_sid(int x)
>         return (x & FSI_SMODE_SID_MASK) << FSI_SMODE_SID_SHIFT;
>  }
>
> -static uint32_t fsi_slave_smode(int id)
> +static uint32_t fsi_slave_smode(int id, u8 t_senddly, u8 t_echodly)

Can I buy you a vowel? :)

>  {
>         return FSI_SMODE_WSC | FSI_SMODE_ECRC
>                 | fsi_smode_sid(id)
> -               | fsi_smode_echodly(0xf) | fsi_smode_senddly(0xf)
> +               | fsi_smode_echodly(t_echodly - 1) | fsi_smode_senddly(t_senddly - 1)
>                 | fsi_smode_lbcrr(0x8);
>  }
>
