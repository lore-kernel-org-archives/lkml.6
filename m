Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3A0C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E92220870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gmSIJzLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E92220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeKUBdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:33:05 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40585 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeKUBdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:33:05 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so288840qtf.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 07:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V2SReyjo/A1i6qq3fxh0RcWHQzbmtFQGa1kzHYEdoWg=;
        b=gmSIJzLLUDjugo2xbAz4QcYensCmcHEtrjyoQc3AnfTfnVwxPAF/6rTmb9k6YqwjvT
         ztCWs6cg2VUQP+e1OG2k5ZMazTlQL7VZvRbiCUg79/KJ6pdCLbF7G9n2vc+6eie+X7b1
         RMaLrLZuy5nlgHZvQsk96kMaLG3KMw3qBLZMq8k3sdaXLQ9KJU5OjUQ+WWs74GftJN1n
         1vYzwqObyr8z8twO26fION+gGGYlJCzC7faMBvPnnf5BLkJfHBk/GoKKU89B/AM1bOdW
         5Xp+6EgfVNXtxL7T6sw8nuo4hlIKjEX3k1pUZ1cMvKLmHldfbDqJH/uWSSJhw9lxw9Z9
         uxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V2SReyjo/A1i6qq3fxh0RcWHQzbmtFQGa1kzHYEdoWg=;
        b=uNOBaCuQiO2VUO6ZRkZGDudCHLxvVVq6K8pmzrKYrmOX3eElMaIXpcRQYqLcpfY6l3
         2NXL4d2X7tiJmeyAn7YVsiKMFAWFO0/jLB/VO8mjyMc/dlJY4aIOKpYD5G+L3lkuXGnq
         TVsEd4rRv3SxNryMFTkN+h5fpV+OreXr5K3qzeTKk9SBigFIqPLfeQr3NYEcKXSOvVl+
         i1wEgnhn6VPFJo5aEsjee3H4Eo4nrZvo8kAxbClBsLwfmqyoWIUnEd2m2evQpNQkiAwh
         qaR/dBHSsZ8YVWI8KdXyJ/hlfRi6oh6zOJDGlsvMiAVbPsZSKq+dJkKRf7R2K9nPtzIE
         X82g==
X-Gm-Message-State: AA+aEWZVEuJHaazi8doyI1292kaPporaQNxmuS0fr5wiDNnWj0sQglQH
        /ERWf0QJ558j+UpY9XXCJL55OA==
X-Google-Smtp-Source: AFSGD/WKYuWOPa/rqoD+KZwGDq+Me10wsYpsKQySf+DS4XLWegd9QAoZw+fkI1VCvbHREiC5GTWM9w==
X-Received: by 2002:ad4:510f:: with SMTP id g15mr2258884qvp.46.1542726209870;
        Tue, 20 Nov 2018 07:03:29 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id q21sm25852954qtk.79.2018.11.20.07.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 07:03:28 -0800 (PST)
Date:   Tue, 20 Nov 2018 15:03:27 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        rppt@linux.vnet.ibm.com, Michal Hocko <mhocko@suse.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        andrew.murray@arm.com, james.morse@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] arm64: Early boot time stamps
Message-ID: <20181120150327.kc5bbkfecmfwbgzn@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <20181119214443.25175-1-pasha.tatashin@soleen.com>
 <20181119214443.25175-2-pasha.tatashin@soleen.com>
 <d66a60d9-6772-a951-9da4-c07443b48aad@arm.com>
 <CA+CK2bAKcdZRRMwhcQ0QnBJ3_6bg=zhaeM7v74f+QFwkw9h17A@mail.gmail.com>
 <01ae5979-9bcd-dd59-adda-efbf69f388ca@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ae5979-9bcd-dd59-adda-efbf69f388ca@arm.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-20 14:55:23, Marc Zyngier wrote:
> > Yeah, I saw 56 is used in arm_arch_timer.c, but I could not find where
> > this minimum is defined in aarch64 specs. I will change it to 56.
> 
> See D10.1.2 (The system counter) in the ARM ARM[1], which says:
> 
> <quote>
> The Generic Timer provides a system counter with the following
> specification:
> Width	At least 56 bits wide.
> 	The value returned by any 64-bit read of the counter is
> 	zero-extended to 64 bits.
> </quote>
> 
> This is not AArch64-specific though, and 32bit systems implementing the
> generic timers have the exact same requirements.

Thank you, makes sense. I was thinking there could be AArch64 specific
minimum limit.

> 
> > I will send v2 soon.
> 
> Please wait a bit and give others a chance to review this too.

I already sent, but will wait in the future before sending v3.

> 
> Thanks,
> 
> 	M.
> 
> [1] https://static.docs.arm.com/ddi0487/da/DDI0487D_a_armv8_arm.pdf
> -- 
> Jazz is not dead. It just smells funny...
