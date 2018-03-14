Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1838165-1521035825-2-16073625570639364766
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521035824; b=sztD6H0djffkyS1tblpxB/O5nK3R/YjVmynExDT9zWWXGGc
    seHeBADX1mtLmMnsfYp9tHsTJ7WF+qD9uX9PaX098elq+rbEWjDxrCyzGWKGbR+z
    JfRcz19ceIVrkFOwo3l0/xW4MPuTcOKV6dlZQPRcI4MRQ+rAepB9nDRgvPSyKNmt
    /ykPPBm++2Ps+QG2zVQ24UpfRz1asdAMpLU95YguHppWJ+x7YQBas2GbY9VW4Wmy
    ZQEga5o9H2YwnWL4VVkeMkpTId74/g9X0pz+20vQQoy5gKzh4akuM/CJtsaExJ8b
    /MAExFm10YGZLFstk5yMJTBjmPkOKOs+N36yGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521035824; bh=9dwsQfjoi+0qcF7Hwm1f8m1QZJ
    BgpwdaRzq+n7AcSsQ=; b=vhX5dHBHNB8KzZqKnlQ5AuDQKHHN78RcSew2GRCh6L
    Kc69Ix7DWMkVcgNO5xU2qXEijbNxqNVvnVoOqlU1/fxGr0W+xqp4IlfcGg0AUQGo
    FKNdZHi/z1pn+kiENs0Jr/9RBk9z5pCb3++L+BU7uwLFpSLMu94SpPPLVnBuE3sq
    lD+GNmZi7xRDtCZdYYpov0w4yUKItsO518+ZD0IJn9zjS37J82UQTNxIHTdTvWrS
    YjxSCSWaS0o/yMFCM2EHa1lLOZaA5kUYCKChDmkXF95FQRV5bHRFaGSOBOl1qnKz
    RJY2XWCrXIxcAg+GvMUPqabQojYJ+HLjTEyRZNBVmSvg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbeCNN5D (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 09:57:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37410 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNN5C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 09:57:02 -0400
Date: Wed, 14 Mar 2018 14:57:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: patrice.chotard@st.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jslaby@suse.com,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 3/3] ARM: dts: STi: Remove "console=ttyASN" from
 bootargs for STi boards
Message-ID: <20180314135701.GA20286@kroah.com>
References: <1520444134-30144-1-git-send-email-patrice.chotard@st.com>
 <1520444134-30144-4-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520444134-30144-4-git-send-email-patrice.chotard@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 06:35:34PM +0100, patrice.chotard@st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> As serial interface is already specified into stdout-path property,
> "console=ttyASN,115200" from bootargs can be removed.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
> ---
> v4: _ none
> v3: _ remove "console=serialN,115200" from bootargs and use prefered 
>       stdout-path property
> v2: _ none
> 

This patch does not apply at all, are you sure you made it correctly?

Can you please fix it up and resend?

thanks,

greg k-h
