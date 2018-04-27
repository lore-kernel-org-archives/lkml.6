Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757509AbeD0HVr convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 03:21:47 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:46256 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753480AbeD0HVq (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:3:1>);
        Fri, 27 Apr 2018 03:21:46 -0400
Message-Id: <5AE2CF8802000078001BF017@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Fri, 27 Apr 2018 01:21:44 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: <douly.fnst@cn.fujitsu.com>, <tglx@linutronix.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: recent patch "x86/acpi: Prevent X2APIC id 0xffffffff from
 being accounted"
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've just stumbled across this commit, and I'm wondering if that's actually
correct (I too have at least one system where such IDs are reported in
MADT): For offline/absent CPUs, the firmware may not know the APIC IDs
at the point MADT is built, so I think it is quite reasonable to put ~0 in
there. The ACPID spec specifically calls out that the IDs must not change
across sleep states, which implies to me that they may change across an
offline period of a CPU. IOW I think such entries still need to contribute to
the count of disabled CPUs.

I notice a similar change has been done for the xAPIC case a while ago
by you, Thomas.

Jan
