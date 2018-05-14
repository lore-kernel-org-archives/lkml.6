Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1474708-1526333463-2-2567208837224367299
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526333461; b=QqdcTfM3wwjx/W7sBLL5+myV+HewUTIIP/so39yUMKTjCcIRVp
    6PDHnW3nJ4gSJmBO88/kZTEsyKYT1uNUh7GryTALm90i/gIwKvOIUDkJ/Iq9xIu6
    h0BfKLE8UsSEmDo9aIHD29/r0iB7mdwVGrpSFj+K2qF3EbSD21fz6VMAnWLhUN7H
    4mGMRUFUn0aqHhR/HX3Qhdk5C9HCWuptSj35cwpA7LSrAcSQYcHTZ4jJj7YAxqK6
    lfdr3mpbaOZyqOfYdXtbDgrBqUowGt8NTwny0VNRx6eIzI+Mdw66ZjJVDqdY5rRr
    Cc422YaXbiZuqtUpez11lp+8IlBnst7Cd86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526333461; bh=N9fOw
    /JYqssHR2w1602Uv5geP7DAKC0Hm9lFepchs8w=; b=nrN+nHwlDWLsE6M3dsUJF
    sgBiGDLxgNMmWdV1ZhJPjhO7NSXxQpGC2PQ/fseACdae4aJ0Yi/lBSBqfChirEvg
    fThcR0vkbXW4biImehynaZ6WO+QHkccoqVO+Vk7/lAkwud/OK2LLjIA2vxv4o5Qu
    pSxgC4BIidL/OJ5qd5yOWF9LPBQVwu0dNRZMl2OVr4Y9J7lXldf35Yg5XrBTbgsC
    U98SIipqEKjC5erNMS+TOTWANmdvxj/RnGKtsdZEAxuqJE3QWjtsnwDYf8YaRjP8
    H1Q0qVXoepeYe08jnM3hpmtlmVX0ZcqHY609O0GMH4CbNYruoH2pSpes89pQN4Hd
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=android.com header.i=@android.com header.b=Uiz1nn0Y
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=gtSQLxMj;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=android.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=android.com header.i=@android.com header.b=Uiz1nn0Y
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=gtSQLxMj;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=android.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFp+iu+kNOu2aJNSMg5d51/lJr7Nf5zV5EEvkK+H7YazxB8USZ2JqiB0Vh/RyF+8KFAAKZ8xYnUsuTi3A5X2uX+WcV2qx99W2H2488qnOt4CqcfCUr++
    ZkPl1+FAbz3PSGkErAdiCQxj7C6Uf7NfNlMnC74PXTX8H2xSr/tagGEEyYStRaKc5eC0/NcMSKH9ZUyQGoVFAw/TYdwbg5q/lPUHZ2w4PI6G/Q8Bx5DhFllS
    +f8vjflPVfS/UWqdYbkfCA==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=tBb2bbeoAAAA:8 a=DDOyTI_5AAAA:8
    a=dEXum9jzBS8EYObEAD0A:9 a=CjuIK1q_8ugA:10 a=Oj-tNtZlA1e06AYgeCfH:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZoy8mTLSQzAzDlbojmX+YPkHJXlRUPazHWFYNsr6Rljjm18ugf9JMTYKAC/yk8MB5h0RXeLo4ovAreFB7eUjl0=
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW0nxOmq7gjJiySg0fho2XDYkyrCgp88OOuULRLH+jt6w@mail.gmail.com>
References: <20180504195728.72932-1-maco@android.com>
 <201805060540.zjwonWcp%fengguang.wu@intel.com>
 <CAB0TPYG-Q6Ki_FMM1u+i_g+0ykQgeUTRpm00qycAUVQOqVH6eQ@mail.gmail.com>
 <20180514120338.GA5265@infradead.org>
 <CAMuHMdW0nxOmq7gjJiySg0fho2XDYkyrCgp88OOuULRLH+jt6w@mail.gmail.com>
From: Martijn Coenen <maco@android.com>
Date: Mon, 14 May 2018 23:30:52 +0200
Message-ID: <CAB0TPYG4Jg54Hg+BWwHqjgZWepxOmcBek=aa3rc=G_h5i=5jNg@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binder: remove 32-bit binder interface.
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Amit Pundir <amit.pundir@linaro.org>,
 "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
 Martijn Coenen <maco@google.com>, John Stultz <john.stultz@linaro.org>,
 kbuild-all@01.org, Linux-Arch <linux-arch@vger.kernel.org>,
 Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 4:00 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Patch sent.

Thanks for the quick turn-around!

>
> BTW, sh also doesn't seem to have 64-bit get_user().
> There may be others.

I checked quickly, nios2 is the only other arch that explicitly
doesn't support it and would result in a build error; some other archs
don't define __get_user, but in that case they just fall back to
raw_copy_from_user().

>
> BTW2, does the Android Binder need to care about endianness when talking
> to userspace?

No, I don't think it should.

Thanks,
Martijn

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
