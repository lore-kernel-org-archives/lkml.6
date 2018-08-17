Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4C2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3E7218AA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0jVjA6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3E7218AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeHQMlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:41:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45968 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeHQMlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:41:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so3343074pgq.12;
        Fri, 17 Aug 2018 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H9L7Ga/f0YTFteWWNGapiXmc6oZkzD80coKBloq1BMM=;
        b=Q0jVjA6MZB68gsBNxcnx3LZ2MIw8Yio5t2/TuiiTOVjirZo9f2fMFw7awLOPpG7ZTx
         yKUyc0Q+iJ6zHeAjwmq5C14a2I3uf+Cf1XbmObeZKOJE5aD6jljFu0x45UArOBT1QdLs
         CjUGg2oH6mjbbuPOvwkxfuHVotcAxFmdUExGOdVZVHeE8SZmZMJuUS1LPzokaZEmhztV
         HdGawJSOMVtP4T6tLOyH2ig3Wj4mg555fdqbT0rvVYbudiVIjD1rrdF3p+ZTypUzTld0
         Jm12Fwo1f8/NuaCN/SQa+XuzCYoFeYC+XrFTRz/7OHKb1bI8Xq235OsIMbLni6pbMfjN
         oqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H9L7Ga/f0YTFteWWNGapiXmc6oZkzD80coKBloq1BMM=;
        b=k3yjjYAwlisaYKDZBGm3p5c9gD43nIqJJYCQFjfGTMHPNFo3JAeH1bWZQQjebuacNP
         h5r986ex/ni7OlZAme/jya0byry8e4lyL9m5MZmpi00PGS7+N3BEpnu4fonDIFJusjff
         BOKD+zDrqqYWRxcV5+LfHveR0xCGpqUkcpQpi2ZsBv/TpTedeYK0PiOXHGCmnGGLQbBS
         K4O1vrEp87YvMx0EgoNY2WifOiqWM5lwN1zzYvWPKUodFGik90pJ6R/bFAV1NwXiNqWP
         8lmMq3NPUMXZqwTzleN2fu6DMaZj6M4vl4/8h4EQCb3bhdtzCRBI2RP25vvV9we7SF7X
         TwsQ==
X-Gm-Message-State: AOUpUlHKd6u4KaXcKtd5KQRrBj1x0D9IRqGjh8LgkI2QlsNkdHYwk7H/
        V8DeZQ64MNJ/9ghAzZyWEbw=
X-Google-Smtp-Source: AA+uWPyuh/P51q6YZy6+YQxGWODXsk4lk5hSHuCJDFNkbQf1gtwUb4fgzk+iSGh+oNsfiT0Ugo5G7Q==
X-Received: by 2002:a63:28c1:: with SMTP id o184-v6mr32009852pgo.225.1534498712817;
        Fri, 17 Aug 2018 02:38:32 -0700 (PDT)
Received: from localhost ([39.7.55.28])
        by smtp.gmail.com with ESMTPSA id u71-v6sm2330349pfk.174.2018.08.17.02.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 02:38:31 -0700 (PDT)
Date:   Fri, 17 Aug 2018 18:38:28 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>,
        Al Stone <ahs3@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        x86@kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] console: Add console=auto option
Message-ID: <20180817093828.GA10337@jagdpanzerIV>
References: <728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com>
 <20180816173902.18971-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816173902.18971-1-prarit@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/16/18 13:39), Prarit Bhargava wrote:
>
> +		auto	[X86] Enable ACPI SPCR console
			^^^^
			And arm64?


Any chance we can rename param to "spcr" or something more clear?
To explicitly state what exactly it's going to do. `auto' sounds
too general and doesn't tell me that much. I'm probably the only
here who can't see a connection between "auto" and "SPCR", but
still.

One more thing, as far as I can tell, acpi_parse_spcr() can fail
and return an error. arch_console_setup() hides all errors and
returns void. Should it return error code?

	int arch_console_setup(void)
	{
		return acpi_parse_spcr(false, true);
	}

Or maybe

	void arch_console_setup(void)
	{
		if (acpi_parse_spcr(false, true))
			pr_err(.........);
	}

There can be other consoles in the system, logging an error is not
such a useless thing.

	-ss
