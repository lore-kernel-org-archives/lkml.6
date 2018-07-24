Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BE3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7845820874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7845820874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbeGXMrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:47:08 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:55059 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388256AbeGXMrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:47:08 -0400
Received: from [IPv6:2001:983:e9a7:1:242d:c895:d0ca:e9e7] ([IPv6:2001:983:e9a7:1:242d:c895:d0ca:e9e7])
        by smtp-cloud8.xs4all.net with ESMTPA
        id hvgcfGbJioj71hvgdfJvyX; Tue, 24 Jul 2018 13:41:03 +0200
Subject: Re: [PATCH v3 00/35] Qualcomm Camera Subsystem driver - 8x96 support
To:     Todor Tomov <todor.tomov@linaro.org>, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, hans.verkuil@cisco.com,
        laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <1532343772-27382-1-git-send-email-todor.tomov@linaro.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <717da3cd-7afe-9aeb-352a-898e12f2b1bc@xs4all.nl>
Date:   Tue, 24 Jul 2018 13:41:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1532343772-27382-1-git-send-email-todor.tomov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL856udXQ4ot+CCC69EhCxwDLhgMdYvvx0TvZ9lXyfMghRRSQ5E0ylwolb+8gXU35GJ4/Y9ecX1Ss7kIug4G/OmYt/QABxpFEWjnhm1uoTbDtVr/m2KC
 zEpde7bgLNuzRd1UBhsdIb8tddLtk39rWIByZlYOPKbvnqH3N6mOp/dfoG6gwV000GmeOOcglIuaMnHZTrHJ4AL0IaVWwBMrLVRagNZe8nDJ6ZvkzYBd5lol
 Kyj5ebqKkF0I0nXwBQIhpatRFFXX37ZSheaVIJaqCLz6OdYJWJdFdVJ4IpprpgNSSoK6RQrbO44JjFVMoROjdKDTfKPZH8erFb5N7F/xVPhuLvr+Cgr+U2HU
 dyDDpCoVWW0bfy6o8+zooQoCJJkleqFu3K8co19/SZI7ZbZRVXqw+HwibHe1P9hALV4lV+uUoEdpHZd2rIC349ue1PAHfgOZTSJiQixSWxcWLv/0b3ZGrmd1
 jJqWXDcOFatHH12w
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/18 13:02, Todor Tomov wrote:
> Changelog v3:
> - split patch 08 to device tree binding patch and driver patch and
>   improve commit message.
> 
> --------------------------------------------------------------------------------
> 
> This patchset adds support for the Qualcomm Camera Subsystem found
> on Qualcomm MSM8996 and APQ8096 SoC to the existing driver which
> used to support MSM8916 and APQ8016.
> 
> The camera subsystem hardware on 8x96 is similar to 8x16 but
> supports more cameras and features. More details are added in the
> driver document by the last patch.
> 
> The first 3 patches are dependencies which have already been on
> the mainling list but I'm adding them here for completeness.
> 
> The following 12 patches add general updates and fixes to the driver.
> Then the rest add the support for the new hardware.
> 
> The driver is tested on Dragonboard 410c (APQ8016) and Dragonboard 820c
> (APQ8096) with OV5645 camera sensors. media-ctl [1], yavta [2] and
> GStreamer were used for testing.
> 
> [1] https://git.linuxtv.org//v4l-utils.git
> [2] http://git.ideasonboard.org/yavta.git
> 
> --------------------------------------------------------------------------------

When running sparse I get these warnings:

camss/camss-csiphy-2ph-1-0.c:170:28: warning: symbol 'csiphy_ops_2ph_1_0' was not declared. Should it be static?
camss/camss-csiphy-3ph-1-0.c:250:28: warning: symbol 'csiphy_ops_3ph_1_0' was not declared. Should it be static?
camss/camss-vfe-4-1.c:976:25: warning: symbol 'vfe_ops_4_1' was not declared. Should it be static?
camss/camss-vfe-4-7.c:1098:25: warning: symbol 'vfe_ops_4_7' was not declared. Should it be static?

checkpatch.pl complains about this as well.

There are externs in vfe.c, but those should probably be moved to camss-vfe.h.

It should solves both checkpatch and sparse.

Regards,

	Hans
