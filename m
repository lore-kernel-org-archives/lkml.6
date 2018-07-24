Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6133CC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A09620856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 22:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kepstin.ca header.i=@kepstin.ca header.b="aa9L+RJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A09620856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kepstin.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbeGXXV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 19:21:29 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46893 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727353AbeGXXV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 19:21:28 -0400
Received: by mail-io0-f195.google.com with SMTP id i18-v6so4720349ioj.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 15:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FzqK4VNjUgF2Eg0wGt+brcsvU1kcQGVT9OPWDgms2xk=;
        b=aa9L+RJd364OIVX0iDZGwCHiJUBLsIwIdN6VydDvN7/4rfOXk7p/+uiu6uwSzeEX31
         XIWD4CfT36klg6BSA+P3YXfpPcogCcE9n1B4+ssZa4Gs+P1jHXt36U7QXmHCzXhn8Gpz
         5EVe02faFg5oWuLtI9FeLVGxNanrbvOQUOn0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FzqK4VNjUgF2Eg0wGt+brcsvU1kcQGVT9OPWDgms2xk=;
        b=UK4q7rbI6gGDiTueFKQYlTqtaMmzvpiNqWvecHWJaJ2TKJFSeqy0g3dPvZM/dX0Mio
         9dK1lcf1ocSFo9H8O2soPOvw4Y0kLAGY2is6EKzqALuuC5KiDQtClXVsEp5LqccEkzTr
         kDGY27EvdxUJuyvPETG2lIkKE4rCrx8S4QoTS4OruG4w7C34q20Q5PZp848DrmB9oMwy
         pVn3c8JWQ4SwPUj7FN0nSWBHNeZW0cFRWEcMra+BigSPA0YnJ7oMlFuKInAN7PDd+Vd9
         fJk/vFxCxCmH21Mafz9WbqGs6P+JS27+JbylHlfM6I6TslFAAPG0uHzGpdKBt3vWqJK9
         +3Jw==
X-Gm-Message-State: AOUpUlF1RHcFQFlhZDRyY5sVuMmItPxTImZKaIO9VtlIOvpXVmmmcvWt
        x3yQn++e0eQuf7HVIhec2WyWMw==
X-Google-Smtp-Source: AAOMgpfbMywr4ILlEyB1u5sMkdtmyAlZBm+MBwoOVtnx1Di6Um2ggPIdtPOxg+TFNyKTA8dw2Kaevg==
X-Received: by 2002:a6b:ca85:: with SMTP id a127-v6mr15800470iog.31.1532470375076;
        Tue, 24 Jul 2018 15:12:55 -0700 (PDT)
Received: from rocky ([2607:fea8:bd9f:ebda:7467:360e:236d:23a5])
        by smtp.gmail.com with ESMTPSA id z71-v6sm10459122ioz.34.2018.07.24.15.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 15:12:54 -0700 (PDT)
Message-ID: <2f5c94891ef890b1821e0a83e40cad8a98e4ea3b.camel@kepstin.ca>
Subject: Re: [PATCH 0/2] turbostat: Improve support for AMD Zen CPUs (RAPL,
 CPUID) (Resend)
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>
Date:   Tue, 24 Jul 2018 18:12:52 -0400
In-Reply-To: <20180718222656.11795-1-calvin.walton@kepstin.ca>
References: <20180718222656.11795-1-calvin.walton@kepstin.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-18 at 18:26 -0400, Calvin Walton wrote:
> Based on the documentation provided in AMD's Open-Source
> Register Reference For AMD Family 17h Processors:
> https://support.amd.com/TechDocs/56255_OSRR.pdf
> 
> I've added support for reading Cores and Package energy usage from
> AMD's
> "RAPL" MSRs. In order to correctly detect the AMD processor
> generation,
> I've also had to update the CPUID code to handle AMD's extended
> family
> field.

Having now had the chance to look at recent changes to the turbostat
tool (these patches were based on the version from the 4.17 kernel), it
looks like I'm going to have to update the second patch in this set
because of the changes to handle processor "Nodes".

One thing I'm not sure about is whether the "Package" power reporting
on multi-node AMD systems is reported per node - I suspect it is, but
don't have hardware to confirm. If someone has a processor where this
applies (I'm guessing this is Threadripper and EPYC?) I'd appreciate
seeing the output of

turbostat --Dump --add msr0xc001029b,u32,raw

to know which is the case.

-- 
Calvin Walton <calvin.walton@kepstin.ca>

