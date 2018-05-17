Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2528567-1526581433-2-3013418112667333903
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Attached: patch.diff
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526581432; b=XVItDdkPhMMtBV7PQ7h8mtIWKt35znCkVfx9FoEiaYQC9zL23i
    t9vPdkp//LW38bhboN6IEVUzcdCYR8ibqavwpULLBRvWTIDLFG4XfTr1A9CMwm0l
    Q0LST2bDpQzWhV/ahrx2yjfOTBRG9Zryd16WBt/u+xPPzJ9+UVmcEIwj0+C9Ybkj
    t6PmofeqVZx3/Yjz5iu6zoTbxGyDKTLVBroCz+1pkNyZk1cAXucUgmYZekB8SMG3
    +2a/R+U6wFKTsvDcblqM/xea4K6BzmEgA9rgBkkYpjOagh1yZf9J6/uSJRrJd7ll
    99oUxRgqLl4ew8yOg9VDDprnAmluzxJJFnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526581432; bh=VeGF4c95EOmFeMnN0qB4rXPcrD4QOmpDMpGVOMpG2f
    w=; b=izGC6LM1ddYhBOKrBLZvIQBHcAILrGbS9YchAb6kKEGYG098ZYty+nCK0P
    C4HgDShli81XtoEOvQASln8xsMMz3lLzFb/7NNQqioDGzLUGMTFqvzWgkZE9/YkF
    31gDWDp47Xb+2xaQcE99tU2YgahhPhhYKokDO1ilbnrIWg8SsFn0jWTJvZ72i46r
    lrUDKCSbYZZ1HsUNiCVpZp36xc6EtZTzN4mTHR42a8EfdmitBGDwn+A207xDbaiv
    fxSBTUWN6FyQWZd4W18rksnfs8pHtUqTji6kvogMDnaCa5pe/qugHc6GQMIhUjVL
    jetBiXoFlxVs9bhQtT/MzUHu9vIQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linux-foundation.org header.i=@linux-foundation.org
    header.b=VzpdIzQB x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=BeuQnLOC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux-foundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linux-foundation.org header.i=@linux-foundation.org
      header.b=VzpdIzQB x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=BeuQnLOC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux-foundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEkeY+pTIaEqUslHrWv3ngl9lZd7q/G8eicUWrfO5QCLUOJzK5Dxh5I8IzVA/83jlHMupy8blj25eUBlCb3Xm63VfXxotosalzxv2FdldMx08LPF7Y6f
    Ipy98oAib0Q+WmG/x8yJCSXADNKZxlGS8hLWETbZt7wqSV3wFr0fotiOrxM9K97jdCPKMw0PsUo44RvI3M79cxFtbwhEcGWslqxmq4Ve/ohXcmQGeWL1aL85
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=w8ksCCaLWviuDnjXRoIA:9 a=QEXdDO2ut3YA:10 a=OYGD7EbCAESyi3mIPfsA:9
    a=CjuIK1q_8ugA:10 a=hquHOILUSkIA:10 a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeEQSXv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 14:23:51 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51764 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbeEQSXu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 May 2018 14:23:50 -0400
X-Google-Smtp-Source: AB8JxZoJJ2uwmLz4932f2S2rL0whtRBSSYR9NN7/vCcmPhqWc2we73mSx4lC4Xo7zDwYvnN7t2bsIlfhN/PUlRdYXfc=
MIME-Version: 1.0
References: <20180517012149.GA1718769@devbig577.frc2.facebook.com>
In-Reply-To: <20180517012149.GA1718769@devbig577.frc2.facebook.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 17 May 2018 11:23:37 -0700
Message-ID: <CA+55aFxdnFpNoufsad2cCic8iz2MYQ8h_KV+5sM+WF9KAuJk_Q@mail.gmail.com>
Subject: Re: [PATCH] proc: Don't allow empty /proc/PID/cmdline for user tasks
To: Tejun Heo <tj@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team <kernel-team@fb.com>,
        Lennart Poettering <lennart@poettering.net>
Content-Type: multipart/mixed; boundary="000000000000d69f84056c6aefc0"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--000000000000d69f84056c6aefc0
Content-Type: text/plain; charset="UTF-8"

On Wed, May 16, 2018 at 6:21 PM Tejun Heo <tj@kernel.org> wrote:

> This patch fixes the issue by making proc_pid_cmdline_read() never
> return empty string for user tasks.

Ugh.

That function really is too damn ugly, and this just makes it worse.

Can we please split things up a bit before uglifying the code further?

IOW, the first step should be something like the attached patch, which
splits up all the tsk/mm error cases.

Then your patch could just be a trivial

     if (!*pos && !ret)
         ret = get_comm_cmdline(tsk, buf, count, pos);

in that new (and much simpler) proc_pid_cmdline_read() just before the
put_task_struct.

Hmm?

NOTE! This patch is *entirely* untested, but it builds and the conversion
was pretty much entirely mechanical.

And yes, the "get_mm_cmdline()" function is still too damn ugly, and should
still be cleaned up more, but it's at least _slightly_ simpler than it used
to be, and the new logic wouldn't go into that horrible thing.

                Linus

--000000000000d69f84056c6aefc0
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jhav5m4o0>
X-Attachment-Id: f_jhav5m4o0

IGZzL3Byb2MvYmFzZS5jIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyks
IDI1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3Byb2MvYmFzZS5jIGIvZnMvcHJvYy9i
YXNlLmMKaW5kZXggMWE3NmQ3NTFjZjNjLi5jNGQ5NjNhMTIxNjIgMTAwNjQ0Ci0tLSBhL2ZzL3By
b2MvYmFzZS5jCisrKyBiL2ZzL3Byb2MvYmFzZS5jCkBAIC0yMDUsMTEgKzIwNSw5IEBAIHN0YXRp
YyBpbnQgcHJvY19yb290X2xpbmsoc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3QgcGF0aCAq
cGF0aCkKIAlyZXR1cm4gcmVzdWx0OwogfQogCi1zdGF0aWMgc3NpemVfdCBwcm9jX3BpZF9jbWRs
aW5lX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICpidWYsCi0JCQkJICAgICBz
aXplX3QgX2NvdW50LCBsb2ZmX3QgKnBvcykKK3N0YXRpYyBzc2l6ZV90IGdldF9tbV9jbWRsaW5l
KHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBjaGFyIF9fdXNlciAqYnVmLAorCQkJICAgICAgc2l6ZV90
IF9jb3VudCwgbG9mZl90ICpwb3MpCiB7Ci0Jc3RydWN0IHRhc2tfc3RydWN0ICp0c2s7Ci0Jc3Ry
dWN0IG1tX3N0cnVjdCAqbW07CiAJY2hhciAqcGFnZTsKIAl1bnNpZ25lZCBsb25nIGNvdW50ID0g
X2NvdW50OwogCXVuc2lnbmVkIGxvbmcgYXJnX3N0YXJ0LCBhcmdfZW5kLCBlbnZfc3RhcnQsIGVu
dl9lbmQ7CkBAIC0yMTgsMjYgKzIxNiwxMyBAQCBzdGF0aWMgc3NpemVfdCBwcm9jX3BpZF9jbWRs
aW5lX3JlYWQoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICpidWYsCiAJY2hhciBjOwog
CXNzaXplX3QgcnY7CiAKLQlCVUdfT04oKnBvcyA8IDApOwotCi0JdHNrID0gZ2V0X3Byb2NfdGFz
ayhmaWxlX2lub2RlKGZpbGUpKTsKLQlpZiAoIXRzaykKLQkJcmV0dXJuIC1FU1JDSDsKLQltbSA9
IGdldF90YXNrX21tKHRzayk7Ci0JcHV0X3Rhc2tfc3RydWN0KHRzayk7Ci0JaWYgKCFtbSkKLQkJ
cmV0dXJuIDA7CiAJLyogQ2hlY2sgaWYgcHJvY2VzcyBzcGF3bmVkIGZhciBlbm91Z2ggdG8gaGF2
ZSBjbWRsaW5lLiAqLwotCWlmICghbW0tPmVudl9lbmQpIHsKLQkJcnYgPSAwOwotCQlnb3RvIG91
dF9tbXB1dDsKLQl9CisJaWYgKCFtbS0+ZW52X2VuZCkKKwkJcmV0dXJuIDA7CiAKIAlwYWdlID0g
KGNoYXIgKilfX2dldF9mcmVlX3BhZ2UoR0ZQX0tFUk5FTCk7Ci0JaWYgKCFwYWdlKSB7Ci0JCXJ2
ID0gLUVOT01FTTsKLQkJZ290byBvdXRfbW1wdXQ7Ci0JfQorCWlmICghcGFnZSkKKwkJcmV0dXJu
IC1FTk9NRU07CiAKIAlkb3duX3JlYWQoJm1tLT5tbWFwX3NlbSk7CiAJYXJnX3N0YXJ0ID0gbW0t
PmFyZ19zdGFydDsKQEAgLTM2NSwxMyArMzUwLDQyIEBAIHN0YXRpYyBzc2l6ZV90IHByb2NfcGlk
X2NtZGxpbmVfcmVhZChzdHJ1Y3QgZmlsZSAqZmlsZSwgY2hhciBfX3VzZXIgKmJ1ZiwKIAogb3V0
X2ZyZWVfcGFnZToKIAlmcmVlX3BhZ2UoKHVuc2lnbmVkIGxvbmcpcGFnZSk7Ci1vdXRfbW1wdXQ6
Ci0JbW1wdXQobW0pOwotCWlmIChydiA+IDApCi0JCSpwb3MgKz0gcnY7CiAJcmV0dXJuIHJ2Owog
fQogCitzdGF0aWMgc3NpemVfdCBnZXRfdGFza19jbWRsaW5lKHN0cnVjdCB0YXNrX3N0cnVjdCAq
dHNrLCBjaGFyIF9fdXNlciAqYnVmLAorCQkJCXNpemVfdCBjb3VudCwgbG9mZl90ICpwb3MpCit7
CisJc3RydWN0IG1tX3N0cnVjdCAqbW07CisJc3NpemVfdCByZXQ7CisKKwltbSA9IGdldF90YXNr
X21tKHRzayk7CisJaWYgKCFtbSkKKwkJcmV0dXJuIDA7CisKKwlyZXQgPSBnZXRfbW1fY21kbGlu
ZShtbSwgYnVmLCBjb3VudCwgcG9zKTsKKwltbXB1dChtbSk7CisJcmV0dXJuIHJldDsKK30KKwor
c3RhdGljIHNzaXplX3QgcHJvY19waWRfY21kbGluZV9yZWFkKHN0cnVjdCBmaWxlICpmaWxlLCBj
aGFyIF9fdXNlciAqYnVmLAorCQkJCSAgICAgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBvcykKK3sK
KwlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzazsKKwlzc2l6ZV90IHJldDsKKworCUJVR19PTigqcG9z
IDwgMCk7CisKKwl0c2sgPSBnZXRfcHJvY190YXNrKGZpbGVfaW5vZGUoZmlsZSkpOworCWlmICgh
dHNrKQorCQlyZXR1cm4gLUVTUkNIOworCXJldCA9IGdldF90YXNrX2NtZGxpbmUodHNrLCBidWYs
IGNvdW50LCBwb3MpOworCXB1dF90YXNrX3N0cnVjdCh0c2spOworCWlmIChyZXQgPiAwKQorCQkq
cG9zICs9IHJldDsKKwlyZXR1cm4gcmV0OworfQorCiBzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVf
b3BlcmF0aW9ucyBwcm9jX3BpZF9jbWRsaW5lX29wcyA9IHsKIAkucmVhZAk9IHByb2NfcGlkX2Nt
ZGxpbmVfcmVhZCwKIAkubGxzZWVrCT0gZ2VuZXJpY19maWxlX2xsc2VlaywK
--000000000000d69f84056c6aefc0--
