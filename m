Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A552FC71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6706720895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 13:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vSbZEkGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6706720895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeJMVUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 17:20:35 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37165 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbeJMVUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 17:20:35 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 16F4821B2D;
        Sat, 13 Oct 2018 09:43:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 13 Oct 2018 09:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=h1CAiv
        5wyHCAJxkS8xn62nWmj0smA0t++/GV0FjfCJM=; b=vSbZEkGJdV5onxH4IE09aV
        VrCsLd6no5IGg0CJYCOklZSLmKwCXXqALB3Hge45dYLUn7RjmQ+Lmwr59WzCreHC
        QUw4qi+SnCLhVnyFWkKlGRfKHdrDugbZyW2xh5AeWjJdXJRAjBLLqBkksrWjwXm5
        VV9/UH7RZbiERNyatld76YK8Qie1Z9qQeH3dyUI8S1/S6B8mJ1+lpdsjn+m98nil
        0Lsmmh0yInhoZLC2ZvYCVqp1C+RniiJKJe279I/ReCJrMGUcaiVcp1PfuR9C7P6U
        8KMtQxgRGPEQfU/R+0FRtHFDvuZ0g6qysy/61Uacmbw/oHdm8edPjzgRBmAX4NHw
        ==
X-ME-Sender: <xms:evbBW61VbXxbl-aOVhF39x5JpoGKlipcLKkiyjHtt3qDhh--8oeOAQ>
X-ME-Proxy: <xmx:evbBW2v61D-9Qfq4tlfpSoRtJUVUjEhszuLesnXnUN-SYwE2fTkgWA>
    <xmx:evbBWwuT1dWpfXOlsFrvd2zr6VX4Hwo_-ujhYf3bL4CCQg5gRnZnYg>
    <xmx:evbBW4t9rbTvOOOvmELb7ueff5WG6-UN38eb0EVlL-0WMbuF6i8ZEg>
    <xmx:evbBW97rLghCEbffiXYQ0QylJbaoBqcBEeXdUd6oX5MQVLQpfvf4Yg>
    <xmx:evbBW2SeYw0CktqM5y9vgUWf7hAbnfsAHP2fHxS244F-n23WKQCkGw>
    <xmx:e_bBW_rzsuAL7FacWEHqT9JGk3ZDXyQr6A6J7o-puvF9Bu7zAKW_3A>
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        by mail.messagingengine.com (Postfix) with ESMTPA id 48DFE102D5;
        Sat, 13 Oct 2018 09:43:22 -0400 (EDT)
Date:   Sat, 13 Oct 2018 15:43:20 +0200
From:   Greg KH <gregkh@linux-foundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: Re: [GIT PULL] KVM fixes for 4.19-rc8
Message-ID: <20181013134320.GA28946@kroah.com>
References: <1539423782-57079-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539423782-57079-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 11:43:02AM +0200, Paolo Bonzini wrote:
> Greg,
> 
> The following changes since commit cc906f07d7d569a30bb6f0baf8f80b2968353dc9:
> 
>   Merge tag 'kvm-ppc-fixes-4.19-3' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc into kvm-master (2018-10-05 09:39:53 +0200)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
> 
> for you to fetch changes up to 5f8bb004bca43f7b5043c02b4aa5b9b43e15fe50:
> 
>   KVM: vmx: hyper-v: don't pass EPT configuration info to vmx_hv_remote_flush_tlb() (2018-10-13 11:38:54 +0200)
> 
> (The last patch shows as committed a few minutes ago because I had
> unqueued it and now requeued it; I had tested it before unqueuing it.
> Just telling you because I know that Linus checks this stuff...).

Yeah, I check that stuff too :)

It is odd, but it's your subsytem, you have to deal with the fallout of
bugs for it...

Now merged,

greg k-h
