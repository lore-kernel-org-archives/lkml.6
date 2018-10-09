Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0416BC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF78213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI7VhdEf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF78213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeJJDQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:16:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38078 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbeJJDQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:16:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id f29-v6so1391087pff.5;
        Tue, 09 Oct 2018 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wWKx37wYU4LVDZA+4X+AtrKHDcXb930FLuWwsSEzHPY=;
        b=TI7VhdEftYH4IfOPl2BnIZdRrTAUf1UGWDynO7NdaXIshCk1ai3KCLIoHr4nrHtk3B
         64td5hCTwJX8bfl15XKwXQPnBTmLOL5xsothnbizKGuIx1847xe8Vw73dyiDJKUHqhau
         uqh9MO5EuXjEIXI1oMfClElCi6XphLCAj20WLXD0zFWzkollQDQ1kdiXhZqn9zsHdP/P
         iIC6FdHLSItumOBbVTOA3xg5RE4ebXE2wl0dr/1fbNFj1PfJ/E+kn/nWBuZaCxB3HpLS
         R2vKx6hfgew/uqQ8kI2LflQ8oFYOJu4ZVq0vqcMOV+5fe0DCW0Ex+7UrkGHcpuLeMEKi
         RR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wWKx37wYU4LVDZA+4X+AtrKHDcXb930FLuWwsSEzHPY=;
        b=cxT/Euwspid2H5jHdlMpR0sWiH3d8xr8EmTpLl9mGwckd8CadqKLtXFE8DfbwwljnG
         TkWC5NbuE8M3J2BzQfEwi39loN9SQIa6e7xUeWWCjat4dLAdyj2iFP2dt/Iu6KycIhGu
         1DKDgWM3hmwDH4aEadsxRuno853CPmWok+eiU6fMjfyfahR27ovE+AX/euuWs2/AU6vW
         4Mv0srtGivgwGqY6l4/H+TZOYm2FQKIQ9R5F0z2bNn/6Ag1d/7Wzn38y2bhjl1SdTlog
         mEm16B0SJYdlKKVgJIycRLQ3CVQu4LUcgnpmu6ezAWjMIgIEIcfoMGaUPvH858FNcOck
         E7hA==
X-Gm-Message-State: ABuFfohWwJ4QlnOl9DqagfttdfGgV+UgyJHdMt65So2esGHk+C+lhIMW
        459btILA+abHNo7re3HfEVA=
X-Google-Smtp-Source: ACcGV62UwAaX3jdlAdElgf4Ng6bUWjHWZzV2HuITEnvh0dazPK8idKwLbgedbPOdIVhCIdxIN8qI2A==
X-Received: by 2002:a63:5059:: with SMTP id q25-v6mr26742499pgl.171.1539115078280;
        Tue, 09 Oct 2018 12:57:58 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id z70-v6sm26135384pgd.64.2018.10.09.12.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 12:57:57 -0700 (PDT)
Date:   Tue, 9 Oct 2018 12:57:43 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] hwmon: (core) Add trace events to _attr_show/store
 functions
Message-ID: <20181009195654.GA7963@Asurada-Nvidia.nvidia.com>
References: <20181009182602.3085-1-nicoleotsuka@gmail.com>
 <20181009145721.0669e412@gandalf.local.home>
 <20181009191111.GA6166@Asurada-Nvidia.nvidia.com>
 <20181009154945.65300231@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009154945.65300231@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 03:49:45PM -0400, Steven Rostedt wrote:
> > > > Trace events are useful for people who collect data from the
> > > > ftrace output. This patch adds initial trace events for the
> > > > hwmon core. To call hwmon_attr_base() for aligned attr index
> > > > numbers, this patch also moves the function upward.
> > > > 
> > > > Ftrace outputs:
> > > >  ...: hwmon_attr_show_string: index=2, attr_name=in2_label, val=VDD_5V
> > > >  ...: hwmon_attr_show: index=2, attr_name=in2_input, val=5112
> > > >  ...: hwmon_attr_show: index=2, attr_name=curr2_input, val=440
> > > > 
> > > > Note that the _attr_show and _attr_store functions are tied
> > > > to the _with_info API. So a hwmon driver requiring the trace
> > > > events feature should use _with_info API to register a hwmon
> > > > device.  
> > > 
> > > Hmm, this doesn't really explain why these trace events are needed.
> > > They look to be attached to sysfs reads. What's the purpose of tracing
> > > these?  
> > 
> > Our power folks analyse Ftrace outputs of cpufreq, thermal and
> > hwmon (power/voltage/current) so as to get the relationship of
> > them. The reason why we specifically need trace events is that
> > it's convenient and timestamped, and because both cpufreq and
> > thermal already have trace events.
> > 
> > I could add this to make the commit message more convincing if
> > you'd prefer that.
> 
> I'm not against the patch, but yes, having this in the change log is
> helpful.

I will add it in v2.

> > > > @@ -193,6 +206,7 @@ static ssize_t hwmon_attr_show_string(struct device *dev,
> > > >  				      char *buf)
> > > >  {
> > > >  	struct hwmon_device_attribute *hattr = to_hwmon_attr(devattr);
> > > > +	enum hwmon_sensor_types type = hattr->type;
> > > >  	const char *s;
> > > >  	int ret;
> > > >  
> > > > @@ -201,6 +215,9 @@ static ssize_t hwmon_attr_show_string(struct device *dev,
> > > >  	if (ret < 0)
> > > >  		return ret;
> > > >  
> > > > +	trace_hwmon_attr_show_string(hattr->index + hwmon_attr_base(type),  
> > > 
> > > Also, the other to tracepoints use hattr->type, here you create a
> > > separate variable. Is that just to keep within the 80 char limit?  
> > 
> > Yes. It looks clearer to me than wrapping the line here, since
> > complier usually optimize the local variable away.
> 
> Or you can just break the 80 character limit ;-)

Personally a checkpatch warning bugs me more than having an extra
line :)

Thank you
Nicolin
