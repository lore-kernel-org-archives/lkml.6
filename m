Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700C6C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3142621F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AOXjhD1h";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D1Q1pHCr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E3142621F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933044AbeF0JaE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:30:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60190 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932280AbeF0JaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:30:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4BFFD606DD; Wed, 27 Jun 2018 09:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530091801;
        bh=19Sjz3ropLRNnspY+TpIJ+hwoP2SjniVoD63tpfNHyA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AOXjhD1hxt7jXe3nqtOSCk3nnisosRDyAKGURiZU2KMoljSnIoG470CjPaZTPF00c
         n/qlXEmlDWtPMIU1bASD4sz/MgB23NdpO5I8XRxs2COQQB6HZpvhJ7j7CoQven9A+q
         WdDNm6KPA33vHCzshFT6JIRTp7XrBGE4JEk9AeeQ=
Received: from [10.79.40.88] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D05C6024C;
        Wed, 27 Jun 2018 09:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530091800;
        bh=19Sjz3ropLRNnspY+TpIJ+hwoP2SjniVoD63tpfNHyA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=D1Q1pHCrjAuqY1pxEkpc602oO9xZeeIHApBbUN2qFgTJ5jzm53fMuv3e7kxk2luVo
         Nkq1O4biclCFJ/MULyO7KRehTTksocxQtvMgHiCl0deKKK8ox4HmCYBqQHN2GQiBae
         aKry8GQVbJrNQ9DjrNtlajl7SZyQstRuE2zHvXBU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D05C6024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
Subject: Re: [PATCH v2 9/9] PM / Domains: Add dev_pm_domain_attach_by_id() to
 manage multi PM domains
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-tegra@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
 <20180529100421.31022-10-ulf.hansson@linaro.org>
 <cc6f36ce-32b7-4b69-f9a9-98cf0b12a9d1@nvidia.com>
 <CAPDyKFoiEctBuyw1nVS6ruQ92-jOsMMSAUsWKew42dkmk64_8A@mail.gmail.com>
 <f214cf2b-49ee-2f7c-babd-1cee7dcae927@nvidia.com>
 <ebec2f66-d28d-7b94-3cef-be980617cd6f@codeaurora.org>
 <CAPDyKFqZVLfKXK7H+VLaiTh96xRwqBWHxaFfs5PDo7o+5hzRsQ@mail.gmail.com>
From:   Rajendra Nayak <rnayak@codeaurora.org>
Message-ID: <c692fec8-29a1-0107-e7b7-971b209d3972@codeaurora.org>
Date:   Wed, 27 Jun 2018 14:59:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqZVLfKXK7H+VLaiTh96xRwqBWHxaFfs5PDo7o+5hzRsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/27/2018 02:35 PM, Ulf Hansson wrote:
> On 27 June 2018 at 10:55, Rajendra Nayak <rnayak@codeaurora.org> wrote:
>>
>>
>> On 05/30/2018 08:00 PM, Jon Hunter wrote:
>>>>> My only other comments on this series are ...
>>>>>
>>>>> 1. I think it would be nice to have an dev_pm_domain_attach_by_name() and
>>>>>    that the DT binding has a 'power-domain-names' property.
>>>> I think it makes sense, but my plan was to do that as second step on
>>>> top. Are you okay with that as well?
>>> Yes that is fine with me.
>>
>> Ulf, do you have a patch for this? I am working on moving some of qcom
>> remoteproc drivers to use this series and it will help to have a
>> dev_pm_domain_attach_by_name() api.
> 
> Right. Besides this I have been working on a little improvement,
> avoiding to power the PM domain while attaching.
> 
> I post a series in a day or two.

great, thank you.

> 
> Kind regards
> Uffe
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
