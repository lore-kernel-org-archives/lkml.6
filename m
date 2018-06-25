Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4633CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F079625845
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWt9Xi9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F079625845
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932520AbeFYLqV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:46:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32842 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932305AbeFYLqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:46:19 -0400
Received: by mail-wr0-f194.google.com with SMTP id k16-v6so13366719wro.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 04:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qc3Gp9oL2RiyJDM+VNIAk4TEjH0dafPAfdRATGYJIeg=;
        b=XWt9Xi9k0EUUb3toTv45E0PdKb7eaJB4FlCPnraTXoOne179eDGSEkqB3XEJtSjZoS
         aCKIdVyvtWi3kqv3MVJFvoXRet5j0ydL5p2s4p97EmX7YuUjPJ25UwgQ2Bs0Exrgazj+
         g4S7iX7bZt0HQ9Z4vWPOYyEpsgYfD69gWwWirQZDjgewiNQyifmOWx5yJPd0LhLNJT0u
         7g23auJ7wW7CrTmYsieatebvB8SsSH1GEHzYA+jUCJ846VPsA0z5AGAUXVVbPcsTbQgY
         eorbj1+NAPneCEH3Z+oSpSGl8Q09AHVPgu1qDZW5YRWXSYDfmeNl0aN85JNVMqDvJ9Ad
         g4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qc3Gp9oL2RiyJDM+VNIAk4TEjH0dafPAfdRATGYJIeg=;
        b=lHox0IQWVK5gj18xLNvsRYEMUCFc2iKvPXlwtikbet9u6JXxsxTm9t+L3AouQXFQCC
         J2eDIdQVdLfgNWdatDRdaP1/OwzMrAA4sU2wu38i+0WaWRO5HnuXsbb9XfKwBrXNe6+v
         qlRv7XjMT1fH0/BgBFYkacLbTMXuY0OhzEC6TCnF0TqmzofrVVlsG2XTwUOn4NgoyD/B
         7qoeqKMKFOivXH1Zee4Z88nK+uiDvNghU3CrAEnwxf3q3GC2bp0UX4LNSppXP00NlhA+
         bMmHkxEl+M0yJLr2JCrri3B6wJgY1HZFCF/0fpZou+KD7r8Lpho48tJEG0ei1Ul3YvWT
         VpgA==
X-Gm-Message-State: APt69E0bbRt21qTAk/ypDN0QHfr51jLCSI/eP1uQI6XFKsb69jyqJxW5
        amx1scWhALteV3THh9ngEQ0=
X-Google-Smtp-Source: AAOMgpeS3tKMO6Fe+CoFgcDYc7Z8NPdcVhKRGWffrSyGl05ng5FfPbtd2QKdFtXJTYFiJMcXK0X6gg==
X-Received: by 2002:adf:e4cd:: with SMTP id v13-v6mr9708565wrm.238.1529927178808;
        Mon, 25 Jun 2018 04:46:18 -0700 (PDT)
Received: from xux707-tw ([109.76.172.189])
        by smtp.gmail.com with ESMTPSA id v2-v6sm15992034wrm.84.2018.06.25.04.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 04:46:17 -0700 (PDT)
Date:   Mon, 25 Jun 2018 12:46:18 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 7/8] staging: rtl8192u: Correct if statement - Coding
 Style
Message-ID: <20180625114617.l4uc7c6k3gxd5tks@xux707-tw>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
 <20180624153454.27356-8-johnfwhitmore@gmail.com>
 <ed1a3747023af619d547e1ef7d593fd25b3abcb7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed1a3747023af619d547e1ef7d593fd25b3abcb7.camel@perches.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 08:59:22AM -0700, Joe Perches wrote:
> Rather than doing individual patches for each line
> with a whitespace issue, I think it'd be better to
> do a single driver wide patch.
> 
> Perhaps use a tool like:
> 
> $ git ls-files drivers/staging/rtl8192u |
>   xargs ./scripts/checkpatch.pl -f --fix-inplace --types=spacing
> 
> where:
> 
> $ git diff -w drivers/staging/rtl8192u/
> 
> should not show a single difference.
> 
> Then compile and commit that as a single patch with
> something like "use a more typical spacing style"
> as the commit message.
> 

Thank you for that command. Hadn't found the "--types=spacing" option.

I'd fixed all the spacing issues in that file in a previous patch set. That
space issue was in a commented out section of code, which is why I missed it
previously. I think that file has all space issues cleared so there's only the
single fix in this patch.
