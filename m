Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14106C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28412145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="1Cy8WAVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28412145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeJIGaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:30:23 -0400
Received: from mail-yw1-f45.google.com ([209.85.161.45]:44707 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeJIGaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:30:23 -0400
Received: by mail-yw1-f45.google.com with SMTP id s73-v6so8780652ywg.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Io/80/jupsmR0z5jah8sylkPVIGmeN+7uFx446pQUm0=;
        b=1Cy8WAVQHOApL/I2jgWHnW+sfcFBcrWIXaVaGrS+YJqugvMISQPz1vBmat/dHdz1XY
         hduZcxHBZbJsP2xZmuUeBRfT8yaXkTdSQh9MliFtCThLg9NNptVxIqea16BTp+ZVSffn
         iAgRn/GJ7GHSgukLdwb1gUvHzgCCLyEMg6q+8nyiUe6vsm5HEomNvo3xw2UR83mGMyDG
         G0dhN0JOARyum7qqVDH5vCMlyWtvblFgGslYAcl8oJGvSNprqhkJVsmLAWfw6ZAXnV0c
         lPGOWcJ6J5cYd49up9h9E3Wn44R4YR/XmGNr+Ggh2yXuGKr9gJ1GyJET3bzC1zXoMwzI
         Nkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Io/80/jupsmR0z5jah8sylkPVIGmeN+7uFx446pQUm0=;
        b=pMY6F6NiZjSQvp0COTMp2mqnH2zmo+gXinlNWJT0Zvu6Opw4JuziXzxTQe5/f0Z6iC
         rTvnhHsUYcTi8bW2K6elWfVWkWySBN/QF7P03ygJT/TXQW5uTGYB1Rs56wEXTZYtL6qw
         rFXz6NDVAmkCrBA9mV0jEYdeI7onIMH5/Gp3TcE+4w9NnzRQszFeBYfjBFB3Tr90J9DO
         LVKslAKcD3Yi6OxZ53h4ULDIvIleIhdcgBjtVnrsvMNbozk8uw8qdSAj9gXiOUMjWbEa
         Qeil1iUjoDWlLX0PqGuU0cpMnExqxEx4aAQoQczzw4uquU0EKfpCfDetkktKPW6Fs6zp
         Sxqg==
X-Gm-Message-State: ABuFfoih/fd4vs1KS1CwyY4Qo/11CkKmPftbpCl/JZjBCU7uZF3Lw4mi
        JDyebDIF/HSohBPx48/2nS4zbQ==
X-Google-Smtp-Source: ACcGV61+F+TwMcEZ5HjN0a8bxjbNVI4CNJ8EmzHxewT9YohKOHLxQm6qM3UieDNBgyiDa5tmhy5iag==
X-Received: by 2002:a0d:c045:: with SMTP id b66-v6mr14310770ywd.208.1539040578136;
        Mon, 08 Oct 2018 16:16:18 -0700 (PDT)
Received: from t480s.mkb.name ([4.16.60.155])
        by smtp.gmail.com with ESMTPSA id z130-v6sm10556084ywd.91.2018.10.08.16.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 16:16:17 -0700 (PDT)
Date:   Mon, 8 Oct 2018 19:16:15 -0400
From:   martin@omnibond.com
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     devel@lists.orangefs.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/19] [V2] orangefs: page cache
Message-ID: <20181008231615.GA48167@t480s.mkb.name>
References: <20181007232736.3780-1-martin@omnibond.com>
 <CAOg9mSTBRni_NVtTr2-W8g7e3LromGrpSww3MOJRNSw=Y_-oaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOg9mSTBRni_NVtTr2-W8g7e3LromGrpSww3MOJRNSw=Y_-oaA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 04:43:36PM -0400, Mike Marshall wrote:
> I still hit writepages_callback not private! on xfstests generic/127...

There's six fsx runs in there.  Can you figure out which one fails?

Martin
