Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031738AbeCAPNR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:13:17 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:35971 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031631AbeCAPNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:13:15 -0500
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
Subject: Do we need to disable preemption in flush_tlb_range()?
Thread-Topic: Do we need to disable preemption in flush_tlb_range()?
Thread-Index: AQHTsW/Ph/wHPbUur0SfkKmu1J1Lqw==
Date: Thu, 1 Mar 2018 15:13:10 +0000
Message-ID: <1519917189.13866.6.camel@synopsys.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F63FCB7436102149B26B564179AFB4FB@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21FDK9E026046

Hi Vineet,

Just noticed that in comments for smp_call_function_many() it is said that
preemption must be disabled during its execution. And that function gets executed
among other ways like that:
-------------------------->8-----------------------
  flush_tlb_range()
    -> on_each_cpu_mask()
         -> smp_call_function_many()
-------------------------->8-----------------------

I'm not seeing right now any real problem with current implementation but
some architectures do that thus the question.

-Alexey
