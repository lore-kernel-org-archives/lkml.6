Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EF8C282C2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0AF20838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 03:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pm6v9gld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfBKDV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 22:21:59 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35044 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfBKDV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 22:21:58 -0500
Received: by mail-it1-f193.google.com with SMTP id r6so22843348itk.0;
        Sun, 10 Feb 2019 19:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Av/cbEdgHXFxeqNqKtYWk0nOBn8QfGpGC0c5TeUYcIs=;
        b=pm6v9gldLb+dTHCpConV8woP2PviDvu0Drf2kAVIJmDvvtQQZXicM15AylV6Y8/J3p
         rqjj4qEEsaPacN/y9n5aTpPcGxWIwtKtf7ATKPkiOHbX4KoXR/DrA0IxdzBKG0d381MA
         DG4yolPa6T0qTaddlbZ0mDJzTA3xG8W1rSqJhJCmWpqc+vvKI3ChIDgVZ2xUZHTrVIwS
         CdxxBFisaKWukTJ046r1kTp+0BidOT0+r7yO+ZONUwYXnjyg/21GnbGfDhG+EqrQcl4I
         tQnDB6D///EICJ5f4h70R+AEe9VnH9C9Gif4jYZV318vPapU3Ru62Ug087+s6Cq99Dez
         JX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Av/cbEdgHXFxeqNqKtYWk0nOBn8QfGpGC0c5TeUYcIs=;
        b=oo//oer6HxeDY07efGCXP3IguLjuuxwmjoIzbCaKr73qiunOec6PpCcfEtEaX3Tpl9
         3FkC8icsHGb9e5ckLZ1YQMIvtxfZ5vr/O5obfAUgame24efMjhTqbZ4BPVO3b7yNexNo
         bRw6LArH0xxEu3Jp7tPH2Vxh9r/E09m7pCpVltzo6zcNNduW+Cwv7a5d1Se6qc6YEo0m
         iT8tKdc7oXPwNqIpQtLxnPiy9ftkHaiEBUcrWicTFE6katPlfbV4u9on7mwrSWuBo+Z2
         Utz18hVcSOmhsEXVH3w59hIJicfiwknpFfmQEz52gdmmNLU4dHF4T7v1zOSdl4S/5Jkj
         HIuA==
X-Gm-Message-State: AHQUAuaEvx0sFGSFbQYxQJauByeBULRVTB3KEAjwIfdOnU0hvOsJL9lR
        feD/0jIKrCdPZ8vqqT6XyF7GaEG2qQjoFkxERv0D4KsZ
X-Google-Smtp-Source: AHgI3IaHGToSmUfe9CK0TSZ9gfSe6WcYghsMj72g/ymk49x6prO3V1FTv1JMjm2eEPmB9c5yVBZa5mac4/55JiOGLwo=
X-Received: by 2002:a02:6a16:: with SMTP id l22mr17694809jac.139.1549855316972;
 Sun, 10 Feb 2019 19:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20190202153454.7121-1-deepa.kernel@gmail.com> <20190202153454.7121-10-deepa.kernel@gmail.com>
 <AM4PR0501MB2769C4BE6CF1C5B051068D0BC56B0@AM4PR0501MB2769.eurprd05.prod.outlook.com>
In-Reply-To: <AM4PR0501MB2769C4BE6CF1C5B051068D0BC56B0@AM4PR0501MB2769.eurprd05.prod.outlook.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sun, 10 Feb 2019 19:21:43 -0800
Message-ID: <CABeXuvqMR7T=3ORvXPihkz-WbTN+oFeHkCu9uvebEq9wTLpJuQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/12] socket: Add SO_TIMESTAMPING_NEW
To:     Ran Rozenstein <ranro@mellanox.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "chris@zankel.net" <chris@zankel.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "rth@twiddle.net" <rth@twiddle.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ubraun@linux.ibm.com" <ubraun@linux.ibm.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 10, 2019, at 7:43 AM, Ran Rozenstein <ranro@mellanox.com> wrote:

>> Subject: [PATCH net-next v5 09/12] socket: Add SO_TIMESTAMPING_NEW
>>
>> Add SO_TIMESTAMPING_NEW variant of socket timestamp options.
>> This is the y2038 safe versions of the SO_TIMESTAMPING_OLD for all
>> architectures.
>>
>> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>> Acked-by: Willem de Bruijn <willemb@google.com>
>
>
> Hi,
>
> I have app that include:
>    #include <linux/errqueue.h>
>
> It now fail with this error:
>    In file included from timestamping.c:6:0:
>    /usr/include/linux/errqueue.h:46:27: error: array type has incomplete element type 'struct __kernel_timespec'
>      struct __kernel_timespec ts[3];
>                                       ^~
> I tried to do the trivial fix, to include time.h:
> In include/uapi/linux/errqueue.h
>    #include <linux/time.h>
>    #include <linux/types.h>
>
> But it just add some other noises:
>                In file included from /usr/include/linux/errqueue.h:5:0,
>                                 from timestamping.c:6:
>                /usr/include/linux/time.h:10:8: error: redefinition of ?struct timespec?
>                 struct timespec {
>                        ^~~~~~~~
>                In file included from /usr/include/sys/select.h:39:0,
>                                 from /usr/include/sys/types.h:197,
>                                 from /usr/include/stdlib.h:279,
>                                 from timestamping.c:2:
>                /usr/include/bits/types/struct_timespec.h:8:8: note: originally defined here
>                 struct timespec
>                        ^~~~~~~~
>                In file included from /usr/include/linux/errqueue.h:5:0,
>                                 from timestamping.c:6:
>                /usr/include/linux/time.h:16:8: error: redefinition of ?struct timeval?
>                 struct timeval {
>                        ^~~~~~~
>                In file included from /usr/include/sys/select.h:37:0,
>                                 from /usr/include/sys/types.h:197,
>                                 from /usr/include/stdlib.h:279,
>                                 from timestamping.c:2:
>                /usr/include/bits/types/struct_timeval.h:8:8: note: originally defined here
>                 struct timeval
>                        ^~~~~~~
>
>
> Can you please advise how to solve it?
>
> Thanks,
> Ran

The errqueue.h already had the same issue reported previously:
https://lore.kernel.org/netdev/CAF=yD-L2ntuH54J_SwN9WcpBMgkV_v0e-Q2Pu2mrQ3+1RozGFQ@mail.gmail.com/

Earlier when I tested this with kernel selftests such as
tools/testing/selftests/networking/timestamping/rxtimestamp(the test
was broken to begin with because of  missing include of unistd.h), I
was using make.cross to build.
This does not put the headers in the right place
(obj-$ARCH/usr/include instead of usr/include). Hence, I did not
realize that this breaks the inclusion of errqueue.h due to the
missing __kernel_timespec definition.
I forgot that nobody seems to be using linux/time.h.

But, if I include guards( #ifndef __KERNEL__) for struct timespec,
struct timeval etc for linux/time.h, then we can include it from
userspace/ errqueue.h for __kernel_timespec:

--- a/include/uapi/linux/errqueue.h
+++ b/include/uapi/linux/errqueue.h
@@ -2,7 +2,7 @@
 #ifndef _UAPI_LINUX_ERRQUEUE_H
 #define _UAPI_LINUX_ERRQUEUE_H

-#include <linux/types.h>
+#include <linux/time.h>

 struct sock_extended_err {
        __u32   ee_errno;
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index a6aca9aaab80..40913d9a5bc8 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -5,6 +5,8 @@
 #include <linux/types.h>


+#ifdef __KERNEL__
+
 #ifndef _STRUCT_TIMESPEC
 #define _STRUCT_TIMESPEC
 struct timespec {
@@ -42,6 +44,8 @@ struct itimerval {
        struct timeval it_value;        /* current value */
 };

+#endif /* __KERNEL__ */

Arnd,

I forgot how we plan to include the definition for __kernel_timespec
for libc or userspace. Does this seem right to you?
Also these changes to errqueue.h needs to be reverted probably as this
breaks userspace.

Thanks,
-Deepa







-Deepa
