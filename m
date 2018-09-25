Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BBAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F6F2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="b3bRZtQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F6F2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeIZCZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:25:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33140 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZCZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:25:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id o21-v6so7354517lfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4+MhuJnlI2ZHaWkdQYVryUp3xDbOnjFEnTEicMRvMGY=;
        b=b3bRZtQx1ZCMonLa8+lBvI/sRKu/P54Jpq2jeKhVrchaxPWndYU8yxW3nbjWINhDA0
         4X/cqqdlQ7xEKDApReu4dO7JOQjU18grF8Pf2z5VW1q6l+kMcX5tdPYwVzElQlZ3J0dR
         ilInFOmpVlCj7Fp4rPRSB+pojUS5dmPdFG7CYMmCUSJcFd9UsHkooHgP6S5PFJ0B8/By
         fUxnafSoigQo8bC36zOLsKqDhl1eMPZHj6FE7Md7Zia18dSTlhA9Q0+ZlTHbOAiM/fJB
         KHXlQiwGkeWRy4WIT3atimjUtDf5WttXjChZ0ASzWO3SGm+1XjHeEx4Nc8X/xUaCb3bs
         s+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4+MhuJnlI2ZHaWkdQYVryUp3xDbOnjFEnTEicMRvMGY=;
        b=YkPZ3meOL8hOHDfR/xwLxBjiSl6Umijt8J/qvn0Cet7xBrAMglKXXhUQGwpdoNGHoB
         w0o1GhBhBURb4MJwjUykrFwb7qGSo/C0wTfBbm0GpCLfl0QrwK+VNBlAiWE6uCRlycxS
         bkGUvs9Z5nWm+338d1uaiY4n1x/obpanrGrKlALKLJFLZefNH1cDvBmTFEEaF7scQes3
         oySKZYV9U6l9j12MlscdhHQY0f/5G3DmyVXc5qooRbukgv7qVlFttT20P2Eubz8Ll75L
         r3kMGDLd2g0D2jQ/u2PeuwIxFxUUTLC73jMhAtNA1ByCYguLw5O8aBefTgZTw9gDYQj/
         YXrw==
X-Gm-Message-State: ABuFfohdMiCbYAtV2ho6ymtfk2RfbGmIcN9MNPxUYoJ1cTBXqwvcN0Bf
        7Uef2hNeJ12XmhEcQAsHOC4gfw==
X-Google-Smtp-Source: ACcGV60X9JtCx6MEVKa4xPFjB0864/PpQ4iP2gxCKxY9CxZa3Fy8+T3WhpVs5/riSl2wBROOEc0jiQ==
X-Received: by 2002:a19:3855:: with SMTP id d21-v6mr2030131lfj.148.1537906557150;
        Tue, 25 Sep 2018 13:15:57 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.se.alltele.net. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id s140-v6sm595636lfs.91.2018.09.25.13.15.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 13:15:55 -0700 (PDT)
Date:   Tue, 25 Sep 2018 12:29:47 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>
Cc:     arm@kernel.org, linux-arm-kernel@lists.infradead.org,
        khilman@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [GIT_PULL] SOC: driver updates for v4.20
Message-ID: <20180925192947.735kcmaywe5umjab@localhost>
References: <1537818662-6307-1-git-send-email-santosh.shilimkar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537818662-6307-1-git-send-email-santosh.shilimkar@oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 12:51:02PM -0700, Santosh Shilimkar wrote:
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_4.20
> 
> for you to fetch changes up to 7bcfe20d0d8b647879629798fa57e39905d6cded:
> 
>   soc: ti: fix spelling mistake "instace" -> "instance" (2018-09-24 12:43:21 -0700)
> 
> ----------------------------------------------------------------
> soc: driver soc update for v4.20
> 
>   - Enable host-id as an optional dt property
>   - Fix minor typo in knav driver

Merged, thanks!


-Olof
