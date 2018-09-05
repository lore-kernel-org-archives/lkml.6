Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34069C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B462073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 05:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpHato6E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1B462073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeIEKUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:20:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39833 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeIEKUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:20:34 -0400
Received: by mail-pl1-f195.google.com with SMTP id w14-v6so2755468plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 22:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zl5XT3Zfky5DLn3mHUlyU2tt5MxBWBc0hzFccCi+gd0=;
        b=PpHato6Ecn/PJt0f6QrkgicylwbmYht0s9WnFygPm65ZIsG5+GJ7tfu3VN27OOoEek
         1ombqCiIK1NbMnZodoVEhZaQLxVP658FGFXNqA0oNkeKxs5QHkmeF+JylaFrsjC7N9KG
         AuED/RvzQdYjtWKMoYat2xovSCnoBrUN+PC84y0PhFPN4dTQFCISHVvL2P1J/d1sb2KL
         OzBYuufNNjDBHdDIofk7D/6PiFbY3swXMatF4PFqg7BJ2e3jxp1HzBBOUEAJpyL/sFr/
         B+cpXPzrFZ5Mo+cKNjTqG131ToJA7lI9aAM+VAFLU6aiKQwBJ2CEleOZM9QMMH9DUXwz
         9jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zl5XT3Zfky5DLn3mHUlyU2tt5MxBWBc0hzFccCi+gd0=;
        b=VHF7urv7Ddtke9aM114jFfTpgrxC1H51FAGAk3mvbLsG3XKGkim4Y/OZMoVk+dbx0v
         y7/1PdU3+jo4lrOWx2D5Dv2Qzaw3lHSq9tkb1o1V5X6iEsMQw+KKAPv2QtBmjMcsFRCD
         jJya3iKT7VJ/e5XgDPz+tLRVSqNoc6lSvzqdnp5g7AQ0iMHrxAa/cOYBLz3oEzZ6UVKt
         SNmf7+/GTV/eZzFpfdCpcsHi70WVNyiBqLYQeHLG7Px820ukJMWlpykBgBfJ6eI7sEXV
         G0OVh0w0Z3it3oDilnSSqv6zTwSFQ1No04goiaPeUiG0HA9YpY/PoWdOSSkZxZEU0XrD
         KRqg==
X-Gm-Message-State: APzg51BFRd0H0VCYRw2syv3bgrwF/iTxITku5mqOp1yEDak+h/XocN4o
        Tqaj9a4OifaNGrh74T71R1M=
X-Google-Smtp-Source: ANB0Vdb6gMUQl3xhqvgNit4u61UctCG1e0sENj9PnbujLdC/Kfl0PFSLkYxTX3vPclUE+jfgGIQXgQ==
X-Received: by 2002:a17:902:b7c5:: with SMTP id v5-v6mr37737790plz.49.1536126724338;
        Tue, 04 Sep 2018 22:52:04 -0700 (PDT)
Received: from localhost ([175.223.19.100])
        by smtp.gmail.com with ESMTPSA id o10-v6sm864837pgp.70.2018.09.04.22.52.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 22:52:02 -0700 (PDT)
Date:   Wed, 5 Sep 2018 14:51:59 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 4.19 regression fix] printk: For early boot messages
 check loglevel when flushing the buffer
Message-ID: <20180905055159.GB19936@jagdpanzerIV>
References: <20180904180154.845-1-hdegoede@redhat.com>
 <20180905023522.GA1444@jagdpanzerIV>
 <93901f2b-91ad-a910-7031-0040b827a3af@redhat.com>
 <20180905053609.GA19936@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905053609.GA19936@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/05/18 14:36), Sergey Senozhatsky wrote:
> 
> OK, thanks for the report!
> So I think that your case is CON_PRINTBUFFER related as well. We have
> a number of logbuf messages before we parse quiet and console_loglevel.
> Those messages pass the suppress_message() test. Then when we finally
> register a CON_PRINTBUFFER console we update console_loglevel and flush
> all logbuf messages, but console_loglevel does not matter anymore.
> 

Hmm, earlycon can also be affected, probably. But I'm not sure if people
do "earlycon" and "quiet" at the same time. May be, who knows...

	-ss
