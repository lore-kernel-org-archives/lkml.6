Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB82AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A7F20871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYPaveeT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A7F20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753893AbeFTGeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:34:46 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33249 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbeFTGee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:34:34 -0400
Received: by mail-pl0-f68.google.com with SMTP id 6-v6so1203574plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 23:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fhMYWj7f6ty2qgF5VCBMsHhx9/p594MpeZRWWrCbdiM=;
        b=PYPaveeTuBI7++mJQFzQriJRtFJsFRQbqiBXl0jggrK5FysRWd5xsYY7QC2MBnNCCj
         hJRh2WKi/BImvKNEx0JGOEKHC2o9e4VtDvPKakAb62+K7RUq3yIQ5zSS7mxzIz50IL5H
         PpuqzkLz7Vb8DH88S2EP5Oc4+Fwxs2dCG0x5wXxtxU7EFJ7IPm6B73Sv/R0tH4VelsP5
         M6mquENrnii7zytK5/B73URFp0MGWv822XWyQ7GnlepG81ogMs1VFkeZnfeQSkgwWH+n
         hQG15vwG0YkSLVvZGbuieiL1QkhDNbTuF6sfevC6iEcvxhPIKlQbLUvSq41lMJr44i32
         J3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fhMYWj7f6ty2qgF5VCBMsHhx9/p594MpeZRWWrCbdiM=;
        b=WGtPXGS+qvIfRVJ4sRfuIIqsdnwW/m2ZjmQc+IRL7ZoRiE9ZwqEsL7uhDCJp5xIOLf
         S0rn4E3ZP04GbXMspIwJrklYy5IZrYZmGy+gswLqrCKBZbRjaIraISJdLS7Rigp8GGbW
         OHYRrq0YmgTd90TBIiAyMhEgRC0U+h5rMozr+eT3Q5nHznw19A7QyNbMtvtSOvEQIy6Z
         wyqpNtb1CpWEZvF6//brsIRpfFQmnIw/r4PWvCkOk2kcJ6FomFTFOUvwH/potYwPOLhT
         juy2Q/QizlvXpoDaOAuu6/Rx0uAsKZGhxHDfvsuSH8SrY584+j5msDX6BS/3edmf0XNz
         Dk5Q==
X-Gm-Message-State: APt69E2q0+J/+3uwm8j2lBFqtw+QsisTgjFVpZMoeAXMMZxsWN4gX3hQ
        Me60ONEDdOdn1a9GRlvbyY4=
X-Google-Smtp-Source: ADUXVKJRGItVBMxvaY8iLlgfesVwXCCrscbhgSvGZy5xbxTZk7u+apMWqwa2l4tg396YuvWhssb7og==
X-Received: by 2002:a17:902:301:: with SMTP id 1-v6mr22116850pld.127.1529476474584;
        Tue, 19 Jun 2018 23:34:34 -0700 (PDT)
Received: from localhost ([110.70.59.159])
        by smtp.gmail.com with ESMTPSA id i17-v6sm2454878pfj.95.2018.06.19.23.34.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 23:34:33 -0700 (PDT)
Date:   Wed, 20 Jun 2018 15:34:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Make CONSOLE_LOGLEVEL_QUIET configurable
Message-ID: <20180620063430.GA749@jagdpanzerIV>
References: <20180619115726.3098-1-hdegoede@redhat.com>
 <20180619093102.5ad9164d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619093102.5ad9164d@gandalf.local.home>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/18 09:31), Steven Rostedt wrote:
> > The goal of passing the "quiet" option to the kernel is for the kernel
> > to be quiet unless something really is wrong.
> > 
> > Sofar passing quiet has been (mostly) equivalent to passing
> > loglevel=4 on the kernel commandline. Which means to show any messages
> > with a level of KERN_ERR or higher severity on the console.
> > 
> > In practice this often does not result in a quiet boot though, since
> > there are many false-positive or otherwise harmless error messages printed,
> > defeating the purpose of the quiet option. Esp. the ACPICA code is really
> > bad wrt this, but there are plenty of others too.
> > 
> > This commit makes CONSOLE_LOGLEVEL_QUIET configurable.
> > 
> > This for example will allow distros which want quiet to really mean quiet
> > to set CONSOLE_LOGLEVEL_QUIET so that only messages with a higher severity
> > then KERN_ERR (CRIT, ALERT, EMERG) get printed, avoiding an endless game
> > of whack-a-mole silencing harmless error messages.
> > 
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Looks OK to me

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
