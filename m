Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A76FC282CB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DFF20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549645317;
	bh=q0p6GEaYBcd2UnK6cT76MmxaTdMXFTv+jOt2DhSmaUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K9avr4eMDGZriEe9aygLJV8BttlSfELJUWnCO+tVjw3XArR2zvE3nJUEXmmIaXr6Q
	 Bplsoj7Br3WOMQ/17ScwOhpzxT9MFyg0dbUumaRMwO2GPS98kNexsBUWtqFjd+W+Zu
	 w3I4ETTLwPuciP+neS9U9PzFMPJGuemwMuJ5Xa5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfBHRB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:01:56 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39348 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfBHRBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:01:54 -0500
Received: by mail-yw1-f65.google.com with SMTP id k188so1635721ywa.6;
        Fri, 08 Feb 2019 09:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lGI1b90+7lYWM0s1T2HpYMGvNcMnNrIxPnTv5GxwsM0=;
        b=UnMSSAZs66S/hfxO2XxunZCkHAq9/NUTbbj0q0AstJWVPZpkrnzRPLLpJRZyCIaitQ
         hL0BGhJYbYq+YWRogwHcT4OtEqwpqp4O+I3hqv6Qjq1/v9Ev2TKznNsID5jKWBqKgG3+
         hN9zcXfnjvvs44MEqF6K6UM/9bJzhV3iXU9ciFGfxJlfdCwHvlizb3rV+DWZ85ACAVE5
         +VF0dQrwY97aVKZZKRgwBqXNitGraHoHiFAarjjPMx3pQsesVuaCJl2i7enmKaQ6vcbi
         WtU0CBB6fTJ77qULESA3x9T6O8wkBDmMlLUfgNDqlm8UOzCDhVntFqTXG/UNdNbUPhgM
         P9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lGI1b90+7lYWM0s1T2HpYMGvNcMnNrIxPnTv5GxwsM0=;
        b=oHcFrQU7PPnRCjSH/f+6P/xrBHHPmcyuINd3IRs/uP1XB72FtCx29KzUchQNI6Iqyh
         VA8VhO2Pif43YMyoit9p6c6W3//I2tHX2rMMBbXyHLn2642T/0q5DfRhrCphN5IkuVhD
         fV8exdHxlNLYf2JWsS+OzS3lJOi20AQkneS4WcrANdEl9/eE2LO7mbNmyLhmIBlfHoGC
         ZBLaOSN+419/MdfFkfR+fMUqbECCQroD2OXuXvEkbPBudN8mQ2W3mhR6kkxz635qhhfk
         c4/15ptFV/FiYRNMSn6DKWfPKJQx3duJTYaYD9ucIYAb++l6LUb4ordNkc8VNV3RC5qV
         DpYg==
X-Gm-Message-State: AHQUAuadWHTwfh+hQW0atBqF+PjPIMtc/f8jvZrqUve8NmtXqxy+U5Hx
        RIat6gXZnJfZvybv4RBXkfE=
X-Google-Smtp-Source: AHgI3Iax8sTODIL6T3+AtZiR40B2SQJJEl3dnxIHEWpYT3nL/O8yWPmaEkaNNWWzfVzkJ6oAoGiLXw==
X-Received: by 2002:a0d:d857:: with SMTP id a84mr10627970ywe.121.1549645313605;
        Fri, 08 Feb 2019 09:01:53 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:1597])
        by smtp.gmail.com with ESMTPSA id n2sm922139ywe.37.2019.02.08.09.01.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:01:52 -0800 (PST)
Date:   Fri, 8 Feb 2019 09:01:50 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: cgroup-v2: eliminate markup warnings
Message-ID: <20190208170150.GK50184@devbig004.ftw2.facebook.com>
References: <7ba0d6eb-8f45-7f4d-4e84-53dab1158da4@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ba0d6eb-8f45-7f4d-4e84-53dab1158da4@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:59:00PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix markup warnings in cgroup-v2.rst:
> 
> Documentation/admin-guide/cgroup-v2.rst:1509: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/admin-guide/cgroup-v2.rst:1511: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/admin-guide/cgroup-v2.rst:1512: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: cgroups@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org

Applied to cgroup/for-5.0.

Thanks.

-- 
tejun
