Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C58C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC642086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="YnlU4GM2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hFdk8+MO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC642086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbeJLPxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 11:53:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43665 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727689AbeJLPxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 11:53:51 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5BEA121BF1;
        Fri, 12 Oct 2018 04:22:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 12 Oct 2018 04:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=jBE/4lSfkd9XSdGMA6g41dHmoBu
        wR/T4O4xt8XWzaTw=; b=YnlU4GM25k+vLeEe9XfrFsEGDNrvhOJxBXoJkSu9Pde
        5po7qQD1N8ehttMtNnAW4PKyq0QmuIp0mpx9SIAx0sjkpZ/FQDZ9gN3erpUi/DEk
        nHQaeA/HlKD5Wjp/Wr98w7wqLzxuwq0tmH2fXHC1wQqJs9Sf5p+WNVZf9dAiMTKI
        nzTIn4p/xBORZBkIkm1jOYSqw8PIvdoiNeLJalYHseSKLDHo8yiuugwcTVk/3KhH
        7gmu5FDa/5i4IfFELctsfrtyD0VjQzS2MDURdyYcy1SgFHnX5Puxns32wEfb2ooj
        1GTrSZtGknXcG6ulErBJp13ApCV2+C4UXuqVitu695A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jBE/4l
        Sfkd9XSdGMA6g41dHmoBuwR/T4O4xt8XWzaTw=; b=hFdk8+MOYabiInJ9RwTa0G
        ac/vKxGQHxbGJPsUzjO4og6kIkTNK93ZPFLquDiVszzxyPmfZiok6b5V1QmEuL/I
        lqqKLhbpmAG+U0ySdri5/ASKyjNYk9XCPw5BVuHRDXrT3Amk7vNUf46U3XnBmEE9
        12pPbwzH5mLPbCB6XIhziKlqq9imQRKLNOONfypayPLSjGJo4ANQdcIz1vPIyBUH
        akkNSvp33UuV5j5JvMAsgEjG7FkUphWQxZyO2uj2yRj9tvYAPpujd/a4Ca8l5iK9
        aYYAixmJIYbsT/vvnRmeLi0KC5jNxrrAQKbEuZc5y14XBpihd8951VgBbNV81QUQ
        ==
X-ME-Sender: <xms:x1nAWxhbU52bv-0BkYTSMJ5ZiqMhR8z43G1UJ9u5Mi32gSDp48fBog>
X-ME-Proxy: <xmx:x1nAW9xDSANoCjFf5tjlROh4ONvDxzL3E78SppFnna-dSPczLghzHg>
    <xmx:x1nAWwE4TTWsA0cOVU-mUHzgfCyYL8arVVakCs7_MLQMwA3x24dcfA>
    <xmx:x1nAW6HHkNIdSrfPU-C_fVR8siv_CC7ozUGe7HgdOWfPMrOq03s82A>
    <xmx:x1nAWzDVMI-G40ZWUMPiR5zOCVYzTy6L1TdSukOuiyZWJiVRr_TRPg>
    <xmx:x1nAW597MkVWFpD6Hqgjc2Rr10vidi3y7hf2GTpAfETMra8BZrGu6w>
    <xmx:yFnAW39VINyQbBoZ-_lgc-8DoocUX-a2I813MyjVMNNF5tDlt3AjTg>
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9B550102E2;
        Fri, 12 Oct 2018 04:22:30 -0400 (EDT)
Date:   Fri, 12 Oct 2018 10:22:29 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the tty tree
Message-ID: <20181012082229.GA23069@kroah.com>
References: <20181012191509.4ad4e5a9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012191509.4ad4e5a9@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 07:15:09PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> Commit
> 
>   c9a8e5fce009 ("tty: wipe buffer.")
> 
> is missing a Signed-off-by from its author.

Yes, known issue, I took a patch from Linus that he didn't get the
chance to sign-off on.

thanks,

greg k-h
