Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3295C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E1520856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 01:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shhAl9lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E1520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeICF6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 01:58:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38813 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725762AbeICF6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 01:58:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id f4-v6so2555290pgq.5;
        Sun, 02 Sep 2018 18:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GZffnLf/qdii9GdgBqkK5zn+qXvrNQ9JivnW1GAX48A=;
        b=shhAl9lhGYY23/MqqEI+7fdavIfiZD/AIt7YJH4LSY4QCRcvzTJ88lbSZdYUzKiIaO
         bovQzrFgUXpJMsQnCLbVsIElP3KjK5eqwNeiTQ97/sleFBfN/Hz9B5xfbSM+gbjSp4g3
         BTnD5E0Cg20EjfGkslKYyfw3c/ygacJLPVuy+XO+etLBG54KVmFDENLs1N2I2gggYnmO
         nQLUIP5tsK2/fy8y4HJDk3kqafFcVmQDOzEnR64p61dMo340/cUI1WsZFdbqcQcFZLUy
         glBwktgr6dS2q+L8Re46hhqCzPAfdMzbUTW0OQOtUcBGiwP8rnEKF7aV86dfSeH/SX/s
         v8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GZffnLf/qdii9GdgBqkK5zn+qXvrNQ9JivnW1GAX48A=;
        b=AFPIIhg+0SbLc7kQYlVbAZcoo9c+5im8c3cvMHRJ9PargANCnTactqEymosGHIBA9J
         SvZBX3kPHp2WEpUGH2GSBD1IBNtSO1SIz90KtVaZJyr5U1Yd98+vKGfh1trQoG34Ur23
         QBvIQEAS2Pp2IBmigiEncroGT2AJt90BXSyzNP5TmkqWUP7T76UJZa+BK+nccMeU0HQk
         ZHipO/OnoiYNrJH3/zOilXntOKJi7yLJlCOaubH51kl47KXAHq6oeCjiGn/vVuvHemDa
         GZfypmqxizrXtzz0dv+0Ru9dbUJtX+928oSftvc+TfuZ4PiJK/Fwi2aBALatamCjkrja
         i5JA==
X-Gm-Message-State: APzg51ANlLNU08VK6zbisRE9bAExcJoPyHBdeo49T8JzD1VBZ7Y22X0U
        OHJIMuJm5xva3pReJ8wxzbyEkZyE
X-Google-Smtp-Source: ANB0VdYpY2dfDyfkhhuebHSD2VFygUOWR/K5nT9FszWr2AOKdWzoNsZvxqQyuRcHkT2fT+c/EFm26g==
X-Received: by 2002:a63:1a1a:: with SMTP id a26-v6mr24133819pga.449.1535938813059;
        Sun, 02 Sep 2018 18:40:13 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.58? ([2402:f000:1:1501:200:5efe:a66f:473a])
        by smtp.gmail.com with ESMTPSA id 82-v6sm26219523pfw.159.2018.09.02.18.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 18:40:12 -0700 (PDT)
Subject: Re: [PATCH] isdn: mISDN: tei: Fix a sleep-in-atomic-context bug in
 create_teimgr()
To:     isdn@linux-pingi.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180901120019.31664-1-baijiaju1990@gmail.com>
 <3ecd32b2-81e5-038e-edc9-fd06d6e21851@linux-pingi.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <c7562383-8255-31f4-8f91-057011172b65@gmail.com>
Date:   Mon, 3 Sep 2018 09:40:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <3ecd32b2-81e5-038e-edc9-fd06d6e21851@linux-pingi.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/3 0:31, isdn@linux-pingi.de wrote:
> Hi,
>
> I do not understand the analysis and do not see that the spinlock is a
> problem here.
> I think your DSAC analyzer assumes that the FUNC_PTR mgr_ctrl call calls
> the  mgr_ctrl in tei.c, but in real it calls l2->ch.ctrl() which is the
> function in layer2.c, not tei.c. And the function in layer2.c should not
> do any GFP_KERNEL allocation.
>
> Same for your 2. reported issue.

Okay, thanks for your reply.
My analysis handles the function pointer using the function type and 
structure field, but it cannot distinguish the different variables of 
the same type and field now.
I will try to improve my tool, thanks for your explanation.


Best wishes,
Jia-Ju Bai
