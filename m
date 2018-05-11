Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbeEKPjx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:39:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54632 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751048AbeEKPjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:39:51 -0400
Date: Fri, 11 May 2018 11:39:22 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tim Shearer <tshearer@advaoptical.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH 1/3] KVM: VMX: Introduce per-VM I/O permission bitmaps
Message-ID: <20180511153922.GA31844@char.us.oracle.com>
References: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
 <1523943962-25415-2-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523943962-25415-2-git-send-email-wanpengli@tencent.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8890 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=635
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805110148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  	/*
> -	 * A vmexit (to either L1 hypervisor or L0 userspace) is always needed
> -	 * for I/O port accesses.
> +	 * Merging of IO bitmap not currently supported.

s/not/is not/

And with that

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> +	 * Rather, exit every time.
>  	 */
>  	exec_control &= ~CPU_BASED_USE_IO_BITMAPS;
>  	exec_control |= CPU_BASED_UNCOND_IO_EXITING;
> -- 
> 2.7.4
> 
