Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2577ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAEE20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="WyXd8zv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAEE20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbeKAEAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:00:18 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33262 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeKAEAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:00:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id q1so6131913otk.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 12:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PyklA2MQuXPRIbam65KPJ5kSd9+qeXPOIpPrlIhu1/U=;
        b=WyXd8zv10JN74jFjk+lN1btbnVGtf24XC6OwjNCfum9ZALTyVTI6aMdnqqrf6Z8GwA
         cRasslkS5oDuacdIV4zLiIQBLgfkfQJf3gE5WH7Izl+soKgJrrwkvdCDI28Czc03kpiW
         4WGR+g46bj51tdH5eGXK6xfgjbfTMkZWES9YcvxJGpscbwauZJE8C/s89+tFak5STzIy
         SX/MedDmJU+aoyoGSDtnGRWBJuugYTdJNDN2GJ7vEqajVX+Uf65TgSOa+XisZAEGxrwy
         gqfUM3211zye1TRYSc1kdW3ZosjQxg1B76dsbTfPJN2dgpUU27rbKuV2cr8dZqTX9yr6
         n7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PyklA2MQuXPRIbam65KPJ5kSd9+qeXPOIpPrlIhu1/U=;
        b=XW8ckhF4qKQCJ5afOy562oz99GrOC2Kum/25xDxk9c7/rpYo13P/BDulKObCkz85E7
         1PAAk7ZZuc0m3hVrap+vcxW13/aahQMnxEgMhmCV2+UiaI0IhbjNtGPgTREiwx3UfSKu
         L5XJiDtQ4BWeh1l4zbhAdLkdF3kJx7RLQ1xEDD+O6CZUbb/BI+2biqOGwG1hCL2ezIna
         AuFglSjayjvOOzKX2KyMqeVgUhZ4lccArKn26yug+eS9vqGO3F9h6VjFeuJHlp8tFo7T
         unvLV6XrRI+fRu8NsZFX+O7IlAyS76wDTLJHmZoPxhWb1KvFefIbYq+0+a9O+vbJ8637
         0dTA==
X-Gm-Message-State: AGRZ1gK5Fj2//SLv//0N+3WNXTdePg8jJnJAnu9yv9zYiAZuhmZC8uZf
        corqLpfK2iMIqV8tI0RDN1uyPw==
X-Google-Smtp-Source: AJdET5dhG14pHnUawblTxPjGORE9xcvp0F+O8fTvVUacP0adcj1aMtrthr5Bo+9WNR3E7uA/w/V0TQ==
X-Received: by 2002:a9d:3208:: with SMTP id t8mr2600206otc.312.1541012458098;
        Wed, 31 Oct 2018 12:00:58 -0700 (PDT)
Received: from [192.168.27.3] ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id s11sm14545274ota.80.2018.10.31.12.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:00:57 -0700 (PDT)
Subject: Re: [patch 0/9] time: Add SPDX identifiers and cleanup boilerplates
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        John Stultz <john.stultz@linaro.org>,
        Peter Anvin <hpa@zytor.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Richard Cochran <richardcochran@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        David Riley <davidriley@chromium.org>,
        Colin Cross <ccross@android.com>,
        Mark Brown <broonie@kernel.org>
References: <20181031182107.726051323@linutronix.de>
From:   Corey Minyard <cminyard@mvista.com>
Message-ID: <18500ee8-450d-864b-763f-268134caf348@mvista.com>
Date:   Wed, 31 Oct 2018 14:00:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181031182107.726051323@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18 1:21 PM, Thomas Gleixner wrote:
> Add SPDX identifiers to all files in kernel/time and remove the license
> boiler plates.
>
> Aside of that use the chance to get rid of (stale) file references and tidy
> up the top of file comments as they are touched anyway by this work.
>
> This work is based on a script and data from Philippe Ombredanne, Kate
> Stewart and myself. The data has been created with two independent license
> scanners and manual inspection.
>
Wow, Arques Ave.  That was about five moves ago.

Anyway, this looks good to me.  Thanks.

Acked-by: Corey Minyard <cminyard@mvista.com>

-corey

