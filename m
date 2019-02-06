Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199C7C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BA620B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="na9ZA9Jw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfBFMyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:54:07 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:7671 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbfBFMyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1549457646; x=1580993646;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=kRiBg6+PJSypMIEr1o3KlnRGpo6KX2xIqB3DZhbH498=;
  b=na9ZA9Jwd8WHkYHRaFeTyThyNRL4rC4uqQE9+eWTlJxbnA0+OMTsr553
   mfcM7EselnmxPUJlb0D0In5+8FxssTS6+ORkJ0D0by7yl031j/gl8on7A
   M2Qqcvf9Nzn+8jdjy3TRnQnke6trP9Rm+fj+Ss/b3zibgWguS1G2MesNv
   4=;
X-IronPort-AV: E=Sophos;i="5.58,340,1544486400"; 
   d="scan'208";a="657949096"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 06 Feb 2019 12:54:02 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id 0721FA20B6;
        Wed,  6 Feb 2019 12:53:58 +0000 (UTC)
From:   Julian Stecklina <jsteckli@amazon.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Suthikulpanit\, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        "joro\@8bytes.org" <joro@8bytes.org>,
        "rkrcmar\@redhat.com" <rkrcmar@redhat.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "bp\@alien8.de" <bp@alien8.de>, "hpa\@zytor.com" <hpa@zytor.com>,
        "sironi\@amazon.de" <sironi@amazon.de>,
        "wawei\@amazon.de" <wawei@amazon.de>
Subject: Re: [RFC PATCH 7/8] KVM: i8254: Remove need for irq ack notifier
References: <20190204144128.9489-1-suravee.suthikulpanit@amd.com>
        <20190204144128.9489-8-suravee.suthikulpanit@amd.com>
        <8ecf791c-d850-25d9-562e-aa2ff5944d2e@redhat.com>
Date:   Wed, 06 Feb 2019 13:53:56 +0100
In-Reply-To: <8ecf791c-d850-25d9-562e-aa2ff5944d2e@redhat.com> (Paolo
        Bonzini's message of "Wed, 6 Feb 2019 11:29:15 +0100")
Message-ID: <ciirm8sgx1axi3.fsf@u54ee758033e858cfa736.ant.amazon.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Alternatively, it is probably a good time to switch the default to split irqchip
> in QEMU.  Split irqchip was introduced in kernel 4.5, which was released about
> three years ago.

I totally agree. At some point, the in-kernel PIT/PIC emulation should
also be removed, but I guess it's too early to talk about this.

Julian
