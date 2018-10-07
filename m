Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87747C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DAE20882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 17:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYt1r9lX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DAE20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbeJHArZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 20:47:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36393 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeJHArY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 20:47:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id f18-v6so6804919pgv.3;
        Sun, 07 Oct 2018 10:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OawaDZisjOyZJbCSyg5eREGwupP4lSS2MDmvQkkf5kA=;
        b=LYt1r9lXV4pbw7BFZ0x08cZyPLMOUl4dOqFmuS/tc9VWRsXr8ysK0v8tm9wJ9z7LbU
         xusUOZFzqY1uekN8FY58g33bGG1uoliGIkT8X+LCP1TAx5Fr+J6f4DLSX9vXbSTQ89sl
         lw/6ejub7taz4QfwZz2S5YBiQTeabiH6UoksS0GKB/MWDZUdsVJeCXtkvj/37USHb1rH
         d/O/oVMjqmMolxxpAPHqn4dXIiCUGq+wYL0AOxm243NNZ8hN1WU2CvCQrzM3p5wpvIq1
         l5CHLejZIiy/i72+T7AidcIhsoiZsVTSzgGgXoqFW3rCshVlMqGGbETqLJxHutjKWz2v
         fbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OawaDZisjOyZJbCSyg5eREGwupP4lSS2MDmvQkkf5kA=;
        b=Z+q2pcWiwHRomsRxq+lH0KIwADhS6asdEm5k1+D4cd3cI9W7b+7Ee8k2ci8tuomjL0
         ItWhZNjwLj/+uzArIf2aztB4vNN1963KfFtywY3nebOMLi1hEQZKgsqd1BY+lGu2whB2
         ABWiMq2LCAkeImlBsejR445sCppyMDJ0PKkpJuZzbjWgn0NqyIh8LXz+0V2wjX7AxsN/
         KsGMtyPlJktiLpTitFLyyMHG20+j/DMVop1rjfGIxtZ5PiAxQrDuEbKEEGmLOYfL3Joe
         x8vUMxUVWYxkv0ZG5sDfWm8s1M04yq54kYWIi7MivIH1ya6dUQlT2DEtfyOokxwa8he1
         sD6g==
X-Gm-Message-State: ABuFfogLaEwDaMEn0Q8fVdu7gjs8Bbwh29iVvppBIumI0dMJXEn5bZi2
        oarbRlUPOWf3fCDjOWkBBvBkmRrz
X-Google-Smtp-Source: ACcGV61jDnOJaFpyjq2ChObYaxB7DezhugwWbdQUZCn225LTF6Mitmj15qx+mCQxsMxr8WVyDW64LQ==
X-Received: by 2002:a62:51c6:: with SMTP id f189-v6mr21532794pfb.7.1538933964507;
        Sun, 07 Oct 2018 10:39:24 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id h6-v6sm12328066pfc.6.2018.10.07.10.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 10:39:23 -0700 (PDT)
Subject: Re: [PATCH v2 net-next] inet: do not set backlog if listen fails
To:     Yafang Shao <laoar.shao@gmail.com>, edumazet@google.com,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1538919405-3093-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <0652963b-90ac-06a7-3a35-50a307465cf9@gmail.com>
Date:   Sun, 7 Oct 2018 10:39:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538919405-3093-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/2018 06:36 AM, Yafang Shao wrote:
> We don't need to set the backlog if listen fails.
> The sk_max_ack_backlog will be set in the caller inet_listen() and
> dccp_listen_start() if inet_csk_listen_start() return without error.
> So just remove this line to avoid this unnecessary operation.
> 
> Regarding sk_ack_backlog, we have to set it before a TCP/DCCP socket is
> ready to accept new flows to avoid race, because dccp and tcp have lockless
> listeners
>

Really could you not add irrelevant stuff in the changelog ?

This patch simply removes one redundant setting, you do not have to explain
about dccp/tcp being lockless and that sk_ack_backlog is not touched by this patch.

Also the title is misleading, since we will still set the backlog even if the listen
fails.

If you really want sk_max_ack_backlog being not changed if listen() fails,
then I am afraid you will need to submit a different patch.
