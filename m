Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeEKPkv (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:40:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54802 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeEKPkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:40:49 -0400
Date: Fri, 11 May 2018 11:40:19 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tim Shearer <tshearer@advaoptical.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 0/3] KVM: VMX: Allow to disable ioport intercept per-VM
 by userspace
Message-ID: <20180511154019.GG27459@char.us.oracle.com>
References: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8890 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=793
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805110148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 10:45:59PM -0700, Wanpeng Li wrote:
> Tim Shearer reported that "There is a guest which is running a packet
> forwarding app based on the DPDK (dpdk.org). The packet receive routine
> writes to 0xc070 using glibc's "outw_p" function which does an additional
> write to I/O port 0x80. It does this write for every packet that's
> received, causing a flood of KVM userspace context switches". He uses
> mpstat to observe a CPU performing L2 packet forwarding on a pinned
> guest vCPU, the guest time is 95 percent when allowing I/O port 0x80
> bypass, however, it is 65.78 percent when I/O port 0x80 bypss is
> disabled.
> 
> This patchset introduces per-VM I/O permission bitmaps, the userspace
> can disable the ioport intercept when they are more concern the
> performance than the security.

Could you kindly also add:

Suggested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you.
