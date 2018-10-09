Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A06CECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D835213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dysK2sew"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D835213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbeJJC3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:29:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44042 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeJJC3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:29:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so1266330pgu.11;
        Tue, 09 Oct 2018 12:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qsKKtpEDzzr1zuA87BPcCd+AccOZRrlI3mDMGqWn6eU=;
        b=dysK2sew0aIBhtwdHCmr56XIkcG0eqnDHi/7eE3a1V+JAHhPxf/Q2XNyFF3fO05Uov
         MDB1WzCtp2+J/pzRk7s1wsWGlCKMFC7Rdjd9XYLc8YHheywM+NY/YEmISVAnfXtiF0Sa
         r7FUqnzGk0veAQH2DgqUiA5KU3YaMWLmcT9BvAqzFQ+VK6R2jS+tRqjDlDsQ2DSe7ni2
         xFj2f5Q9v3Khje8y3ETYjjsQRMgHmQjvo2qy01q8zkYMVNZSCWA4RiBiPwrlRN4E7zyN
         fNG0TlPqFO5Qycj3JYhQzm9WP3DiNUQiQlJJ+oN2X69n3Kp8oo/anPkTVMBuCqUduvRn
         ABpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qsKKtpEDzzr1zuA87BPcCd+AccOZRrlI3mDMGqWn6eU=;
        b=O8/X+ZgojKBBiDfKTXB8YZ7wq/mk/gA707/fJ5N0fL1Dl5Vmv5aQRBEHrHZMBcy50n
         Rn9XBifhoLC6tGVIkpFJahEkCnVdscMaIHV8fDeLAhh2RPDdurJ6/r3N/O0ipb/m817Y
         Qw0OJ4CwQhIwrBPpZPfB4ZIJBemgEDjq7fDQhqlJHeBpR57w5OIODJ3u/2zFU5VCYy0H
         Ux/JgrsovvuEQYUMLz8OO5WjPfPm9JyFL0Aq3Q5tmvJOG0a5V7O/RanmUho7CIAyBS3j
         tQxgxOzohnR32DZcUJbdG8Q/CgwF6CtMxtspyygPiu8FFvIrqpnoYmAmY5G7ijT9Ic+Z
         c5Kg==
X-Gm-Message-State: ABuFfojJwQuuFYzFJWav67NoIhFAI+nxwvrgXeSdCC1OUt80PoVi8PMu
        QZzJubhFA5FhFdgnrqI0jV0=
X-Google-Smtp-Source: ACcGV63VfC4ZTw4QkqGlWgbwhAgln+bmVYQtY3/TgxnnUPxlH0ZwhoagLQazmELmt8aTAY7fpl6jzQ==
X-Received: by 2002:a63:4f20:: with SMTP id d32-v6mr25183171pgb.231.1539112276781;
        Tue, 09 Oct 2018 12:11:16 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 74-v6sm33381824pfx.182.2018.10.09.12.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 12:11:16 -0700 (PDT)
Date:   Tue, 9 Oct 2018 12:11:11 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] hwmon: (core) Add trace events to _attr_show/store
 functions
Message-ID: <20181009191111.GA6166@Asurada-Nvidia.nvidia.com>
References: <20181009182602.3085-1-nicoleotsuka@gmail.com>
 <20181009145721.0669e412@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009145721.0669e412@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 02:57:21PM -0400, Steven Rostedt wrote:

> > Trace events are useful for people who collect data from the
> > ftrace output. This patch adds initial trace events for the
> > hwmon core. To call hwmon_attr_base() for aligned attr index
> > numbers, this patch also moves the function upward.
> > 
> > Ftrace outputs:
> >  ...: hwmon_attr_show_string: index=2, attr_name=in2_label, val=VDD_5V
> >  ...: hwmon_attr_show: index=2, attr_name=in2_input, val=5112
> >  ...: hwmon_attr_show: index=2, attr_name=curr2_input, val=440
> > 
> > Note that the _attr_show and _attr_store functions are tied
> > to the _with_info API. So a hwmon driver requiring the trace
> > events feature should use _with_info API to register a hwmon
> > device.
> 
> Hmm, this doesn't really explain why these trace events are needed.
> They look to be attached to sysfs reads. What's the purpose of tracing
> these?

Our power folks analyse Ftrace outputs of cpufreq, thermal and
hwmon (power/voltage/current) so as to get the relationship of
them. The reason why we specifically need trace events is that
it's convenient and timestamped, and because both cpufreq and
thermal already have trace events.

I could add this to make the commit message more convincing if
you'd prefer that.

> > @@ -193,6 +206,7 @@ static ssize_t hwmon_attr_show_string(struct device *dev,
> >  				      char *buf)
> >  {
> >  	struct hwmon_device_attribute *hattr = to_hwmon_attr(devattr);
> > +	enum hwmon_sensor_types type = hattr->type;
> >  	const char *s;
> >  	int ret;
> >  
> > @@ -201,6 +215,9 @@ static ssize_t hwmon_attr_show_string(struct device *dev,
> >  	if (ret < 0)
> >  		return ret;
> >  
> > +	trace_hwmon_attr_show_string(hattr->index + hwmon_attr_base(type),
> 
> Also, the other to tracepoints use hattr->type, here you create a
> separate variable. Is that just to keep within the 80 char limit?

Yes. It looks clearer to me than wrapping the line here, since
complier usually optimize the local variable away.

Thanks
Nicolin
