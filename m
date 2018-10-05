Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8C6C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680532087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZpaYEOIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680532087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbeJEWgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:36:33 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53421 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728606AbeJEWgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:36:33 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AA6D721ADD;
        Fri,  5 Oct 2018 11:37:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 05 Oct 2018 11:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=xNwhbk
        C0GQ0S0lQCEvpF+v86t8v90Zr0XRYQNREDyKQ=; b=ZpaYEOIaYDNbvq4bgtKpAa
        /Ijo/b7/AEFOXYorlnZj8I9VDF531wdlWJ7gj5o0CEvRWkwkvBnMaPNmVdbyjHjN
        4U/AKTnBeFgmq15I6Ya8RyEezrYMIumhdWa9eMwlblz5OWIv/HpEHVhMVyP5DOTS
        9bfkzdQ7rnX9vdPTrAQPb2KEmklSkg86BxJ5IMv8JDZJFZ8yPHDTNlSmIcOfvrwR
        zh90wST2fRkz9JJXw8kPZqjAqzjv9RSIlwUQhPILjbAtzXAqJZvVdk2ZXIo3JkBa
        jkeuPweBdgoMKFE3pmtU/WG4Wz4TGFAgA+rFSvajp7zQWDtjx+tlX0BQ9DEDj81g
        ==
X-ME-Sender: <xms:LYW3W_bKpykNeNELsJfRb7UjNCoMDYosBY8PaFGmnt-wrsIeg6GO6g>
X-ME-Proxy: <xmx:LYW3W_waUQNBKm7D0VpG9BdpUKzUaBzK7H8dEZrx4quvfzaIWEuUFg>
    <xmx:LYW3W4s3BmLAYn7x-htPiQkUr5uPsDqcE9lrmbAl7wMjnBgrw0_5Ig>
    <xmx:LYW3W0vAZjWG1BCsNJyi8a2ll0wgo8a3fbyHb_9H1w4-MgHYnA8CVQ>
    <xmx:LYW3W2k2Bneb3L67QUdChfcxDOqnt8TFHEedtCrhvBzIdyYuMKjhJQ>
    <xmx:LYW3WytYJfbxE-pYi_eB_Z926LEC3qZQ8a0KPKon-XJJEL2ljIZQYA>
    <xmx:LYW3WxHyXUJ5cXXGZwQDycOmx_R3Y_nAPenSQAoMkZboEFbO_yzGxQ>
Received: from localhost (unknown [216.9.110.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 822C3E4A3D;
        Fri,  5 Oct 2018 11:37:16 -0400 (EDT)
Date:   Fri, 5 Oct 2018 08:37:12 -0700
From:   Greg KH <gregkh@linux-foundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: Re: [GIT PULL] KVM changes for 4.19-rc7
Message-ID: <20181005153712.GC530@kroah.com>
References: <1538726433-17221-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538726433-17221-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 10:00:33AM +0200, Paolo Bonzini wrote:
> Greg,
> 
> The following changes since commit a27fb6d983c7b5bb0129ae4d7a7c81758173bfab:
> 
>   Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2018-09-21 16:21:42 +0200)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

Now merged, thanks.


greg k-h
