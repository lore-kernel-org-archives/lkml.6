Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A41C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA9C20834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="zOHTL+bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA9C20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbeLAKHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 05:07:31 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37795 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbeLAKHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:07:31 -0500
Received: by mail-lj1-f196.google.com with SMTP id e5-v6so6412832lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 14:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wqz6Hz/qvhwKWRmkkj197fjEJCJwBjwxL/4ZA4fi6FQ=;
        b=zOHTL+bdcaROj8j6vLT7DdGkGl/dIStH33MIWolia1kQNBQVTG1kizk4aiZwc9yFOv
         /Wdufg/tdf9hWpqZIYV1ss21tJWYSSvV6plmXxXz6EQ4DyW2VoFg12favxbx9dUuPcBO
         HJnZPAlWZSayxjO5uBRgiG5AsWUOP0WM47Y8vNGtB1v+H8K7xBHg7a8QbNGRZ0zfdTgu
         loOtHLP291gTz9r4vtW6HTtLcnIwTprg46icgu3UgKSwrjNQ/04bRd69ADgjhGEJxfdM
         MlpXRCmUsvKtwVk8FVfqwMqR6QTOFqvBPPQ+NWnVirhRqkBDgowZXL6ZdlPSoCp6KB0J
         Ss/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wqz6Hz/qvhwKWRmkkj197fjEJCJwBjwxL/4ZA4fi6FQ=;
        b=D5+u+XsE9zVEtfR7d4iQWRaMb/oxlc3rbnpWiHDQBqjfuYmjFPU01uYjeSQUfXVE9x
         g83PFSzTujHEnq5eh+efIme7VWU3ZS8a/1prauyw03ieFxxcZyQutOzV14G5iPWrn0Cq
         0cq4TiR40Lpv2qVtqLF6cV0Na+QCaneTat0VF7WshOeCDleU2O2nPJ8zlAtphBBwE3i0
         P2Y6OR4bwM7BEotqTEgA07uV4SOQgVhXiIwZ0dwH2ydz+Y57KOa/bNMA3m3Xt9BKbi0n
         t3dlfuNPTEM/07CxQdPnYBxNyr6mQ5J1viyRAJ93X5ixB6m4s2GDZ3x+i/HGEF+EMuu6
         Y2ew==
X-Gm-Message-State: AA+aEWbLq+wpeDSnooL89tiUmCbWKTwGmiFp/T383LXKIXnvF0g+6dyP
        HIdMdCr5JhBFqJcUnE7lzU5KoQ==
X-Google-Smtp-Source: AFSGD/XPz9w3WmBfpJVAJGeDcWnl8lEsiVHOxZXDQSBrUV58SWEobEbWkCOJz2Ah6X2A0aGapN6B/g==
X-Received: by 2002:a2e:7d15:: with SMTP id y21-v6mr4372757ljc.77.1543618597422;
        Fri, 30 Nov 2018 14:56:37 -0800 (PST)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id q6sm1027219lfh.52.2018.11.30.14.56.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 14:56:36 -0800 (PST)
Date:   Fri, 30 Nov 2018 11:57:21 -0800
From:   Olof Johansson <olof@lixom.net>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     arm@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] MAINTAINERS: Remove unused Qualcomm SoC mailing list
Message-ID: <20181130195721.omkxvvin7iu3be3u@localhost>
References: <1543530666-32141-1-git-send-email-andy.gross@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543530666-32141-1-git-send-email-andy.gross@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 04:31:06PM -0600, Andy Gross wrote:
> This patch removes the linux-soc mailing list from the Qualcomm SoC
> entry.  We use the linux-msm and there is no need to have the second
> one and this clears the list for use by others.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

Applied to fixes. Thanks.


-Olof
