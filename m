Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2109217-1525752920-2-6400222172571179151
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525752920; b=PsU9jwXNoqn8yFJdu5x9Y7HDtYyzT0/Qxk069UL9nhAXQq2KcR
    DmYff0DmQxSW8sDCxSJsHxA7jU120E8kIKz4FwRhltezGoKgYXftYJ6otroGFQES
    V7fjc0SI4ahkYzfqRUPwwpBA/zkyNswRcauRale6TsQ17ySiL08La9ORFNuo4SrT
    PZnkhdUi4n/L0WRbid70Q7yy2ZBMoLiYE2McjNRf9YeEyyE0mVsrWLmQanoxCuXb
    JoFSv7VSbiBwAPZDKoTN0dq4TSQOd8EGdZ9C6zSf9x882lQKP9YE8fC+AqZwA6Wy
    9tvpN6g8n5HeYYTHCgU/larw8i+st9sTNEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:in-reply-to:references:mime-version
    :content-type:content-transfer-encoding:subject:to:cc:from
    :message-id:sender:list-id; s=fm2; t=1525752920; bh=/AAhwSEYsaC8
    NkmBJMeZcvvcnIYCRvjupNs4QbtElTs=; b=QHnVOedZ15N6fbYo2Amp5WIE3I9N
    e7CI6Y+Pk9J7AAXzauOOgASPku+8gFyshMdv93AbUEeRktkTFafAagmJu0betNhy
    +2/hpp++nsjUGg2u/P9mV+oHqgacaUJXvMAmKPUZ3oMpKvySSw41X4oSq7bJfR9E
    peFCynTAxe6A7D1cV4LzGS4OVtg4HUimvB07Jr5yfRgUl5vYwwboco0IdIRrdgY1
    SVwQHX8SQYBB5jxYtk4V3qYklf6fN5aMs77TK/NiMutbbDPSTsYaETmwgAGzMvU0
    onNOqfNM4R/ILyUI00lwJAcsEfN1NvgE5ptb3MgAJIvaHxhWJ9EYg8bnDg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=odAFrbq0 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=KQQp/bp6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=odAFrbq0 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=KQQp/bp6;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEf0JfJtOTQlFKaHCFQQzOvl4UeX/wsRY44TIcV4bWzHrOwNeKPSueld247l0zEDJN6GU+7UoCd1jfYKGbz9xbpPSx0kut28B3S5IidD893u3F4l7Z3V
    1SgkMtK/NHqFUOJEhsQFE+EOhyh7b5vZ3ZxbMfB0Emqg//EwSAUcEUV/VCOKiRUFuTpXd5xDnsfhzzLzf72RD/F+tWC6YROJAzHvsb4TXKOwq9awO8+q5H7m
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=GZSbEf3-C1UA:10 a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=PuvxfXWCAAAA:8 a=sWOTHNijPJNshOUQyR8A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=uAr15Ul7AJ1q7o2wzYQp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750751AbeEHEPS (ORCPT <rfc822;linux@kroah.com>);
        Tue, 8 May 2018 00:15:18 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40183 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750715AbeEHEPR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 May 2018 00:15:17 -0400
X-Google-Smtp-Source: AB8JxZpSgo147gEBFxgKS7V+78Y0S1bxNbfhz4CQKm3gQx4h1nWoL/5N5TmeTpkUBNMd59AY09nXNA==
Date: Mon, 07 May 2018 20:23:09 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180507231506.4891-1-mcgrof@kernel.org>
References: <20180507231506.4891-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] mm: expland documentation over __read_mostly
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, tglx@linutronix.de,
        arnd@arndb.de, cl@linux.com
CC: keescook@chromium.org, luto@amacapital.net, longman@redhat.com,
        viro@zeniv.linux.org.uk, willy@infradead.org,
        ebiederm@xmission.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: Joel Fernandes <joel.opensrc@gmail.com>
Message-ID: <9AE4F1FC-2B6A-4EB4-8626-9936B8EB5CBB@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On May 7, 2018 4:15:06 PM PDT, "Luis R=2E Rodriguez" <mcgrof@kernel=2Eorg>=
 wrote:
>__read_mostly can easily be misused by folks, its not meant for
>just read-only data=2E There are performance reasons for using it, but
>we also don't provide any guidance about its use=2E Provide a bit more
>guidance over it use=2E
>
>Signed-off-by: Luis R=2E Rodriguez <mcgrof@kernel=2Eorg>
>---
> include/linux/cache=2Eh | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>
>Every now and then we get a patch suggesting to use __read_mostly for
>something new or old but with no justifications=2E Add a bit more
>verbiage to help guide its users=2E
>
>Is this sufficient documentation to at least ask for a reason in the
>commit
>log as to why its being used for new entries? Or should we be explicit
>and
>ask for such justifications in commit logs? Taken from prior
>discussions
>with Christoph Lameter [0] over its use=2E
>
>[0]
>https://lkml=2Ekernel=2Eorg/r/alpine=2EDEB=2E2=2E11=2E1504301343190=2E288=
79@gentwo=2Eorg
>
>diff --git a/include/linux/cache=2Eh b/include/linux/cache=2Eh
>index 750621e41d1c=2E=2E62bc5adc0ed5 100644
>--- a/include/linux/cache=2Eh
>+++ b/include/linux/cache=2Eh
>@@ -15,8 +15,14 @@
>=20
> /*
>* __read_mostly is used to keep rarely changing variables out of
>frequently
>- * updated cachelines=2E If an architecture doesn't support it, ignore
>the
>- * hint=2E
>+ * updated cachelines=2E Its use should be reserved for data that is
>used
>+ * frequently in hot paths=2E Performance traces can help decide when to
>use
>+ * this=2E You want __read_mostly data to be tightly packed, so that in
>the
>+ * best case multiple frequently read variables for a hot path will be
>next
>+ * to each other in order to reduce the number of cachelines needed to
>+ * execute a critial path=2E We should be mindful and selective if its

Nit: in its use=2E

- Joel


>use=2E
>+ *
>+ * If an architecture doesn't support it, ignore the hint=2E
>  */
> #ifndef __read_mostly
> #define __read_mostly

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
