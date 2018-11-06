Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94D2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9AB2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+ZfPtCx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A9AB2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbeKGHVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 02:21:31 -0500
Received: from mail-pf1-f177.google.com ([209.85.210.177]:32944 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbeKGHVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 02:21:30 -0500
Received: by mail-pf1-f177.google.com with SMTP id v68-v6so3143379pfk.0;
        Tue, 06 Nov 2018 13:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L7mT2wYXMecMbAvmjrJxTahyoUEFJDhWpI7hoacznyM=;
        b=g+ZfPtCxdIA/hxX7eK9yMAY4bXAxoUS/b9PV3cUdrjXKGDIR4bVb71/zXlw0RB0E6X
         gDLTJr1EUr/lFy+IF6tgdkUup7Kx/YqI3rroMldlfXRznfzJT8yJonJe7e+EU7LaxPbO
         PAB58Nlf18gt5WhGaJypfc0PBnxkQIPbHqI4Bnh94hrbGzPYei2/B110HKHb8lVlsTiQ
         THydeEWCxCIM9PJKChvqWpVSfeQX4Pvu83o6u8gXb0Ok+U6TUwwbUCvRUQaB7sPDTybq
         9Z7OALtx2YgQ049jBZYXphxUzggEAqmWPzMusbFnjbB5/mJG6J8VyTgFJojQmoF1bxuN
         srdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L7mT2wYXMecMbAvmjrJxTahyoUEFJDhWpI7hoacznyM=;
        b=jr6KVCOXhrzOYJiOxVNE2JQMoe1XM5Oop7TiKcqRYiCFZ/InsCw2j72RZNJwoZ1Jkf
         STcvWGh642o6btrmxwQYpWl/HiBuJ/Yv9aeYQ2yP8+iID/MsqRabRGIH20jZc4a9KWUg
         SUSN9fvbCih0l9dI7ArmtaooRh4kGoaID7EanHqTbJ9DHwtgThZ5+7r0R1NLLkjIIi5+
         ND80C7ukMsesZRuzOCxbS5oISReX2eWHRQj7RwRiLLEooD8jDnQ6dHOf+YQtgLAlnHtX
         jgNOAo2LyCcHO0aa+udJdYVcOMn9Hk0FT3x0Ckig64Wi+qF65t4Bostk0ZmPsDLAIkPU
         dN0w==
X-Gm-Message-State: AGRZ1gKXcL150MK6FwQ8zKnAHQ4R/Y/14HiBMUs7fv502c5MkpkXNi17
        CkPug1zjHxkh93Gu6gpBmVc=
X-Google-Smtp-Source: AJdET5c41HKFDqnRTh7QFpB0Rh4ub3EBnhncs3o6gcPiJb+luH2y7fY8WdtrSBgV8a+QVP9I1ZUCzA==
X-Received: by 2002:a63:f710:: with SMTP id x16mr25415819pgh.322.1541541251698;
        Tue, 06 Nov 2018 13:54:11 -0800 (PST)
Received: from ?IPv6:2601:282:800:fd80:30c7:3851:bc7d:ba41? ([2601:282:800:fd80:30c7:3851:bc7d:ba41])
        by smtp.googlemail.com with ESMTPSA id r137-v6sm14130467pfc.105.2018.11.06.13.54.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 13:54:10 -0800 (PST)
Subject: Re: [RFC perf,bpf 5/5] perf util: generate bpf_prog_info_event for
 short living bpf programs
To:     Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, ast@kernel.org, daniel@iogearbox.net,
        peterz@infradead.org, acme@kernel.org
References: <20181106205246.567448-1-songliubraving@fb.com>
 <20181106205246.567448-6-songliubraving@fb.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <b984776a-ce69-ab16-ed87-1cea89c9d79a@gmail.com>
Date:   Tue, 6 Nov 2018 14:54:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181106205246.567448-6-songliubraving@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/18 1:52 PM, Song Liu wrote:
> +
>  static int record__mmap_read_all(struct record *rec)
>  {
>  	int err;
>  
> +	err = record__mmap_process_vip_events(rec);
> +	if (err)
> +		return err;
> +
>  	err = record__mmap_read_evlist(rec, rec->evlist, false);
>  	if (err)
>  		return err;

Seems to me that is going to increase the overhead of perf on any system
doing BPF updates. The BPF events cause a wakeup every load and unload,
and perf processes not only the VIP events but then walks all of the
other maps.

> @@ -1686,6 +1734,8 @@ static struct option __record_options[] = {
>  			  "signal"),
>  	OPT_BOOLEAN(0, "dry-run", &dry_run,
>  		    "Parse options then exit"),
> +	OPT_BOOLEAN(0, "no-bpf-event", &record.no_bpf_event,
> +		    "do not record event on bpf program load/unload"),

Why should this default on? If am recording FIB events, I don't care
about BPF events.

