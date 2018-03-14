Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeCNTPQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:15:16 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:48558 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751408AbeCNTPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:15:14 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Re: Do we need to disable preemption in flush_tlb_range()?
Thread-Topic: Do we need to disable preemption in flush_tlb_range()?
Thread-Index: AQHTsW/Ph/wHPbUur0SfkKmu1J1Lq6PQHecA
Date: Wed, 14 Mar 2018 19:15:11 +0000
Message-ID: <1521054910.11552.44.camel@synopsys.com>
References: <1519917189.13866.6.camel@synopsys.com>
In-Reply-To: <1519917189.13866.6.camel@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.225.15.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <30A2D9E66292534496C2D08722D7A51C@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2EJFMIx014177

Ping!

On Thu, 2018-03-01 at 18:13 +0300, Alexey Brodkin wrote:
> Hi Vineet,
> 
> Just noticed that in comments for smp_call_function_many() it is said that
> preemption must be disabled during its execution. And that function gets executed
> among other ways like that:
> -------------------------->8-----------------------
>   flush_tlb_range()
>     -> on_each_cpu_mask()
>          -> smp_call_function_many()
> -------------------------->8-----------------------
> 
> I'm not seeing right now any real problem with current implementation but
> some architectures do that thus the question.
> 
> -Alexey
