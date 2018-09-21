Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320F2ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2AE21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DwyBz5Es"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2AE21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391625AbeIVEVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 00:21:50 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:33690 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391588AbeIVEVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 00:21:50 -0400
Received: by mail-lj1-f177.google.com with SMTP id s12-v6so13396827ljj.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 15:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2jvFQjTqMRH8h9dfmz9B+usUOiuChKBPfAil8USXMQ=;
        b=DwyBz5Es4YJGCw1HmvdWcNw1zOH1s+3lLzPu6vlJc/VVL8DVrbWN27CGlbp5AH71vx
         p7WRntPrrUir1GrhgX11NhLsBSbZU5Lztm0hYf8I4G5Xd/WkcjgDkZ5WqjokUxRYg9Nu
         XNzCkUHApG+/jxn3oA4tDo19Tx5ypc4PUlBb1C0EwAriY7kgAX6Rz0uUweAEtp16LIM7
         ukpjyH6GMXxY+JjZbS84Txx86NEAcYYU++jY5XOqmmLpS0PPrwyUsc+eFZ5nDETc6f4C
         kYvpI4A7jk5EQ1mN37gvhXGJkJgJ2bZwBajzLYFAYThrcge3og7LZT3RdHxQ8GC7S3Mm
         pZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2jvFQjTqMRH8h9dfmz9B+usUOiuChKBPfAil8USXMQ=;
        b=V1g/+T/X4DvDf8yQHm0MzNQc+CGEKx9Duyah9v3Hw7fwyJ7mYkPvVRuQeyO0DgBHPv
         hhc/pDINwjW/W+WeCbiTsRBU15TpLCmt9kS7zRpQ6yC9Kl5abDPQVf2GYlGvOUD+gh4N
         ucZiUfzFsD6YFHUFfLhsG26GyjBMzLpgLlFiQHZJBGZkqJ4JHs3iAOXOi66xDrETZQvN
         sPsygSTO0BfUMJGW9W+sQrTYUREXRALYGkRsvYop59CBK7Hd9pwENgGn6M+/AtGam3PD
         TdLcpdXQ1cQWuOeainMC41EZMqNs4Gv3iv3BXBqXDYXj6emxfQlvW3+MFPqfaLNTB2pH
         i5wg==
X-Gm-Message-State: ABuFfohuquEcunkPFtFAExCDWtL8RTtB1ZkhVvbKf2mIKNjSHaZxVIMK
        74F1vs8giX1O3QjsGEFdzkA7n4RUlqu0cP6H/4GY6g==
X-Google-Smtp-Source: ACcGV63JuZ1ZM0WKJZqkSXCz3QCuUga6GNyIagoO6OEdLsKYjm+QHyfj0474TKRsUiN7h2RUM3ErLbQHyTwq2PRT1G8=
X-Received: by 2002:a2e:21d5:: with SMTP id h82-v6mr3774527lji.46.1537569053736;
 Fri, 21 Sep 2018 15:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180921221025.75003-1-brendanhiggins@google.com> <f5943177-6f1b-9344-3821-2aac001ff45d@linux.intel.com>
In-Reply-To: <f5943177-6f1b-9344-3821-2aac001ff45d@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 21 Sep 2018 15:30:42 -0700
Message-ID: <CAFd5g46==5HG2stvuVfOUtsSW37SvLN6cCmOhRSxibrUpxb8aA@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: aspeed: fix invalid clock parameters for very
 large divisors
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-i2c@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 3:26 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
<snip>
>
> > +     if (base_clk_divisor > ASPEED_I2CD_TIME_BASE_DIVISOR_MASK) {
> > +             base_clk_divisor = ASPEED_I2CD_TIME_BASE_DIVISOR_MASK;
> > +             clk_low = clk_high_low_mask;
> > +             clk_high = clk_high_low_mask;
> > +             dev_err(dev,
> > +                     "clamping clock divider: divider requested, %u, is greater than largest possible divider, %u.",
>
> Please put a newline character at the end of the string.

I always forget to do that. I wonder if anyone has considered adding a
warning for this to checkpatch?

>
> Thanks,
> Jae
>
> [....]
