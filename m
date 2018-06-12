Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B8A6DC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1E520693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 08:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjdHH6VB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1E520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933879AbeFLIfU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 04:35:20 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34164 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933242AbeFLIfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 04:35:18 -0400
Received: by mail-ua0-f195.google.com with SMTP id 74-v6so15415012uav.1;
        Tue, 12 Jun 2018 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L0zVPtMmKaBYTp5i546jbnmilE81p6WH0U2ES150nrE=;
        b=IjdHH6VB1EcInzmut/JATElElhEf4PJ5Zs5EkQ3Fc+DLAjdcspGLDcYpeH4CxNfwk6
         O8DDY8p2CwPUm6V49lx4QMGt7+gYGWA0ixhRxyH1m/szNvnfKNwlqEB2vLNS3qO/V4Mn
         p3ExBz7vU9vSE2hqZh+KNQjAxHuSIPRh+0M6FILgFRCvUQl90s2IE+8/Q32jXwHAjWH9
         3oC0iSSCFLOoz1kYoDPESOFBUolt7YFOxoUkmbY204fUAKGaQc3OlVHBKV+hmNaOkRs1
         +A2JuZU19FjLkKj85lOta5GOVWpmnxaxuDKRiTzoyzlW52xvje1Q9D3xOHKRT780mNc/
         sO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L0zVPtMmKaBYTp5i546jbnmilE81p6WH0U2ES150nrE=;
        b=jJWBUI3IWQcVWqg09rTAyjhfNcA+U7tfpDsyeYnYHrtP6aWM/I+zJEBi/NS5p5XW1e
         qgrUkpwEKNFEtteIUQ3J+/j2GCubNEcoVsgiTKtG5/4uZw4WfNnU/M1xoMN5ZqVnzNMq
         y2gXtPwSl+5p1kezrCl0EZezfEeDCNHG0zoOf0GUXHbVsi8otsPaUau1UGUxPIjR0ubS
         YaQWdOgLyZ/CPdGLQck2MWbGiE7X/RcCsdJqP3KPCvKMUBBMXPs21ehkRZqIhtiUFhtl
         zXHd/Wo9Y5SBDSBoWJP2vvQaslhZvd7Ac/a2rvfP5wXnog6Ib+D2seERxtfo83gYwTu4
         4qrA==
X-Gm-Message-State: APt69E2+x9pUBKnFJpRRjPbMCYhVIDunQJrF5+cHIp4BIVQwA7EiINDQ
        O+clSWoBf3b9jOAwi79DcTd7YZjhrJJrDNGay1w=
X-Google-Smtp-Source: ADUXVKK9DLRgSxYH9sA5VEYCYjX+iDB+Y3HZlzKP1nsBcXDce4+Kp8hQX4kru0bDaoj8dzxC6MsxZHwMcIKOiJki8eE=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr1723526uae.12.1528792517661;
 Tue, 12 Jun 2018 01:35:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 01:35:17
 -0700 (PDT)
In-Reply-To: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
References: <23be2945b593a36d8fa1970bb579389c0f892a3e.camel@kernel.crashing.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jun 2018 11:35:17 +0300
Message-ID: <CAHp75VfJNrviiiam9p49+6_oSjW+YH8vwjcZ2hn5Ux5mHgDCQw@mail.gmail.com>
Subject: Re: [PATCH] drivers/of: Add devm_of_iomap()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 3:01 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> There are still quite a few cases where a device might want to get to a
> different node of the device-tree, obtain the resources and map them.
>
> Drivers doing that currently open code the whole thing, which is error
> proe.

prone

>
> We have of_iomap() and of_io_request_and_map() but they both have shortcomings,
> such as not returning the size of the resource found (which can be necessary)
> and not being "managed".
>
> This adds a devm_of_iomap() that provides all of these and should probably
> replace uses of the above in most drivers.

It feels like a wrong approach.
Can OF graph help here? Would it be better approach?

-- 
With Best Regards,
Andy Shevchenko
