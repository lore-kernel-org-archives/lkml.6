Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0CAC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1997E23F1F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XKRQ/8gb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ASpIVLhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1997E23F1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933830AbeF0IzQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:55:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36080 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932549AbeF0IzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:55:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6AE0A60714; Wed, 27 Jun 2018 08:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530089713;
        bh=MxPdJySkh5aY27mksr7L8pDUA+FaR2Y+fpE8Or0fdt0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XKRQ/8gbKtF+eDurXEEPzuDKs5eJSe+CQ5VbONM2bHPL5cDWrEK+0VsOw6KWDlr3L
         gXhsKiCjtD8FdgXKuN6l7gcp5rJStY/m+6VxEyV44Tjc+8Cfvb+uavNUKuAtMXEcYo
         5ku6RePPXdfh73EGG3lKUDhdBZp6suzEu6LXoE8M=
Received: from [10.79.40.88] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EA116024C;
        Wed, 27 Jun 2018 08:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530089712;
        bh=MxPdJySkh5aY27mksr7L8pDUA+FaR2Y+fpE8Or0fdt0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ASpIVLhe6z67WwAKPCeshzs5xQPA3aGLQQuC6pV6kfBQEqw7tQygHD5zmm+f7o70G
         uQxvIVO55bg20XFb7NPw+JGMznL+wBpUXubhF+j0PVrI0+h2d17te8l5mkpSkWA7O/
         F6KDc60cyhdwx9taCXcpQpluEWa51QhP9S7JBfYM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EA116024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 9/9] PM / Domains: Add dev_pm_domain_attach_by_id() to
 manage multi PM domains
To:     Jon Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-tegra@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-10-ulf.hansson@linaro.org>
 <cc6f36ce-32b7-4b69-f9a9-98cf0b12a9d1@nvidia.com>
 <CAPDyKFoiEctBuyw1nVS6ruQ92-jOsMMSAUsWKew42dkmk64_8A@mail.gmail.com>
 <f214cf2b-49ee-2f7c-babd-1cee7dcae927@nvidia.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <ebec2f66-d28d-7b94-3cef-be980617cd6f@codeaurora.org>
Date:   Wed, 27 Jun 2018 14:25:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <f214cf2b-49ee-2f7c-babd-1cee7dcae927@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/30/2018 08:00 PM, Jon Hunter wrote:
>>> My only other comments on this series are ...
>>>
>>> 1. I think it would be nice to have an dev_pm_domain_attach_by_name() and
>>>    that the DT binding has a 'power-domain-names' property.
>> I think it makes sense, but my plan was to do that as second step on
>> top. Are you okay with that as well?
> Yes that is fine with me.

Ulf, do you have a patch for this? I am working on moving some of qcom
remoteproc drivers to use this series and it will help to have a
dev_pm_domain_attach_by_name() api.

Thanks,
Rajendra
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
