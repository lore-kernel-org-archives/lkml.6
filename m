Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-872240-1523535638-2-7301310418440484195
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CA'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523535637; b=JVvyyDR25V3/yyLMro2UCIoHDNs3vZIcqyjrvGhZuKwR224LFj
    GHyCZCCVuvSWEC1Hy7Rj94vHIKYSBKlpAu+EaNWdymQrhKayQ7Il5GUajYTPaTQa
    jICzA/9kSYlWcKzUK8a2hwZQ96cuLC/KLTTzndM6EAHl49h+6mz1fDxqCsn3hv+S
    Zr4d1+YeSz8wiihyZB+HdlAZR/EdMOVbs55Vc+Y8KIpDKtIWA6ME4x/YJHkSFwPB
    nGhP141KcspCADwxDSAjB4bH42e5Cs+6GK2M9NU6Qq9IALIPPNEEgT14rtPzTmRf
    veOcx7Y1QINQSItTNuy3U8SJ8Fnw1ZrgVrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:in-reply-to
    :references:subject:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523535637;
    bh=EeaGBTFie6ALt7PPlfejxXuUeOPZCrUmYhf33X3d9yo=; b=e22ZbLjX90Hk
    6k3IxeU7FylpZwb6LVN+kJEMMJF3lS1G0gLl2Xty5vsSiYDBUypCC0dbfC4x3Y1W
    nGmD+csBtOdpuWL9QSN51N2rNq/xn0d+KFdEdVt4nWP5QYZAgSoutAlqGKsbWlWz
    d5KgR6zlF0Jvryn2dsTs45qWA7ktoW31nfgZFfpASIBQaTuBSGLyXsAENDPKa+SB
    g0g9nwk1TTIWtWu+QaGPVu0V1DlGDaN2Pn8ep/2pTvaqKjgbaTzqDo9ddMJ824OB
    OOQhgAkVYsiBg1HYaSLGwXpLi9Ip8PPREvJgYijn0b3+TFSD9GfmqRUkmbSGRe/t
    EIE+EZk/0w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=efficios.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=efficios.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD7deQwlIIJDVJr5MumwE7/dR+k6SqHuaEx/kyvHuj5yI0+uUTAciHV34913a/micqPLcaOUIW6GJD4xJrUxxNW6QDVFbI/J733bUzgYH3nMvxqf1FwH
    qaZkvKSldwjGAXM409eAfv1IuAWZNEWokhJkV2ktgur2QrU1+DViSPrOVXy82dAYqjWNCN4M6TbdzS10pq0URwG8A8kgD0jQOkvXf9sNS940Zmr8gdTzEaGa
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=FKkrIqjQGGEA:10 a=alcw4SYXYecA:10
    a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10 a=FqpbrowB-PMA:10 a=pGLkceISAAAA:8
    a=7d_E57ReAAAA:8 a=VwQbUJbxAAAA:8 a=3iOD4vu_0_h0fXPiZXoA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jhqOcbufqs7Y1TYCrUUU:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeDLMUL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 08:20:11 -0400
Received: from mail.efficios.com ([167.114.142.138]:50734 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeDLMUK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 08:20:10 -0400
Date: Thu, 12 Apr 2018 08:20:08 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        maged michael <maged.michael@gmail.com>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Watson <davejwatson@fb.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Greg Hackmann <ghackmann@google.com>,
        Will Deacon <will.deacon@arm.com>, David Sehr <sehr@google.com>
Message-ID: <1431121546.8624.1523535608737.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAKgNAkiGXL6Th4DGS_OD0MuwCtM6f7_nAehOVcbpU=u5L9atKA@mail.gmail.com>
References: <20180212195549.11485-1-mathieu.desnoyers@efficios.com> <CAKgNAkiGXL6Th4DGS_OD0MuwCtM6f7_nAehOVcbpU=u5L9atKA@mail.gmail.com>
Subject: Re: [PATCH manpages] membarrier.2: New membarrier commands
 introduced in 4.16
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.7_GA_1964 (ZimbraWebClient - FF52 (Linux)/8.8.7_GA_1964)
Thread-Topic: membarrier.2: New membarrier commands introduced in 4.16
Thread-Index: vxeagk3Is4PPdMRLz1bt7YGMQmn/fQ==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

----- On Apr 12, 2018, at 7:42 AM, Michael Kerrisk mtk.manpages@gmail.com wrote:

Hi Michael,

[...]
> 
> I have applied the above patch, and done quite a bit of tweaking, and
> pushed the results to the git repo.
> 
> I would be grateful if you would read the entire manual page as it
> currently stands, to see if anything needs improving. I isolated some
> of the more significant changes into a simple patch, shown below, and
> especially I'd like your confirmation that all of those changes are
> okay.

Thanks for applying my membarrier man pages updates. I've reviewed the
result and it is all good.

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
