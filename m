Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B850C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AB72085B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CByO1qA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AB72085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJJEZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:25:41 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:39943 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbeJJEZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:25:41 -0400
Received: by mail-pg1-f173.google.com with SMTP id n31-v6so1414177pgm.7;
        Tue, 09 Oct 2018 14:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+oY8B+wJAsR8I75440Bd80CXzr6NL2AmnS1SnMGzn5s=;
        b=CByO1qA+ioE2mQlGDRv2ufs43EeOC6Q6rOLYP+yNqzh/25Sb2JCiwJb/fPGeaeBX4f
         1Y3BC+BVyINi1QOJphhr3yGe0Dp3GswlNkE3NbPjV1cmCmesF75BEeACMgFxqQxI6Vs8
         OIXLI/d7/KQo+YxEp0QlbkT7BEhLQCIlxwiGFXlvRt7VmImHRdMNK369KEUvW+jzD4Z5
         bKb5KB/09rQcSZonJDqQSQdWRW1n4xdT6k9BV4s4E6IE2l+oFqZIhG1nBsJlh7xzjPV+
         19bNLflFjMw7z0ZGpRzK3Ishh8ip2T1Z067RnZT4GGekpy0eXhBiG/6PUJ3Ly0ruqC/J
         CWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+oY8B+wJAsR8I75440Bd80CXzr6NL2AmnS1SnMGzn5s=;
        b=Y9YQ/f3Ui+u2I34ys2YqtQet3xllXR8Yml3LeaVdAVV4/hoRruO33J1h8/3dlTDPS0
         SB4dOV8XIGd7fNpfj2MUIQF7FIsQRTU5YKCVzKoPlyKUeSWf6xQYBxNMyf++sS+/VttV
         VaAL9MvWq/tZ2+ScvXDnGqTOTrXQ3XmUFlQc9B1yh5VylkmgJtsVE4Tref9rZTyqmkXX
         uK99x6E5pRppYJqeaYt1W38DmYUyIhfAMh7cEo7GlnMK839CIS0uGAcR4/OJMlgIMYfS
         8usPWp3TI8K6mTRfetABQTOoTtIWzE8dkTVDE1nju70iFzFgB+25JYL9WS7sXtuombGm
         eL8w==
X-Gm-Message-State: ABuFfoiq499jOBijMlzWwbXd0R9fvwVQaygyNdGt0zcoJ1oaV0uWVv1j
        gYbKjVg6324K5TGoudcOncY=
X-Google-Smtp-Source: ACcGV61bN5X1gktqiUPXm8DH+bmyjpb/TMER/47o+D2zhcKepPEAQG6JrEuiqAF87VPz68CVke1PMg==
X-Received: by 2002:a63:ee43:: with SMTP id n3-v6mr25797338pgk.234.1539119212165;
        Tue, 09 Oct 2018 14:06:52 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m11-v6sm24678214pgn.39.2018.10.09.14.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 14:06:51 -0700 (PDT)
Date:   Tue, 9 Oct 2018 14:06:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.18 000/168] 4.18.13-stable review
Message-ID: <20181009210650.GD12203@roeck-us.net>
References: <20181008175620.043587728@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 08:29:40PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.13 release.
> There are 168 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Oct 10 17:55:44 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 321 pass: 321 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
