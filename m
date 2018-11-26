Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6658FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3415020663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 17:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3415020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeK0Epb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:45:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54778 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbeK0Epb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 23:45:31 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A2BBC036769;
        Mon, 26 Nov 2018 17:50:41 +0000 (UTC)
Received: from gondolin (ovpn-117-95.ams2.redhat.com [10.36.117.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C840587A8;
        Mon, 26 Nov 2018 17:50:38 +0000 (UTC)
Date:   Mon, 26 Nov 2018 18:50:35 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Junaid Shahid <junaids@google.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: Re: [PATCH 1/3] kvm: make KVM_CAP_ENABLE_CAP_VM architecture
 agnostic
Message-ID: <20181126185035.19635614.cohuck@redhat.com>
In-Reply-To: <1543251253-24762-2-git-send-email-pbonzini@redhat.com>
References: <1543251253-24762-1-git-send-email-pbonzini@redhat.com>
        <1543251253-24762-2-git-send-email-pbonzini@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 26 Nov 2018 17:50:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 17:54:11 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> The first such capability to be handled in virt/kvm/ will be manual
> dirty page reprotection.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Documentation/virtual/kvm/api.txt | 13 +++++++++----
>  arch/powerpc/kvm/powerpc.c        | 14 ++------------
>  arch/s390/kvm/kvm-s390.c          | 11 +----------
>  arch/x86/kvm/x86.c                | 14 ++------------
>  include/linux/kvm_host.h          |  2 ++
>  virt/kvm/kvm_main.c               | 25 +++++++++++++++++++++++++
>  6 files changed, 41 insertions(+), 38 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
