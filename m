Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C78C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D2E20858
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F5NAFV83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D2E20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390568AbeIUWPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:15:24 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48027 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728221AbeIUWPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:15:24 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5B2E921CA5;
        Fri, 21 Sep 2018 12:25:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 21 Sep 2018 12:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=9PCGtsrO5wnyenp3WhNLdMbBhfz0Z
        6GW9v39HYq37Ro=; b=F5NAFV83J9oYl45BTxpnd9Lyen+yNJfiqkaChgXgeSt4x
        7j3fkbEcOfe/yLeGEgcOyf+XGoFCWmwhSYx1Vh0tyB77RfcaTFnn9r9+b3VdrjR1
        8I0AIjnKi8Rd4hBRNT8MdPL41Ql7zgiUQ+wPAiMOaCJrBxaorFsdiAdxPGT0w/9x
        CaC9/1skkFq9pMk5VZSE7KSv8HE1rt1NA9sDnUFLj6Q44JAG2SUQfF7jAhl5MGnf
        Lvu/pdgyGvmVF9qQGp0tpQ582eMMhsAxpuh27g4/JG4/4lFXDb14AxWPI63otxrC
        00ifLHv8SteHHuZ6lp9wEbkOQ5uI43bdkVdWdvo+g==
X-ME-Proxy: <xmx:ixulW55x62sleqYXwSfjNE0n-iwLBxRYZ6qsp58f4t_WtcxqNiyGuw>
    <xmx:ixulW8giGopS9IKsDZ7X7Eay1uiiDaHSVwxr_gxLVcqiR0INmBateQ>
    <xmx:ixulW1brb8kaohcjLbQ9qIBzIu_tL_Y_NGSyiBgG7SMl5lk2xwCirA>
    <xmx:ixulWyjTdaTqdMgjn8785BU9y2MiQBfKSttOs2EO8zMcXeNAHV4F4A>
    <xmx:ixulW6cALMCvHklSQqI1XDtkrpCEycZH2BLzdUsOP1NlctgOViIcEA>
    <xmx:ixulW06Vy7tsPgizrKD2zWx4vae2iZ8_Hs3d30Qm82vvyACgUORxWA>
X-ME-Sender: <xms:ixulW8xUDVH1H2P6RhqntXOW1wFNqGgetCiidCbmEUeNDHU-JKvGbg>
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA074102E8;
        Fri, 21 Sep 2018 12:25:46 -0400 (EDT)
Date:   Fri, 21 Sep 2018 18:25:45 +0200
From:   Greg KH <gregkh@linux-foundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, rkrcmar@redhat.com,
        kvm@vger.kernel.org
Subject: Re: [GIT PULL] KVM changes for Linux 4.19-rc5
Message-ID: <20180921162544.GA32325@kroah.com>
References: <1537538766-8252-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537538766-8252-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 04:06:06PM +0200, Paolo Bonzini wrote:
> Greg,
> 
> The following changes since commit 7876320f88802b22d4e2daf7eb027dd14175a0f8:
> 
>   Linux 4.19-rc4 (2018-09-16 11:52:37 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
> 
> for you to fetch changes up to 26b471c7e2f7befd0f59c35b257749ca57e0ed70:
> 
>   KVM: nVMX: Fix bad cleanup on error of get/set nested state IOCTLs (2018-09-20 18:54:08 +0200)
> 
> ----------------------------------------------------------------
> This pull request is slightly bigger than usual at this stage, but
> I swear I would have sent it the same to Linus!  The main cause for
> this is that I was on vacation until two weeks ago and it took a while
> to sort all the pending patches between 4.19 and 4.20, test them and
> so on.
> 
> It's mostly small bugfixes and cleanups, mostly around x86 nested
> virtualization.  One important change, not related to nested
> virtualization, is that the ability for the guest kernel to trap CPUID
> instructions (in Linux that's the ARCH_SET_CPUID arch_prctl) is now
> masked by default.  This is because the feature is detected through an
> MSR; a very bad idea that Intel seems to like more and more.  Some
> applications choke if the other fields of that MSR are not initialized
> as on real hardware, hence we have to disable the whole MSR by default,
> as was the case before Linux 4.12.

Now pulled, thanks.

greg k-h
