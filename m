Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750978AbeC0E4H (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 00:56:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47146 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbeC0E4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 00:56:05 -0400
Date: Tue, 27 Mar 2018 00:55:58 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 2/2] KVM: VMX: Add Force Emulation Prefix for "emulate
 the next instruction"
Message-ID: <20180327045558.GC16974@char.us.oracle.com>
References: <1522116735-4861-1-git-send-email-wanpengli@tencent.com>
 <1522116735-4861-3-git-send-email-wanpengli@tencent.com>
 <20180327044020.GB16974@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327044020.GB16974@char.us.oracle.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8844 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=702
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803270044
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 12:40:20AM -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Mar 26, 2018 at 07:12:15PM -0700, Wanpeng Li wrote:
> > From: Wanpeng Li <wanpengli@tencent.com>
> > 
> > This patch introduces a Force Emulation Prefix (ud2a; .ascii "kvm") for 
> > "emulate the next instruction", the codes will be executed by emulator 
> > instead of processor, for testing purposes.
> 
> Can you expand a bit ? Why do you want this in KVM in the first place?
> Should this be controlled by a boolean parameter? 

.. per guest. That is instead of a global one, have a per guest one?
