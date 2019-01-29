Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06328C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA83A21841
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 14:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZT6K/fVj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UYKyJRnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfA2OrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 09:47:05 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52968 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfA2OrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 09:47:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8CDE0608C5; Tue, 29 Jan 2019 14:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548773223;
        bh=Zs3i6jD1okYi4Opv3xL3bXxvd/KZ5XgU/aG+dX1y8eU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZT6K/fVjv48bzrip8pju8wNTWxr/imEJs0Ewhqb137Tf4NFBinHSy+8uIWUeYte0r
         dFUo29vx4L7tKYOdzg0gSRIquWmsWKALqmWEXH/HQAnu+0tRvJCFqaQ1d9mvdrpAJa
         /HBl+5+fK8gosLHOJ6Ck4g/72UIzPUiaAPikMdJk=
Received: from [192.168.1.100] (unknown [157.49.239.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CB773601CF;
        Tue, 29 Jan 2019 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1548773222;
        bh=Zs3i6jD1okYi4Opv3xL3bXxvd/KZ5XgU/aG+dX1y8eU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UYKyJRnmkfkCG1+tSlxTnATluf1r7Yh+7cCFZDWYxmvVS2QSW2hbeHPB5LwGFnqwb
         6W/YIfDM1w3OTMS2JN3wpfEkW3bDNLX5iq/7jfjZgseCdQKQOvli9aqKYd+k+CkFAJ
         /2rkfsmWJN1Zq3Oahj7qNyXZaJAowDhinNgKZv8I=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB773601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCHv5 4/7] coresight: etm4x: Add support to enable ETMv4.2
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, robh+dt@kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, alexander.shishkin@linux.intel.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        vivek.gautam@codeaurora.org, jhugo@codeaurora.org,
        dianders@chromium.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, marc.w.gonzalez@free.fr
Cc:     rnayak@codeaurora.org, sibis@codeaurora.org,
        tingwei@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <cover.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <980aaf18c0fe92a667930e3a035394442af74869.1548419933.git.saiprakash.ranjan@codeaurora.org>
 <342fa449-124e-7581-dfff-ef5d382f1f6b@arm.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <c243233a-96d3-ddde-1bff-f5ec5d0058e9@codeaurora.org>
Date:   Tue, 29 Jan 2019 20:16:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <342fa449-124e-7581-dfff-ef5d382f1f6b@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/2019 2:56 PM, Suzuki K Poulose wrote:
>
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> 

Thanks Suzuki.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
