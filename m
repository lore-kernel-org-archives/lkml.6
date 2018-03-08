Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2594629-1520534455-2-17939232859942211547
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='au',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520534455; b=qdqb2SsY2EW62diTMLivPR87E67lDwbvrUC3odgIpQIscoE
    GCJgbk/UlZDCHW+AguZLwJSe4JazFvaxx2QvK5pMrgQDwQ67QZdimy3m91QsoP2s
    E6KYAbrGAdCGclLR4hZIa5QEUWlOVX2RNEhZacvABbYVu4KX/noxAFZmjMAcLMxo
    wAs/Jgw15V+/QZVXekAgXhNAbCL9VMUEuR3BuHZ43vMsVl9PvzLBVuB7DozUR1mD
    mg5cMcWk91iMoNb1pWUhY08WEjYBAkoKhvlhcAAlRbq3lTdtRBmSN6iVdm1njpNH
    AkLeKKq9C4SlNMRZ0mnc37WVKGZIDAHWh6okBCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520534455; bh=zSo41Bo2IEImLh4ZN7AuREnnpf
    EkF0gY6xBHBUHifPg=; b=MrMLN3ybg+TNpcT7XbM2Iy9uZ6LaL8dxiSg0bSxrKN
    3wpci+LHbAwOfMKukTagn0hkYBbBZIBCbJZQWE3qyoR2GOc6k7Uf+ZrSolGP7JXE
    yAI/PjVZAKP4dx45gb2rFNr7HxTMTHrH2lgZRR+MFfkCvMdkWiyMaCvnNC4KOPtT
    0TdJLSr0h2OvTPSyEIxQoP8l990MIfOA+TATsEeqrHG3UfWZ2uz2WzktsXQ/Z6hN
    xZ+khAOi2ncFu+eKSRsr82vV4TMgyyIbfkVQgoZlFm7byThoOXHQcS2LgVRqWZxz
    P4QPpOD3FL07J15SeKu0yLp7ixH5LVsl3ATEe7waHWsg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gondor.apana.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gondor.apana.org.au header.result=pass header_org.domain=apana.org.au header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gondor.apana.org.au;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gondor.apana.org.au header.result=pass header_org.domain=apana.org.au header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeCHSkh (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 13:40:37 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:37178 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751652AbeCHSkg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 13:40:36 -0500
Date: Fri, 9 Mar 2018 02:40:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Greg Hackmann <ghackmann@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: xfrm: use preempt-safe this_cpu_read() in
 ipcomp_alloc_tfms()
Message-ID: <20180308184020.GA10422@gondor.apana.org.au>
References: <20180307192416.233202-1-ghackmann@google.com>
 <20180308073328.GA8111@gondor.apana.org.au>
 <feddabcd-61c5-a1ef-8c1e-6e3f1d71a9b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <feddabcd-61c5-a1ef-8c1e-6e3f1d71a9b9@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 08:31:47AM -0800, Eric Dumazet wrote:
>
> Because that would not be nice.
> 
> this_cpu_read() is faster than going through raw_smp_processor_id() and
> per_cpu_ptr()

I see.  In that case I have no objections to this patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
