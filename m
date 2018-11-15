Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372A7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EB0224E0
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnPnKqKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EB0224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeKPFYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:24:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45890 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbeKPFYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:24:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so6886482pfd.12;
        Thu, 15 Nov 2018 11:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=54j0MAv3f2rtKQSRqMZj+h314ucHlBOPriiq0U5wUWo=;
        b=OnPnKqKbQGI9umy6ucsClu117fupf9ku76CvsbLvK8Y0SIJAqnGxOTLqShv+32k56Y
         SO+f3Gk8QnDxZ7yKyjZSaYjiySnhLhUcuqTqj2KQEHVif1n03R7jXfekDtS4AFVL4ieH
         IvcdtwAW+5f/R7oSkU+dkg3yHlNfmjOPiQJRh0LLGPMdR1ufEmO9Pi/FC5xPwhjvHy+s
         cEn2M53m92xLFOTHNpn4cUFQmkqpZHeksKfRlRJ0rxyMr0rK1Sfzf+DMrcD6GhX0N1pH
         LRkzG3IlxBe5SJGBDGxBmHNsPgZyqGA+VkCiOemvhcxPXXPIkUOfDqj5plUqhEYyXQkG
         drMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=54j0MAv3f2rtKQSRqMZj+h314ucHlBOPriiq0U5wUWo=;
        b=qA+IK8NSBfaoJB9xn8Ur1vVit+euxdQ0MZjE5Ma5AxaJmH4gUAE2bJPExPKzkQMyEA
         GN93NYfy8tvbnMleWK3CkHKTVdY2BMnhrT9qP0p8Su67aJk8HtDic5N4F1++CeQJ3uLl
         Hlq0SNSOC+5AJUPZl0fDVkuNX3J17wk95fQQxIxR9LukiIM88ls4cbJ6VubL7jk988/H
         OvmhyguONxADy+HogSSLvhXMl6u96Od0coGJqBvT+gvHnoOPosPaTj8/Lj4TV1U5E/ox
         phf3ZcsFxcKGQGn6c8Nk1/1XqROMwLcX5zV9ESlNjTjnomsx8x0b0KT1DuHgcqDNzd1F
         CnAg==
X-Gm-Message-State: AGRZ1gI8Ma8GpfOxJJLRIyjIZFAr6EUJGjJd8MwIU13WN8N7GvY0q8UF
        atuPfe/5USoz8ThQmgAbikM=
X-Google-Smtp-Source: AJdET5dUmRvsolSv9SfPVB+cfhBPJHX1NmnU03Z+FJ255ZN8dARqTRxAO9Q2L+HDsvEF2cGlHfjnig==
X-Received: by 2002:a63:a16:: with SMTP id 22mr6982130pgk.318.1542309334091;
        Thu, 15 Nov 2018 11:15:34 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v185-v6sm30372972pfv.48.2018.11.15.11.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 11:15:33 -0800 (PST)
Date:   Thu, 15 Nov 2018 11:15:30 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 0/6] OLPC 1.75 Keyboard/Touchpad fixes
Message-ID: <20181115191530.GB212221@dtor-ws>
References: <20181112023029.648408-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112023029.648408-1-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 03:30:23AM +0100, Lubomir Rintel wrote:
> This makes keyboard/touchpad work on a DT MMP2 platform.
> 
> Changes since v1:
> - Collected Acks
> - Replaced "Input: olpc_apsp: depend on CONFIG_OF" patch with "Input:
>   olpc_apsp: drop CONFIG_OLPC dependency", since it was correctly
>   pointed out that the driver doesn't actually depend on OF.
> - Dropped "Input: olpc_apsp: allocate the GPIOs used" and "dt-bindings:
>   olpc,ap-sp: add GPIO lines" since at the moment they are not useful
>   for much more than documenting the lines the SP uses and actually
>   claiming them was deemed not to be a good idea.
> - Fixed error handling in the "enable the SP clock" patch.

Applied the series, thank you.

-- 
Dmitry
