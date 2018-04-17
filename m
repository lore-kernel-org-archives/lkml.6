Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeDQKKv convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:10:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752086AbeDQKKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:10:50 -0400
Date: Tue, 17 Apr 2018 12:10:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Harald Freudenberger" <FREUDE@de.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>,
        Tony Krowiak <akrowiak@linux.vnet.ibm.com>, alex.williamson@redhat.com,
        alifm@linux.vnet.ibm.com, berrange@redhat.com,
        bjsdjshi@linux.vnet.ibm.com, borntrae@linux.ibm.com,
        fiuczy@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, kvm@vger.kernel.org, kwankhede@nvidia.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        mjrosato@linux.vnet.ibm.com, mschwid2@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, pbonzini@redhat.com,
        "Reinhard Buendgen" <BUENDGEN@de.ibm.com>, thuth@redhat.com
Subject: Re: [PATCH v4 03/15] KVM: s390: refactor crypto initialization
Message-ID: <20180417121044.5c8f2182.cohuck@redhat.com>
In-Reply-To: <OFE3FE11B1.8E1BDDEF-ON00258272.002AEDB1-C1258272.002B06EF@notes.na.collabserv.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1523827345-11600-4-git-send-email-akrowiak@linux.vnet.ibm.com>
        <4fb50a31-1893-5cfb-0f35-fb2501c2afa8@linux.vnet.ibm.com>
        <OFE3FE11B1.8E1BDDEF-ON00258272.002AEDB1-C1258272.002B06EF@notes.na.collabserv.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 09:49:58 +0200
"Harald Freudenberger" <FREUDE@de.ibm.com> wrote:

> Didn't we say that when APXA is not available there is no Crypto support
> for KVM ?

[Going by the code, as I don't have access to the architecture]

Current status seems to be:
- setup crycb if facility 76 is available (that's MSAX3, I guess?)
- use format 2 if APXA is available, else use format 1

>From Tony's patch description, the goal seems to be:
- setup crycb even if MSAX3 is not available

So my understanding is that we use APXA only to decide on the format of
the crycb, but provide it in any case?

(Not providing a crycb if APXA is not available would be loss of
functionality, I guess? Deciding not to provide vfio-ap if APXA is not
available is a different game, of course.)
