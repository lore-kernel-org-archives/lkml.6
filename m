Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEBAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78BB2148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOlOTAtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbeL0T3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 14:29:40 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44124 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbeL0T3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 14:29:40 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so13263698lfe.11;
        Thu, 27 Dec 2018 11:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=EUITZJIQZPU/F4v7l3UgbkDkrH3puV1HqDw68oauauc=;
        b=pOlOTAtC1lvQgps1ZHB/DYcj5PZ+XG7Kyu6l/XpRWXlbX4QU6dYakz4hmpJDKdZzin
         lhB/eTVbCPTlEDGdQ+X1qBteGMLn/j2PSO5dZXBH8A/jwy3rEGYQSHAmizK0u9KH/rMb
         s2n9az+u2hNgQeDFatSfnLHrw+G8YVntGUtmse7qeh9v779Uh6j4AFsf5/kYqOQae73S
         5v9qKU432a2qQihtnTuidvuCgGGbYJvMZ6HYp2wbQvNHGVvUT6FQjfpnLp6T6klQzWck
         py+Es/Z3nxKVNkXUfPqMlfJbSIhLb0lrMu+3RSoFk85X4YVjYcEHn3nT6+Bpmba7TWRH
         phvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EUITZJIQZPU/F4v7l3UgbkDkrH3puV1HqDw68oauauc=;
        b=EqGUZxaNuKqxAYp+u0VBFS88YcOU+FWfREhHh10lJMC6TbtSnpJXUKhcpZlvGS1iL/
         UE/9ViuE+iB/XFGiAdQ9RA4nOlp4PvKOlBzTf139E9ecAjEUwo0rZZrh/y1o7yKxdZUv
         4BV3iYbhNtbAhi+HJxv/Un9U+Gd8nF7ab6n7P9R13yqy2UeS5N3r/FrZux7iTAXYzfy1
         kYMtVsW5DV3AcG8rLJ8xKygjBQU8IVRN+b7xjrD0qVn3fz2tr941WzjVp2VG3g9bUNxq
         gkkOP/vA3DLw1QiMyQJy8nGpee/KDx7HP+lYEsKF5mveEY9bQNQypDj+ZYm5qp0bOjLu
         xCuw==
X-Gm-Message-State: AA+aEWZV4EIrAYrM7DjDyw7fWQFZuNJNrcFDDDc0+Lgx+KFHY3At0lIl
        x1o/X3+LMXk4XaGzU+ccmoopa/3t
X-Google-Smtp-Source: AFSGD/X5jWnRPkN5eaR+VLSjskClk+uxgh58PDVcatrbSBHAqJ4S7coKyW8nmEHg2rPvWlyoJGwv2A==
X-Received: by 2002:a19:200b:: with SMTP id g11mr12244114lfg.58.1545938977669;
        Thu, 27 Dec 2018 11:29:37 -0800 (PST)
Received: from [192.168.1.18] (bgu133.neoplus.adsl.tpnet.pl. [83.28.84.133])
        by smtp.gmail.com with ESMTPSA id y131sm7452905lfc.43.2018.12.27.11.29.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 11:29:36 -0800 (PST)
Subject: Re: [PATCH v4 2/5] leds: Add helper for getting default pattern from
 Device Tree
To:     Krzysztof Kozlowski <krzk@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raphael Teysseyre <rteysseyre@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1545146852-32207-1-git-send-email-krzk@kernel.org>
 <1545146852-32207-3-git-send-email-krzk@kernel.org>
 <CAJKOXPew1Ufq8vOE2=dqh-=zCQpB8H-X+CEK456MqgcEsNi+5A@mail.gmail.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <2efcaaa2-61ef-c967-dacc-8aff51c17840@gmail.com>
Date:   Thu, 27 Dec 2018 20:29:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPew1Ufq8vOE2=dqh-=zCQpB8H-X+CEK456MqgcEsNi+5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/18 9:47 AM, Krzysztof Kozlowski wrote:
> On Tue, 18 Dec 2018 at 16:27, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> Multiple LED triggers might need to access default pattern so add a
>> helper for that.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>   drivers/leds/led-class.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> 
> As pointed out by 0day-ci this has to be in leds-core.c.
> 
> I'll fix it.

Right, please also remove "classdev" from the new API name.

-- 
Best regards,
Jacek Anaszewski
