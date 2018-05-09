Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-424357-1525872893-2-3149659716930506452
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525872892; b=eqZZAeM5s4ls/AcJ6pFO7Q0Flohc1cfCehY9H5hRxP/e9FWx9C
    8yMHHFP0i0bc3f253WomsHiBe0aTTf8SqijN0IroXPElIljQ++/Yi98trV0M7C+N
    Cv9hQjDg3Fqq8dPFXCdwTL9a1sWx2kQspe/jvHzOUaBynZgB4L9tt8KXPDmmajh8
    2L4MZ6lwGGuGx6J5dJKipVTz3oC909RAL2g3f+MfzfttV/ah5aBUKh75fZw6CECx
    or/EUiRQBFJ5yzTI3Rzuj/OR41HKBRzuTTzEzG7d7si1RXnqlpI6kNu5S+AiIP8l
    QTIBTASNUKjDossjr5TJkDXvozBwv5IeTIpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525872892; bh=eLsX9XWWaiXKOvE1CbVwZH0StTOKgL
    bugjk9+rLRQuQ=; b=QTXAJjTdMHS8oxlyYqqwgtSROl3aGevNJ6+74/ahkN/elv
    RALD9VtHuogY2jjY4wd/OqO19WtqejLDEPutVXo3zeCc1+/aYcFFrJpVXth+Nl4W
    aSh3ozLotvGSanKHqo6fXLNwzq6pmG+pnLjGzziUaLq9XYwsmuw3Xa7vjcVHlJBN
    ea0cO5qdTmO7MGdq0E36HcjEu+fS7z+CWHHPBELBdR4FGz/S4XvKCcMa3SF8LDtr
    cnJkQuxZOzYjNrcSh4EO6eDqWzlgjlv1fiS5au6PP6lCWlB2b0/1aH3IG8kX+Yan
    zqbon/pHGXUEojP23Arfn8aZKB8TfaHwmkm1sbKQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=thunk.org header.i=@thunk.org header.b=Hp+LZOMC x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=thunk.org header.i=@thunk.org header.b=Hp+LZOMC x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=ef5046eb;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mit.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mit.edu header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOncwK2TNM5OKx88dG4YoLDl19+n7TLHPz3fqpxSPAnsOIARYyUa6gvW6tkjj3DgpfouIL3uM4NXHg6VZIpsQLd/cxmJriaD/+L2FZxFc+ZxMM1CtWZp
    pJnOxS9UoG7E+hyvTwjgNRy+Y2A1ue2BsguqxGQLcYKgmwDX95R83AIr6EIet4qRREUuBZIpaaU4wr69a/AQEuBE/wX1HG37Zxeh0vlISNf8PA9XPQolcXxy
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=VUJBJC2UJ8kA:10 a=JF9118EUAAAA:8 a=VwQbUJbxAAAA:8 a=L9cxVZx8VZPqrdJDUNoA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=xVlTc564ipvMDusKsbsT:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934619AbeEINeh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 09:34:37 -0400
Received: from imap.thunk.org ([74.207.234.97]:59620 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934110AbeEINeg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 9 May 2018 09:34:36 -0400
Date: Wed, 9 May 2018 09:34:32 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] fs: Convert kiocb rw_hint from enum to u16
Message-ID: <20180509133432.GD28388@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        adam.manzanares@wdc.com, viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180508174202.2537-1-adam.manzanares@wdc.com>
 <20180508174202.2537-3-adam.manzanares@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508174202.2537-3-adam.manzanares@wdc.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 10:42:01AM -0700, adam.manzanares@wdc.com wrote:
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 760d8da1b6c7..7a90ce387e00 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -284,6 +284,8 @@ enum rw_hint {
>  	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
>  };
>  
> +#define MAX_KI_HINT		((1 << 16) - 1) /* ki_hint type is u16 */
> +

Do we really think there will be *ever* be a need for more than 16 I/O
priority levels?  I would much rather use the low four bits of KI_HINT
for the priority level, and reserve the rest of the 16 bits in KI_HINT
for some future use.  (For example, we might want to use some number
of bits for a stream ID.)

					- Ted
