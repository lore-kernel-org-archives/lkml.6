Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFEDC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F30320833
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCEA7QoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F30320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeIZAsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:48:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32874 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIZAsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:48:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id l19-v6so8259368ljb.0;
        Tue, 25 Sep 2018 11:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9gjsbWy8viaUdrt5D75hpJqxS2wAmj/8yUFyJb6Z28M=;
        b=gCEA7QoFKwN1P4RF471/n42XJ2OmoIIRtiJ8eWp9IP7c0yD7L90WdVI2S4Rz69EHs6
         bYvvxL1HH0ItBVJfkJaRCLyVrdGHQG8wwwjNelBifeabZXcw1WSIxD4jr0t9y5s9/QPn
         fQXCbUSdD3C1fhhl+VoYtKS6w5oPWorcbI9ULN8BWDjO0J0bkkMMqziLvwBmpKEsFfFu
         mT1ev/pWYUyVWv+f5bp7VhbQnmYqe2kk2PuuKeVHVczvp36FucK4VrrcZ6qt5km6c3hb
         pCczCrM6seWYiIYIq/tx1lYK5pxecihPN3O3AEGDk5XF3JPMlUhlQIXsSM+wye4EGqRF
         qdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9gjsbWy8viaUdrt5D75hpJqxS2wAmj/8yUFyJb6Z28M=;
        b=N1Ki0uBAKUEq6Vvi7PiEQAk67ujkuFR6IK+QpRMHIibo/P/JtPbUkZCFgm3H4CH0R5
         3q9WBV7P30O/sjANO4zwicTZwRxUq47SlZvWtywEZFMUGXUQ7hVaaSIa4IPg/7dGKPrP
         LYu+722vkR0iHNRMhR9fOnLTOe5/L1m/BQh0GEGkV8k7bITAAZ0CRkCmOGa2EaWnrYeG
         68HIVcBLk20pQ6hjnBS9aDuJbxhE2b5IiNYgjXsalwX6iV3KHop33Nhutmwqh8moF1RM
         MWkZuAMllczCV6t/12k9FW1Y20usF/aSV+I/a680Xjzqg5Ia/7X2vTz0ePfiqOvP2S+i
         NYvw==
X-Gm-Message-State: ABuFfogZwnpnCCDiYXubXUQvgM8oefG7ud2htLc+v0GhiuM6Eg8LIeWg
        e2ol6lKLPJ9l8ISHdTYaBLqkgQtwr90=
X-Google-Smtp-Source: ACcGV63kLspjrW7v/6mjqOJAwG1SHOF1iwshf7SiyscQtwKzq0b9hxH9cSD9cSMboOrKRAnIuNy55w==
X-Received: by 2002:a2e:3e0d:: with SMTP id l13-v6mr1781943lja.151.1537900794813;
        Tue, 25 Sep 2018 11:39:54 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id 3-v6sm539524ljs.69.2018.09.25.11.39.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 11:39:53 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 8E6A746067E; Tue, 25 Sep 2018 21:39:53 +0300 (MSK)
Date:   Tue, 25 Sep 2018 21:39:53 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Tong Zhang <ztong@vt.edu>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, wenbo.s@samsung.com
Subject: Re: Leaking path for set_task_comm
Message-ID: <20180925183953.GI15710@uranus>
References: <F7DFF547-5267-4EF3-8BF3-70DAF6C2A53A@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F7DFF547-5267-4EF3-8BF3-70DAF6C2A53A@vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 01:27:08PM -0400, Tong Zhang wrote:
> Kernel Version: 4.18.5
> 
> Problem Description:
> 
> When using prctl(PR_SET_NAME) to set the thread name, it is checked by security_task_prctl.
> 
> We discovered a leaking path that can also use method implemented in 
> fs/proc/base.c:1526 comm_write(), to do similar thing without asking LSM’s decision.

I don't understand how it is a problem. Could you please explain?
procfs/comm is created with S_IRUGO|S_IWUSR permissions. So
prctl and procfs are simply different interfaces.
