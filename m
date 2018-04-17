Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbeDQPLH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:11:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752613AbeDQPLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:11:05 -0400
Date: Tue, 17 Apr 2018 17:10:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
Subject: Re: [PATCH v4 02/15] KVM: s390: reset crypto attributes for all
 vcpus
Message-ID: <20180417171057.2030e56b.cohuck@redhat.com>
In-Reply-To: <4dd8242a-4f25-065f-5eea-e53c73130763@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1523827345-11600-3-git-send-email-akrowiak@linux.vnet.ibm.com>
        <41496d07-54b3-5cc6-8803-a935f6d821ee@linux.vnet.ibm.com>
        <4dd8242a-4f25-065f-5eea-e53c73130763@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 10:55:30 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> On 04/17/2018 10:29 AM, Halil Pasic wrote:
> >
> >
> > On 04/15/2018 11:22 PM, Tony Krowiak wrote:  
> >> Introduces a new function to reset the crypto attributes for all
> >> vcpus whether they are running or not. Each vcpu in KVM will
> >> be removed from SIE prior to resetting the crypto attributes in its
> >> SIE state description. After all vcpus have had their crypto attributes
> >> reset the vcpus will be restored to SIE.
> >>
> >> This function will be used in a later patch to set the ECA.28
> >> bit in the SIE state description to enable interpretive execution of
> >> AP instructions. It will also be incorporated into the
> >> kvm_s390_vm_set_crypto(kvm) function to fix an issue whereby the crypto
> >> key wrapping attributes could potentially get out of synch for running
> >> vcpus.
> >>  
> >
> > Wasn't this 'issue' reported by me by any chance?  
> 
> Yes it was .... was I supposed to include that fact in the commit message?

A Reported-by: is usually nice.

> 
> >
> > I agree with Connnie, we don't need the forward reference to
> > ECA.28.  
> 
> I'm not sure that's exactly what she said, but I'd be more than happy
> to remove it.

It was kind of implied :)
