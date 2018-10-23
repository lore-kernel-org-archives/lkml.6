Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB06FC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0089520665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 00:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0089520665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJWJEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:04:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37614 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeJWJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:04:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id d14-v6so48670230qto.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 17:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qm9U1qcDP4vP5l9gETRzMvMs29Du15m4jHZVnFwtdNc=;
        b=Dg1L14lZ/JURoEpu+PwKGUyAuIeJJVQbmxAR8o3eLX/JUj6cPVfSXjNpVzMeugeTYK
         4cPazGxvDc3JyMtfGkb55Rem0IpbB5q8UsjI7fBEV3DlKzdBAB0I6+fg2S+aiW3JROVV
         L30+BSuFNaD6LAJFJmUp3XCJOMpj14G1cZWraWbiA60TRwSE47UZn769cldrqnAuLaqv
         brzVa3FaATsfwFK9hCE6gD9fU9bnTb62nbX+LBiFyLtCtw/lFFmY9dNPhzVPIxSYBoOn
         ReWaWPLkEK/leIp8tOWWXPdTtnd5ojAgZiZZC/9/ajmc85Y9j4OgTnfp5snPsvKRIa4e
         sUww==
X-Gm-Message-State: AGRZ1gI6Ilg570FfcZCYoiy7tW3Zjg2LGepOIz2C17nJZ2pL0jgXaKb6
        rkwYym6XkBfWQ2DnQmAPWGQ=
X-Google-Smtp-Source: AJdET5eOtZPkWbo0JBc7fHD9F2HYO1Qs7126q6BA6+LuxskpwKEeBlrJc8200Xrj06pfPo+gw9gK/w==
X-Received: by 2002:a0c:f6d2:: with SMTP id d18mr12175799qvo.203.1540255433952;
        Mon, 22 Oct 2018 17:43:53 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id 83sm2951619qkz.73.2018.10.22.17.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 17:43:53 -0700 (PDT)
Subject: Re: [PATCH] Revert "workqueue: re-add lockdep dependencies for
 flushing"
To:     Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Tejun Heo <tj@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme @ lists . infradead . org" 
        <linux-nvme@lists.infradead.org>
References: <20181022151818.135163-1-bvanassche@acm.org>
 <13901aed5074f4b1fbd259d03928efb6ab40c65a.camel@sipsolutions.net>
 <1540244870.128590.39.camel@acm.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <63ae9bac-3587-bded-ea98-e43fb4d7240d@grimberg.me>
Date:   Mon, 22 Oct 2018 17:43:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540244870.128590.39.camel@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> I must also say that I'm disappointed you'd try to do things this way.
>> I'd be (have been?) willing to actually help you understand the problem
>> and add the annotations, but rather than answer my question ("where do I
>> find the right git tree"!) you just send a revert patch.
> 
> Sorry that I had not yet provided that information. You should have
> received this information through another e-mail thread. See also
> http://lists.infradead.org/pipermail/linux-nvme/2018-October/020493.html.
> 
>> To do that, you have to understand what recursion is valid (I'm guessing
>> there's some sort of layering involved), and I'm far from understanding
>> anything about the code that triggered this report.
> 
> I don't think there is any kind of recursion involved in the NVMe code
> that triggered the lockdep complaint. Sagi, please correct me if I got this
> wrong.

I commented on the original thread. I'm not sure it qualifies as a
recursion, but in that use-case, when priv->handler_mutex is taken
it is possible that other priv->handler_mutex instances are taken but
are guaranteed not to belong to that priv...
