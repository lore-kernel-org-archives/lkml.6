Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B61FC282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C2A217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 02:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2hWly7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfBFC1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 21:27:51 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46091 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfBFC1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 21:27:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so2395315pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 18:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=Exs8DslF/FoHAd2OOMSuDxa20cRQ+wZMqf7dmULLdCQ=;
        b=q2hWly7e2BT4to7g94QemmcNvsM35iYk4gr76k9sdAQvDq04OX1C9xxoU78YMXDSvv
         X7bFppCETsm2tqsWX/dnybpwaYl8lM+RjXFo3HqJ0u8FHbt8ckPXlVSjv97sbRZf8K/f
         nxUzCPJTmZ7uJOjAgx8QMKimx9XvOYWSToT1/Yv2vyEOlG6KH1yOb0jV9JsEtOyM4+KE
         ZfNOkAM/pRVOEMhz0aJgglz7Djzx4BJTP3wggq4+Vrx88Y71M1CrKQ+HaJ+imtaPIG+i
         MtmH+af9/w3l4OkNj0h35BLkgVWgcuzO1YwUUrcGMLMHG78SQJ/MfOp5R7vyj8MqJpE7
         KfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=Exs8DslF/FoHAd2OOMSuDxa20cRQ+wZMqf7dmULLdCQ=;
        b=rxewnOAvxLtUHaU3rc0WzNQEh+AYwMQTVeyezem4JsNsoRin4qjXn8AhnisdBuie1e
         VXVTutKZESz0PojKI+3Q9G/bAEs2hDCaagoVeEjZ5igzYCdjx1LDvHJzCGlgAmx90H7L
         N8eJZmLBCIEMD2x3f44xgvVdKxfwU9gcOuhuG16A37tC6HSA9nlBZ+9zDWC0YK8g3jGt
         eQfpq18HDqy/inYb/LBOusLcZWPB+KwD8elRW98YwCnRjYQC4OFnnFE4lrA8GyWExK4T
         2WHlGzhwnrPkvqRfBrhBKcqLg3kQfzO7HXri9YRW2FJ0JtTyJBoBw8ur4ezcFCM/xoYp
         ZLqA==
X-Gm-Message-State: AHQUAubqXEtN1Vr6GvBvcAyB5HjyqgmZqWcNi4idVLcbRgB9bG/qflNp
        lFXA6WtKPM67Ui73F/791QDyNMSv
X-Google-Smtp-Source: AHgI3IY4Lyv1kvQZPJ8Uo8ec/sRuN/xamz2TFjchZiJ4d2kL0gp27WJEwFEHP2CduLdtWwN0F+SRsA==
X-Received: by 2002:a63:3287:: with SMTP id y129mr7438061pgy.337.1549420070223;
        Tue, 05 Feb 2019 18:27:50 -0800 (PST)
Received: from Paul-HP (174-17-117-135.phnx.qwest.net. [174.17.117.135])
        by smtp.gmail.com with ESMTPSA id m67sm7046416pfb.25.2019.02.05.18.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 18:27:49 -0800 (PST)
Date:   Tue, 5 Feb 2019 19:27:33 -0700
From:   Paul Zimmerman <pauldzim@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        David Miller <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] r8169: Avoid pointer aliasing
Message-Id: <20190205192733.b4bd98988d1e4695f740d445@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-05, Joe Perches wrote:
> On Tue, 2019-02-05 at 12:04 -0800, Eric Dumazet wrote:
>> 
>> On 02/05/2019 10:42 AM, Joe Perches wrote:
>> > It's declared after a pointer so it is already is 2 byte aligned.
>> > 
>> > A lot of drivers wouldn't work otherwise.
>> 
>> Maybe these drivers are only used on arches where this does not matter.
>
> Possible.
>
> I had only grepped through the sources looking for
> declarations using:
>
> $ git grep -B1 '\[ETH_ALEN\];' -- '*.c' | grep -A1 '\*'
>
> It's quite a few files in net/ too btw.
> 
> I still think adding __align(<even#>) is unnecessary here unless
> it follows something like a bool or a u8.

Um, guys, this is practically C-101.

From C99, 6.7.2.1:

> 13/ Within a structure object, the non-bit-field members and the units in
> which bit-fields reside have addresses that increase in the order in which
> they are declared. A pointer to a structure object, suitably converted,
> points to its initial member (or if that member is a bit-field, then to the
> unit in which it resides), and vice versa. There may be unnamed padding
> within a structure object, but not at its beginning.

AFAIK there is no such language in the spec regarding variable layout on
the stack. So Joe, you are totally off-base here.

-- Paul
