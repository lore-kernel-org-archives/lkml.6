Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CBEECE562
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D023F214DC
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 13:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="PHJcSeqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D023F214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeIWTFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 15:05:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42466 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeIWTFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 15:05:48 -0400
Received: by mail-lf1-f68.google.com with SMTP id d7-v6so10741284lfj.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Sep 2018 06:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4/eZsaa1GOWp5cdUxQQd2rNtNER4P94TCCSK4lPepZM=;
        b=PHJcSeqP6eG+Zm7YXqJrOy90nhS5o0HEmG56uDmOGfwlRwg3Mz/ISW5lCVIszpPujW
         yTReu46BNTPcKneon0lMA311tsLLwMxbXF2uehsCcaS66tsE6E2v7ovVMo/EdVPJmxNd
         e3no7jeMX5pBg/ELNrRczoVw1b5m8j6tc6lCRkLR7iF8m2ZdmpifpbdPK6pCN5mDHQib
         JhZ4Z8uFXfT5VzI7tET5NVmwrCPRLWaYbYQpCOj39z9dEEkwVF8Ze0NAm/zPKUVzl7k9
         jxgxYpbipLXMt39+N3eXp2VgV5/AiiAKtyh8X7NjYS25g4Zq7Y4OJOZXznyceH37O6Tw
         UkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4/eZsaa1GOWp5cdUxQQd2rNtNER4P94TCCSK4lPepZM=;
        b=pcydJHG2Xznk5HYQb1pD1hJ3Llw/vwyX8hY05fwsYgwfzvpRZgEBIMK9uArOKoV08i
         3BzJTu3p/CYxkgDpT9ozJ3EOuQEGwj4dec3XJ+ne1TjveWjHytYe38yWcwKUOJ486EwP
         xXSO+JrRRF55CCXKqClIVaWfwOlc1XRQ2hKsOWN+0Jxd11Y2+Y2R0LmrGtP1/CemviOn
         OyZbIqhni32/xM9e51p2D9BgViWyM4OG+qNMqE3q9Ty/su7/u8+PsyKcGJd4NyQdXXWQ
         j4m6iHq5/KDyegv1KO+sp6T5jVuYK1VMemCZt35Q56+rRWWnqssaZq4De8YRAdzF60Ac
         nRtg==
X-Gm-Message-State: APzg51CwtNeIavPyFkkxObI7gOtC+y2iaWXUen2S8S6Rn3sCvNsLc6LN
        1f/fEz8xac7F999y4DiOk4s6BQ==
X-Google-Smtp-Source: ANB0VdY/rToDOeHgntKyFxteKSVNC7i4lsCbzm0T0c65GpkF0SyIDNbKlpy/akg8XpdUV5kVevA8aw==
X-Received: by 2002:a19:ed06:: with SMTP id y6-v6mr3450249lfy.65.1537708101992;
        Sun, 23 Sep 2018 06:08:21 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id d190-v6sm3215614lfg.19.2018.09.23.06.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Sep 2018 06:08:20 -0700 (PDT)
Date:   Sun, 23 Sep 2018 06:06:32 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org
Subject: Re: [GIT PULL] soc/fsl drivers updates for next(v4.20)
Message-ID: <20180923130632.uhcjl347goqxeutd@localhost>
References: <20180920170634.32046-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920170634.32046-1-leoyang.li@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 12:06:34PM -0500, Li Yang wrote:
> Hi arm-soc maintainers,
> 
> Please merge the following updates for soc/fsl drivers.
> 
> Regards,
> Leo
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-for-next-4.20
> 
> for you to fetch changes up to afa86d264a7ce62ba214bc7c6012e2129141421e:
> 
>   soc: fsl: dpio: remove redundant pointer 'priv' (2018-08-30 12:19:02 -0500)
> 
> ----------------------------------------------------------------
> soc/fsl for next

Hi,

My feedback here is the same as for the fixes pull request; please provide
another level of detail of what is in the pull request.

(Not merged, please respin with new tag description).

Thanks!


-Olof

