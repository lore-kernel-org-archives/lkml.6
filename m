Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-2522609-1528205148-2-1846121192536664296
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528205147; b=NyXxjX0D9Ske48xbGjTc/TQxGOI7TCGxgq+D8TGoR/KRawI0Bx
    ienQZoaPLYLGVnt/dXUDZA1Xfn//ABCBI0SzTJaqIF82hRI/ypNwxpLqJfvlisUZ
    s/f0oYUROC24EU+lZW1Zgn7MLTk1ZgwGDupZI2Qlq6mQ1KyjnCBYCa3OCYffLDOR
    ZG9FZ1gX7GmDQmEzH+oTATpDf6wPGYpRUki5TFtPmlmC0njv3cNtRLteJSWGf0GA
    Xt27dXlgzk7cJ3zHkHFpxQO6V8acInuW6+P5XF57gVdoqVdfhl/nyOSaIrzykn47
    p6mhJWks5p9afoK2FInzoPO8fMK3rWgmNvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1528205147; bh=AptkiV5nDueF6Y03WMK/x1DqaK9qLO
    j7eQC4OURJamg=; b=HLzVSEQKMWEBeYSmOC8Qwdf1hOavcAyNm5v8lHeB6z42kf
    Ssm160fW7evyMrQPGP0tGW8s5TvRmf2FC3L+VXmufOAKZYQjIREqetSQvdcXcOE5
    JtmHacLlydVCTMQj/GK6SlvVFrIiQRGoioo3chDlXbyDT3NZt52MxWpA0P/r/Tgo
    HYviAYC8oDf3DyBryvb6n00PDRzEs4PSGFvv6MaoxVmxjNf4ND+eEbhFDrZfmJlh
    Nq9Bn67u0bIS0Qtds8shMEJy2ou7QyZsx1q9br9MdQx5/bzmkxGv0QAC4XsuxiVy
    d8D4iHbZjkDj1V4tSEv50MH+9h1xYSF5LIRCo2jQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hallyn.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=hallyn.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hallyn.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=hallyn.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfECdFQw8o8xFbR5jd9OZAWqdo52uNi/vi1DYSi2qNMlM5HIpL0LJ+ueeCp+N4cdOEr/8CXDHIVUFabZ+2lIELz5/rVncvZT6GKdHr8ezepDjswRqGayk
    jptN444ApFUteJP/NflMHyE+YY0Qwz1M86kQuB5fiWQNlG/IKZELqW7Lhx3JW8wDtSPcNGomiAUK131XoCcAopnbPpnzex5G39ZsBFyVVFbbryS4Ic+EnSUW
    +3lPuEbvN78EvkM5+yMUjQ==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=7mUfYlMuFuIA:10
    a=cm27Pg_UAAAA:8 a=hBqU3vQJAAAA:8 a=VwQbUJbxAAAA:8 a=BBo-H7Z2zwKRrtPtfGMA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=WLjMIN4s_96MqnBbPenP:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeFENZq (ORCPT <rfc822;linux@kroah.com>);
        Tue, 5 Jun 2018 09:25:46 -0400
Received: from h2.hallyn.com ([78.46.35.8]:58890 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751822AbeFENZo (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 5 Jun 2018 09:25:44 -0400
Date: Tue, 5 Jun 2018 08:25:42 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Kees Cook <keescook@chromium.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <james.l.morris@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
Message-ID: <20180605132542.GA26722@mail.hallyn.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1528121025.3237.116.camel@linux.vnet.ibm.com>
 <CAGXu5jJGrPtOUa8f4pMiZTiYBEP_eVJ1oEUqum8YBr9JbfuLmg@mail.gmail.com>
 <20180605040920.GA19747@mail.hallyn.com>
 <CAGXu5j+UfR94xAoKsyZY9dhzREH-b2fhTAtQLfX33BhDdMVweA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+UfR94xAoKsyZY9dhzREH-b2fhTAtQLfX33BhDdMVweA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Kees Cook (keescook@chromium.org):
> On Mon, Jun 4, 2018 at 9:09 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > Personally I agree with Eric and prefer a new hook.  I don't feel strongly
> > enough about it to keep bikeshedding, but since this set already exists,
> > it seems like the way to go.
> 
> And the new hook is "load stuff without a file descriptor"?

Yes.  Load stuff based on my own credentials not those attached
to a file.
