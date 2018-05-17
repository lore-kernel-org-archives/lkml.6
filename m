Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1793992-1526547385-2-12389507849530566086
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526547384; b=BHiMKXB/vdC94k7e2Z4wgeJxuuTzNOFvdM0t0ietlAPEu/jOVh
    YNx9CGJ8mTpeo3sZwOhzKmeoQ9zkd8SZWVz9T9IQZ4CcOwjnQJQqKAztzbPXmtlY
    f8azoIKO5fDSO17+Xxd3MajThv/51V5QeJ7wf5T/DMQw2o0Ow/zKaa0XSfVihsSA
    p933Dup3p7r/OfaS96kQwB/Tjdn2C4PttqRN6wWpiiUWQVyRGXDruiunp0ZTWTta
    uhccSBkGG9fpzzNq/oaMZrwV8KO6ImJ2dmO1KHrxnc4mbSlG8X5zQW3KFY+muoT9
    bfyoFdDu1XIhw8wb0jZodGAadm2u0lVDJjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526547384; bh=V40v52bBTzO
    ILdQN6YV86655x5DHZuuSBD2cpfKA7ZQ=; b=i2oi41hoDqc0hcvB1zxQYbMRHqp
    UnSmSYP4JvdFk6jl2Bg5bk7KO4ppKNxou8GZkHJsOOyAI/l9NzkMzBBTo5CBmiSB
    79HwdF05TGbJP9u6HrKwzMsXTconujS14M/2tW+1eu5KObmETXPLQ+c/s8eqsvio
    I8lpHGLKBzmA2FnLcTOyzYIDbbu2uw43ajvvqLBWwVWsXnfz2R5HC+lQQe3O6IW/
    RMm9M6CBxwfgAnKS+kiIz9MP/+QufsUFH+OvRGGXG61TdArW73Q7Iesmztm+TYqn
    8SdBfkM7ClgpPHdScEBLoJ4aJS2KM6q3t9h5HvtQjfnBQowwUoO28dy9L9w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=TDinh0z/ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=TDinh0z/ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGs79oxn6G/wJFWvCgevOLn0OWPo44cGhKkHzxv35sVqxurSrLwoJ312I3TDb7SQr2Cjfy3RRMknRkEKSZ/6xJilhNa7HNuCgQeaBTxZhupTYI1TIc3H
    IxM90xAAD+Pg1FQBmsByPAXcOnPxy/cRny2meGHQikA9euoHF5NrkP4C3iaifeBoUWo4dmnRcKmT/GUio1LwasCUhzZ0UkXbqw3vwkj0JYZf88UD21USoFPh
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=8e_HEIcpV5a_I70Rd28A:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750924AbeEQI4V (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 04:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeEQI4U (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 17 May 2018 04:56:20 -0400
Date: Thu, 17 May 2018 10:56:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [PATCH 4.4 24/72] audit: add tty field to LOGIN event
Message-ID: <20180517085602.GC25318@kroah.com>
References: <20180406084305.210085169@linuxfoundation.org>
 <20180406084307.173351538@linuxfoundation.org>
 <1526314736.9159.13.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526314736.9159.13.camel@codethink.co.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 05:18:56PM +0100, Ben Hutchings wrote:
> On Fri, 2018-04-06 at 15:23 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Richard Guy Briggs <rgb@redhat.com>
> > 
> > commit db0a6fb5d97afe01fd9c47d37c6daa82d4d4001d upstream.
> [...]
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -1976,6 +1976,7 @@ static void audit_log_set_loginuid(kuid_
> >  {
> >  	struct audit_buffer *ab;
> >  	uid_t uid, oldloginuid, loginuid;
> > +	struct tty_struct *tty;
> >  
> >  	if (!audit_enabled)
> >  		return;
> > @@ -1983,14 +1984,17 @@ static void audit_log_set_loginuid(kuid_
> >  	uid = from_kuid(&init_user_ns, task_uid(current));
> >  	oldloginuid = from_kuid(&init_user_ns, koldloginuid);
> >  	loginuid = from_kuid(&init_user_ns, kloginuid),
> > +	tty = audit_get_tty(current);
> >  
> >  	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_LOGIN);
> >  	if (!ab)
> >  		return;
> 
> This error path leaks the tty ref.  Fixed upstream by:
> 
> commit 76a658c20efd541a62838d9ff68ce94170d7a549
> Author: Richard Guy Briggs <rgb@redhat.com>
> Date:   Tue Jun 28 12:06:58 2016 -0400
> 
>     audit: move calcs after alloc and check when logging set loginuid

Thanks, now queued up.

greg k-h
