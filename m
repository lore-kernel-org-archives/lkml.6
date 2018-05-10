Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2524989-1525975768-2-2935956721537248264
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525975767; b=a+W1JpJiNFpBLyaRSE3dBrXnyrxQDUHMYD0sz4YUp0Wz+O39xR
    zLdGMQQr7ObfcvUnmusr2mp94esneUptNx5Lfh7b/N4ZtOIfa0Fj2GGO+qcpnQpn
    5Ns9y69e08vWMVaK7uDq7emq5/GK8lQkpL07zLxCPdOz1SXsWjzyA3b+oxJ/Z0p5
    NFNz8ya69shjbm09kwmVOaY1ziHatS2pbHOOk4rU2S8mW4Ks2ZYX8yrciWQ2uzfs
    Awr4nu+4/w7FqTJMzBCEBcp7dqH8ePAnm6QphveFHLNwvwwNdhsL1V673tR9VQPR
    0PmubmAl3pQNdr2j5b+kKurq7rF2y/oi6h3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1525975767; bh=ix2bTLWAM/Nd3Doya9cjE+qasUovArpVodlzwU0
    xEZc=; b=Q87B84UBh6mLJRQT4bXlrfBzlvl1fHmRbooFgUOFbkXRTwGOFpBTomy
    VB1M5CsHwC3/M6/FT591bHT/9LQSLFZvInqYIusHYG/bxzzNaSItOdm3emyd3Zfs
    W8zbbxoOD0TsSUamQbKJa8XDSLUTKEjIHpD1gywnrzitH1aHs547UNNwcoG5vDmE
    3Vu0vJSsmuW0IxXXziQUMiKR+J02M9AcM+CMtsuZESW19hMFAab9N26Pd/IkV3nR
    njYq6ex//DLB0evG1JP33pzUsiNYR+x6twrC+nH+TZOM/E2ayYS8xdlwvI1s85jR
    JBM79eDF5+BI5cOsnAqb5g7Z25oLHtQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLwO6w24QrQ68nb8z2gXSq+EStog8MMeOXhvO7LY9vp7jDqRsn2uJnWa9VbYFgsq78/X3Loe4q5CdNXERSh6irely1ob2+1ccp4igHhFq839DX9EImt3
    j/C2LITn1qhucuJSgY1mBLEQyYVYFvKl5RJFl+FvWmjfmmW41u4IEf6n0TvRTcjghstqyj99zwZ9LoS4Hw51YK0rISmkWAchtir61iCfC3T+TuFM2fxYjs/w
    vB6yJt9DQw+g4ZizmsDsLg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=IJv9LcIfAAAA:8 a=yMhMjlubAAAA:8 a=K6HrmWtEAAAA:8 a=VwQbUJbxAAAA:8
    a=3BHxA-pp4jnYww9m5voA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=cmr4hm9N53k6aw-X_--Q:22 a=yV38gEssg_2GhkhKF82i:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966853AbeEJSJZ (ORCPT <rfc822;linux@kroah.com>);
        Thu, 10 May 2018 14:09:25 -0400
Received: from namei.org ([65.99.196.166]:60130 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966849AbeEJSJW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 10 May 2018 14:09:22 -0400
Date: Fri, 11 May 2018 04:09:13 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Joe Perches <joe@perches.com>
cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/18] security: encrypted-keys: Remove pr_fmt duplicate
 logging prefixes
In-Reply-To: <fd41a51e9258970fa0de06912884bfd673609581.1525964386.git.joe@perches.com>
Message-ID: <alpine.LRH.2.21.1805110409080.1003@namei.org>
References: <cover.1525964381.git.joe@perches.com> <fd41a51e9258970fa0de06912884bfd673609581.1525964386.git.joe@perches.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 10 May 2018, Joe Perches wrote:

> Converting pr_fmt from a simple define to use KBUILD_MODNAME added
> some duplicate logging prefixes to existing uses.
> 
> Remove them.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  security/keys/encrypted-keys/encrypted.c | 63 ++++++++++++++------------------
>  1 file changed, 28 insertions(+), 35 deletions(-)


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>

