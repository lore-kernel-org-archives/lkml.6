Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeBXBi1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 20:38:27 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:33435 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeBXBiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 20:38:25 -0500
Subject: Re: [PATCH v2 1/3] ARC: mcip: halt GFRC together with ARC cores
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
References: <20180223164154.22377-1-Eugeniy.Paltsev@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <49291bc3-665b-2cd8-aabc-4adb67b73413@synopsys.com>
Date: Fri, 23 Feb 2018 17:38:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223164154.22377-1-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.10.161.84]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/23/2018 08:41 AM, Eugeniy Paltsev wrote:
> Currently GFRC is running regardless state of ARC cores in the SMP cluster.
> That means even if ARC cores are halted when doing JTAG debugging GFRC
> [our source of wall-time] continues to run giving us unexpected warnings
> once we allow ARC cores to run due to some tasks being stuck for too
> long.
>
> Starting from ARC HS v3.0 it's possible to tie GFRC to state of up-to 4
> ARC cores with help of GFRC's CORE register where we set a mask for
> cores which state we need to rely on.
>
> We update cpu mask every time new cpu came online instead of using
> hardcoded one or using mask generated from "possible_cpus" as we
> want it set correctly even if we run kernel on HW which has fewer cores
> than expected (or we launch kernel via debugger and kick fever cores
> than HW has)
>
> Signed-off-by: Alexey Brodkin<abrodkin@synopsys.com>
> Signed-off-by: Eugeniy Paltsev<Eugeniy.Paltsev@synopsys.com>

Acked-by: vineet Gupta <vgupta@synopsys.com>
