Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDC9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675C121565
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGw6+mIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675C121565
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeI0AeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:34:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45983 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeI0AeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:34:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23-v6so6183647pfi.12;
        Wed, 26 Sep 2018 11:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9XcgBsmS+j7XteB8biEg9lQAUjCIssplti0Wfz57IlA=;
        b=fGw6+mInskD71fw2Sb8JgAdxd9hyfvPI9DemgdHoXxpr2My7Yy0EiBmE5UCebF6Vd3
         +9Sns9MrDOKSQWIET3xHjIR+yeTyCYdXFIDFmnhmpldWmXytSIJ/EuYrSLV9sBcq/lzk
         6d2zkii4/LltfoVU7xjCrY8jqAau7KKPsq5X7y+lOjbUIz27CEWfMrWRJ7yHOynF22ZD
         H//EdPuupTqTwwjE9CszzJqbusR5cxFzTr/+WGmncVlHJZ4FiUDukp2GwGQHEl+HjB7e
         jwYNhymZk0PN/C2TRxuYmj7ft4NSF4NMjx49r4S2SnpcYkBjAtnsixrkz/IWg8wL9DUH
         yX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9XcgBsmS+j7XteB8biEg9lQAUjCIssplti0Wfz57IlA=;
        b=DYOmrhtxWREIiiv34LpCv70n82pfTwZxRrxKnec300Vibzhes9pzerpVn4f+KfYp01
         GJce+y+UXee6SskcbKbWtFxtTi72Stjnv1Z0QAYKJMlNmbgfqtMUby9hhUzSLXe75CKo
         ZTg7eVB2M9zRahJY9B0GbgDH3B+vsv1YaFGCoWjEjHXfWwx9dNzM5EgPldq6YPZ1qnQ4
         CgUM51qPMLfAvZkB9mbjeB7xMDSTDiFySAFRS1Mk7aKmt3EM1HHtLwVIuE09ZL1EhKxM
         /O+MXcD6o8qHkgJNmRRZ2cJE9VdRceB66oVZk5XMHCsoLvk3vgpopO8F2Uev+/B21Hz2
         G0pg==
X-Gm-Message-State: ABuFfohTIQqlyOqX0ATA8MGG4FVA6Qohma7Q3NyVkspaWU7q/vM6Pl6k
        tUzMaLiLP7i9pB8L1pVmFRw=
X-Google-Smtp-Source: ACcGV61UP/TAD0H8Gu5t8FxnxifvW7kWlxkCsuCdmnI1Mu/Y4CNZG7avGW9vw7FhmJqxzFtK9T0aVw==
X-Received: by 2002:a63:2d86:: with SMTP id t128-v6mr6867181pgt.128.1537986009079;
        Wed, 26 Sep 2018 11:20:09 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 77-v6sm7652650pga.40.2018.09.26.11.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 11:20:08 -0700 (PDT)
Date:   Wed, 26 Sep 2018 11:20:06 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, corbet@lwn.net, afd@ti.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: ina3221: Add power sysfs nodes
Message-ID: <20180926182006.GB6329@Asurada-Nvidia.nvidia.com>
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
 <20180926064245.4091-2-nicoleotsuka@gmail.com>
 <dbf77a33-ae5c-1ac7-c94f-fa5505074adb@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbf77a33-ae5c-1ac7-c94f-fa5505074adb@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 05:34:53AM -0700, Guenter Roeck wrote:
> Hi Nicolin,
> 
> On 09/25/2018 11:42 PM, Nicolin Chen wrote:
> > The hwmon sysfs ABI supports powerX_input and powerX_crit. This
> > can ease user space programs who care more about power in total
> > than voltage or current individually.
> > 
> > So this patch adds these two sysfs nodes for INA3221 driver.

> Ah, sorry, we can't do that. The sysfs nodes are for chips providing power
> registers, not for kernel drivers to provide calculations based on voltage
> and current measurements.

Hmm..I saw ina2xx.c and ltc4215.c are doing similar calculations...

> Basic guideline is that we report what is there, not some calculation based
> on it.

I could feel the back thoughts behind the guideline, but this does
give user space programs some trouble -- I have a few programs that
were used to read ina2xx driver which provides power nodes, but now
those programs will have to implement another function to read the
voltage and current separately to do further calculations.

Do you know any better solution for this situation?

> This is even more true for power limits: We can not assume that the power limit
> is (max voltage * max current). or (current voltage * max_current), or anything
> else. We simply don't have the knowledge to make that assumption.

I agree that power limit is a bit tricky here as the voltage could
change depending on the user space, Yes, I assumed that users who
set_power() should be aware of it (whether fixed or dynamical) so
as to decide to configure power limit or just current limit.

Thanks
Nicolin
