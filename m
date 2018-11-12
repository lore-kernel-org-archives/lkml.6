Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15C9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991D1223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Oj1cxLTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991D1223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbeKMBm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:42:28 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41449 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728416AbeKMBm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:42:27 -0500
Received: by mail-pl1-f194.google.com with SMTP id p16-v6so4531652plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 07:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jUM1IU2p9/emIAUN1aY2J9DJMh5MBq8/2GVefKP4h7U=;
        b=Oj1cxLTchF6eMB4wM3JXOcnrCPu6crvk8ipP/n3PJnD/l1H6DF0W75XgaGEIKwsWW/
         N+MOV/vj8kcwOQ1XLWgvS0qF62qgNaLWz9ix7TPlNHO/tzDSGgYod7PaffWtdxBZgXVF
         OJdbWzEwiqqIL4I85u1N4s8+5z3pZVr7/eMWn//8fcrdM8zV3RQaLRD7X7Klp5ZzefVw
         F0M+AL+voHaYSSVtGH7+fhArrtXYpqM8xc5j6qjJpExcQTxSpgfCPgixNiV9rtmx829/
         pDvHjTeo9krDcl+M3GRjx9GvHGodd/grMzoSnI61ANFN8LGme97JmLbYltlFYRu8oKjY
         XS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jUM1IU2p9/emIAUN1aY2J9DJMh5MBq8/2GVefKP4h7U=;
        b=WRSieO8jfFr4jWZtUgS08ysOpO5MND3em+83+cyGq/5aebcRLPe+WJyN/5LElTC4WI
         J2crHGRsgZbixde6j2LxmcwZZsuRzBcqqXno6n4pIM4Vq3E6FqNQMT7KQiAxhW4FH751
         +Z7hOORDkfLbPxu3Z75+77fsERjEwpq1GoO82dvb2ai+hxP0I8DeKImJs55ARCAJhDVK
         hl+DnlbmIiIFixzWXzEVsF7OWstKXyYEl6iXnY9M04vNHGFtRvk84L4j29EEoYbgjt0i
         8YLQ5fy0ND9TOPQF7ArFY5I6D/ZhQFXkkQgmMrZj7ltPhGVulWCYGjpGYRhSw/EmyRuE
         64NQ==
X-Gm-Message-State: AGRZ1gJ0t3QN4/hvn9qa1OB3s5ZfdNdGTtlKm6rsk+x6DSKBQzW65n6t
        h77TMOxk97SNdzcLqcbVlJjBzwk0b/8=
X-Google-Smtp-Source: AJdET5cqcpQ5d3v5TCWMPmaGprl27bpd2lvp0dTZHlU0gZe8haoCl8AVMweuWghnoHjPjo17uqHrNA==
X-Received: by 2002:a17:902:7882:: with SMTP id q2-v6mr1451063pll.188.1542037719372;
        Mon, 12 Nov 2018 07:48:39 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l3sm16496310pga.92.2018.11.12.07.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 07:48:38 -0800 (PST)
Subject: Re: [PATCH 00/12] unify the interface of the proportional-share
 policy in blkio/io
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        'Paolo Valente' via bfq-iosched 
        <bfq-iosched@googlegroups.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        lennart@poettering.net
References: <20181112095632.69114-1-paolo.valente@linaro.org>
 <9e8adb3271680165d85994a225713391@natalenko.name>
 <E8A20452-A73C-4A31-B5EC-48EFB9937832@linaro.org>
 <e85cfae0-7743-8c51-c2c9-0855c26f868e@kernel.dk>
 <F0F86365-D4EC-43F0-AE13-CC8FA6CC3D97@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c665a05b-66fc-6b8a-fa73-1c76885053db@kernel.dk>
Date:   Mon, 12 Nov 2018 08:48:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <F0F86365-D4EC-43F0-AE13-CC8FA6CC3D97@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 8:45 AM, Paolo Valente wrote:
> BTW, since this patch series is probably even more useful for older
> than for future kernels, might it make sense to also propose it for
> stable/longterm kernels (provided that such a possibility exists)?

That just not how things work, we don't put different things in
older/stable kernels, it's strictly backports of what we have in
current/newer kernels. Hence it appears to be a dead end right now.

-- 
Jens Axboe

