Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB7AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2502188D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 15:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hg9ZuM9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2502188D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeHQS4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:56:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40544 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbeHQS4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:56:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id e19-v6so4789321edq.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 08:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OZVJ+vPzxbHVtuhnyulB8hPgwDbv1APmX+tC8fAnvC8=;
        b=hg9ZuM9NZeiifbN0dZTHx380Kf14/7E1k+2IFwLtxtbOyDFBmP16s5EzCqBH82aKEF
         jCV28VZZxTgcIG5SflonlXAzMqn8MI+q/FGzJK1phJfHpd4d3hs6ZB98BeYhUP4j4dNb
         NGie/+SYgM6zE8knBA+9Fc4yONtb7XlhcujBUZmK+dOAAjNuXHUtTZSQZlzh5oKGWaNp
         D6qwIntRUI8qPYvqEcdPsKeQK4Bb2WzOlvM+YWed6y2tVJbYjl9qWPfEq0EpQyQ+Rsdx
         lo72W1mvGZm1iJeS2Cxq/v7vggNVztrISTU09BDYTONoS5+8qBjqJ6JI4SWRQTcI7tO/
         KswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OZVJ+vPzxbHVtuhnyulB8hPgwDbv1APmX+tC8fAnvC8=;
        b=aJq+fFD3hlOry4X/M5HWjBVyaLmpKvu6vAtGe23xPzUi/TP0jzAxGPWO7XweCvpU79
         Fy4FrWrepg/7wbay9CQFRhH76ZAVX77cFtx0vOdxQfByUkRn0K0BHfT/wDMvMoEGSz4N
         LOkgW+0wL04TgCR5VDh4ds02BRyVomv2FAHImMWuh09GAjKScn728mPuY679owGbV5rK
         DqgXPCXRJ666fYQL5zflQ7FvgQIeDbIAgX5WunvA7BHmds1dD6BKTLDaSz67gTCLrWCS
         2heNWzrBiNmY3rRJh2MO87y3G1lwJpjSkpw8UD8KXexU65BV4UA2Z4GK7h+nQkWXv4B/
         gxtQ==
X-Gm-Message-State: AOUpUlG6cYcvIOCV9d6axUaF2pOTCrc9AgAt9lxVD0FbKYc/4BBWGfpA
        7p+qSMwTIwHudhJno/fzWpQDH6G39KeNp1xZm18=
X-Google-Smtp-Source: AA+uWPy7xwR5z3XWEQQIDaLsj2rTpBOA2JlikZuI9qmCnl2+06SzSs0eRejhhpqpoVpEfzafTtTwsuMvWbfQNpoG18Y=
X-Received: by 2002:a50:aa43:: with SMTP id p3-v6mr43441039edc.233.1534521141293;
 Fri, 17 Aug 2018 08:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <1534477355-14060-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1534477355-14060-1-git-send-email-zhongjiang@huawei.com>
From:   Robin Holt <robinmholt@gmail.com>
Date:   Fri, 17 Aug 2018 10:52:09 -0500
Message-ID: <CAPp3RGpGY-hvprrfx32WX=PBtDB4Pk4JZ5cLmEK-7EGzR_H9uQ@mail.gmail.com>
Subject: Re: [PATCH] misc: remove meaningless null check before kfree
To:     zhongjiang@huawei.com
Cc:     Cliff Whickman <cpw@sgi.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 10:55 PM zhong jiang <zhongjiang@huawei.com> wrote:
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Acked-by: Robin Holt <robinmholt@gmail.com>
