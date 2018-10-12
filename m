Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D371C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7C120865
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 20:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7C120865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJMDr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 23:47:58 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38039 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeJMDr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 23:47:57 -0400
Received: by mail-ot1-f65.google.com with SMTP id l1so13512151otj.5;
        Fri, 12 Oct 2018 13:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3pb24OT3MmhkEwfOGe+akcrfqOtfS8yAJxlq21mGbhw=;
        b=gDMTIqn1GXUa/1yTEK1oEzPuoov9x8aO5qAkFHEuPjrkqKMdX2T4iBqNTG05OEsIJ0
         nt8c8seuhV+L3IFToy0X6JoVoCzkpjY4v0OFYNwoVqU+qEKIK45XmyF5NNLu/0WOrKjd
         akf5DVFQN1HxQ100BmwsEol67I0QH/ZeydEQ12WRF5wzvI1mfqk+f65hVSGJUQ1MdZWT
         rh2QHz0lQEbBU1pNFUgl6q+lXqLsMHAIl7hR84xWC1FqN626/y3qSVosHKQgMAqK29ei
         EsBzT9BAJmAvtr+tIOIXVmfB6ZIkcOQ27tWYiD368ySEvDBVCCp2Ura3PIvgfSX9iDP0
         14Rw==
X-Gm-Message-State: ABuFfojrk/+EMD2H+Uz4t46QnmN1/UlOvgfJnt90is4DdO47Wmk8wIXP
        krRbH7p2d0aKiukkO0gryvqAdmg=
X-Google-Smtp-Source: ACcGV61ZV8COptgRqkrHjfLnUJXSQTnHWjVswrTYiOfKOM5D3AYSrnN8US+GWIYhr5qrTzoY4hkcVw==
X-Received: by 2002:a9d:4359:: with SMTP id y25mr4968896oti.80.1539375228035;
        Fri, 12 Oct 2018 13:13:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w128-v6sm540977oiw.15.2018.10.12.13.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 13:13:47 -0700 (PDT)
Date:   Fri, 12 Oct 2018 15:13:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yasha Cherikovsky <yasha.che3@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 2/7] dt-binding: interrupt-controller: Document RTL8186
 SoC DT bindings
Message-ID: <20181012201346.GA17471@bogus>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
 <20181001102952.7913-3-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001102952.7913-3-yasha.che3@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 01:29:47PM +0300, Yasha Cherikovsky wrote:
> This patch adds device tree binding doc for the
> Realtek RTL8186 SoC interrupt controller.
> 
> Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../interrupt-controller/realtek,rtl8186-intc  | 18 ++++++++++++++++++

.txt

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
