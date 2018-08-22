Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D4FC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB6921486
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uVzCADEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB6921486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeHVS5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:57:36 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:45842 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729024AbeHVS5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:57:35 -0400
Received: by mail-yw1-f48.google.com with SMTP id p206-v6so784567ywg.12;
        Wed, 22 Aug 2018 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S7jqSq6FlSfYhFE1ODOsxoMWl0vj3raCZZ6tfe0zbvw=;
        b=uVzCADEa2UjyaUEWmMyT35e9KwvYkhZA/o03t0Wn0lxML/ynp1u2/J+UABbznYcWU6
         ULu94Clv3mF7h308SfG+KmXgizC1Pl1As/U/q5sH48lz7vesudbMxN1nPj5YG9l2QQba
         hdLID/SyO4FrbEIBQNhqa0r4feNDcbrkHZk1qXf4MYiaORnNolcuJdrytqJY5N+dg2q1
         SDhRia1uYMqqA++tLIXxuVw72DsHmWfGpjFZxleG3n4zaZUT4dhxtW9ZOPPwB07Ea8FB
         2gzmI8ZfDcMfSeNisTUKycnTlFZu6EnnkjD9v9N/tmWiS/kKHkhPtWRRzr+Spy5I48O0
         eQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=S7jqSq6FlSfYhFE1ODOsxoMWl0vj3raCZZ6tfe0zbvw=;
        b=l2Bi7c+OF10ADtOvtsiKbVmPwQU1lSRuuO04MSOrxNmqyaP50mm343z18ictR3ZrqG
         Ok4cVN8n9ML3QABrJcda/xWuFNPhaC6HdIh2algOTd9lDPXoJapAk1mNI7csZcwu0WLf
         VyPsduVCovv8W3iIWb8pQbbiHywLL/wW60bn9C2IGRMRjHaAYBZY8IP2j88L+e3D6APh
         2FykqDLTcHfsCYBZXh7LJip/tvSJKU9gUh132AlRTihElFIpJIjscOA+sK+nQ0YHw/nq
         2hde9jPu4u+IAKEmLqoSDsx+UEoS4ROYx+MvJFawhKZYxhmi1KCOU7Ynf06xwjyOaq0E
         Ccyw==
X-Gm-Message-State: APzg51B6/96psOX6PMYUeALwEV6LAy9bCu5y8I5sxQVPSiCq54MEoyZf
        LMkFBKNJFEt9TuN1ZPH2Y4o=
X-Google-Smtp-Source: ANB0Vdbe7jkfa0nkX+2zrbGIMJVflLtT6BYdHxUailhFSvG7l7xb6HGJzLJKjmoJ59efRgRuz1F5zA==
X-Received: by 2002:a81:6c8a:: with SMTP id h132-v6mr283370ywc.219.1534951933090;
        Wed, 22 Aug 2018 08:32:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1dc9])
        by smtp.gmail.com with ESMTPSA id l21-v6sm747862ywb.108.2018.08.22.08.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 08:32:12 -0700 (PDT)
Date:   Wed, 22 Aug 2018 08:32:10 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Byungchul Park <byungchul.park@lge.com>
Subject: Re: [PATCH v2 0/2] workqueue lockdep limitations/bugs
Message-ID: <20180822153210.GV3978217@devbig004.ftw2.facebook.com>
References: <20180822094904.15718-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822094904.15718-1-johannes@sipsolutions.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 11:49:02AM +0200, Johannes Berg wrote:
> This addresses the first two issues.
> 
> The third problem is actually caught when the flush ever does
> anything, but that might be rare depending on the circumstances,
> so I still think it'd be nice to catch it somehow, but right now
> I don't have the time to look into it.

Applied to libata/for-4.19.

Thanks.

-- 
tejun
