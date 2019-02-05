Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CD4C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F5C20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw9RBhAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfBEBLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 20:11:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38013 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfBEBLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 20:11:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id q1so756132pfi.5;
        Mon, 04 Feb 2019 17:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8nlmQ7IS2mYLzzDHOfe9r2Py+GW2rYGgJszDC0FMfq4=;
        b=mw9RBhAdHxuE3sOwX4xKHqmNCgRijDfsLBHrGnkTCszaaj/b6A8Ji91iGwL3AJN2Qm
         9dqtO7h5PP1KUM8SnWAWy1mXNI7HGbdoQftJUvooECsF1TBUn3tuL3/A8q2gCZhUnFe2
         CoN6C9YDlwTJkNIVkAWa6EhfGFwQszYuzczMv+m+JGAev+dOcM30iNAxsqBnbqaytCZi
         6j3OOtQBVfgJnU5YeyX0td5twCCky+SxzM3ZUEuSEet83cPfd9Armslh7YM2iwoW/VpX
         l0ZfYRR8SbKigQBWsmyjJJmi4Vmp1aAdQNyEXIA02X+//4H+cdaKPEoP5/k1vO7QVHeS
         deEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8nlmQ7IS2mYLzzDHOfe9r2Py+GW2rYGgJszDC0FMfq4=;
        b=lSUtGwr9OqgylKqQ2VhaATtVilRuJL5+0g1YYAELOwC/O9R4JNTie2gnN1m63nyM+c
         m3ukCnnKkMVrzlLkri9d0/3DWmBYbA1Esi9SavKP8Vv6bCdXyjyojF9NFYGPGX/dLHeP
         JD271RyBE+JkPOru4m5Ru4HRcd5yJHDb9LdejM3aqAIY9vitZBc6dwa+JPMan88pRdfW
         DiyZ0qzzZMThPhnMSkZgPfrCVf9+hk5fNP81Xmpsdwcif2528CWbxeBVSafm/nuDUTUk
         QLS0Bys1v3xFmqe87Q3k/sdWQwBY+71npLCPqVaqedRDSSYVFPSKJD5bNgsogJ5Pc0B9
         zOng==
X-Gm-Message-State: AHQUAuZ9Stjp1P6Us19bNS9ecxz14JOlloIDFSf2xMmPTkNwNNsJI+eO
        n9V878SlwcFsdxdEDrj8Yvu+7bhl
X-Google-Smtp-Source: AHgI3IaRWKAWAcbjZNfm0b/TzjTh+tJr/Bau/f7+BGOx4wilpevQv4bwQhlng0wfVDOpNPHRoNYKNw==
X-Received: by 2002:a65:6105:: with SMTP id z5mr2158635pgu.26.1549329090658;
        Mon, 04 Feb 2019 17:11:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w136sm1762522pfd.169.2019.02.04.17.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 17:11:29 -0800 (PST)
Subject: Re: [PATCH] watchdog: Update sysfs documentation.
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1549324656-78660-1-git-send-email-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <de1c8050-6784-8e92-a195-e18b849f7d91@roeck-us.net>
Date:   Mon, 4 Feb 2019 17:11:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1549324656-78660-1-git-send-email-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/19 3:57 PM, Jerry Hoemann wrote:
> Document the sysfs attributes:
> 	pretimeout
> 	pretimeout_available_governors
> 	pretimeout_governor
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/ABI/testing/sysfs-class-watchdog | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-watchdog b/Documentation/ABI/testing/sysfs-class-watchdog
> index 736046b..6317ade 100644
> --- a/Documentation/ABI/testing/sysfs-class-watchdog
> +++ b/Documentation/ABI/testing/sysfs-class-watchdog
> @@ -49,3 +49,26 @@ Contact:	Wim Van Sebroeck <wim@iguana.be>
>   Description:
>   		It is a read only file. It is read to know about current
>   		value of timeout programmed.
> +
> +What:		/sys/class/watchdog/watchdogn/pretimeout
> +Date:		December 2016
> +Contact:	Wim Van Sebroeck <wim@iguana.be>
> +Description:
> +		It is a read only file. It specifies the time in seconds before
> +		timeout when the pretimeout interrupt is delivered.  Pretimeout
> +		is an optional feature.
> +
> +What:		/sys/class/watchdog/watchdogn/pretimeout_avaialable_governors
> +Date:		February 2017
> +Contact:	Wim Van Sebroeck <wim@iguana.be>
> +Description:
> +		It is a read only file. It shows the pretimeout governors
> +		available for this watchdog.
> +
> +What:		/sys/class/watchdog/watchdogn/pretimeout_governor
> +Date:		February 2017
> +Contact:	Wim Van Sebroeck <wim@iguana.be>
> +Description:
> +		It is a read/write file. When read, the currently assigned
> +		pretimeout governor is returned.  When written, it sets
> +		the pretimeout governor.
> 

