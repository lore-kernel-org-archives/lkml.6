Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B5A67C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E24208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 10:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFYl72z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E24208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754953AbeFNKDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 06:03:44 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39234 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754910AbeFNKDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 06:03:41 -0400
Received: by mail-lf0-f68.google.com with SMTP id t2-v6so2088244lfd.6;
        Thu, 14 Jun 2018 03:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vodbzBKpJhhpe4g90mTwqzCE5CjR0xvzILkSUKy7L0Q=;
        b=uFYl72z06Tow+SFEHzvDIeMKpYgz8lEHFq3Tjw5GKdQLWGancG0Rtb0M4joS/yNI78
         GOfW5vUt7Ckz8MA1tkY7k9h5n1fiETCIuyLl/lyB8jkTKiPJNXLaeMLL9Ntl6gg5ZLUp
         zgV5PZOqwyrwvBYkh4Yxrwxuu81dA+HWLj2RzSfAkgfF/jsW2FYZYsJFb6BhzSgq2K2Q
         n/xazhuAgXdoplk//9rAri8q1fKc3KuLqJetKcpliQKlQ+aPKk5Ak2Ej7oy5jHjSNzcG
         zdIjnHLedItQkD9NSbDGYrwUNb0LmCJ2dxewOAcVH8HbavZo6zt1sAOlJyoVC3doi9QH
         cZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vodbzBKpJhhpe4g90mTwqzCE5CjR0xvzILkSUKy7L0Q=;
        b=HW3FVjPCke0f/AsJI1kKapTxg9DITWyYQgfvPXjQ0YxEcqXKusSq6zaq+/hYSruIoC
         BxwsolWrljF+lo9Ma8sLZf8I0WUVo2CvMwO99ZGXtWx1oMNGOcBn3pQIoHL6/XYdNVEc
         uX6pR/B/KYitEc9acCQp7mUA1rmlLFd8OsJzVBMIyLbukocrC0lqIOpmrTw/3Swkwz1/
         6Z4WbZyTW511f5iHipatd++yFGu9UhghlhzEj6TrZpvKqJzadS6mt76l9r45GwI4fWCr
         WcXVJ6Bbt1+9Iw5JZVUgW21uYKbH7T3gikGYpOfOuJQWMzaCl+sjQWmWqG3mU6eRlMxX
         EViA==
X-Gm-Message-State: APt69E3+Ek+hb7/2qHBWUcWgGsO1qn7yjF/PavFezR25WyBitK520lsL
        NA8TXTxA+LGfb7Dv5xzkyej99QzvqAblvikr3TU=
X-Google-Smtp-Source: ADUXVKJ5alK9gLVnKhDZ3G4yT8tXhTpULBE3a/iooRSe4DKa88kKA3l9knJL2uEHm+Q/cJC2HQt7aYLcEPFRXbKiJ7g=
X-Received: by 2002:a2e:5453:: with SMTP id y19-v6mr1234608ljd.11.1528970619879;
 Thu, 14 Jun 2018 03:03:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 03:03:38
 -0700 (PDT)
In-Reply-To: <20180612054034.4969-2-songjun.wu@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com> <20180612054034.4969-2-songjun.wu@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 14 Jun 2018 12:03:38 +0200
X-Google-Sender-Auth: e6NBsyed01hqbvTPE9y-orQf8xk
Message-ID: <CAK8P3a1=CBahrEE2uDRfdrSi=ALc5LBED1=KbLbLa40c9H8dmQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] MIPS: dts: Add aliases node for lantiq danube serial
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        qi-ming.wu@intel.com, linux-clk <linux-clk@vger.kernel.org>,
        linux-serial@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 7:40 AM, Songjun Wu <songjun.wu@linux.intel.com> wrote:
> Previous implementation uses a hard-coded register value to check if
> the current serial entity is the console entity.
> Now the lantiq serial driver uses the aliases for the index of the
> serial port.
> The lantiq danube serial dts are updated with aliases to support this.
>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
>
>  arch/mips/boot/dts/lantiq/danube.dtsi | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
> index 2dd950181f8a..7a9e15da6bd0 100644
> --- a/arch/mips/boot/dts/lantiq/danube.dtsi
> +++ b/arch/mips/boot/dts/lantiq/danube.dtsi
> @@ -4,6 +4,10 @@
>         #size-cells = <1>;
>         compatible = "lantiq,xway", "lantiq,danube";
>
> +       aliases {
> +               serial0 = &asc1;
> +       };
> +

You generally want the aliases to be part of the board specific file,
not every board numbers their serial ports in the same way.

       Arnd
