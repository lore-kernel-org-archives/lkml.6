Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47B6C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D032064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544027133;
	bh=4ClGsp8WnsogEKzs3xB6e2jPJ+9STJqrdodFLuWR6GQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RGuyN129bq45oZh7ZxTV4yb02ckkPEj85AYWqWFpg0G33s255czxgxcO36QU1c0GB
	 XppgvL4iTFOSpX/i5Gx3vATVpjuBKBMp9ns7EJXXcfeB+iYsIFnR0mzqBcvTk2K/XI
	 pQ6+Iv0iYr5cbI5eYULwGKDGQ38AqfV87wcS3WoY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D032064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbeLEQZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:25:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33201 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbeLEQZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:25:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so12153332wmh.0;
        Wed, 05 Dec 2018 08:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AwYqTPYHnLdK9kRadGDxAqkyA5Ng1JOQ6haKegZgC+Y=;
        b=mk/Z7M1ZVqMP0nuklmHPA84YoEmZU4wiB5TjjVtyLXqxQ3dx4WOCVPNCX38BR83ILI
         pxoJIkNBm8mAK/9x8t0tje6Kq96/dSdEgokgB3CEyby9UikSBVSEZQxJ1fjb9WVRxYHm
         eZxYQLOBB2eFZoPKmMeZttmOF61DTCd5kZEGll+4hmC1be8BI+pWj31dh+3t9s7UHp4o
         FpVS5OXlmA3o+8PqasJqX2FLsSxbfW6BtXD0+qG8yNIDUCJUH+DHyNQgzr+PhN3dXHkv
         LJfFrdOd7xpEHriCHjWc1+tHqemJZS/ucuMl0EmCZaByMKFOKOSPOZ7r7HZQ/t+89IfG
         Pl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AwYqTPYHnLdK9kRadGDxAqkyA5Ng1JOQ6haKegZgC+Y=;
        b=C6TsZqOUAgw21QTdth0Q9shDwXUdPwfA99qcL0HdS5WuTschk4DCytdBaGT0LsTKrT
         Vy8+N4QDaxEdrPIQwOFuvpnpIuWO9H/GCc6GnaGRYxfMXdjzoFzHjFcuQibNgSZKYc7H
         9RkpGhG/dN1I9TOIt9/EFgK+1LbSz+u/q2GpiaPR38u0x4gtYv6Lgq0eug5IGJYPEB5h
         6dYnU6ZxWLT2Zt693RFlPK9RlEgJYL0cYrfn7AQnxvRb4BXo7aBpqPAmk+ZKwQFXNfrV
         2o1+yRYZAJomw0G8Pc+cXbm5SvSZ125JSDpZNU8ppkqVogkcyd6PkvBzaFl4tQ9Eo7j2
         ikoA==
X-Gm-Message-State: AA+aEWbvYxNu/995LY8wL3W02JZouoxYD7wTAZD65HGMAVJ27Q6Fheb8
        gAlJhZKCAvUOSRYlEL7c7uQ=
X-Google-Smtp-Source: AFSGD/U+eLmONk5yzPcdXw6FOJRhPozT0cVEr2JLuIsH9PJmTt01vLa3Myo8VEuUPXcQKNPf0aC7tw==
X-Received: by 2002:a1c:6508:: with SMTP id z8mr16796779wmb.28.1544027129122;
        Wed, 05 Dec 2018 08:25:29 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j8sm18601630wmd.0.2018.12.05.08.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 08:25:28 -0800 (PST)
Date:   Wed, 5 Dec 2018 17:25:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Banman <andrew.banman@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yi Wang <wang.yi59@zte.com.cn>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] x86/kernel: Fix more -Wmissing-prototypes warnings
Message-ID: <20181205162526.GB109259@gmail.com>
References: <20181205101131.28996-1-bp@alien8.de>
 <20181205224906.824483ea3c5d1d5b7712c99a@kernel.org>
 <20181205142448.GH29510@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205142448.GH29510@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> On Wed, Dec 05, 2018 at 10:49:06PM +0900, Masami Hiramatsu wrote:
> > I would like to put this prototype inside arch/x86/kernel/kprobes/core.c,
> > since that is locally used.
> 
> Done.

Also, preferably the prototype should be eliminated via proper ordering 
of functions from lower level to higher levels.

On the rest:

Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
