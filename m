Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43E5C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A62214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A62214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbeHVRPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:15:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33198 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbeHVRPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:15:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A0667A9;
        Wed, 22 Aug 2018 06:50:48 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 123643F739;
        Wed, 22 Aug 2018 06:50:46 -0700 (PDT)
Subject: Re: bisected - arm64 kvm unit test failures
To:     Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
 <1532768831.9882.71.camel@gmx.de> <1532847330.1618.8.camel@gmx.de>
 <1532864867.1618.32.camel@gmx.de> <1532967899.30205.62.camel@gmx.de>
 <1533061729.12487.26.camel@gmx.de>
 <c96d252c-6ed7-320e-0d47-c4b78af20ce0@arm.com>
 <1534945105.8087.8.camel@gmx.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <77ab9a57-b3ad-d8fa-7dc8-b94527f56139@arm.com>
Date:   Wed, 22 Aug 2018 14:50:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534945105.8087.8.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/18 14:38, Mike Galbraith wrote:
> On Tue, 2018-08-21 at 16:34 +0100, Marc Zyngier wrote:
>> Could you give that patchlet[1] a go? It solves a similar issue for me
>> on a different platform.
>>
>> [1] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-August/032469.html
> 
> Yup, all better.

Now I'm not sure it actually fixes anything. Alex's test case seem to
have opened a new can of worms... In tracing hell at the moment.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
