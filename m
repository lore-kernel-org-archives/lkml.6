Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFC7C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCBA2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esQfTih5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCBA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbeLKI0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:26:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45498 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbeLKI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:26:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so6764318pfd.12;
        Tue, 11 Dec 2018 00:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eJBLnyNKtUuuMCGGejqDPXyDoSLW/oj0vqEYccG14H4=;
        b=esQfTih5iOTm7DAWM1wUjfjOjQkWveIGMYJv3waxCs3axbLUqvHLCQvuWqWAWqhLqz
         GULjcBzH+cJiGxIQfBD4UaY5IJJPraGUBw5ePPnnStqt9n+54At8FGthT6Cq0i+ubhc3
         zNL8nsaJvfvcYMUDBYiLkRW1vxU2PzlGh4mc+P6TGVdO23RTgxLrwGF1Omfe99dpbUth
         re43+44PME23l8ILz3uQO9Vm3YYDCc6o6CI8XAL43ii/O6oqVK7ixsJdunLE5Ypb0Bhh
         O4HGZPIoJO7b5qDOcpJNp263EUi66fdh8yUp6fCsqNU5u4tn5qsEGYz7PadcHeSZqx/c
         pdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eJBLnyNKtUuuMCGGejqDPXyDoSLW/oj0vqEYccG14H4=;
        b=FXnmAM02Ih7PKkwR5voR3FPL7J9A8c/A6Oe06RL1UoTUWMlD6F+6LkZUSBJ0YYshe9
         lZaIpS/hxqfMeFxzQAxjSgPa75DW/YbhMUOqKM5uBS3Hdlbi0BXu4+yhy4zDzXRQwhnR
         jvP0qVcfGzyzRa8UkHR5D+B1velylZ0Jk4uGVZw6fm58d7l+tTCGczFSLP08NrBtmrUE
         Yi9WzywpPUMmnseWYV6FSuVEEZel5t2cM58cLjKuVjM2xppEERcUN30jegtNpAXiicQO
         DmMI/f60tqHFlIijdV4thruo3GyTaqx8r6jXKnT+txwRj5xDz2zFty0mOvhBrTdl14ON
         wycw==
X-Gm-Message-State: AA+aEWY8rvIGKMh3X4zXqCRmW8v5HeYRqJRRMMIGBReeQa3s7B6yFXxM
        OTKWitI6EAt2d+pWxJ78hUg=
X-Google-Smtp-Source: AFSGD/VxhnfDxAijC26jKSjVza3O5X4/QiBxZPo0cF9gR5bIR+cUbEjZuwDYi7F96+69NvF+v3I2bA==
X-Received: by 2002:a63:5f95:: with SMTP id t143mr13979496pgb.395.1544516780617;
        Tue, 11 Dec 2018 00:26:20 -0800 (PST)
Received: from localhost ([175.223.2.144])
        by smtp.gmail.com with ESMTPSA id b10sm26452146pfj.183.2018.12.11.00.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 00:26:19 -0800 (PST)
Date:   Tue, 11 Dec 2018 17:26:16 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        akpm@linux-foundation.org, bp@suse.de, keescook@chromium.org,
        mm-commits@vger.kernel.org, sergey.senozhatsky@gmail.com,
        stable@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: + panic-avoid-the-extra-noise-dmesg.patch added to -mm tree
Message-ID: <20181211082616.GC521@jagdpanzerIV>
References: <20181205025728.GC503@jagdpanzerIV>
 <20181205052912.GA423@jagdpanzerIV>
 <20181205080044.GA11190@jagdpanzerIV>
 <20181205154620.4dqtledc2duhrp2c@shbuild888>
 <20181206035825.jz2bfh3errj23rjq@shbuild888>
 <20181207095004.GB3729@jagdpanzerIV>
 <20181210094554.z5n7dmkrnlcpygg4@shbuild888>
 <20181210155705.qowbi7xvszzfonzk@pathway.suse.cz>
 <20181211080743.GB521@jagdpanzerIV>
 <20181211082221.3wovowe6tql5o3s4@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211082221.3wovowe6tql5o3s4@pathway.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/11/18 09:22), Petr Mladek wrote:
> I suggested to clear the panic_blinking (or whatever name) in
> __handle_sysrq(). The idea is that sysrq needs manual intervention.
> It allows to see the original message before it gets overridden
> by a potential sysrq-related output.

Ah, indeed. Sounds good.

> It assumes that sysrq is the only interesting operation when
> printk() might be useful at this state.

Agreed. Makes sense.

	-ss
