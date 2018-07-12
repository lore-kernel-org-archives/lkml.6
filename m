Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5606C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CD620C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CD620C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbeGLIBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:01:22 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:7911 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbeGLIBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:01:22 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b4708d10000>; Thu, 12 Jul 2018 00:52:53 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 12 Jul 2018 00:52:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 12 Jul 2018 00:52:58 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 12 Jul
 2018 07:52:52 +0000
Date:   Thu, 12 Jul 2018 10:52:47 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Jon Hunter <jonathanh@nvidia.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] soc/tegra: pmc: Implement
 tegra_io_pad_is_powered()
Message-ID: <20180712105247.121a5d13@dhcp-10-21-25-168>
In-Reply-To: <2d669942-0b4d-f48b-a8ba-67794485bf5f@nvidia.com>
References: <1531317693-3520-1-git-send-email-avienamo@nvidia.com>
        <1531317693-3520-4-git-send-email-avienamo@nvidia.com>
        <3ced704b-2a8b-b78c-3b1e-6c2d7562edcc@nvidia.com>
        <2d669942-0b4d-f48b-a8ba-67794485bf5f@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 16:26:42 +0100
Jon Hunter <jonathanh@nvidia.com> wrote:

> On 11/07/18 16:23, Jon Hunter wrote:
> > 
> > On 11/07/18 15:01, Aapo Vienamo wrote:  
> >> Implement a function to query whether a pad is in deep power down mode.  
> > Can you elaborate on why this public function is needed and who will be
> > using this?  
> 
> Or I should say does this need to be public?

It's only called from the pinconf callbacks and exposing it doesn't
indeed make much sense if we intend to replace direct calls to pmc.c
with pinctrl anyway. I'll make it private on the next iteration of the
series.

 -Aapo
