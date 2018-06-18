Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F064C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367B720693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+pKuR9g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367B720693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935263AbeFRRSt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:18:49 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36870 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934215AbeFRRSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:18:47 -0400
Received: by mail-pf0-f194.google.com with SMTP id y5-v6so8500569pfn.4;
        Mon, 18 Jun 2018 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g3NftWdppLc0VF7uXUr73ZFrthOaoLpdwqpt3lZVZZs=;
        b=b+pKuR9gsYVBXadDWzvXP/Th6PyDISNB+5+601HROx0nGut+cIS2EL5wxeOifTqxkl
         RA2QxXtx1rzcfS0imBfqHn2gFlw3RjPj4CbBdiJ03Uya/LGYuQnKj+ymKPZhMRg3pC49
         XeL24qWpJ0qHrbjgETnkHeZM/DGtIibfPt2m9gx//R55zi0iGEG2HTBF6rJ/Q2Q84SGL
         YnOhGw9jIU+mHXkgpxicPDum/NG4530dbg/lzrTirH2ZueEeAHWbpKtDomiVt+NgR1Z1
         0eaMHq1I75hCQpXUZhXFvD82DURhyaBkbS5O9JNKzv/rzjtslfZOxKzr9Xf1NZjb17gP
         AeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g3NftWdppLc0VF7uXUr73ZFrthOaoLpdwqpt3lZVZZs=;
        b=ooTSoDwLQXyJkRT/Uco5yJX50l+OeYP+jRp27QBL3xKOXT3k3ROit73n5Aee139t5N
         VTZ5Ku9h03tHmfno9cYLzt1HfgP2iXBlQAFyOGQBT+DidTrjWjhIdPYcvSz8dxd+F7KC
         o2+xOPJHEbBNA6tX7KAWbuk68b8K1/OtV1AYNO2E7Lviwr1m2jAvgRKZOZmMx8avX2az
         aoQAtTo1kkAV7UUqRuwWcdbGPT6uMafbVYWrBS9ZYFOred82Ynfwxh+4JlDhNvZfTqX6
         KxrRy8+fjeQzv6ntxJf5FABWT63dy+YmAduIVnC16dQU5pWT1nmF3z8XQCS5OyqBARr3
         J74w==
X-Gm-Message-State: APt69E3zyW0KZeNgHU5+RDMRlm+KOJMBQjP0h4Jzzv+GUH3hdZlTYbfQ
        MmE5Kxx48qf06XpoS7cXSdZs04UCEFJPssI/06s=
X-Google-Smtp-Source: ADUXVKI4RqpWmsGXGbYcAUBi+ONsnOLjbwtJJt2M6PtR1zMEnNeg6BFT/2nhwiXD+QXOirIQqtvG+XJPzm1xNn1+hhI=
X-Received: by 2002:a63:b812:: with SMTP id p18-v6mr12141601pge.11.1529342326631;
 Mon, 18 Jun 2018 10:18:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:80cc:0:0:0:0 with HTTP; Mon, 18 Jun 2018 10:18:25
 -0700 (PDT)
In-Reply-To: <CAH2r5muZJkx0eR0uAyuRBkkTf7-97x5oSMWPXdfb1TUK4rwGJw@mail.gmail.com>
References: <20180618130737.GA13880@embeddedor.com> <CAH2r5muZJkx0eR0uAyuRBkkTf7-97x5oSMWPXdfb1TUK4rwGJw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 18 Jun 2018 12:18:25 -0500
Message-ID: <CAH2r5mvu7e2ec6fb0Aay5OAr8S31jy=j7_7sL_VRfi6U2G_mZA@mail.gmail.com>
Subject: Re: [smb3] unreachable code and memory leaks
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000001e8b15056eedc2cc"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001e8b15056eedc2cc
Content-Type: text/plain; charset="UTF-8"

Gustavo,
Thx for pointing this out.  Let me know if this patch addresses what
you found.  Code is experimental mount option but extremely important
to get right due to move away from SMB1/CIFS which had posix
extensions.



On Mon, Jun 18, 2018 at 11:55 AM, Steve French <smfrench@gmail.com> wrote:
> On Mon, Jun 18, 2018 at 8:07 AM, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>> Hi Steve,
>>
>> While doing some static analysis I came across the following piece of code at fs/cifs/smb2pdu.c:2017:
>>
>> 2017                if (n_iov > 2) {
>> 2018                        struct create_context *ccontext =
>> 2019                            (struct create_context *)iov[n_iov-1].iov_base;
>> 2020                        ccontext->Next =
>> 2021                                cpu_to_le32(iov[n_iov-1].iov_len);
>> 2022                }
>
> Good catch - this is harmless (and experimental mount option) - cut
> and paste - unneeded clause.
> Fixing now
>
>
>> Also, it seems there are multiple places in which memory allocated for *path* is leaking:
>>
>> 1946        else
>> 1947                return -EIO;
>>
>> 1951        if (rc)
>> 1952                return rc;
>>
>> 1987                if (rc) {
>> 1988                        cifs_small_buf_release(req);
>> 1989                        return rc;
>> 1990                }
>
> Cleaning that up now. Will post a patch - thx.
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve

--0000000000001e8b15056eedc2cc
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-fix-memory-leak-in-smb311_posix_mkdir.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-fix-memory-leak-in-smb311_posix_mkdir.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jikiwy4v0

RnJvbSAwZjRlM2RlYzFjMzYyMTE5ODUxYWEyMDQ5ZmYyM2QxOTcxYjRlNGE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IE1vbiwgMTggSnVuIDIwMTggMTI6MDI6NDcgLTA1MDAKU3ViamVjdDogW1BBVENIXSBz
bWIzOiBmaXggbWVtb3J5IGxlYWsgaW4gc21iMzExX3Bvc2l4X21rZGlyCgpTaWduZWQtb2ZmLWJ5
OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+ClJlcG9ydGVkLWJ5OiBHdXN0
YXZvIEEuIFIuIFNpbHZhIDxndXN0YXZvQGVtYmVkZGVkb3IuY29tPgpSZXZpZXdlZC1ieTogQXVy
ZWxpZW4gQXB0ZWwgPGFhcHRlbEBzdXNlLmNvbT4KLS0tCiBmcy9jaWZzL3NtYjJwZHUuYyB8IDE5
ICsrKysrKysrKystLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvc21iMnBkdS5jIGIvZnMvY2lmcy9z
bWIycGR1LmMKaW5kZXggODEwYjg1Nzg3YzkxLi5iMDQ5OGNhZGI5NTIgMTAwNjQ0Ci0tLSBhL2Zz
L2NpZnMvc21iMnBkdS5jCisrKyBiL2ZzL2NpZnMvc21iMnBkdS5jCkBAIC0xOTQzLDEzICsxOTQz
LDE3IEBAIGludCBzbWIzMTFfcG9zaXhfbWtkaXIoY29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3Ry
dWN0IGlub2RlICppbm9kZSwKIAogCWlmIChzZXMgJiYgKHNlcy0+c2VydmVyKSkKIAkJc2VydmVy
ID0gc2VzLT5zZXJ2ZXI7Ci0JZWxzZQorCWVsc2UgeworCQlrZnJlZShwYXRoKTsKIAkJcmV0dXJu
IC1FSU87CisJfQogCiAJcmMgPSBzbWIyX3BsYWluX3JlcV9pbml0KFNNQjJfQ1JFQVRFLCB0Y29u
LCAodm9pZCAqKikgJnJlcSwgJnRvdGFsX2xlbik7CiAKLQlpZiAocmMpCisJaWYgKHJjKSB7CisJ
CWtmcmVlKHBhdGgpOwogCQlyZXR1cm4gcmM7CisJfQogCiAJaWYgKHNtYjNfZW5jcnlwdGlvbl9y
ZXF1aXJlZCh0Y29uKSkKIAkJZmxhZ3MgfD0gQ0lGU19UUkFOU0ZPUk1fUkVROwpAQCAtMTk4Niw2
ICsxOTkwLDcgQEAgaW50IHNtYjMxMV9wb3NpeF9ta2Rpcihjb25zdCB1bnNpZ25lZCBpbnQgeGlk
LCBzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCQkJCQkJIHRjb24tPnRyZWVOYW1lLCBwYXRoKTsKIAkJ
aWYgKHJjKSB7CiAJCQljaWZzX3NtYWxsX2J1Zl9yZWxlYXNlKHJlcSk7CisJCQlrZnJlZShwYXRo
KTsKIAkJCXJldHVybiByYzsKIAkJfQogCQlyZXEtPk5hbWVMZW5ndGggPSBjcHVfdG9fbGUxNihu
YW1lX2xlbiAqIDIpOwpAQCAtMjAwMCw2ICsyMDA1LDcgQEAgaW50IHNtYjMxMV9wb3NpeF9ta2Rp
cihjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCQkJY29weV9w
YXRoID0ga3phbGxvYyhjb3B5X3NpemUsIEdGUF9LRVJORUwpOwogCQkJaWYgKCFjb3B5X3BhdGgp
IHsKIAkJCQljaWZzX3NtYWxsX2J1Zl9yZWxlYXNlKHJlcSk7CisJCQkJa2ZyZWUocGF0aCk7CiAJ
CQkJcmV0dXJuIC1FTk9NRU07CiAJCQl9CiAJCQltZW1jcHkoKGNoYXIgKiljb3B5X3BhdGgsIChj
b25zdCBjaGFyICopcGF0aCwKQEAgLTIwMTQsMTcgKzIwMjAsMTEgQEAgaW50IHNtYjMxMV9wb3Np
eF9ta2Rpcihjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCXJl
cS0+UmVxdWVzdGVkT3Bsb2NrTGV2ZWwgPSBTTUIyX09QTE9DS19MRVZFTF9OT05FOwogCiAJaWYg
KHRjb24tPnBvc2l4X2V4dGVuc2lvbnMpIHsKLQkJaWYgKG5faW92ID4gMikgewotCQkJc3RydWN0
IGNyZWF0ZV9jb250ZXh0ICpjY29udGV4dCA9Ci0JCQkgICAgKHN0cnVjdCBjcmVhdGVfY29udGV4
dCAqKWlvdltuX2lvdi0xXS5pb3ZfYmFzZTsKLQkJCWNjb250ZXh0LT5OZXh0ID0KLQkJCQljcHVf
dG9fbGUzMihpb3Zbbl9pb3YtMV0uaW92X2xlbik7Ci0JCX0KLQogCQlyYyA9IGFkZF9wb3NpeF9j
b250ZXh0KGlvdiwgJm5faW92LCBtb2RlKTsKIAkJaWYgKHJjKSB7CiAJCQljaWZzX3NtYWxsX2J1
Zl9yZWxlYXNlKHJlcSk7CiAJCQlrZnJlZShjb3B5X3BhdGgpOworCQkJa2ZyZWUocGF0aCk7CiAJ
CQlyZXR1cm4gcmM7CiAJCX0KIAkJcGNfYnVmID0gaW92W25faW92LTFdLmlvdl9iYXNlOwpAQCAt
MjA1Nyw2ICsyMDU3LDcgQEAgaW50IHNtYjMxMV9wb3NpeF9ta2Rpcihjb25zdCB1bnNpZ25lZCBp
bnQgeGlkLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCiBzbWIzMTFfbWtkaXJfZXhpdDoKIAlrZnJl
ZShjb3B5X3BhdGgpOworCWtmcmVlKHBhdGgpOwogCWtmcmVlKHBjX2J1Zik7CiAJZnJlZV9yc3Bf
YnVmKHJlc3BfYnVmdHlwZSwgcnNwKTsKIAlyZXR1cm4gcmM7Ci0tIAoyLjE3LjEKCg==
--0000000000001e8b15056eedc2cc--
