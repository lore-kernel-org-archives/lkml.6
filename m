Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A002C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7AA20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl6AfDVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7AA20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeLJQcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:32:08 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:38041 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeLJQcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:32:07 -0500
Received: by mail-it1-f172.google.com with SMTP id h65so19109668ith.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=46tvpxVbU2zFpq/Iyuhir9BVuj6+xMYy5WaRMx8qxWE=;
        b=Hl6AfDVMVpxL4C7pBVTWoPAmjH/r/bEl2UCarGpHEiimuNChYF4Hvx8HsYonmHntTA
         8mCmhDBLmV4NJOnKJ035/wd78puc/T6/2gzNtDnjsQp1vAHTsmfgzKjbAFKbbfaCmtca
         kFMcIXVE7z+HKqpVuo7r52IOI2kH7hB5gHSrz+qAyhQ88EYPBpsZEJr5lUz2FYqZPgb7
         kRORxHn/dPBjYItomPBcDPnaZ6MioHRdREhlioYbXTs6nS5O0AVqd71rm0SzYhTH5hRz
         umB4qreWbvKRI/OwH0WSp1ihPAU3ohe6tjvyw2VVzTsE4LMC2jzQE1DqLFb5o6GyT7q9
         FbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=46tvpxVbU2zFpq/Iyuhir9BVuj6+xMYy5WaRMx8qxWE=;
        b=bF03SFO0zVDchGKz4bIO3i3pc0t7OFHf3DW0OtIpygAi8sXAR8lST2R3FSn6qfYv6o
         m2xdauiLuK4jASi5YT6tKavvKANUE1dLwVyTIFHIBLqeACezCOwXKpHWg12/OhTTimNA
         yAWi+4y8o8JUvsZPZtfCAo05vuCqME08RTPKF/3xRqoV+rCyZbXB49GJ/KLahgrDG4nF
         +qqj0kdDzA4IGLQlo1zqhhvfpbog/mWce8zsaV/LudxflFV9SgGbAhIndEFGi0OwutCa
         46bopyTl9osI4VKjzgBl3h/9FWN1mufI1spVb5w6IrjqblzxTTvwpvJDJVlNMfIpn+a1
         pj7Q==
X-Gm-Message-State: AA+aEWbj9BXDTZ1zrKxJ/484nQPGD9sIRZ8/cmQQ8QpLPxRotpcSFyaM
        beXI69sriQcNdwVsGTQVyuH86vQmAV7GhB/+X88=
X-Google-Smtp-Source: AFSGD/Wmumf+F3iYpK47UniIRZL2WY0R/eGrwTL2gXeCfAgYu+veVedqHWbtOYnpq8vfgI9yCSvRSLjr6PuiYHm6zmk=
X-Received: by 2002:a24:7b90:: with SMTP id q138mr11133979itc.37.1544459527133;
 Mon, 10 Dec 2018 08:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20181101154153.23042-1-tiny.windzz@gmail.com>
In-Reply-To: <20181101154153.23042-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Tue, 11 Dec 2018 00:31:56 +0800
Message-ID: <CAEExFWuoVpKmaGKCUVcORXirBLKwA-z+sHuWVMY4Hc8ptpdPTQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: fix small typo
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping.......
