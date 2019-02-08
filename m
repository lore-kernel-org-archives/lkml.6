Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9502C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825922085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 04:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="djWK8Nbn";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LrbJT56x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfBHEje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 23:39:34 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48170 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfBHEjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 23:39:33 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 85CF56085F; Fri,  8 Feb 2019 04:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549600772;
        bh=q2vH9t475bMq8VLSdCFwAendgdV3JVdF7MH04rEtX1Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=djWK8NbnBUYIchzvT9GqlZcvpq8rUosqmunPgAKSecSthMHBsOux5ojuyNWtj7E6T
         78v0MS8rMefHpVXwQJ02bA/DDSxDcshQtlX5K36Dn32zVNp7EJGwLpN1l+nr5C6hfY
         Rh1UmVa8claf610oZE4ZWdsxs2l3ELr7YWTiLhl0=
Received: from [10.79.128.169] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 197A060791;
        Fri,  8 Feb 2019 04:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549600771;
        bh=q2vH9t475bMq8VLSdCFwAendgdV3JVdF7MH04rEtX1Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LrbJT56xrXZBAwNHK20lxYq7JW0bxxwgfijewZ8pjwCfMBkDc0ngQWNBxk2yv6hBg
         W7a7mIeMwds8k+xpd3VyjJUNw2Aye2uIe3JZNZzphTlPAPrNGoQssyfb6B+RyyB32U
         HoUDP91KqJr65OT2YzVM27H00HIQJkq/KYWSO42c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 197A060791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [RFC/PATCH 0/5] DVFS in the OPP core
To:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Anderson <dianders@chromium.org>
References: <20190129015547.213276-1-swboyd@chromium.org>
 <7af27aa5-3ff6-d4ee-1dc0-bac797c2bdbc@codeaurora.org>
 <154956885472.115909.8681514480591552850@swboyd.mtv.corp.google.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <76b656dd-e8b2-0982-23a7-398235630d54@codeaurora.org>
Date:   Fri, 8 Feb 2019 10:09:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <154956885472.115909.8681514480591552850@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/2019 1:17 AM, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2019-02-06 22:57:12)
>>
>>> 3) How do we handle devices that already have power-domains specified in
>>> DT? The opp binding for required-opps doesn't let us specify the power
>>> domain to target, instead it assumes that whatever power domain is
>>> attached to a device is the one that OPP needs to use to change the
>>> genpd performance state. Do we need a
>>> dev_pm_opp_set_required_opps_name() or something to be explicit about
>>> this? Can we have some way for the power domain that required-opps
>>> correspond to be expressed in the OPP tables themselves?
>>
>> I was converting a few more drivers to use the proposed approach in this
>> RFC, in order to identify all outstanding issues we need to deal with,
>> and specifically for UFS, I end up with this exact scenario where UFS already
>> has an existing power domain (gdsc) and I need to add another one (rpmhpd) for
>> setting the performance state.
>>
>> If I use dev_pm_opp_of_add_table() to add the opp table from DT, the opp
>> layer assumes its the same device on which it can do a dev_pm_genpd_set_performance_state()
>> with, however the device that's actually associated with the pm_domain when we
>> have multiple power domains is infact the one (dummy) that we create when
>> the driver makes a call to dev_pm_domain_attach_by_name/id().
>>
>> Any thoughts on whats a good way to handle this?
>>
> 
> Ulf mentioned that we can use dev_pm_opp_set_genpd_virt_dev() for this.
> Does that API work here?

Ah, yes, that should work, I hadn't noticed this API existed.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
