Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D132C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6164C20684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4MyrH2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfAVNxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:53:00 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:38448 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfAVNxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:53:00 -0500
Received: by mail-it1-f193.google.com with SMTP id h65so20115848ith.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcstbP2du4nmOxhluyBXs8pC2Gr+Za/j1KtRguPwC28=;
        b=I4MyrH2QB4Nw2swVtuj2XSA4/Fwz6/Fbe5dQSa3542bHtOAkcdGDWOMVwzSoaijotX
         JCLyvSuQ0bWI4YuHypsqMrc9eyGbU1wEHO02nDrxMCh6+YtCoeRAB3NTw085/7Akni9/
         eyE8h3gSjIvq5Dq83haw4igACAJxAtUlIANLJOEPdMASPjQDOIMMhQ0/kOaa4v6hqlub
         Bc2SjY/nyKJjWMlxXYb0Sx1SA30eG4z0B4dwaPJyf180oKigr0l6E2hzwegXjsPoj1KB
         oiEuLnFziqYMUkUwhp0qIAFdFm4S/NkjkzEE76dBgtdSR26fa+6XakKqugrvUCdwTKFv
         U5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcstbP2du4nmOxhluyBXs8pC2Gr+Za/j1KtRguPwC28=;
        b=g/YnV/paNOrVoYBC6+1Uaaazh8vTLglwBTjXldC99VJNTDnfCF0F5JtwQVd/rdkeW6
         88919UvDQ3Y9qJbGDQis6HKg4cN0jrTWoAA5b75d8XdWQciZToNxu6LotGkOW3oyBdSL
         Lb6GyhB2F3tkE7vPD6rdXm0iuoGaXObqfTicp8q9AE7jPsVjcfC96g4ONifN8UalLdBK
         gxTfrXSq8DrjuROihmEts5yURONUNh/7j05kG5P/94MWnp/+OTSOrkKH1Gz5vccFKqxZ
         KynmEdwq3qiQ4NZXaaFC9Tt48KPNf630hZKt3nQlS3FhEHXw/9oNr8uq3wRIY1wQmBzC
         WD8g==
X-Gm-Message-State: AJcUukc4ywdu340ee1/XeMEsKxmJLW8bwoB55g61Jipkokx+NaxRMptp
        8I9X07hlIVTbhIz+ejwg6ezEVVS4mKs0xrHjA4w1jg==
X-Google-Smtp-Source: ALg8bN4S/7RlDMRYmYLdQw35QoXS1xuVyrqyGvgM1YJzZQe0SlF3vBK0WP2VlQQIMieX4vjUDJSb9d/VO1DgNOXDzno=
X-Received: by 2002:a24:6511:: with SMTP id u17mr2165794itb.12.1548165178757;
 Tue, 22 Jan 2019 05:52:58 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f7a28e057653dc6e@google.com> <20180920141058.4ed467594761e073606eafe2@linux-foundation.org>
 <CAHRSSEzX5HOUEQ6DgEF76OLGrwS1isWMdtvneBLOEEnwoMxVrA@mail.gmail.com>
 <CAEXW_YSot+3AMQ=jmDRowmqoOmQmujp9r8Dh18KJJN1EDmyHOw@mail.gmail.com>
 <20180921162110.e22d09a9e281d194db3c8359@linux-foundation.org>
 <4b0a5f8c-2be2-db38-a70d-8d497cb67665@I-love.SAKURA.ne.jp>
 <CACT4Y+ZTjCGd9XYUCUoqv+AqXrPwX4OqWMC0jFgjNxZRFkNYXw@mail.gmail.com> <c56d4d0b-8ecc-059d-69cb-4f3e91f9410c@i-love.sakura.ne.jp>
In-Reply-To: <c56d4d0b-8ecc-059d-69cb-4f3e91f9410c@i-love.sakura.ne.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 22 Jan 2019 14:52:47 +0100
Message-ID: <CACT4Y+YA38BfnByA_jrocbhbbqg7NWRe4-5UAp5Q-iKFi9hGQA@mail.gmail.com>
Subject: Re: possible deadlock in __do_page_fault
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        syzbot+a76129f18c89f3e2ddd4@syzkaller.appspotmail.com,
        Andi Kleen <ak@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: multipart/mixed; boundary="0000000000008983d005800c4bdb"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008983d005800c4bdb
Content-Type: text/plain; charset="UTF-8"

On Tue, Jan 22, 2019 at 11:32 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2019/01/22 19:12, Dmitry Vyukov wrote:
> > On Tue, Jan 22, 2019 at 11:02 AM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> On 2018/09/22 8:21, Andrew Morton wrote:
> >>> On Thu, 20 Sep 2018 19:33:15 -0400 Joel Fernandes <joel@joelfernandes.org> wrote:
> >>>
> >>>> On Thu, Sep 20, 2018 at 5:12 PM Todd Kjos <tkjos@google.com> wrote:
> >>>>>
> >>>>> +Joel Fernandes
> >>>>>
> >>>>> On Thu, Sep 20, 2018 at 2:11 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >>>>>>
> >>>>>>
> >>>>>> Thanks.  Let's cc the ashmem folks.
> >>>>>>
> >>>>
> >>>> This should be fixed by https://patchwork.kernel.org/patch/10572477/
> >>>>
> >>>> It has Neil Brown's Reviewed-by but looks like didn't yet appear in
> >>>> anyone's tree, could Greg take this patch?
> >>>
> >>> All is well.  That went into mainline yesterday, with a cc:stable.
> >>>
> >>
> >> This problem was not fixed at all.
> >
> > There are at least 2 other open deadlocks involving ashmem:
>
> Yes, they involve ashmem_shrink_scan() => {shmem|vfs}_fallocate() sequence.
> This approach tries to eliminate this sequence.
>
> >
> > https://syzkaller.appspot.com/bug?extid=148c2885d71194f18d28
> > https://syzkaller.appspot.com/bug?extid=4b8b031b89e6b96c4b2e
> >
> > Does this fix any of these too?
>
> I need checks from ashmem folks whether this approach is possible/correct.
> But you can ask syzbot to test this patch before ashmem folks respond.

Right. Let's do this.

As with any kernel changes only you really know how to apply it, git
tree/base commit info is missing, so let's do guessing and
finger-crossing as usual:

#syz fix: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

--0000000000008983d005800c4bdb
Content-Type: text/x-patch; charset="US-ASCII"; name="ashmem.patch"
Content-Disposition: attachment; filename="ashmem.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jr7tha2d0>
X-Attachment-Id: f_jr7tha2d0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9hbmRyb2lkL2FzaG1lbS5jIGIvZHJpdmVycy9z
dGFnaW5nL2FuZHJvaWQvYXNobWVtLmMKaW5kZXggOTBhOGE5ZjFhYzdkLi4xYTg5MGM0M2ExMGEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc3RhZ2luZy9hbmRyb2lkL2FzaG1lbS5jCisrKyBiL2RyaXZl
cnMvc3RhZ2luZy9hbmRyb2lkL2FzaG1lbS5jCkBAIC03NSw2ICs3NSwxNyBAQCBzdHJ1Y3QgYXNo
bWVtX3JhbmdlIHsKIC8qIExSVSBsaXN0IG9mIHVucGlubmVkIHBhZ2VzLCBwcm90ZWN0ZWQgYnkg
YXNobWVtX211dGV4ICovCiBzdGF0aWMgTElTVF9IRUFEKGFzaG1lbV9scnVfbGlzdCk7CiAKK3N0
YXRpYyBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqYXNobWVtX3dxOworc3RhdGljIGF0b21pY190
IGFzaG1lbV9zaHJpbmtfaW5mbGlnaHQgPSBBVE9NSUNfSU5JVCgwKTsKK3N0YXRpYyBERUNMQVJF
X1dBSVRfUVVFVUVfSEVBRChhc2htZW1fc2hyaW5rX3dhaXQpOworCitzdHJ1Y3QgYXNobWVtX3No
cmlua193b3JrIHsKKwlzdHJ1Y3Qgd29ya19zdHJ1Y3Qgd29yazsKKwlzdHJ1Y3QgZmlsZSAqZmls
ZTsKKwlsb2ZmX3Qgc3RhcnQ7CisJbG9mZl90IGVuZDsKK307CisKIC8qCiAgKiBsb25nIGxydV9j
b3VudCAtIFRoZSBjb3VudCBvZiBwYWdlcyBvbiBvdXIgTFJVIGxpc3QuCiAgKgpAQCAtMjkyLDYg
KzMwMyw3IEBAIHN0YXRpYyBzc2l6ZV90IGFzaG1lbV9yZWFkX2l0ZXIoc3RydWN0IGtpb2NiICpp
b2NiLCBzdHJ1Y3QgaW92X2l0ZXIgKml0ZXIpCiAJaW50IHJldCA9IDA7CiAKIAltdXRleF9sb2Nr
KCZhc2htZW1fbXV0ZXgpOworCXdhaXRfZXZlbnQoYXNobWVtX3Nocmlua193YWl0LCAhYXRvbWlj
X3JlYWQoJmFzaG1lbV9zaHJpbmtfaW5mbGlnaHQpKTsKIAogCS8qIElmIHNpemUgaXMgbm90IHNl
dCwgb3Igc2V0IHRvIDAsIGFsd2F5cyByZXR1cm4gRU9GLiAqLwogCWlmIChhc21hLT5zaXplID09
IDApCkBAIC0zNTksNiArMzcxLDcgQEAgc3RhdGljIGludCBhc2htZW1fbW1hcChzdHJ1Y3QgZmls
ZSAqZmlsZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpCiAJaW50IHJldCA9IDA7CiAKIAlt
dXRleF9sb2NrKCZhc2htZW1fbXV0ZXgpOworCXdhaXRfZXZlbnQoYXNobWVtX3Nocmlua193YWl0
LCAhYXRvbWljX3JlYWQoJmFzaG1lbV9zaHJpbmtfaW5mbGlnaHQpKTsKIAogCS8qIHVzZXIgbmVl
ZHMgdG8gU0VUX1NJWkUgYmVmb3JlIG1hcHBpbmcgKi8KIAlpZiAoIWFzbWEtPnNpemUpIHsKQEAg
LTQyMSw2ICs0MzQsMTkgQEAgc3RhdGljIGludCBhc2htZW1fbW1hcChzdHJ1Y3QgZmlsZSAqZmls
ZSwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpCiAJcmV0dXJuIHJldDsKIH0KIAorc3RhdGlj
IHZvaWQgYXNobWVtX3Nocmlua193b3JrZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQorewor
CXN0cnVjdCBhc2htZW1fc2hyaW5rX3dvcmsgKncgPSBjb250YWluZXJfb2Yod29yaywgdHlwZW9m
KCp3KSwgd29yayk7CisKKwl3LT5maWxlLT5mX29wLT5mYWxsb2NhdGUody0+ZmlsZSwKKwkJCQkg
RkFMTE9DX0ZMX1BVTkNIX0hPTEUgfCBGQUxMT0NfRkxfS0VFUF9TSVpFLAorCQkJCSB3LT5zdGFy
dCwgdy0+ZW5kIC0gdy0+c3RhcnQpOworCWZwdXQody0+ZmlsZSk7CisJa2ZyZWUodyk7CisJaWYg
KGF0b21pY19kZWNfYW5kX3Rlc3QoJmFzaG1lbV9zaHJpbmtfaW5mbGlnaHQpKQorCQl3YWtlX3Vw
X2FsbCgmYXNobWVtX3Nocmlua193YWl0KTsKK30KKwogLyoKICAqIGFzaG1lbV9zaHJpbmsgLSBv
dXIgY2FjaGUgc2hyaW5rZXIsIGNhbGxlZCBmcm9tIG1tL3Ztc2Nhbi5jCiAgKgpAQCAtNDQ5LDEy
ICs0NzUsMTggQEAgYXNobWVtX3Nocmlua19zY2FuKHN0cnVjdCBzaHJpbmtlciAqc2hyaW5rLCBz
dHJ1Y3Qgc2hyaW5rX2NvbnRyb2wgKnNjKQogCQlyZXR1cm4gLTE7CiAKIAlsaXN0X2Zvcl9lYWNo
X2VudHJ5X3NhZmUocmFuZ2UsIG5leHQsICZhc2htZW1fbHJ1X2xpc3QsIGxydSkgewotCQlsb2Zm
X3Qgc3RhcnQgPSByYW5nZS0+cGdzdGFydCAqIFBBR0VfU0laRTsKLQkJbG9mZl90IGVuZCA9IChy
YW5nZS0+cGdlbmQgKyAxKSAqIFBBR0VfU0laRTsKKwkJc3RydWN0IGFzaG1lbV9zaHJpbmtfd29y
ayAqdyA9IGt6YWxsb2Moc2l6ZW9mKCp3KSwgR0ZQX0FUT01JQyk7CisKKwkJaWYgKCF3KQorCQkJ
YnJlYWs7CisJCUlOSVRfV09SSygmdy0+d29yaywgYXNobWVtX3Nocmlua193b3JrZXIpOworCQl3
LT5maWxlID0gcmFuZ2UtPmFzbWEtPmZpbGU7CisJCWdldF9maWxlKHctPmZpbGUpOworCQl3LT5z
dGFydCA9IHJhbmdlLT5wZ3N0YXJ0ICogUEFHRV9TSVpFOworCQl3LT5lbmQgPSAocmFuZ2UtPnBn
ZW5kICsgMSkgKiBQQUdFX1NJWkU7CisJCWF0b21pY19pbmMoJmFzaG1lbV9zaHJpbmtfaW5mbGln
aHQpOworCQlxdWV1ZV93b3JrKGFzaG1lbV93cSwgJnctPndvcmspOwogCi0JCXJhbmdlLT5hc21h
LT5maWxlLT5mX29wLT5mYWxsb2NhdGUocmFuZ2UtPmFzbWEtPmZpbGUsCi0JCQkJRkFMTE9DX0ZM
X1BVTkNIX0hPTEUgfCBGQUxMT0NfRkxfS0VFUF9TSVpFLAotCQkJCXN0YXJ0LCBlbmQgLSBzdGFy
dCk7CiAJCXJhbmdlLT5wdXJnZWQgPSBBU0hNRU1fV0FTX1BVUkdFRDsKIAkJbHJ1X2RlbChyYW5n
ZSk7CiAKQEAgLTcxMyw2ICs3NDUsNyBAQCBzdGF0aWMgaW50IGFzaG1lbV9waW5fdW5waW4oc3Ry
dWN0IGFzaG1lbV9hcmVhICphc21hLCB1bnNpZ25lZCBsb25nIGNtZCwKIAkJcmV0dXJuIC1FRkFV
TFQ7CiAKIAltdXRleF9sb2NrKCZhc2htZW1fbXV0ZXgpOworCXdhaXRfZXZlbnQoYXNobWVtX3No
cmlua193YWl0LCAhYXRvbWljX3JlYWQoJmFzaG1lbV9zaHJpbmtfaW5mbGlnaHQpKTsKIAogCWlm
ICghYXNtYS0+ZmlsZSkKIAkJZ290byBvdXRfdW5sb2NrOwpAQCAtODgzLDggKzkxNiwxNSBAQCBz
dGF0aWMgaW50IF9faW5pdCBhc2htZW1faW5pdCh2b2lkKQogCQlnb3RvIG91dF9mcmVlMjsKIAl9
CiAKKwlhc2htZW1fd3EgPSBhbGxvY193b3JrcXVldWUoImFzaG1lbV93cSIsIFdRX01FTV9SRUNM
QUlNLCAwKTsKKwlpZiAoIWFzaG1lbV93cSkgeworCQlwcl9lcnIoImZhaWxlZCB0byBjcmVhdGUg
d29ya3F1ZXVlXG4iKTsKKwkJZ290byBvdXRfZGVtaXNjOworCX0KKwogCXJldCA9IHJlZ2lzdGVy
X3Nocmlua2VyKCZhc2htZW1fc2hyaW5rZXIpOwogCWlmIChyZXQpIHsKKwkJZGVzdHJveV93b3Jr
cXVldWUoYXNobWVtX3dxKTsKIAkJcHJfZXJyKCJmYWlsZWQgdG8gcmVnaXN0ZXIgc2hyaW5rZXIh
XG4iKTsKIAkJZ290byBvdXRfZGVtaXNjOwogCX0K
--0000000000008983d005800c4bdb--
