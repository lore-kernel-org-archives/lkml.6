Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA66C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CF920841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 10:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHJMZ1Fk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CF920841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeJKSIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 14:08:37 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37822 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeJKSIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 14:08:37 -0400
Received: by mail-wm1-f65.google.com with SMTP id 185-v6so8896698wmt.2;
        Thu, 11 Oct 2018 03:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NAFAVdbrOYRzZ+Lro6+mo/qyk3l0DLIb6CoSWmu8tFQ=;
        b=BHJMZ1FkJW7yUcCyU2JlBfwYTk2S+TmqXNcj3xKXkX7OqXYL0j2Yc9mKYUHlTVuicy
         R8fKBeHTFfsECqSZgPhuXaqLWFFtj5XC1PajtYdz8h5SVPGcNP41M3NweoQ2zjSgHWj3
         kKGRuYex8xWvg+SOUEEOy8FvvaMNKRUh6GvTyK92K0SBgMB04pZKeuXq+WcaLSfkUv1J
         ClJ47ec35xwzfRcB/+dZmrcUjClvRlDDhcdyBr0Cin2g5E7fCitk9vwNwTOFUSuXoKKT
         lsHuIsk27x2ePpoB9WXfcijL6uV4e80v/o4tVLsIMaYQWTF5JBpwHBn/jMQ/i3rNRKgZ
         FUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NAFAVdbrOYRzZ+Lro6+mo/qyk3l0DLIb6CoSWmu8tFQ=;
        b=Xw3bbg+4rBR/GSOEM+4/7BayXcoCTlr3646WQnCXOtbniX/nggU+TlUm59Sj9E6ZcP
         0fpS7fl1/lUxMrth8lQl8x3ZpwLMOha+qVW+R6j1ke+NJ+kEIBG/pvCQwZU+yrTJQC7k
         ifbTUzkKe4nqfhYLS6zaD6ExjLo3h1ONT4/vV+4Cvy6g9MH4omXHQi+N/94/9WyYSV5Z
         mfUpBXEmH3Ud5LxRgh1IJtt0sREiN+dROCReYqnbNDUZVO3TdcXS9FgzFLZA+qq08g/O
         cMEha8Rb4VJhvcHe9LU1X4UMKJ41ZmgJlgxuUouCF/0Nh5Z+aZ2tIa0lU0OyrzjBYdJP
         kE+Q==
X-Gm-Message-State: ABuFfohXtSNXuj/R8GpMF8NKgQB6PBf0ZSfGt526vGidIPXeVUxpX8uV
        kAfYS7z9M63M9vI88/jRoO8=
X-Google-Smtp-Source: ACcGV61g4nl7r6SBQ2DbCkD9mvfm1lFrhcDKmxX71kUs/LgDB+/WW1gNuImSSxpDVG0JAn12ArdRow==
X-Received: by 2002:a1c:9fd5:: with SMTP id i204-v6mr1265706wme.88.1539254514698;
        Thu, 11 Oct 2018 03:41:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n11-v6sm32169628wra.26.2018.10.11.03.41.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 03:41:53 -0700 (PDT)
Date:   Thu, 11 Oct 2018 12:41:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86: baytrail/cherrytrail: Rework and move P-Unit
 PMIC bus semaphore code
Message-ID: <20181011104151.GA31491@gmail.com>
References: <20181011102627.7418-1-hdegoede@redhat.com>
 <20181011102627.7418-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011102627.7418-2-hdegoede@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Hans de Goede <hdegoede@redhat.com> wrote:

> +int iosf_mbi_block_punit_i2c_access(void)
> +{
> +	unsigned long start, end;
> +	int ret = 0;
> +	u32 sem;
> +
> +	if (WARN_ON(!mbi_pdev || !iosf_mbi_sem_address))
> +		return -ENXIO;
> +
> +	mutex_lock(&iosf_mbi_block_punit_i2c_access_count_mutex);
> +
> +	if (iosf_mbi_block_punit_i2c_access_count > 0)
> +		goto out;
> +
> +	mutex_lock(&iosf_mbi_punit_mutex);
> +	blocking_notifier_call_chain(&iosf_mbi_pmic_bus_access_notifier,
> +				     MBI_PMIC_BUS_ACCESS_BEGIN, NULL);
> +
> +	/*
> +	 * Disallow the CPU to enter C6 or C7 state, entering these states
> +	 * requires the punit to talk to the pmic and if this happens while
> +	 * we're holding the semaphore, the SoC hangs.
> +	 */
> +	pm_qos_update_request(&iosf_mbi_pm_qos, 0);
> +
> +	/* host driver writes to side band semaphore register */
> +	ret = iosf_mbi_write(BT_MBI_UNIT_PMC, MBI_REG_WRITE,
> +			     iosf_mbi_sem_address, PUNIT_SEMAPHORE_ACQUIRE);
> +	if (ret) {
> +		dev_err(&mbi_pdev->dev, "Error punit semaphore request failed\n");
> +		goto out;
> +	}

Isn't this error path leaking the iosf_mbi_punit_mutex held mutex? The 'out' label only unlocks 
iosf_mbi_block_punit_i2c_access_count_mutex:


> +	/* host driver waits for bit 0 to be set in semaphore register */
> +	start = jiffies;
> +	end = start + msecs_to_jiffies(SEMAPHORE_TIMEOUT);
> +	do {
> +		ret = iosf_mbi_get_sem(&sem);
> +		if (!ret && sem) {
> +			iosf_mbi_sem_acquired = jiffies;
> +			dev_dbg(&mbi_pdev->dev, "punit semaphore acquired after %ums\n",
> +				jiffies_to_msecs(jiffies - start));
> +			/*
> +			 * Success, keep iosf_mbi_punit_mutex locked till
> +			 * iosf_mbi_unblock_punit_i2c_access() gets called.
> +			 */
> +			goto out;

Ditto - although this does claim that this is done intentionally.

> +		}
> +
> +		usleep_range(1000, 2000);
> +	} while (time_before(jiffies, end));
> +
> +	ret = -ETIMEDOUT;
> +	dev_err(&mbi_pdev->dev, "Error punit semaphore timed out, resetting\n");
> +	iosf_mbi_reset_semaphore();
> +	mutex_unlock(&iosf_mbi_punit_mutex);
> +
> +	if (!iosf_mbi_get_sem(&sem))
> +		dev_err(&mbi_pdev->dev, "PUNIT SEM: %d\n", sem);
> +out:
> +	if (!WARN_ON(ret))
> +		iosf_mbi_block_punit_i2c_access_count++;
> +
> +	mutex_unlock(&iosf_mbi_block_punit_i2c_access_count_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(iosf_mbi_block_punit_i2c_access);

So this is a rather unusual looking locking pattern.

So if this is all intended and works fine then at minimum the semantics of the function should 
be explained - right now it has no description whatsoever.

Thanks,

	Ingo
