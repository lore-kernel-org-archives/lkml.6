Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91CDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF8F208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF8F208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbeGaNzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:55:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53240 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730031AbeGaNzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:55:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14AD880D;
        Tue, 31 Jul 2018 05:15:03 -0700 (PDT)
Received: from [0.0.0.0] (e107985-lin.emea.arm.com [10.4.12.239])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E9163F5D0;
        Tue, 31 Jul 2018 05:15:01 -0700 (PDT)
Subject: Re: [PATCHv4 00/12] sched/fair: Migrate 'misfit' tasks on asymmetric
 capacity systems
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, gaku.inami.xh@renesas.com,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1530699470-29808-1-git-send-email-morten.rasmussen@arm.com>
 <CAKfTPtB9tRb6vWAHf-CyMpZjMaRtOzUnB7PCuWwAmfsJf_Y6pA@mail.gmail.com>
 <20180709150839.GA19287@e105550-lin.cambridge.arm.com>
 <98eb0daf-4467-3790-ec80-90b746807392@arm.com>
 <7bad2238-369c-f61c-0a51-eb14204e0429@arm.com>
 <CAKfTPtCVDJqj64HNKnOM0ZN5d8BXycJj86Sm7ZOyEPCiAHhB_Q@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <0205e147-00cc-bc8b-104a-9cb4392ac0f8@arm.com>
Date:   Tue, 31 Jul 2018 14:14:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCVDJqj64HNKnOM0ZN5d8BXycJj86Sm7ZOyEPCiAHhB_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 02:13 PM, Vincent Guittot wrote:
> On Mon, 30 Jul 2018 at 16:30, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 07/26/2018 07:14 PM, Valentin Schneider wrote:

[...]

>> The task layout of the test looks like n=85 always running tasks (each
>> for ~ 1.25ms on big or little) and they all get created and run one
> 
> How mistfit task can make a difference for a benchmark which uses 1.25ms tasks ?

Ah, sorry! This was a typo. It should be ~ 1.25s.
