Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F587C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE70C24BE8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:38:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HH7FE9tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE70C24BE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934628AbeF1Miz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:38:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37559 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932235AbeF1Miy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:38:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id n17-v6so8370297wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N3BTJW3nHPZMWOGJqDD/3n0ik4XqJVhK5JN37vUASO8=;
        b=HH7FE9txd+9IpJ3yFPnPDVHDxZoNUYhd0CWhwESMnCGjy3nVDW5+Gu7wRh/0AkTHx8
         3lkm0wNGg0S8OUDKnogu8a9/1ZFz+lwCms8ix7cKa2O+O8aE+HPUNc/b+7f/3uvQmS5A
         FHZBkbVJr718veLvJ1SwjGs1hplnD2JDD8AFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N3BTJW3nHPZMWOGJqDD/3n0ik4XqJVhK5JN37vUASO8=;
        b=jHzTK5xAIinOlxEwitpA9PbxPoTVkrot1JoyeFHRUUW5i2djGvvf5zmG7/B0qVlENB
         PF40jpJJqHfL4H8q0knblSfhVfpCRufd2ipUqs9tTzJyAzAxlRs+TsRfpOq5sJ/6CFz0
         8ZxyyYh+BwsPfhQi28jtAmEDcmTSFZRIn+03ahIR/V94NuPKvmzX+nV1kTiMgm8suopq
         635gqEv8O94g5bRn4sJlpgU6E/vwxPThdkwisVtcgJiTwtn16UCqwNY7yJLRdyFk8seD
         M+W2yr75/twW38/jxleJX57bArDexjW9nqnhLZkiKu2suEAz4qgSeuhSBiJvpiLQuoZJ
         EPSA==
X-Gm-Message-State: APt69E2WEKEeQa60w97gtKGrWdMFCDT9Sw74RostnE+LrmrSnGzl62Sk
        qcfBzRavZqN71+bBPXvLzhg6Gg==
X-Google-Smtp-Source: AAOMgpdvnqt1it78O/ePQj8niYhJe5vxBWHAcDxSAJisxLWkrghtUT4JOnLMcCQBIy1PH4aeNxrEkw==
X-Received: by 2002:a1c:d045:: with SMTP id h66-v6mr8022467wmg.101.1530189533008;
        Thu, 28 Jun 2018 05:38:53 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id 132-v6sm12186723wmr.33.2018.06.28.05.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 05:38:52 -0700 (PDT)
Date:   Thu, 28 Jun 2018 14:38:45 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, akiyks@gmail.com,
        boqun.feng@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, npiggin@gmail.com,
        paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        stern@rowland.harvard.edu, will.deacon@arm.com
Subject: Re: [PATCH 0/2] tools/memory-model: remove ACCESS_ONCE()
Message-ID: <20180628123845.GA14456@andrea>
References: <20180628123347.52963-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628123347.52963-1-mark.rutland@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 01:33:45PM +0100, Mark Rutland wrote:
> Since commit:
>     
>   b899a850431e2dd0 ("compiler.h: Remove ACCESS_ONCE()")
>     
> ... there has been no definition of ACCESS_ONCE() in the kernel tree,
> and it has been necessary to use READ_ONCE() or WRITE_ONCE() instead.
> 
> However, since then the kernel memory model was added to the Linux tree,
> sporting new instances of ACCESS_ONCE() in examples and in the memory
> model itself.
> 
> These patches remove the new instances of ACCESS_ONCE() for consistency
> with the contemporary codebase.
> 
> Thanks,
> Mark.
> 
> Mark Rutland (2):
>   tools/memory-model: remove ACCESS_ONCE() from recipes
>   tools/memory-model: remove ACCESS_ONCE() from model

For the series:

Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Cheers,
  Andrea


> 
>  tools/memory-model/Documentation/recipes.txt | 4 ++--
>  tools/memory-model/linux-kernel.bell         | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 2.11.0
> 
