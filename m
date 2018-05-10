Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756353AbeEJE6e (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 00:58:34 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:34746 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753639AbeEJE6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 00:58:33 -0400
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: hoeun.ryu@lge.com
X-Original-SENDERIP: 10.159.138.109
X-Original-MAILFROM: hoeun.ryu@lge.com
From: =?ks_c_5601-1987?B?t/nIo8C6?= <hoeun.ryu@lge.com>
To: <mingo@kernel.org>, <peterz@infradead.org>, <aaron.lu@intel.com>,
        <adobriyan@gmail.com>, <frederic@kernel.org>, <ying.huang@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: smp_call_function() friends and irq/bottom_half context
Date: Thu, 10 May 2018 13:58:29 +0900
Message-ID: <00fb01d3e81b$89b9c2d0$9d2d4870$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdPoGTxXFiQXuWoETj601yD+O1m8lw==
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all.

I'm reading kernel/smp.c code and I found comments on smp_call_function()
and smp_call_function_[single/many]
saying that these functions are cannot be called in interrupt disabled
context or irq/bottom half handlers.

I understand that there is a potential deadlock issue when caller CPU of
the functions is waiting for the completion of the callback of other CPUs.
But I was wondering if this is the case even when the caller CPU doesn't
wait for the completion (wait == 0).

Thank you.
