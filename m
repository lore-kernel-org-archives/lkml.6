Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753441AbeD3McN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 08:32:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35720 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbeD3McL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 08:32:11 -0400
Date: Mon, 30 Apr 2018 13:31:49 +0100
From: Darren Kenny <darren.kenny@oracle.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
Subject: Re: [PATCH] KVM: X86: Limit timer frequency with more smaller
 interval
Message-ID: <20180430123149.mroow2pdhglqesrn@starbug-mbp.local>
Mail-Followup-To: Wanpeng Li <kernellwp@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
References: <1525055900-20729-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525055900-20729-1-git-send-email-wanpengli@tencent.com>
User-Agent: NeoMutt/20180323
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8878 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804300121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wanpeng Li,

On Sun, Apr 29, 2018 at 07:38:20PM -0700, Wanpeng Li wrote:
>From: Wanpeng Li <wanpengli@tencent.com>
>
>Anthoine reported:
> The period used by Windows change over time but it can be 1 milliseconds
> or less. I saw the limit_periodic_timer_frequency print so 500
> microseconds is sometimes reached.
>
>This patchs limits timer frequency with more smaller interval 200ms(5000Hz)
>to leave some headroom as Paolo suggested since Windows 10 changed the
>scheduler tick limit from 1024 Hz to 2048 Hz.

I would suggest re-writing this slightly, removing the 'this patch'
as some people suggested in other threads, and maybe some other
small re-wording, e.g.:

  As suggested by Paolo, lower the timer frequency limit to a
  smaller interval of 200 ms (5000 Hz) to leave some headroom. This
  is required due to Windows 10 changing the scheduler tick limit
  from 1024 Hz to 2048 Hz.

Also, in the subject line, maybe write it as 'Lower timer frequency
limit to 200ms'?

>
>Reported-by: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
>Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>Cc: Paolo Bonzini <pbonzini@redhat.com>
>Cc: Radim Krčmář <rkrcmar@redhat.com>
>Cc: Anthoine Bourgeois <anthoine.bourgeois@blade-group.com>
>Signed-off-by: Wanpeng Li <wanpengli@tencent.com>

With those changes (or similar):

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>

>---
> arch/x86/kvm/x86.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>index 51ecd38..dc47073 100644
>--- a/arch/x86/kvm/x86.c
>+++ b/arch/x86/kvm/x86.c
>@@ -114,7 +114,7 @@ module_param(ignore_msrs, bool, S_IRUGO | S_IWUSR);
> static bool __read_mostly report_ignored_msrs = true;
> module_param(report_ignored_msrs, bool, S_IRUGO | S_IWUSR);
>
>-unsigned int min_timer_period_us = 500;
>+unsigned int min_timer_period_us = 200;
> module_param(min_timer_period_us, uint, S_IRUGO | S_IWUSR);
>
> static bool __read_mostly kvmclock_periodic_sync = true;
>-- 
>2.7.4
>
