Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88336FA3736
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBA820870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DBA820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbeG2KzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 06:55:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37346 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeG2KzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 06:55:00 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so10259314wmc.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 02:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v9sDBPYKDShkZ2+AKnzEGKVf48UXlNFb58bvS5H08PM=;
        b=sLAFEh7ZesUaA901vzvOohrW0eg6BFcoFsf1EcZReG8krjfmwHfpcWWXxbevlLez/B
         C2mAH/JF0PkwooBYj1JzxfN8W4o3UbIoFo4RGIlvw1kzLl/4hqE0fY/8CNRo1SAwpZQ/
         KFpmHN9KqtKUaWoPW7xUG6tLMMomqxlFIWBIxiBPyCLzEhS9XCawkWv8fcPd6vqaAgfY
         stQ43BGgBdbF6QdrUpB5+Da3Xg3A1/I6Oc5l2kalFN7G8v07n73Z8tNLZE8lwXnbZmaE
         AlNvMFsUxYrrBuB9jy1z9LxZIpJDvz5qUbViA7YmTOiDGuxxugR2TsOqYwTQVi6bxSVg
         Trew==
X-Gm-Message-State: AOUpUlFtb9Ik4NVhdaoEJ/oKw/whqMCOxBRM9rc6lnNs8DSnD8mWxoat
        jHhwmnkoLrpWOHSFsE7rvwdauw==
X-Google-Smtp-Source: AAOMgpcd6j2K1sirUMwjGBEo5JmHz+ZZ62Vm1EYMxJZxPQ/G4W7aCSF/vDOKO9mUTeL+cZc/WZoMdw==
X-Received: by 2002:a1c:d946:: with SMTP id q67-v6mr10819543wmg.156.1532856311100;
        Sun, 29 Jul 2018 02:25:11 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id n7-v6sm2835942wrr.35.2018.07.29.02.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 02:25:10 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] ata: ahci: Enable DEVSLP by default on SLP_S0
 support
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        tj@kernel.org, rjw@rjwysocki.net
Cc:     alan.cox@intel.com, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Mario.Limonciello@dell.com
References: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <930a28d9-6a81-ee03-eb77-4c3802145c65@redhat.com>
Date:   Sun, 29 Jul 2018 11:25:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27-07-18 22:47, Srinivas Pandruvada wrote:
> One of the requirement for modern x86 system to enter lowest power mode
> (SLP_S0) is SATA IP block to be off. This is true even during when
> platform is suspended to idle and not only in opportunistic (runtime)
> suspend.
> This series is to enable DEVSLP by default.
> 
> v2:
>   As suggested by Hans, take care of the module param is same as default
>   LPM policy

Thanks.

Series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Note we need to keep an eye out for this causing regressions with
some disks / firmware-versions.

Regards,

Hans




> 
> -current (non-rfc) series
> Implemented suggestions from Hans
> - no override of policy set via module param
> - Override lpm policy per host not global policy
> - changed the new policy name to "min_power_with_partial"
> 
> rfc-v2
> - As suggested by Hans, it is possible to have ASP with DEVSLP, so
> add a new state.
> - Removed usage of mem_sleep_current, instead just rely on low power
> idle flag. Don't feel good to EXPORT from core suspend code.
> - Depending host policy to decide if we enable DEVSLP by default.
> 
> Srinivas Pandruvada (2):
>    ata: ahci: Support state with min power but Partial low power state
>    ata: ahci: Enable DEVSLP by default on x86 with SLP_S0
> 
>   drivers/ata/ahci.c        | 38 +++++++++++++++++++++++++++++++++-----
>   drivers/ata/libahci.c     |  5 ++++-
>   drivers/ata/libata-core.c |  1 +
>   drivers/ata/libata-scsi.c |  1 +
>   include/linux/libata.h    |  3 ++-
>   5 files changed, 41 insertions(+), 7 deletions(-)
> 
