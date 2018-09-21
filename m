Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28826ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2D32154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBL+wbs+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2D32154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390040AbeIUToi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:44:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33875 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727392AbeIUToi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:44:38 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9B76D21B7F;
        Fri, 21 Sep 2018 09:55:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 21 Sep 2018 09:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=cyonCF3S7yVqS0fPiEdZdX8uLFsHG
        Dq4XIykZ9RutFg=; b=tBL+wbs+iVQKU33AzohpUiuE3kKShIv9FnDF9RAAgoRB9
        8pyf29VlICYgz/fO+LxdqYPs3AMxYIR6RrBWag73XGj9VbOK/RM9cAsVtbIunGpv
        LchI2ncpUKqhBZbxC1kny+UB6D8PCetJ8i7Ew3cS0kBvuTrYyhxb/8zhadDOQxr3
        op6u0KvHZg5ZVwjMMA0h/Ktc3RZlMBdMqgoM4QwAFz238l9FYDCHLQhKGdxRKXnM
        dNmjZ+wR0o2whMsjXmRQUahH7cfNSVECcEN5l8M97LgP6e35P598drmjiqs5MFvw
        xQyJJJglMOGa822kP3LYG7RYmlgqR4HWr2b0L1p4g==
X-ME-Proxy: <xmx:WPikWxSgmMlhkxBj2RSvwQNgZSNFfJrda9JUo0SFMC5VHLW3tOiT5A>
    <xmx:WPikW5DYJeoKttsgxqJiV-GlRd6cfMoZqLv8WHph7sAE6aquO4sxPA>
    <xmx:WPikWz8W_hrbh-0iATCR_4KTzF-TNMBuKgFz1FKJRrBznuE_ZHzF0Q>
    <xmx:WPikW71dHvURLPWiZ3_NJi2faW9y4wLSez9gNJF5CA3kQ7415y7Q4w>
    <xmx:WPikW6TTtrM5PbHdcmhGZcODZ6VbsQXSWzN2UtNQ2tWO46FRSWCu-A>
    <xmx:WPikW8Xn7XxJnIjhFuKifuWwjFB6chatQpDO0I158kL1DugjZHMJ1Q>
X-ME-Sender: <xms:WPikWyk9YwriW2svWPAuF92BEBQuc0h3V7MIPtI0T-tLdZJCK5cHbw>
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id F0CC6102A0;
        Fri, 21 Sep 2018 09:55:35 -0400 (EDT)
Date:   Fri, 21 Sep 2018 15:55:34 +0200
From:   Greg KH <gregkh@linux-foundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: Re: [GIT PULL] KVM changes for Linux 4.20-rc5
Message-ID: <20180921135534.GB13900@kroah.com>
References: <1537532067-42759-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537532067-42759-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 02:14:27PM +0200, Paolo Bonzini wrote:
> Greg,
> 
> The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:
> 
>   Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/virt/kvm/kvm.git queue

No signed tag?  You did that for the last pull request you sent to
Linus.  Any reason you didn't do that here?

Care to fix that up and resend?

thanks,

greg k-h
