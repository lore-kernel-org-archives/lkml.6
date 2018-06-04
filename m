Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1918895-1528140740-2-6282722143906642660
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528140739; b=Cq+UZEHGvHVuREIlMetTwAQOjqLp8FhdR957b8Tq8o9j7gs0hv
    o5EVQ/NkMiLvwztwbs+/kE3TEPUQIFGr/c7eCHu4la36KPz3ZmP3cAfteAGC1K/5
    1AVhJXUyDSeWn82S/fGexHDTpgo/6w822JJDkV/oOUwCTutKo6HGypJapnTYIj+5
    J/UMitQMkm4bqFgZjxZ7H3FLRW4TrPZo7lLWg/vqr6Y8Irz4X9r4G1EgLEveqFnJ
    fAdvDbmIY+TpVaKZZ1OMqbB9OAN0xBTxGaiOCrguMRoYpwVAzupa3iFJAA+JI4gG
    k5zfMRP0/Utyl/9ODbbWvp83WFARJbFswqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1528140739; bh=deiQpTsd2CA
    xMGqdDpOjaY6l6oacH8oMZA5XhEg2U2A=; b=HKFn7UYdspObVuTIi8ZHRe+S6W9
    M2A7ePyU2ucFSHAznQD8fnxVhzG6nyF7LEAq/tTq/MrozzZ9FmtKaYVZ0ZR7gdav
    g2vVytHT9nPk/jR5X9p/La1jH9op3ONDJ3oBbjzJexGc5Sv1Zx/nBOQMezwo7TwK
    I8OLfwxE7zJ9OOOT++G5J18w6gR3o9p6jJLfDlvFJGU9qEEG8E3KguBTCkfIYVBl
    jEJbKId5MU93Ck07qGn2U5qPsSkuStxgLqU1FvCAHqiC6Dg99xcC6N07icdH7hee
    XRTtSRCNEaVPWM+fPy3B13YsyjtiLqLujXl3CiGw8J5YFdtUz5leNEHW6jQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfJPz+anu3uarOY8zCOuPwOj7MdSZJKCkovlLVTbIJjbH3BocJ498Jv1u4YTFHzyLiAJPXJ1DgxI0EsdXSlRXZIWBl+/SF/fMnjdUS33/Dhas8pe6+9fl
    0/hTTBKVjhlM2K43oe+/Zs2qVIkrMMSKmAYgbIHiQLKQYUlprcFBmEkGldesbh8POC1NSmxB+DZA4uqmqgatMxE28jGKhKfFlAlpgxfginPmSlGbyS3WJuCQ
    gtyGHcGzwfI+NWuNOc5KqQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=7mUfYlMuFuIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=9Ac_F3uiyos6nGsJ164A:9 a=wPNLvfGTeEIA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751103AbeFDTcS (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 15:32:18 -0400
Received: from h2.hallyn.com ([78.46.35.8]:55740 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbeFDTcR (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 4 Jun 2018 15:32:17 -0400
Date: Mon, 4 Jun 2018 14:32:15 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <james.l.morris@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
Message-ID: <20180604193215.GA13553@mail.hallyn.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1528121025.3237.116.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528121025.3237.116.camel@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Mimi Zohar (zohar@linux.vnet.ibm.com):
> On Tue, 2018-05-29 at 14:01 -0400, Mimi Zohar wrote:
> > Instead of adding the security_kernel_read_file LSM hook - or defining a
> > wrapper for security_kernel_read_file LSM hook and adding it, or
> > renaming the existing hook to security_kernel_read_data() and adding it
> > - in places where the kernel isn't reading a file, this version of the
> > patch set defines a new LSM hook named security_kernel_load_data().
> > 
> > The new LSM hook does not replace the existing security_kernel_read_file
> > LSM hook, which is still needed, but defines a new LSM hook allowing
> > LSMs and IMA-appraisal the opportunity to fail loading userspace
> > provided file/data.
> > 
> > The only difference between the two LSM hooks is the LSM hook name and a
> > file descriptor.  Whether this is cause enough for requiring a new LSM
> > hook, is left to the security community.
> 
> Paul does not have a preference as to adding a new LSM hook or calling
> the existing hook.  Either way is fine, as long as both the new and
> existing hooks call the existing function.
> 
> Casey didn't like the idea of a wrapper.
> James suggested renaming the LSM hook.
> 
> The maintainers for the callers of the LSM hook prefer a meaningful
> LSM hook name.  The "null" argument is not as much of a concern.  Only
> Eric seems to be asking for a separate, new LSM hook, without the
> "null" argument.
> 
> Unless someone really objects, to accommodate Eric we'll define a new
> LSM hook named security_kernel_load_data.  Eric, are you planning on

I'm confused - isn't that what this patchset did? :)

> Ack'ing patches 1 & 2?
> 
> Mimi
