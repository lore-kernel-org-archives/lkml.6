Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F30C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7197A21720
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 06:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sT37E+90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLZGTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 01:19:02 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:33735 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeLZGTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 01:19:02 -0500
Received: by mail-wr1-f52.google.com with SMTP id c14so14882952wrr.0;
        Tue, 25 Dec 2018 22:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WVZiMmTGUoWf2bPMp++17hiZ6pZXQiB5C2RRL0PHHvY=;
        b=sT37E+90xpR6ExZddSu+dykMgmzJlVJESEgTWrMbi/dbAVf5dPOcybDZ8dkC03UpwV
         PkOeD3kdv+Ejwc8N8NvW4PTW/0vZgwwL6vQ0eQqEx/cMn3olrEsin0559A3WCRRb+VQZ
         c57N11mcoQxg6jxK9ceOtm5Y/45eeqRxBFL1ilr0M3LebI+me9ftYrTgWUMkd+c8qK9d
         kWJx0JKpM7QKu9t3oWyoFIRw53hnRUpEaYRgt0eNh70iqJw93pb4ZIn+LgL7cdVnNIsk
         V7x+b1LBrzjUrPMa00q2otQmYgTd1UVdienct1F7oBT2cqlCeblLlF4rMYaUedCxgGsT
         /m6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WVZiMmTGUoWf2bPMp++17hiZ6pZXQiB5C2RRL0PHHvY=;
        b=B7NUmN3Mcx+gbG14t46eSNCoKSkPsid8UfbAYeenBw7YLC2jZ3q4VyVq9PfvwxDDUy
         T8aZqWi2kXM9gmVmJScWkwOjyZkPouTA1FWfyjhdpAy83tKQPxVemBlmJxdLVaYT8Eo6
         rPmqdxMm0Q7hcLfnoewsfd8Nu/kdr2EM4eNPD+sIlPMW+BNlq7WCnm+aEIpN5KbCNnFk
         0uxSfuu00sCfINAoZ15MIWvF16j19ZowjdBaOvUc9rAgYv2aIrOQqUeV/8jr8MHVjyrz
         MCdSW4S2zRvHXJJETvZ/X96HwNW2DBTGHz0swM+0MLO9zWe07HwS9H/gMKWMV8U2iZf6
         uxQw==
X-Gm-Message-State: AJcUukeEqUrZ9aNMjQXHmCdx4p+tS0Wf/hTEKrBKx3stAvsedAC80q3m
        0fLZu9blyiGDtMnsJ6Hxvg==
X-Google-Smtp-Source: ALg8bN6BL7fsMCc62620+c4CFCo5oRaRTlYeqw5tcMQjq6UnaGe0wymxgoIdQkxFNVqJr7HeiW/bVQ==
X-Received: by 2002:adf:e846:: with SMTP id d6mr17959423wrn.72.1545805139941;
        Tue, 25 Dec 2018 22:18:59 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id r3sm21776232wrs.78.2018.12.25.22.18.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 22:18:58 -0800 (PST)
Date:   Wed, 26 Dec 2018 09:18:56 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: proc: check status of register_filesystem
Message-ID: <20181226061856.GA2122@avx2>
References: <20181226030642.72757-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181226030642.72757-1-kjlu@umn.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 09:06:40PM -0600, Kangjie Lu wrote:
> register_filesystem() could fail. The fix issues an error message if it
> fails.

> -	register_filesystem(&proc_fs_type);
> +	if (register_filesystem(&proc_fs_type))
> +		pr_err("failed to register the filesystem.\n");

No, register_filesystem() should do it.
