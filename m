Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-897776-1525273215-2-9746377038611088415
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
    1525273215; b=F2+6p5vilWdxsIRM67nmQpLO/sM+XE/Eyf3qAt8hl85klyiLzU
    0qFiEn4ZhMm/8Q4ADlDSZCmwkZuN/C3bxXt80JZ6Y0wjUCUOy+pW5HlGsiKlnGPe
    3ssgx35XsjeGjHpPI9gXv53bnYuVbYZNMPPq3JEvqfNL4gRa45yBFtrAWXrWTIAa
    k1Y+7Rn/Kvbr0zofNmwiUwagHOVuWikwDlAY/MfQ5RV/7DUOrEqHGAwfr5uDJFqc
    P0y/5/sGw9R24FkPmvhzAGsRH6y76o+37RFcLMdkti/bhS7wbObvNgKtL9Io6FV4
    BhsYrdrd7HAeVukf7OQlL5JDBm24m562wUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:date:from:to:cc:subject
    :references:in-reply-to:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525273215;
    bh=vwwmNZVZTWW5PkkEOEqN8g7r2mWBhIOVVQfLV3fG3cc=; b=HxhyKuXvRYFo
    /2N8NZBdXuX+iG4BQE4gGFPStZMR7rCxGcBHeO9YhdqAzS0/9fVcyoZG6WIwRH7K
    VYT4b1NejuPNKCfslmk6tbJwDTkBbGre8OtqMe4NTH2fnlrosHiJeggfJaylmW81
    +nKqFfkbBAbB5xSNNByrvbeRP1rXQOFSglQQowZ5pK6mufd7qY5KerZ4bfQa4mMn
    hpcvO6xPPFkufdWsrIQla3WmS+kZGi5QVG6WnX7XOFwHfec//Fzgj8zRZf9s2RNK
    VFbPt7azTkKQJvG40uPYZMSkQRGVtowZf543KMsV9F6SYa3oQVvVx/gihq3LoA28
    RqX86yuZJQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfEeSvY8Eskht70BM6itB+Oa9qhvdD78PL+DtUg8vfz9aYIuJ66QKSd+rqDfvcRKgZ0IipjnSreZD0Tsj8ANZgL6UMR7BLWb7sAZ9Rr1KU9A3TUFPIWhk
    LKRmy20jCC4mFo6jGnkpxGml+xXUkbOwf/vCHHweHTvXKlkTCneiqdeS4ZRF8TOiEbCYw9rE823KIBEzvgXNDRnJs3ABoA89fXTyf4+bbl/YYfGfgOp1ivTN
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=tDeBQlekpoq6MqRf_iUA:9 a=CjuIK1q_8ugA:10
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbeEBPAM convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 2 May 2018 11:00:12 -0400
Received: from prv1-mh.provo.novell.com ([137.65.248.33]:50466 "EHLO
        prv1-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbeEBPAM (ORCPT
        <rfc822;groupwise-stable@vger.kernel.org:4:2>);
        Wed, 2 May 2018 11:00:12 -0400
Message-Id: <5AE9D27402000078001C02ED@prv1-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Wed, 02 May 2018 09:00:04 -0600
From: "Jan Beulich" <JBeulich@suse.com>
To: "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Cc: "xen-devel" <xen-devel@lists.xenproject.org>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [Xen-devel] [PATCH 2/4] xen/PVH: Use proper CS selector in
 long mode
References: <20180430162339.17143-1-boris.ostrovsky@oracle.com>
 <20180430162339.17143-3-boris.ostrovsky@oracle.com>
 <5AE9713D02000078001C007B@prv1-mh.provo.novell.com>
 <6b7a748d-e289-c370-123a-678c6ad7d9dd@oracle.com>
In-Reply-To: <6b7a748d-e289-c370-123a-678c6ad7d9dd@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>> On 02.05.18 at 16:57, <boris.ostrovsky@oracle.com> wrote:
> On 05/02/2018 04:05 AM, Jan Beulich wrote:
>>>>> On 30.04.18 at 18:23, <boris.ostrovsky@oracle.com> wrote:
>>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Reviewed-by: Jan Beulich <jbeulich@suse.com>
>>
>> But to understand why things have been working nevertheless it would
>> have been nice if the commit message wasn't empty, but instead said
>> something like "The two happen to be identical on 64-bit."
> 
> 
> Why do you think they are identical? __KERNEL_CS points to entry#12
> (which we don't specify in PVH GDT) while __BOOT_CS is the second entry
> (which we do create).

That's 32-bit's __KERNEL_CS. If the two weren't identical, the ljmp
you adjust would never have worked afaict.

Jan
