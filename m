Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754309AbeDTI6D (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:58:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754264AbeDTI6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:58:02 -0400
Date: Fri, 20 Apr 2018 10:57:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rkrcmar@redhat.com
Subject: Re: [PATCH] KVM: s390: reset crypto attributes for all vcpus
Message-ID: <20180420105757.506c4421.cohuck@redhat.com>
In-Reply-To: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Apr 2018 17:13:52 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> Introduces a new function to reset the crypto attributes for all
> vcpus whether they are running or not. Each vcpu in KVM will
> be removed from SIE prior to resetting the crypto attributes in its
> SIE state description. After all vcpus have had their crypto attributes
> reset the vcpus will be restored to SIE.
> 
> This function is incorporated into the kvm_s390_vm_set_crypto(kvm)
> function to fix a reported issue whereby the crypto key wrapping
> attributes could potentially get out of synch for running vcpus.
> 
> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>  arch/s390/kvm/kvm-s390.c |   18 ++++++++++++++----
>  arch/s390/kvm/kvm-s390.h |   13 +++++++++++++
>  2 files changed, 27 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
