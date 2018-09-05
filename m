Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5EAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BB72077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4dMb7PG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0BB72077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIFDVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 23:21:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33605 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeIFDVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 23:21:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id m26-v6so7409977lfb.0;
        Wed, 05 Sep 2018 15:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ogDL5QpWO9MSGJ4HlS1fXf0iuqQSw46hxcEpO0mErqo=;
        b=m4dMb7PGOmQRzASkvu92qEfV6/ExTngkeqtqyhOitAtC6E7fDm0kS9KWeyW8b734WY
         rUuzeT6tAsU2pts7cO5HyqeQrdCpcEx/UAM9DNeUPtkV8A+i5ts9qlFLTQTWaFwvvpry
         ym7Y+8Yvra+I0uoAJMwBjCWB+m1rdT4YBPYExqHYztSeHBb6RiqKM9WaSjmSt4jQp0mS
         IhgajxVGtJ0R7CTNYSsPWO7EjUh81cTkZzcMKdwEkMXrN+/dF7QFUaZCPfWrCaSNfbN+
         GqB/cVkrGSxzQDrmu75bm7PHOu7+BjKzt8asVZteCEho8ytS9p1EvSky1AuQV1lnwnji
         HiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ogDL5QpWO9MSGJ4HlS1fXf0iuqQSw46hxcEpO0mErqo=;
        b=pBwnjuTcR/pCvubZrA1v7Y2XcKK+nWSDHiSTaR8oHA+51Z3+BjhYaE/5IYp8fy+qAk
         mFxZev5XuoV6LRrvDJcwF0DxoFKc+mCgq7EBwMae5msAs8LwBfRKuonqJVD/dGM5KhHQ
         tnRpJTFGcRVzy4Jllq9z1917WhLNepaayQAVA+ECuP26gPdOGd0BKnULcOwIFfZ7Yt7i
         Bk5yIgJ80Nz9tRDjyv0t1turCkwOPHnmyNvtUJM+tY79xx+w19SLZwdxcJipk7y0ncro
         cIabAIgnIYX8hdxhWqRQk1DT0lumLPkMZ8F9kyLEriVISXPlAjDSTVbEVjwt8EUG/WZ3
         B8ow==
X-Gm-Message-State: APzg51Akh+pqKZwHR9X8JmRhhiXM9DIuq5ojyfuH4Ur4nO/plEmXQ4rO
        OxkOtPoqbwVKFvx5VN2oKe9zrDIwbmM=
X-Google-Smtp-Source: ANB0VdZcTO075R4pdi8MN5NTXjhkVq6KSmpdKCdTFV1CP4ASMz6b8cpTntqapvXhGRWFwJzVq9uTJg==
X-Received: by 2002:a19:c016:: with SMTP id q22-v6mr24457468lff.8.1536187762228;
        Wed, 05 Sep 2018 15:49:22 -0700 (PDT)
Received: from [192.168.10.160] (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id f14-v6sm514980lfm.29.2018.09.05.15.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 15:49:21 -0700 (PDT)
Subject: Re: [PATCH] seccomp: remove unnecessary unlikely()
To:     Kees Cook <keescook@chromium.org>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180905203443.32289-1-igor.stoppa@huawei.com>
 <CAGXu5j+e2n6pUW+40ZNm5qifd8dVEEryN-Qfqe7ok-KZHP1Hyw@mail.gmail.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <2192189d-b8bb-3233-c9f3-14cbeeddaf34@gmail.com>
Date:   Thu, 6 Sep 2018 01:49:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+e2n6pUW+40ZNm5qifd8dVEEryN-Qfqe7ok-KZHP1Hyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/09/18 01:23, Kees Cook wrote:

> Should I take this, or is it part of your series going somewhere else?

It turned out it doesn't really work to have a generic series against 20 
trees :-/

I'm submitting them individually to each subsystem.
So this one is just for security.

--
thanks, igor
