Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-434588-1525248327-3-4868706255358676867
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525248327; b=bWUvaqgPmJfuPz/PfGHF1RbJwznzdDIDILaqsRTfXS8K716U6B
    dlLJPTgWowA4PolTxsQW4QO2eDZ7ZMjz9Aam7MwFwMZVK86IHMNcW7nbEWdojeaC
    S6TwdWDfyD//JaX5DhtEHQCbl8R4H+gO9JSU/LsIw844+Gxy79pSV5Jst6yRvgj6
    ni7md5nKZF97OqdLOY7xJMtcsrnB4Bu8TPCmeO58BqLhM+m8IiUkUnffIRtJ4pII
    E31VjmdgAfaq1gSPULm8oG4NpMqYISa0tFZjPTFdYHKbu6KhQlHd/eX2pWtkJhBx
    fOEZb6K+bEhX6yXmg25l8iCV3sqouDrfw7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:in-reply-to:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525248327;
    bh=9NOrQhToLdpjJp8J/rzVzvTU6LDgXf+K0VK/UGdPY94=; b=I59eYtz1uqg8
    NCtDCoHI5r4kGSdbHg/xK8Ret+gx/TrR5n6jgCAs29lUydknLO8FNvl9ekg+vWbo
    eF+s+RWl0MtLSveMnFK2h3KsKJKwgP6pigOr2tKkSLR42s6EKdCb/VY3laH3jnFN
    wXVHJsC1ot0uNodrWRppEJJFO/k1tRp1/hFx2btAyNB2POC8u5rQuZgfVG772Xqe
    koQDUvQwGk9U4sFdELHly7pf/5qU0HmJzh8DBcTasSzG7IUGQORXvKl1E+4uShNh
    vBXxVgqwkPfC+CKEx9kZzikRcuZBNusVvHnDv3l2pNygRqe69qqpbHHgamrHJW/M
    JSaJASlgQA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-90 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-90 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKVN6uhYI0amIJPC4vKLZKIrb2eDyqAyVRHVsBDaRj1IZwsc1pH+TEYvddedr/Z7hc9ZKDRk0Z6p0TlQ6bfd2BeObBGR1TN8vLv2gQ7F8JyiyLho6Xfh
    BHWmhFXKLSPlgWzQ0CBVaoGxJxjfn8SvDaFXgLLN1ztijGw3APed1FiiNS/vtuDQ5qXaq4lZ/Eb35KwbiLDszxHWRIR6wN87wo117FpY+age3OfQaPeaSsLp
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=MqAvrVvU0T_ckHue7KkA:9 a=CjuIK1q_8ugA:10
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbeEBIFX convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 2 May 2018 04:05:23 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:38085 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbeEBIFX (ORCPT
        <rfc822;groupwise-stable@vger.kernel.org:4:2>);
        Wed, 2 May 2018 04:05:23 -0400
Message-Id: <5AE9713D02000078001C007B@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Wed, 02 May 2018 02:05:17 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc: "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 2/4] xen/PVH: Use proper CS selector in
 long mode
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-3-boris.ostrovsky@oracle.com>
In-Reply-To: <20180430162339.17143-3-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>> On 30.04.18 at 18:23, <boris.ostrovsky@oracle.com> wrote:
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Reviewed-by: Jan Beulich <jbeulich@suse.com>

But to understand why things have been working nevertheless it would
have been nice if the commit message wasn't empty, but instead said
something like "The two happen to be identical on 64-bit."

Jan
