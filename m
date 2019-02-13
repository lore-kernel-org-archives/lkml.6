Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3D6C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043DF222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 06:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+SAXfjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733209AbfBMGiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 01:38:20 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43905 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfBMGiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 01:38:20 -0500
Received: by mail-pl1-f193.google.com with SMTP id f90so707680plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 22:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8hd0bchLPW831lBEDOivAggG0dO8jJpUK8mpvf0pvoI=;
        b=i+SAXfjHhfUKokyCBh/5BEfW93EuoM9HXAuNKk+Z5TOtWf1sDpp8QwCT++IgeWLAXy
         ETnLsCogYxGTsaCMcGhetmbz8F6Ild/Yf9/iBsqFE79vKzpQOyMIjocmgbqKgZuE8Olk
         gED1zG4tkBQTTQiRrSMLDZfAuVHHIKDlBrsyyOlUYhITQe8lQH4IxOn4VwF0KcGooT2h
         yI9/6CB/3i2443UoSmL/IUzbkorEZw9tXn0K+5DG8YnFj1T7M1WtLgT3bW4DtUj6sQBv
         GfajJRNumbiAIN0LAAJn8YcydQlXOiZ72UY19+esrTjGzDa2PoGydiBSggl+A3JP7/0x
         R2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8hd0bchLPW831lBEDOivAggG0dO8jJpUK8mpvf0pvoI=;
        b=ucSHXs3RMpYAAwK2ngNUGRPuIknEhm4uT6/7GxkhsCVtiVcW+XhukNnfX1+YKR6zsb
         OB00ux8VrcIYljwi26pMhntIn02b/iNotDC3rqoul354VV1qxWyApgZkGRCt82CrXCSJ
         Y7ntmpaU4Th3bgXz03Qa+M4V8oQjce0Oq5nAcwYQFeShjaiL9rpsL+Dy191C1GfXy950
         w44s1jU+5m9YTLSWnYYwWkFQlBNxTEUQyi/IwgMao8NK6MzUmd8dXtB9V35MT8szDrUO
         ChndtyWz7r8OgKXFNEWa+CYUxBs69zEb6S5Xl9j39tz2Om4OZww42i/S954vQiOVIQhk
         FMZA==
X-Gm-Message-State: AHQUAuanLZjvP2Sv6b7mwa8EEvjRbcD1X1G/n9RH65Vh+cUoanBM8F//
        z0Cl73L0ZquK6YraRo1463g=
X-Google-Smtp-Source: AHgI3Iaa4WKpU7xAW6/6qpii9y7YiFgIXVHuQkQf9uSVm8ggt0HrprVxIKP12wuqOTvw5YrmGZcRuw==
X-Received: by 2002:a17:902:2a66:: with SMTP id i93mr7882402plb.128.1550039899190;
        Tue, 12 Feb 2019 22:38:19 -0800 (PST)
Received: from localhost ([39.7.15.189])
        by smtp.gmail.com with ESMTPSA id v15sm19250563pgf.75.2019.02.12.22.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 22:38:18 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:38:15 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     xiang xiao <xiaoxiang781216@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Xiang Xiao <xiaoxiang@xiaomi.com>
Subject: Re: [PATCH] printk: add KERN_NOTIME to skip the timestamp
Message-ID: <20190213063815.GA32272@jagdpanzerIV>
References: <1549995065-27597-1-git-send-email-xiaoxiang@xiaomi.com>
 <20190212144606.4b7cf0f8@gandalf.local.home>
 <CAH2Cfb-Zd9TKgs52ROVGYg6F_hiN2ieWKwYPkxpVV8St+zwa2A@mail.gmail.com>
 <20190213062912.GA23233@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213062912.GA23233@jagdpanzerIV>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (02/13/19 15:29), Sergey Senozhatsky wrote:
>
> cat /sys/module/printk/parameters/time ?
 ^^^^^
cat / echo

Works both ways.

	-ss
