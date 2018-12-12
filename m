Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911CDC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549F22084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYGUPno1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549F22084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeLLNUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:20:11 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42998 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeLLNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:20:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so8331306pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 05:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FhNVRGmXGeyCuX974tZRGvjTmr5a0jpLT2+F+XVzwwU=;
        b=NYGUPno1sx96WnE0TndHI/ejUkEgh6VslJA6zF+tFsoobPQupPLZx09ep2zigYoK8x
         KI0zjXuEoqrssK1fCFPSzgqpUHatmBVT6MRxKNhvgpFBRGnC+pLj5FGAI+n54YNKP91a
         bJH700pdXdIb4hf42YJC1P8E121oaC2qTJmx0aHqYvk4Bv9TOtlL1Ux5OsNu5alfP9/y
         o1aCE3AnPkWNW6FguqZum4m9tgqtx13bHZNpFkzwWZLjfn948GeLyizFpqHmqEioiVhR
         tIK0gScIb6jTZ6+PubcFgFl9ohpP0/obq3N/nDVa0p9PTYdDDXcBR0ZCIO+bHbUWApza
         tT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FhNVRGmXGeyCuX974tZRGvjTmr5a0jpLT2+F+XVzwwU=;
        b=r5bd9mkHsj0wlqo3P6aStLfcKA4kEZNCheR67uBI/ffYCOEAEgZly+3F5W275gJDiS
         RmefgZPY2szCDx6MWs0DsJ1K50ADzcyhJ6pK7RBh4m9BCJi11dBtgou6rwOTWiL3gNkK
         GVhZ6rOk+r6u9IF4zChlaPi6xUZfrNnAfGDUTSpR749Iwi0R09tqwaEy7xPy46bzD67C
         BxSdVRJ2cp8JDTgeed75LayIng93PJ70qLT9OFc0UXk3skcbWCHTzNqnv2po53b035I5
         hqKZl1fNVOcnvUC6P3cy9RDvqf77Z3U546n9cGflI5dd8BzYjFcy7goDJ6K65Cdl0tv9
         Qa4Q==
X-Gm-Message-State: AA+aEWYlwYh/I+m8ryVWquo9JsqoM/8mevtHpYOlhRN8TDiD1KGlxOgd
        UgcNCMyWjqLydwgNKqtM3Cg=
X-Google-Smtp-Source: AFSGD/WRmeC4GmfGF2ehDwK3RqLpsi+57m3UnpCI6T49AEp6QbHEHQTeloBCe23M8E/jgcEoQssbcQ==
X-Received: by 2002:a62:f5da:: with SMTP id b87mr20527926pfm.253.1544620810020;
        Wed, 12 Dec 2018 05:20:10 -0800 (PST)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id a15sm22628303pgb.1.2018.12.12.05.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 05:20:09 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Wed, 12 Dec 2018 22:20:04 +0900
To:     Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Remove print_prefix() calls with NULL buffer.
Message-ID: <20181212132004.GB1823@tigerII.localdomain>
References: <1544521745-11925-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181212022029.GA431@jagdpanzerIV>
 <20181212131626.ikmrr4mylw3sgcvc@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212131626.ikmrr4mylw3sgcvc@pathway.suse.cz>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/12/18 14:16), Petr Mladek wrote:
> On Wed 2018-12-12 11:20:29, Sergey Senozhatsky wrote:
> > On (12/11/18 18:49), Tetsuo Handa wrote:
> > > 
> > > We can save lines/size by removing print_prefix() with buf == NULL.
> > > This patch makes no functional change.
> > > 
> > > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > 
> > Looks good to me,
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> 
> Thanks. I have pushed the patch into printk.git, for-4.21 branch.

Thanks.

> > Shouldn't this also have "Suggested-by: Petr Mladek" ?
> 
> I did not add this tag. This idea comes from some other Tetsuo's patch.

Oh, OK. Sorry then, seems I was under wrong impression.

	-ss
