Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57409C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE9023E80
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 15:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IK6AYVCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE9023E80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934056AbeGCPhe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 11:37:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42269 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932884AbeGCPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 11:37:31 -0400
Received: by mail-pl0-f68.google.com with SMTP id y15-v6so1219019pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=UhAr27YJ0Cbj7IUq/PD8n3H0jaMa+T7/33UximkNlCs=;
        b=IK6AYVCDCpJ5df+ymNrC3ogQnp3mJzCMlIS2fMOUn97WboXkDJrilEdjinyD2qE5dS
         cUwaxrkVilYeilT6IoyXcn4w4g/rJl25OiuGcXCnqz/B0EJc/A3QdjlzY1bffjVBJKs6
         O5o3AxLfM1xkFKGTr3N8vO9s5UmKBTN4L4fMaS0QCI4pUxNw0aXiOMK1qgCcXWqaMkz+
         7lQ1U5uZxUmvW0b85D0P4+RT2J4oeHbM6uPORPQLX6oaFcs7clp48opjE4paXeYy/+3t
         2ax1xo0e3rKq9Of5wV/11gP8xaAebL9I5wWa+3AkY+cWePrUXPUbzKmQq0eDiLXp74dc
         /VKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UhAr27YJ0Cbj7IUq/PD8n3H0jaMa+T7/33UximkNlCs=;
        b=sKyw3wE5+CwzJgtm5VaJuzo/XDuVyRj2BfXRzJ7sv0pZJXo+cWN3bUJtI0Exgn6me8
         LT+W2OBRiGgHejRMMjz8JQ1KvJ3Ha9P9VRe6dh9KGbR63ZwcnCEawVA0vO1eNao+ESoT
         Rn3TwRT9SuPs5M5Oyf8AVQh6ZTByLS4aaK0MP1oPzG3FrhH8+/9i1qksV3/V7+pv38wA
         8NgN1ILkYkSZf6R5L7z1tAud1zuvSwux+lSsrfEFsWa7+212pUp+DalUblLB9WgXaeh1
         2ysRTqwbZALwcZ644dsSFwfcD4MwFqcgP9xos/6RcfH8t138NLUExaT6bdWhH2c08yc1
         jCVQ==
X-Gm-Message-State: APt69E39HMl0yhIVpQslyD9AWbNbJOVoQkobm9zGJj6fhTrul0EI4Ryl
        IIHaqeifEWlOdbws//PMD4LF8atOlvc=
X-Google-Smtp-Source: AAOMgpfrjJbfruM5a59aDNGRVXX3CDxwgfhNNRdM6NEUta9X58pGW8+566FQszdt7mkcvtaRbTOU4g==
X-Received: by 2002:a17:902:a716:: with SMTP id w22-v6mr13408958plq.271.1530632251037;
        Tue, 03 Jul 2018 08:37:31 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1132::1214? ([2620:10d:c090:180::1:a9d6])
        by smtp.gmail.com with ESMTPSA id n2-v6sm2336532pgp.71.2018.07.03.08.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 08:37:29 -0700 (PDT)
Subject: Re: [PATCH 0/14][V6] Introduce io.latency io controller for cgroups
To:     Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
References: <20180703151503.2549-1-josef@toxicpanda.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f2d28a6b-a4bf-f340-cf78-024fb5f3314b@kernel.dk>
Date:   Tue, 3 Jul 2018 09:37:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180703151503.2549-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/18 9:14 AM, Josef Bacik wrote:
> Jens, I'm sending this through your tree since it's mostly block related,
> however there are the two mm related patches, so if somebody from mm could weigh
> in on how we want to handle those that would be great.  Thanks,

Since we got Hannes's and Andrew's ack, I think we're fine. I've applied this
for 4.19, thanks.

-- 
Jens Axboe

