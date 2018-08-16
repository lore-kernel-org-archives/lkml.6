Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637F6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1432147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sDNYbp0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1432147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeHPWKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:10:20 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:39683 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeHPWKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:10:20 -0400
Received: by mail-it0-f48.google.com with SMTP id g141-v6so8189008ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 12:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kEBHf+Bb2D0ixiOGGLYnhCwkWUrodpCWHMAq+nCzBFg=;
        b=sDNYbp0AIPZb2Ep0lQduxHxOZX5jVYT5VxJxxa4U7UcfNPtmhydUpOGWslLYnzonO2
         fGiZsyY3HmTUlvbf9Z16q13qEGKS4q4bq+Ioyw6acnuo3J196r0nbHzZPKv+GWH+z8DX
         2MTOuPk8xNKBvqEYJqzRT2l0Kb1IFalWfxETTFL1RURf+SwsJk1WBS2vNejvTqpUMI3s
         own/21LZ7Wt1zbs7sbJ6gSHGkSYuvsdLZxluHxdYFme/El1j/XY11N6y5rFoV5AYfDZC
         I1ZgI18FGXSSQVDFPUd1L7QNjaV069HudpybYcA3okQUP5vVKAdPbENeCYfL7doq5l4n
         aDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kEBHf+Bb2D0ixiOGGLYnhCwkWUrodpCWHMAq+nCzBFg=;
        b=gXAPsRYRfEzF+iKlTZyFkdmivmsqhNNfjNZifoLUQyUorPODtyfRZxvzxleFTL3B+L
         1+mnGVEGes4O7FvM+skPvr5l3n6Us/tW25Z0W6z+C2rV6aU4ASW9bL7l+11Mcw7OPKr+
         e16CnFxjLoabVJKOzWXFpl6N1Dqjrzqi3r0TTZ71j9fU2C2mzPFU6eW+1tZqdMBXxLep
         /tE4LgZIfuM3Gj8g3MHCNVi8uh8R17dpW817Mrn7wLxnxsWzGGN2KbEgAxaJQ3RSDokP
         RA545TbwAy3Y3mvSLdh0zZPU1AGnDE2Ur5XMW1eCWpCn/6y2n6bnFTO7+cCbAygKE2Dt
         ZtrQ==
X-Gm-Message-State: AOUpUlFjkkphmdVOy+O/oCSUVf+eGfUrV95+MKeDNx5+AoXEExeciSUB
        AXOKfabCeUS/HN1/N/TtIht5UA==
X-Google-Smtp-Source: AA+uWPzfK5ryscLCFjP7pjQM/ufpAhcbGTQnL5bowVzVG/s+uBVE7Wx6hd/OB8sazkp1V6bviARlnA==
X-Received: by 2002:a02:97a1:: with SMTP id s30-v6mr26774317jaj.89.1534446604526;
        Thu, 16 Aug 2018 12:10:04 -0700 (PDT)
Received: from [192.168.1.212] (107.191.0.158.static.utbb.net. [107.191.0.158])
        by smtp.gmail.com with ESMTPSA id d134-v6sm19926iog.84.2018.08.16.12.10.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 12:10:03 -0700 (PDT)
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 0/4] bfq: two fixes and one improvement
 related to I/O control
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        oleksandr@natalenko.name
References: <20180816165118.17402-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ac17a9b-1c38-0664-15e3-ff75c9671388@kernel.dk>
Date:   Thu, 16 Aug 2018 13:10:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180816165118.17402-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/18 10:51 AM, Paolo Valente wrote:
> Hi Jens,
> 
> while working a little bit on cgroups I/O control, I found two nasty
> bugs in bfq. They break bandwidth control in simple configurations
> with one-process groups. These bugs are fixed by the first two patches
> in this series.
> 
> These fixes improved I/O control so much, that I could reduce the
> write overcharge factor, used by bfq to counter write-induced
> issues. This reduction is performed by the third patch.
> 
> The fourth patch contains a little code improvement I made in a
> function that has to do with I/O control.
> 
> I hope we are still in time for 4.19.

Patches look fine to me. You are in fact several weeks late for 4.19, I
need to have anything that's going in to 4.19 by -rc6 or -rc7 time
(depending on whether we have an -rc8 or not). This is to ensure that it
gets plenty of time in linux-next as well. I've queued up patches this
time (since they were small), but please send them in in due time next
time.

-- 
Jens Axboe

