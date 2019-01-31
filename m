Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964BCC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606F52086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WSdZg3Gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfAaTKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:10:44 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33904 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfAaTKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:10:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so3696544lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xscg+IDwK+piZ4gwM9pr76+iGnilAL9l9sUJBQ14ql4=;
        b=WSdZg3GgdCf+Bfnb/A+u6kK/WpovsTeVodF2/V5GuUcUeDkcXBt+Io4wfbZtEB10pR
         uWykPgozcSi9R+lsNeRiDIVXAhIHyaJlu4Q34fAMU6DMQ98fuJ7fIiolhm9S2/Dez8oN
         do5hjWbqseBMjJJBGiVlLhgtJtFN6ap3qboak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xscg+IDwK+piZ4gwM9pr76+iGnilAL9l9sUJBQ14ql4=;
        b=ZRVaFGTHG5aQc+4FJLSBLWY6DpiZnd8/TbdqzRtmX+LkuKDRZlMiTIRzjt+LRvslnQ
         v1OY61hAzYCt0iB1TOrQLfOvXaugwffTclYDetX22a/RnbBLEafNSgWJ0ZPeIReh+HD7
         eHGpl6Plrhg73kiwoxpgcbQGFS4/I2u09ze1DQWc+WN5r2a10KLyuwFJhd5ANnwI9sPE
         u/eK4Bq/lMQd81NJ0qjyw22snmBP29KZbP2LKZTuLpdbbh+vp8Vy8/Eh8J8I6D+A3x7t
         9tks56bx3XCgS6WJm2IdYkTO9gkuUSBMOeCyurAZYQeI6BR+zgcrUEfaHtnhs3s8vf/H
         M/9g==
X-Gm-Message-State: AJcUukerzmeCwPzsKkSwnxCNaxcPOLjfdlWwZg1kilAtUvwnkp4PACzL
        XFuk2CUWiepQLihpJ/3BWqqWfvPSmCM=
X-Google-Smtp-Source: ALg8bN4+jwcbHK2GcajABXtHtYyu2QW6CASPgbYzU8r04/CH+GB0iDDPLi+BLgQUGTC+gwc2VEk+Xw==
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr28607254ljg.150.1548961840367;
        Thu, 31 Jan 2019 11:10:40 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id s9-v6sm918591lja.12.2019.01.31.11.10.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:10:37 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id v15-v6so3602511ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:10:37 -0800 (PST)
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr30717208ljh.174.1548961837166;
 Thu, 31 Jan 2019 11:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20190122010218.GA26713@linux.intel.com> <20190122025836.GH25163@ziepe.ca>
 <20190122132910.GA2720@linux.intel.com> <CAHk-=wgdOfi+zVVfKDDqJMs2Y7Lq0uufmP8Hx8JzQFA9UzNrBw@mail.gmail.com>
 <20190123153638.GA8727@linux.intel.com> <CAHk-=whgoJ8aAYH37hnyFjZ8jbYyswyf9wZZ82tTFL5f2he+6g@mail.gmail.com>
 <20190129132016.GA1602@linux.intel.com> <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com> <20190131170603.GA18349@linux.intel.com>
 <20190131183530.GA27112@linux.intel.com> <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
 <CAHk-=whEb14V981ziWmMdcqR40x5xfhhDCaB2JYcOBQHnHmsgw@mail.gmail.com>
In-Reply-To: <CAHk-=whEb14V981ziWmMdcqR40x5xfhhDCaB2JYcOBQHnHmsgw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Jan 2019 11:10:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYtqGO7v7c=Ak0xQfonGVbC_1sRHfxS4xNO-Sa6mFevw@mail.gmail.com>
Message-ID: <CAHk-=whYtqGO7v7c=Ak0xQfonGVbC_1sRHfxS4xNO-Sa6mFevw@mail.gmail.com>
Subject: Re: Getting weird TPM error after rebasing my tree to security/next-general
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     tomas.winkler@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000136afa0580c5c8f2"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000136afa0580c5c8f2
Content-Type: text/plain; charset="UTF-8"

On Thu, Jan 31, 2019 at 10:52 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think what I should do is to just make "memcpy_*io()" do the "align
> naturally" thing.
>
> Let me cook up a patch for you to test.

Does this work for you?

I haven't tested it at all, but I verified that the generated code
seems to make at least some amount of sense.

               Linus

--000000000000136afa0580c5c8f2
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jrkzvf6d0>
X-Attachment-Id: f_jrkzvf6d0

IGFyY2gveDg2L2xpYi9pb21lbS5jIHwgMjcgKysrKysrKysrKysrKysrKysrKysrKysrLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9saWIvaW9tZW0uYyBiL2FyY2gveDg2L2xpYi9pb21lbS5jCmluZGV4IDY2
ODk0Njc1ZjNjOC4uN2I1YjA3ZjNkMzcwIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9saWIvaW9tZW0u
YworKysgYi9hcmNoL3g4Ni9saWIvaW9tZW0uYwpAQCAtMyw3ICszLDcgQEAKICNpbmNsdWRlIDxs
aW51eC9pby5oPgogCiAvKiBPcmlnaW5hbGx5IGZyb20gaTM4Ni9zdHJpbmcuaCAqLwotc3RhdGlj
IF9fYWx3YXlzX2lubGluZSB2b2lkIF9faW9tZW1fbWVtY3B5KHZvaWQgKnRvLCBjb25zdCB2b2lk
ICpmcm9tLCBzaXplX3QgbikKK3N0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCByZXBfbW92cyh2
b2lkICp0bywgY29uc3Qgdm9pZCAqZnJvbSwgc2l6ZV90IG4pCiB7CiAJdW5zaWduZWQgbG9uZyBk
MCwgZDEsIGQyOwogCWFzbSB2b2xhdGlsZSgicmVwIDsgbW92c2xcblx0IgpAQCAtMTksMTUgKzE5
LDM2IEBAIHN0YXRpYyBfX2Fsd2F5c19pbmxpbmUgdm9pZCBfX2lvbWVtX21lbWNweSh2b2lkICp0
bywgY29uc3Qgdm9pZCAqZnJvbSwgc2l6ZV90IG4pCiAJCSAgICAgOiAibWVtb3J5Iik7CiB9CiAK
KyNkZWZpbmUgbW92cyh0eXBlLHRvLGZyb20pIFwKKwlhc20gdm9sYXRpbGUoIm1vdnMiIHR5cGU6
Ij0mRCIgKHRvKSwgIj0mUyIgKGZyb20pOiIwIiAodG8pLCAiMSIgKGZyb20pOiJtZW1vcnkiKQor
CiB2b2lkIG1lbWNweV9mcm9taW8odm9pZCAqdG8sIGNvbnN0IHZvbGF0aWxlIHZvaWQgX19pb21l
bSAqZnJvbSwgc2l6ZV90IG4pCiB7Ci0JX19pb21lbV9tZW1jcHkodG8sIChjb25zdCB2b2lkICop
ZnJvbSwgbik7CisJLyogVW5hbGlnbmVkIElPPyAqLworCWlmIChuICYmIHVubGlrZWx5KDEgJiAo
dW5zaWduZWQgbG9uZylmcm9tKSkgeworCQltb3ZzKCJiIiwgdG8sIGZyb20pOworCQluLS07CisJ
fQorCWlmIChuID4gMSAmJiB1bmxpa2VseSgyICYgKHVuc2lnbmVkIGxvbmcpZnJvbSkpIHsKKwkJ
bW92cygidyIsIHRvLCBmcm9tKTsKKwkJbi09MjsKKwl9CisJcmVwX21vdnModG8sIChjb25zdCB2
b2lkICopZnJvbSwgbik7CiB9CiBFWFBPUlRfU1lNQk9MKG1lbWNweV9mcm9taW8pOwogCiB2b2lk
IG1lbWNweV90b2lvKHZvbGF0aWxlIHZvaWQgX19pb21lbSAqdG8sIGNvbnN0IHZvaWQgKmZyb20s
IHNpemVfdCBuKQogewotCV9faW9tZW1fbWVtY3B5KCh2b2lkICopdG8sIChjb25zdCB2b2lkICop
IGZyb20sIG4pOworCS8qIFVuYWxpZ25lZCBJTz8gKi8KKwlpZiAobiAmJiB1bmxpa2VseSgxICYg
KHVuc2lnbmVkIGxvbmcpdG8pKSB7CisJCW1vdnMoImIiLCB0bywgZnJvbSk7CisJCW4tLTsKKwl9
CisJaWYgKG4gPiAxICYmIHVubGlrZWx5KDIgJiAodW5zaWduZWQgbG9uZyl0bykpIHsKKwkJbW92
cygidyIsIHRvLCBmcm9tKTsKKwkJbi09MjsKKwl9CisJcmVwX21vdnMoKHZvaWQgKil0bywgKGNv
bnN0IHZvaWQgKikgZnJvbSwgbik7CiB9CiBFWFBPUlRfU1lNQk9MKG1lbWNweV90b2lvKTsKIAo=
--000000000000136afa0580c5c8f2--
