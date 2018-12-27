Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61509C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1342148D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 21:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OTHQrnWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbeL0Vql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 16:46:41 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39492 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729839AbeL0Vql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 16:46:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so13467941lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 13:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4FdawT9bWZDQaygW+AxiAj5Ed7jpTTMebHfDAzk5uaM=;
        b=OTHQrnWaziIivdMSMWToa4FIiNsY2VMnMeDIleju36bSTSR9DPYQcpDBcdYWs3vUnD
         MnVFtRi9OrGkp9fdkMr8CBt4+fhZQ2AI2SeZ49vLQaXC1tLS3YAq75Pu5PALKIHoR5fI
         ERXudqtrtFdny+DQKMq4O/aYtpYdJdEJ0PfKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4FdawT9bWZDQaygW+AxiAj5Ed7jpTTMebHfDAzk5uaM=;
        b=MhyH866B9LKD+KWxqTGib4+1sHkk6YORoHrbfKXwLlMNscsowIc6hWyTDIzDo5x74Z
         SMjNsLZD7F0yWfK/uFURplkYi34kzPeZ1L4SkXAUEjJMRD2aZg6l6FUqs4qAE06evgtB
         2qTW/HDKeCOwbC2k/y5ZSnaqSZNJ1BUY8/w4JvtCEDQ8lS8V5rkzgWIh7UGKndt5XRer
         qgsZMGrX7yVnjCuWhb4k6mRs/lLlbgdhH40VRB4dIiIQPgypaDgaEmR07Lsi5d9VdRrc
         odSz3LCGt7oMYEFB+CTPAUIHX7HEeOrSrN5k2S3zAG+os3z4ENzXZX33hc/4lwhgoYHY
         rMHg==
X-Gm-Message-State: AA+aEWaFv1yO/xMzYaA3Vg01z98iG+UYfwHm+y9bXY43A5pKj0PGD7mD
        Kj/8f2PoonjN7wiTBg9uGO5usdwyxmw=
X-Google-Smtp-Source: AFSGD/UXNGgf3ZO5KHlUW5faa2zLsQHdlAgv5TA4WgVMcMsMLo0Vj3CRqksixBOtCK4PoKdz3WkEqA==
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr13408986lfg.117.1545947196822;
        Thu, 27 Dec 2018 13:46:36 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id q2sm8186923lfa.63.2018.12.27.13.46.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 13:46:34 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id f23so13439353lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Dec 2018 13:46:33 -0800 (PST)
X-Received: by 2002:a19:7006:: with SMTP id h6mr9131803lfc.147.1545947193363;
 Thu, 27 Dec 2018 13:46:33 -0800 (PST)
MIME-Version: 1.0
References: <1545879866-27809-1-git-send-email-xiexiuqi@huawei.com>
 <CAKfTPtDRGULW3mdFzeyT=OBPdtPsz-6BG-=UGWbK6RQ7Lg8YpA@mail.gmail.com>
 <20181227102107.GA21156@linaro.org> <CAKfTPtD7O_DU5no36jaQziZDCvy=BMJk+tZbnQk2yVt=pzRfPw@mail.gmail.com>
 <CAMp4zn-bN=DdiKox-xZ++i2n_pgTA7Ms+1hBnAY2AbYv2iqXOA@mail.gmail.com>
 <CAKfTPtAmkHZ5XVHpf6rE8nrSPGzW_uO7a0tvH5JqDSpTzK9D=Q@mail.gmail.com>
 <CAHk-=wja7WN1sDz5_E7hf8c47CmX=yH8xc3h0zmmF8Y_fSR71A@mail.gmail.com> <CAMp4zn_N9fVNmyaiH-XGJW=E8QO0OnnVmAwQM_kcXjiybmhyGw@mail.gmail.com>
In-Reply-To: <CAMp4zn_N9fVNmyaiH-XGJW=E8QO0OnnVmAwQM_kcXjiybmhyGw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 27 Dec 2018 13:46:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_0v3t+mAdS2-sPWD6DTH3Y9aGoQUhx7Mk1MB8gm9xjw@mail.gmail.com>
Message-ID: <CAHk-=wg_0v3t+mAdS2-sPWD6DTH3Y9aGoQUhx7Mk1MB8gm9xjw@mail.gmail.com>
Subject: Re: [PATCH] sched: fix infinity loop in update_blocked_averages
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, xiezhipeng1@huawei.com,
        huawei.libin@huawei.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Adamushko <dmitry.adamushko@gmail.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000004d92e3057e07e184"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004d92e3057e07e184
Content-Type: text/plain; charset="UTF-8"

On Thu, Dec 27, 2018 at 1:09 PM Sargun Dhillon <sargun@sargun.me> wrote:
>
> This appears to be broken since October on 4.18.5. We've only noticed
> it recently with a workload which does ridiculously parallel compiles
> in cgroups that are rapidly churned.

Yeah, that's probably unusual enough that people will have missed it.

Because it really looks like the bug has been there since 4.13, unless
I'm mis-reading things. Other things have changed there since, so
maybe I am.

> It's also an awkward bug to catch, because none of the lockup
> detectors, were catching it in our environment. The only reason we
> caught it was that it was blocking other cores, and those other cores
> were missing IPIs, resulting in catastrophic failure.

My gut feel is that we just need to revert that commit. It doesn't
revert clealy, but it doesn't look hard to do manually.

Something like the attached?

But we do need Tejun and PeterZ to take a look, since there might be
something subtle going on.

Everybody is probably still on well-deserved vacations, so it might be
a while. But testing the attached patch is probably a good idea
regardless.

                  Linus

--0000000000004d92e3057e07e184
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jq7507hc0>
X-Attachment-Id: f_jq7507hc0

IGtlcm5lbC9zY2hlZC9mYWlyLmMgfCA0MSArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL2ZhaXIuYyBiL2tlcm5lbC9zY2hlZC9mYWly
LmMKaW5kZXggZDE5MDc1MDYzMThhLi4wMWYzY2I4OWQxODggMTAwNjQ0Ci0tLSBhL2tlcm5lbC9z
Y2hlZC9mYWlyLmMKKysrIGIva2VybmVsL3NjaGVkL2ZhaXIuYwpAQCAtMzUzLDkgKzM1Myw4IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBsaXN0X2RlbF9sZWFmX2Nmc19ycShzdHJ1Y3QgY2ZzX3JxICpj
ZnNfcnEpCiB9CiAKIC8qIEl0ZXJhdGUgdGhyJyBhbGwgbGVhZiBjZnNfcnEncyBvbiBhIHJ1bnF1
ZXVlICovCi0jZGVmaW5lIGZvcl9lYWNoX2xlYWZfY2ZzX3JxX3NhZmUocnEsIGNmc19ycSwgcG9z
KQkJCVwKLQlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoY2ZzX3JxLCBwb3MsICZycS0+bGVhZl9j
ZnNfcnFfbGlzdCwJXAotCQkJCSBsZWFmX2Nmc19ycV9saXN0KQorI2RlZmluZSBmb3JfZWFjaF9s
ZWFmX2Nmc19ycShycSwgY2ZzX3JxKSBcCisJbGlzdF9mb3JfZWFjaF9lbnRyeV9yY3UoY2ZzX3Jx
LCAmcnEtPmxlYWZfY2ZzX3JxX2xpc3QsIGxlYWZfY2ZzX3JxX2xpc3QpCiAKIC8qIERvIHRoZSB0
d28gKGVucXVldWVkKSBlbnRpdGllcyBiZWxvbmcgdG8gdGhlIHNhbWUgZ3JvdXAgPyAqLwogc3Rh
dGljIGlubGluZSBzdHJ1Y3QgY2ZzX3JxICoKQEAgLTQ0Nyw4ICs0NDYsOCBAQCBzdGF0aWMgaW5s
aW5lIHZvaWQgbGlzdF9kZWxfbGVhZl9jZnNfcnEoc3RydWN0IGNmc19ycSAqY2ZzX3JxKQogewog
fQogCi0jZGVmaW5lIGZvcl9lYWNoX2xlYWZfY2ZzX3JxX3NhZmUocnEsIGNmc19ycSwgcG9zKQlc
Ci0JCWZvciAoY2ZzX3JxID0gJnJxLT5jZnMsIHBvcyA9IE5VTEw7IGNmc19ycTsgY2ZzX3JxID0g
cG9zKQorI2RlZmluZSBmb3JfZWFjaF9sZWFmX2Nmc19ycShycSwgY2ZzX3JxKQlcCisJCWZvciAo
Y2ZzX3JxID0gJnJxLT5jZnM7IGNmc19ycTsgY2ZzX3JxID0gTlVMTCkKIAogc3RhdGljIGlubGlu
ZSBzdHJ1Y3Qgc2NoZWRfZW50aXR5ICpwYXJlbnRfZW50aXR5KHN0cnVjdCBzY2hlZF9lbnRpdHkg
KnNlKQogewpAQCAtNzY0NywyNyArNzY0NiwxMCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgb3RoZXJz
X2hhdmVfYmxvY2tlZChzdHJ1Y3QgcnEgKnJxKQogCiAjaWZkZWYgQ09ORklHX0ZBSVJfR1JPVVBf
U0NIRUQKIAotc3RhdGljIGlubGluZSBib29sIGNmc19ycV9pc19kZWNheWVkKHN0cnVjdCBjZnNf
cnEgKmNmc19ycSkKLXsKLQlpZiAoY2ZzX3JxLT5sb2FkLndlaWdodCkKLQkJcmV0dXJuIGZhbHNl
OwotCi0JaWYgKGNmc19ycS0+YXZnLmxvYWRfc3VtKQotCQlyZXR1cm4gZmFsc2U7Ci0KLQlpZiAo
Y2ZzX3JxLT5hdmcudXRpbF9zdW0pCi0JCXJldHVybiBmYWxzZTsKLQotCWlmIChjZnNfcnEtPmF2
Zy5ydW5uYWJsZV9sb2FkX3N1bSkKLQkJcmV0dXJuIGZhbHNlOwotCi0JcmV0dXJuIHRydWU7Ci19
Ci0KIHN0YXRpYyB2b2lkIHVwZGF0ZV9ibG9ja2VkX2F2ZXJhZ2VzKGludCBjcHUpCiB7CiAJc3Ry
dWN0IHJxICpycSA9IGNwdV9ycShjcHUpOwotCXN0cnVjdCBjZnNfcnEgKmNmc19ycSwgKnBvczsK
KwlzdHJ1Y3QgY2ZzX3JxICpjZnNfcnE7CiAJY29uc3Qgc3RydWN0IHNjaGVkX2NsYXNzICpjdXJy
X2NsYXNzOwogCXN0cnVjdCBycV9mbGFncyByZjsKIAlib29sIGRvbmUgPSB0cnVlOwpAQCAtNzY3
OSw3ICs3NjYxLDcgQEAgc3RhdGljIHZvaWQgdXBkYXRlX2Jsb2NrZWRfYXZlcmFnZXMoaW50IGNw
dSkKIAkgKiBJdGVyYXRlcyB0aGUgdGFza19ncm91cCB0cmVlIGluIGEgYm90dG9tIHVwIGZhc2hp
b24sIHNlZQogCSAqIGxpc3RfYWRkX2xlYWZfY2ZzX3JxKCkgZm9yIGRldGFpbHMuCiAJICovCi0J
Zm9yX2VhY2hfbGVhZl9jZnNfcnFfc2FmZShycSwgY2ZzX3JxLCBwb3MpIHsKKwlmb3JfZWFjaF9s
ZWFmX2Nmc19ycShycSwgY2ZzX3JxKSB7CiAJCXN0cnVjdCBzY2hlZF9lbnRpdHkgKnNlOwogCiAJ
CS8qIHRocm90dGxlZCBlbnRpdGllcyBkbyBub3QgY29udHJpYnV0ZSB0byBsb2FkICovCkBAIC03
Njk0LDEzICs3Njc2LDYgQEAgc3RhdGljIHZvaWQgdXBkYXRlX2Jsb2NrZWRfYXZlcmFnZXMoaW50
IGNwdSkKIAkJaWYgKHNlICYmICFza2lwX2Jsb2NrZWRfdXBkYXRlKHNlKSkKIAkJCXVwZGF0ZV9s
b2FkX2F2ZyhjZnNfcnFfb2Yoc2UpLCBzZSwgMCk7CiAKLQkJLyoKLQkJICogVGhlcmUgY2FuIGJl
IGEgbG90IG9mIGlkbGUgQ1BVIGNncm91cHMuICBEb24ndCBsZXQgZnVsbHkKLQkJICogZGVjYXll
ZCBjZnNfcnFzIGxpbmdlciBvbiB0aGUgbGlzdC4KLQkJICovCi0JCWlmIChjZnNfcnFfaXNfZGVj
YXllZChjZnNfcnEpKQotCQkJbGlzdF9kZWxfbGVhZl9jZnNfcnEoY2ZzX3JxKTsKLQogCQkvKiBE
b24ndCBuZWVkIHBlcmlvZGljIGRlY2F5IG9uY2UgbG9hZC91dGlsX2F2ZyBhcmUgbnVsbCAqLwog
CQlpZiAoY2ZzX3JxX2hhc19ibG9ja2VkKGNmc19ycSkpCiAJCQlkb25lID0gZmFsc2U7CkBAIC0x
MDU3MCwxMCArMTA1NDUsMTAgQEAgY29uc3Qgc3RydWN0IHNjaGVkX2NsYXNzIGZhaXJfc2NoZWRf
Y2xhc3MgPSB7CiAjaWZkZWYgQ09ORklHX1NDSEVEX0RFQlVHCiB2b2lkIHByaW50X2Nmc19zdGF0
cyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIGludCBjcHUpCiB7Ci0Jc3RydWN0IGNmc19ycSAqY2ZzX3Jx
LCAqcG9zOworCXN0cnVjdCBjZnNfcnEgKmNmc19ycTsKIAogCXJjdV9yZWFkX2xvY2soKTsKLQlm
b3JfZWFjaF9sZWFmX2Nmc19ycV9zYWZlKGNwdV9ycShjcHUpLCBjZnNfcnEsIHBvcykKKwlmb3Jf
ZWFjaF9sZWFmX2Nmc19ycShjcHVfcnEoY3B1KSwgY2ZzX3JxKQogCQlwcmludF9jZnNfcnEobSwg
Y3B1LCBjZnNfcnEpOwogCXJjdV9yZWFkX3VubG9jaygpOwogfQo=
--0000000000004d92e3057e07e184--
