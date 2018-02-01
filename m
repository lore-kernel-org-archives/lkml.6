Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932209AbeBABsZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 20:48:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56314 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932118AbeBABsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 20:48:22 -0500
Date: Wed, 31 Jan 2018 20:48:10 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Mihai Carabas <mihai.carabas@oracle.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: Re: [PATCH v3 0/3] Per-VCPU MSR bitmaps patches - topic branch for
 x86/pti
Message-ID: <20180201014810.GA19582@char.us.oracle.com>
References: <20180131210924.22812-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180131210924.22812-1-pbonzini@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8791 signatures=668659
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802010018
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 04:09:21PM -0500, Paolo Bonzini wrote:
> David and others,
> 
> the following changes since commit ba804bb4b72e57374b5f567b783aa0298fba0ce6:
> 
>   Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-01-26 09:03:16 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/virt/kvm/kvm.git msr-bitmaps
> 
> for you to fetch changes up to 904e14fb7cb96401a7dc803ca2863fd5ba32ffe6:
> 
>   KVM: VMX: make MSR bitmaps per-VCPU (2018-01-26 22:59:32 +0100)
> 
> The patches are on top of Linus's tree and I checked that they apply okay
> on top of the latest 4.14 tree as well as required for tip x86/pti.
> One extra commit is needed that is pretty safe and would have been merged
> for 4.16 anyway.
> 
> Radim, please pull this into kvm.git too.  As before I've placed my
> resolution on kvm.git, branch refs/heads/msr-bitmaps-merge-resolution.
> It's based on kvm/next this time.

You don't want folks to review patch #2 and #3 first? There are tons
of people that I am sure would be thrilled with the whole Spectra circus.

> 
> Thanks,
> 
> Paolo
> 
> 
> Jim Mattson (1):
>   KVM: nVMX: Eliminate vmcs02 pool
> 
> Paolo Bonzini (2):
>   KVM: VMX: introduce alloc_loaded_vmcs
>   KVM: VMX: make MSR bitmaps per-VCPU
> 
>  arch/x86/kvm/vmx.c | 440 ++++++++++++++++++++++-------------------------------
>  1 file changed, 186 insertions(+), 254 deletions(-)
> 
> -- 
> 2.14.3
> 
