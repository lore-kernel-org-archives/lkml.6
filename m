Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE24C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6546620874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ov5zXsyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6546620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754393AbeFUBnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:43:46 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40981 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754104AbeFUBnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:43:42 -0400
Received: by mail-pl0-f65.google.com with SMTP id w8-v6so738409ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 18:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VYl/U+nXEQuzfttS2PBaJ/SgcKFBBFEimfL7g7HdJ6E=;
        b=ov5zXsyrSvFUA82si3EhBS3sSvChHmgJ7swVXeghpsuAnTWJRT8YZH0aG2Z+E9ZSN8
         OH6Xl3PrPsNQgCR2yvkAf4iOySmnn5y9ZIgrjyCrg/Ct+ALjNrs487l6oqQ4MO2/sYl1
         KmLqsA4Wkf6OixjylO9WoxcqhKTLgFYH3ggv+yPYkG6YpY3PdOYRNRc0mAZVcMeQYB3n
         MOyVHmj+86gPvrIpFrThkomwlvRClUzhmqnZx5HkEYIO0ZFKW8d2Q41eoLOHnUxYzoiE
         yBjDEAglAG0R0bLDXV5JCNHo+7iMkXCnrSkS9Xqxsshpkfu/GoeQDErTJKhwkmdiRKh1
         c6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VYl/U+nXEQuzfttS2PBaJ/SgcKFBBFEimfL7g7HdJ6E=;
        b=hy5ocB7ND9IW0RE8iNOhsix2+zutREBC+S/psadW285BjIColeiZLvH2Y/1oYlIuPy
         pQARwTa1S5MIhVwZGaDSqlhcnh6lUXkC3GgVJJs2HHHv469uA/0iixbfJ1yXhm59+KPY
         OSlxjEpYGVlkCnDBPjjmMrRaZocmGcTgVIRp47/TSwhigH1EBUuKYM3YVwlclGxhSw+j
         6Peh+Q5+VTTjXQa0gYXTibg/MLyGMCV/d80asaJcCAZ6SXyBRdK1SsvaSYVFdkHJgFtY
         6vw7aPQ6mYkHmL3wdOxJkA/lwZl8sM826HoxS3sPWQEFYzUYTBZQNpPM3Xavv0hP2VM9
         0vWQ==
X-Gm-Message-State: APt69E2Q2RZFrjYNhOcyn0XaquTYyJI2lQYsUQ/aolR7tUoybgdwUZ+J
        RRXW6NcfY0ypHocwUnDPF78=
X-Google-Smtp-Source: ADUXVKKAAeBCyfq8RJRQ2/syKbyF2gkbT/M7bqleD8OwXlo5dwMKMsnD2sihMa4Z/tBnpBp8+XHUuA==
X-Received: by 2002:a17:902:9b92:: with SMTP id y18-v6mr25771880plp.57.1529545422214;
        Wed, 20 Jun 2018 18:43:42 -0700 (PDT)
Received: from localhost ([39.7.59.103])
        by smtp.gmail.com with ESMTPSA id n85-v6sm5860567pfa.146.2018.06.20.18.43.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 18:43:40 -0700 (PDT)
Date:   Thu, 21 Jun 2018 10:43:37 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Make CONSOLE_LOGLEVEL_QUIET configurable
Message-ID: <20180621014337.GD15462@jagdpanzerIV>
References: <20180619115726.3098-1-hdegoede@redhat.com>
 <20180620110335.sjzmtra2z3chvon2@pathway.suse.cz>
 <20180620112436.GF444@jagdpanzerIV>
 <ad4ecac7-e57b-b058-7179-54c5dd949745@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad4ecac7-e57b-b058-7179-54c5dd949745@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/20/18 15:43), Hans de Goede wrote:
> 
> I guess with my downstream hat on that we could live with silent,
> but I would much prefer changing quiet, also so that we can lower
> the firehose of mostly false-positive bugs coming in because of this.
> Here is a short list from quick search which in no way is complete
> (tip of the iceberg really):
> 
>   1413342 - Linux 4.9.3: ACPI Error: [_OSI] Namespace lookup failure, AE_NOT_FOU
>   1415853 - ACPI Error: Namespace lookup failure, AE_NOT_FOUND (20160831/psargs-
>   1514937 - ACPI Error: AE_NOT_FOUND
>   1527870 - ACPI Error: [\_SB_.PCI0.SAT1] Namespace lookup failure, AE_NOT_FOUND
>   1552580 - ACPI Error: Method parse/execution failed
>   1553320 - Kernel errors at bootup -- system runs okay
>   1556967 - ACPI Error: [SMIC] Namespace lookup failure, AE_ALREADY_EXISTS
>   1582825 - ACPI Error: Method parse/execution failed
>   https://bugzilla.kernel.org/show_bug.cgi?id=109511
>   https://bugzilla.kernel.org/show_bug.cgi?id=194687
> 
> If we change quiet to filter these out, all of these will go away, if
> we add a new silent option then only fresh installs will get the
> new silent option and the benefit will be much reduced.

Hi,

No real objections from my side, I guess. Especially given that
Red Hat, VMWare and SUSE like your patch :)

	-ss
