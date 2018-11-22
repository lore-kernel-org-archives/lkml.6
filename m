Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6D8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2FF20870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEfcpJ/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2FF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392126AbeKVQSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 11:18:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38983 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731310AbeKVQSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 11:18:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id c72so1373231pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 21:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FRbX1DFw1UWGoclFmcWoaS4OzeGGPFi/dFVuUs6GsQk=;
        b=XEfcpJ/MMaAuKLBlb6ifsgPM4DCRFrohvfhtthK+4Ioq3ug2gZlvjkR3+Yynt760s3
         CfcNe6XlNk3TOHlRW6Vc4rP6n4DqvwDV18ADLiZOjS8eDGr24ZghJcfz6p7IPjHiwZ1N
         qJYJVLWZlhmkvVcaKkwXlWCpydRM3zAwuxFuoSF/+N59p5RQE+n/31PL1V21abEuJ2lD
         bjsEqg8ABYDlHnOoO4AgkcZkuyyxVktm1E6vnl5AeNgyd2A87j4M6uZYmrgEAwDBpa0i
         mVmUXhkr5jmzHek0xohWaskojHUf43vynWPsyrPWbZ5deVvPKBXGtD0/urkvBpIY/N3S
         HTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FRbX1DFw1UWGoclFmcWoaS4OzeGGPFi/dFVuUs6GsQk=;
        b=IJ51nyvjVJq05wmbwNKxcbHrgapJIfzCEcQdJXGzjB4nF+3FMGCZsXfK8Lt0h643rk
         8Fj5VaNGsnR7BNmUldZrxuKF/JvEO/DrD9zvPGi9800YYJMizMtZysAeRJHEvnVEjUq7
         QdNiYmr/CgkSYV50+O4XvZOdnYYW6PwVK0vQ+RbRdEk319sQX9DuRjrH4FCFpeCFYJWb
         m6F4ZyGkyDbnuNby2LC4hNPRR/TcipRlHqaV6Y58sAuMC1GRVk/NiDlN37+QfeD3/RIy
         9KNIoafviZQDL2u3x4uUlN0DrazmFuTcuMGLXX57HaZZOFuQdOh1KyHtxAKtxakdldHN
         U7Yw==
X-Gm-Message-State: AA+aEWb+o3o0DZyMYmoyk+MTxhdmftPDwAHQF7fgcn3xEOs6CozvnEJ+
        22A26pnnEEGD5ZlHNYakcTY=
X-Google-Smtp-Source: AFSGD/VDzWCaMOR4bVxZGaXMZMCCaJO5yTYvATHBNKY0026X08gf3+7r+N/SlYyQgHTc3/WI75ybAA==
X-Received: by 2002:a63:b30f:: with SMTP id i15mr8835001pgf.240.1542865244410;
        Wed, 21 Nov 2018 21:40:44 -0800 (PST)
Received: from localhost ([175.223.27.1])
        by smtp.gmail.com with ESMTPSA id b26sm7862486pfe.91.2018.11.21.21.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 21:40:43 -0800 (PST)
Date:   Thu, 22 Nov 2018 14:40:40 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] zram: support idle page writeback
Message-ID: <20181122054040.GE3441@jagdpanzerIV>
References: <20181116072035.155108-1-minchan@kernel.org>
 <20181116072035.155108-5-minchan@kernel.org>
 <20181121045551.GC599@jagdpanzerIV>
 <20181121133408.GA103278@google.com>
 <20181122021442.GB3441@jagdpanzerIV>
 <20181122050437.GA182024@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122050437.GA182024@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/22/18 14:04), Minchan Kim wrote:
> 
> > additionally, it's too simple. It writes-back pages which can be
> > swapped in immediately; which basically means that we do pointless
> > PAGE_SIZE writes to a device which doesn't really like pointless
> > writes.
> 
> This patchset aims for *IDLE page* writeback and you can define
> what is IDLE page by yourself. It doesn't do pointless writeback.
> > 
> > It's a whole different story with idle, compressible pages writeback.
> 
> I don't understand your point.

Seems you misunderstood me. I'm not saying that IDLE writeback is bad.
On the contrary, I think IDLE writeback is x100 better than writeback
which we currently have.

The "pointless writeback" comment was about the existing writeback,
when we WB pages which we couldn't compress. We can have a relative
huge percentage of incompressible pages, and not all of them will end
up being IDLE:
 - we swap out page
 - can't compress it
 - writeback PAGE_SIZE
 - swap it in two seconds later

// as example //

IDLE page writeback (this patch set) looks to me like a really
significant improvement. Especially if we can writeback compressed
objects and do, e.g., 300-bytes writes instead of PAGE_SIZE writes.

	-ss
