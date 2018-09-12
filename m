Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFD0C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6810204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk1KV8rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6810204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbeILVAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:00:41 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43212 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbeILVAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:00:40 -0400
Received: by mail-yb1-f193.google.com with SMTP id k5-v6so1816664ybo.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 08:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KH5ZCL3wnlUMY5VuHnYFv1Wn4bWglgdoVqOV+C8wHE4=;
        b=Kk1KV8rjfv9RmVjvZk8OQQ2FXwsW9SzQ7XHPk1Bjtv2367LHo+aIawuqNRn69shbLn
         HsS1GmjEze2FMpaszybSYC3k7yVdKui3o6KcQtF9G18672i8ibOpE3TSjQlitq0qLLmc
         UibATcafVuafHxcXy4qhTOaYDkpXEJY3ZzDubgOQhaFY8rBmgFITBQyWxcMXhAoQj9Jn
         YlFRf8LGgJVv9DJeI7EPn6q97rCfQEgGU154F5ZAVq83R2AzK9udttCeTUU33jOUouBy
         NLpsE2W45Y3dxXe9OaRjtD4SH4/Xczdat78rHrWXzQIEQCeTnNW8PSm5QR3b/8u5Bw8F
         uZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KH5ZCL3wnlUMY5VuHnYFv1Wn4bWglgdoVqOV+C8wHE4=;
        b=pBgHoyjkp0lsJoxxw8LBEFNGM1YHAo/0O0LOGIETg4du5GdHN8gTP2erzAkmE8mSSH
         x7ssJIvHF0cm5shkQ8tIdwniI/NLxttsUqMZ96MbD+06xx9zazFgLjn9Nkx1v2a7WQt2
         zTDvDtzEq1MA33hYz6H1Wi+bnDJJrFYI64vbtgqZKiXmtY/DIR2/xH61CjeC7od5vZtk
         qSWxIf9Qi8q1ag6FRKFTDd6mTOdu7urLj3f20azxkrS6iIhYvCtgWMDw9dBKcV9gA3Qh
         LipKLUAMdbe+4eg2kvs7ZWAfq74hvVqKmcilQt08Fvj0hJg/GKbyh4zLk+mbsZVCdVsK
         cuww==
X-Gm-Message-State: APzg51BMbkVYxB2XxdJ61NpF0/o/QHDAZrmoMy94tYrOKi2j8UFKIS1S
        ikkZuoI/dGVyQ0ou8eM4PkQ=
X-Google-Smtp-Source: ANB0VdbGCTAmHF0kDO9qjFNzw0HONJ6PChE2B51ZLGYt6SoNtSx1YtUQ115hVqEi0+VThuEYFXoXMA==
X-Received: by 2002:a25:d6c8:: with SMTP id n191-v6mr1300126ybg.150.1536767732702;
        Wed, 12 Sep 2018 08:55:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:6304])
        by smtp.gmail.com with ESMTPSA id n2-v6sm867842ywd.64.2018.09.12.08.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 08:55:31 -0700 (PDT)
Date:   Wed, 12 Sep 2018 08:55:30 -0700
From:   Tejun Heo <tj@kernel.org>
To:     liusong@tom.com
Cc:     jiangshanlai@gmail.com, liu.song11@zte.com.cn,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: combine judgments in the loop of
 maybe_create_worker
Message-ID: <20180912155530.GF2966370@devbig004.ftw2.facebook.com>
References: <20180912135829.3832-1-liusong@tom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912135829.3832-1-liusong@tom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 09:58:29PM +0800, liusong@tom.com wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> Although the 'need_to_create_worker' has been determined to be
> true before entering the function. However, adjusting the order
> of judgment can combine two judgments in the loop. Also improve
> the matching between logical operations and function naming.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>

idk, this doesn't really improve anything.

Thanks.

-- 
tejun
