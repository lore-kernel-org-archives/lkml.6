Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721F5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D5820851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwqcp6qN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfAQWaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:30:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41782 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfAQWaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:30:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so5512106pfi.8;
        Thu, 17 Jan 2019 14:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Flg9UyWqDfkMw/fLK76ciPXUqMDoI3BxkA0JnI3gY78=;
        b=iwqcp6qNckDpxeGQnZCvsWT4lATx5KeuSr68meF/BpF8H3hAZNNmWvmukTjvaHYtzA
         1gSA2OUm+c4NucjzTAQJh7CNL1meYFuQJF0VDAxesD4LpJ5qMfpBGhpLBVb6jha7sa/m
         QW77jAh7RWvkhF87ydiDbMDLbeClztvaL54pKrFuA+HvqVEdpr9Jm9WWz/ab5zEbo2g+
         N+srYVKGTaYrzAsDjc53dmHgG+XVRFSBNi+jZy0uuIyFX4iHlWgqWtjrxU8YMEqnKNID
         zArgCAJuPX8OsDtwRh3GzFNDzqh8BYdi4IH+6Qd8/9DhMVZ8IRIkaV58dbb0TjqhqKcS
         PVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Flg9UyWqDfkMw/fLK76ciPXUqMDoI3BxkA0JnI3gY78=;
        b=gcPm0YcwCC/s+ZnXPq3788OTMIXU+ZtqmZZjb+iC2YW0b1p4UlKeMhilcOa/TmBwgE
         gKZZjtU02n2Y5r3XdFeF3PM0y3y3SfGQc5DQddAE3cCHZTe9EsZyKsfJM5gObq9JIS9f
         m9kSW154FIdprBHRJo3s24jC/NU3PmeuFNArjSnxjZd3kX+612o4l5NdhypsJS1EuNi9
         PiaJC48XI7kgej7Xf+4FAsgZ0JxBXq6KlCn/tfvCKvJhDfNumH6Awc3nKYATBU9bkU6r
         tDFyxa9/rHZQn5WkZ6+AJ5W/Nu+Mrj9uLJRh8byZFxZJ2Q9tcYmX110XRYTKG6AWrLzF
         CpqA==
X-Gm-Message-State: AJcUukdKvYBtRpWUn1hlnPCj0UrYq0t7TM2hH4XSJY2muMKnT4uQvSiM
        ZkzHGeTxnA2tdiWFngClzz4=
X-Google-Smtp-Source: ALg8bN51QAJdkUnuMhqB8DcZqA7nlGEoUa3s2Mrv81kVasrJi0932YTdly1kTMg4XxeVpMI24gPWyQ==
X-Received: by 2002:a62:6e07:: with SMTP id j7mr17151733pfc.135.1547764216352;
        Thu, 17 Jan 2019 14:30:16 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id u70sm4875968pfa.176.2019.01.17.14.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 14:30:15 -0800 (PST)
Date:   Thu, 17 Jan 2019 14:30:13 -0800
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] hwmon: (ina3221) Implement ti,single-shot DT
 property
Message-ID: <20190117223012.GH16918@Asurada-Nvidia.nvidia.com>
References: <20190105030636.533-1-nicoleotsuka@gmail.com>
 <20190105030636.533-3-nicoleotsuka@gmail.com>
 <20190107193555.GA13547@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107193555.GA13547@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:35:55AM -0800, Guenter Roeck wrote:

> > +	if (of_property_read_bool(np, "ti,single-shot"))
> > +		ina->single_shot = true;
> > +
> 	ina->single_shot = of_property_read_bool(np, "ti,single-shot");
> 
> No need to resend right now; let's wait for feedback from Rob.

Looks like Rob has acked. Is this resend version fine for review?

Thank you
Nicolin
