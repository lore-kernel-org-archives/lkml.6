Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B77FC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AC720811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTjG9tpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51AC720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeLLFEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:04:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46970 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbeLLFEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:04:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so8253752pfe.13;
        Tue, 11 Dec 2018 21:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AZkcxCL3eo/u3eWNKY17NVrQBiummIjTchhD+nXK+uQ=;
        b=QTjG9tpwSzrgH2Y7NBZYTBjiOeMjqxsB+qr3w26kCeprv9/aNMOQasF/dwM2eexyFo
         7Z6Un5MvsOiACy8BkaG52FzaL1f7I1Vc3zPHzQLgzF8OBDWIrAzIbODZcw1zK++5Xf7u
         UHe7WwfEoSpZyEhW2Lx0s4A+utJ2lqh/CvQVxHq/i/R3vatOEjiUuVGviP7/aOxSbpSW
         HwfsHMC4x6WQb4LjidRDzT1uxdp8ZsoEntEUwoPN1SgBX0gb2w6XqZ49jxdChJVVGFVi
         I/tYWbsQxK10OmUZyQM0T2I4RTX/QL0bOIDcrBPMzq6LNyqrPisyxRDUTdwlibnsUOKi
         35AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AZkcxCL3eo/u3eWNKY17NVrQBiummIjTchhD+nXK+uQ=;
        b=A5uer70s8YxPNvAkMKQ5dIPdug3Qb/+fAsKGx8WVmfpHFKjWhlsmZPmRdaqpP9tG+L
         KIpZThlXq8mOC/x+wV+uGcjlC1q+ds0zNcmwSulwnRRYUN/dsMzIIssxsfzPI3ZUaA+U
         qA0mwyU41HubrQrDngEKyk4pSoD0qER7cp61cHhcWvyGSyDi5TwEh2ey+CamzS2jpKue
         S6V7gAb9nDiWb9NS+LZZSRY80aLs2Y5vFFCx57uY4+KmN4pHhqcvIbGWSxrRTO9TvKxR
         /s56mMocK9T6UqUuyRXKgTtkZoXjA6zpt2f2XMaUoBVY0ZqPDHakiwQ1MxZdgmbzrrCc
         owCQ==
X-Gm-Message-State: AA+aEWb9xd8j/RN1+bSqRs/UF43TNdyDpIuaF5WvHr8tgF4ThnsISxQE
        fr9b2UYXwFrSDrJy2gEiFKQ=
X-Google-Smtp-Source: AFSGD/V3byIKQY6BMKaHpLtydiPE5qF8OQuVwVp2N/J1+titrzHDUUYw4QSb/pmELhLhxh1wkjzXUQ==
X-Received: by 2002:aa7:824f:: with SMTP id e15mr17890621pfn.192.1544591076557;
        Tue, 11 Dec 2018 21:04:36 -0800 (PST)
Received: from localhost ([211.246.69.141])
        by smtp.gmail.com with ESMTPSA id z191sm18529510pgd.74.2018.12.11.21.04.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 21:04:35 -0800 (PST)
Date:   Wed, 12 Dec 2018 14:04:32 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        kernel test robot <rong.a.chen@intel.com>, lkp@01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [LKP] [tty] c96cf923a9:
 WARNING:possible_circular_locking_dependency_detected
Message-ID: <20181212050432.GE431@jagdpanzerIV>
References: <20181211091154.GL23332@shao2-debian>
 <b8a5b151-9eaa-b098-f24f-b17c1886f456@suse.cz>
 <2780774e-b397-dcc2-6950-cccb527d5014@arista.com>
 <20181212034252.GD431@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212034252.GD431@jagdpanzerIV>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/12/18 12:42), Sergey Senozhatsky wrote:
[..]
> > >> [   87.255156]        CPU0                    CPU1
> > >> [   87.255813]        ----                    ----
> > >> [   87.256460]   lock(&port_lock_key);
> > >> [   87.256973]                                lock(console_owner);
> > >> [   87.257829]                                lock(&port_lock_key);
> > >> [   87.258680]   lock(&obj_hash[i].lock);
> 
> So it's like
> 
> 	CPU0					CPU1
> 
> 	uart_shutdown()				db->lock
> 	 uart_port->lock			 debug_print_object()
> 	  free_page()				  printk
> 	   debug_check_no_obj_freed		   uart_port->lock
> 	    db->lock
> 
> 
> In this particular case we probably can just move free_page()
> out of uart_port lock scope. Note that free_page()->MM can printk()
> on its own.
> 
[..]
> 
> [1] https://lore.kernel.org/lkml/1542653726-5655-8-git-send-email-longman@redhat.com/T/#u

That said, I'd first try Waiman's patch. The one I suggested is
more of a defense move - there are too many things happening under
uart_port->lock. This is not the first time we see lockdep complaining
about the way uart and the rest of the kernel interact.

	-ss
