Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD846C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 17:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7826D2083E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 17:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rI65yFxz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7826D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933406AbeGJRQf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 13:16:35 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:37192 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933299AbeGJRQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 13:16:32 -0400
Received: by mail-ua0-f196.google.com with SMTP id u8-v6so14456468uao.4;
        Tue, 10 Jul 2018 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GdzrCn4Nfl9/sGcQI1y6gmlaoYxyIgncQ479LOqnaXY=;
        b=rI65yFxz1eJ3RRBnqGM/f3TEB/x9PmsuPbafT6nr/i3KAKwn236zczfVm9G5k2MHU3
         /1YiPis2GKuNiqzBq59Zjqu/uxFSFePFs6Sfux+XpvW8Uk0hZxI9cZorNjizjnQIIo9V
         qBAwaOyeu3iIKYj4u1AkDnbHGJbpOKUcyHluJBhjVYv1T9HSqPsmsEltT6+5xpOmqfQi
         FqO4XVbZ9gvF6XNMuq4lGoWNE+LJzIf2HI95yuFghMwA3sRNOp8X95EZKJDSJBGTeHN5
         6CZHxnA5VkrMvdAl9TxgYrb3mD6EGtfLsoHwXYfMq8831Jpfq/upXZmaAkLqMxGwusWh
         VLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GdzrCn4Nfl9/sGcQI1y6gmlaoYxyIgncQ479LOqnaXY=;
        b=bhkHtJOCIEwmY6120SCBGrN/V+SDMekoDMEO+SN/ERJE/ItHm1sUItXjTvcg7KzgaG
         jUx51O/syqP4HIPtR+xas+3bmELORNwatCMpfV4rVrbyQTuSoXAvHf2ltRa3ui9ixAas
         J6lfmC2+RehQ7qq71PKxsmChuGGPG/BaDuh9lbKJxitmcB8FrkYlSQ33XZzgiB0dctXr
         pLyrP8Ii63AjtQRqkmbpPUXyGlWruKsfegFqfssgI3ULKaOxZhk1aQbRGbq3JbGTPDrQ
         HidBEMZjUqHNsjLL1+/6y2OXEEJceOQa8aCmw1aor9TI0Izti3W1bUrH9BNdRbh8y5dY
         MruA==
X-Gm-Message-State: APt69E26TGCFoe4382l4hV42hgzsAznzlPp+bGb8LnSocCkDjhwCWiBy
        SZ2wdeM5OKEpbPQDMs3NRohGR1NvF2jCgSXYqKU=
X-Google-Smtp-Source: AAOMgpfqhoN1HCud/zGJh/v688kCS+yrosBz0bjJh51Zsk4eQU1D39nSrPl7mNR2bhfTDiuewYaO36U+k2xzXWYdbdQ=
X-Received: by 2002:a9f:3047:: with SMTP id i7-v6mr17282869uab.189.1531242991708;
 Tue, 10 Jul 2018 10:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <1530503634-32241-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1530503634-32241-2-git-send-email-lizhijian@cn.fujitsu.com>
 <1530503634-32241-3-git-send-email-lizhijian@cn.fujitsu.com> <1f24bf06-88cb-8d09-febf-02ff55ec263a@kernel.org>
In-Reply-To: <1f24bf06-88cb-8d09-febf-02ff55ec263a@kernel.org>
From:   Pintu Kumar <pintu.ping@gmail.com>
Date:   Tue, 10 Jul 2018 22:46:20 +0530
Message-ID: <CAOuPNLjrVtdALr6-3NcciSUW6-rTEv_6Ts2f0qzZ-niKzq0Mdg@mail.gmail.com>
Subject: Re: [PATCH 2/3] selftests/android: initialize heap_type to avoid
 compiling warning
To:     Shuah Khan <shuah@kernel.org>
Cc:     lizhijian@cn.fujitsu.com, linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 8:20 PM Shuah Khan <shuah@kernel.org> wrote:
>
> Hi Li Zhijian,
>
> On 07/01/2018 09:53 PM, Li Zhijian wrote:
> > root@vm-lkp-nex04-8G-7 ~/linux-v4.18-rc2/tools/testing/selftests/android# make
> > make[1]: warning: jobserver unavailable: using -j1.  Add '+' to parent make rule.
> > make[1]: Entering directory '/root/linux-v4.18-rc2/tools/testing/selftests/android/ion'
> > gcc  -I. -I../../../../../drivers/staging/android/uapi/ -I../../../../../usr/include/ -Wall -O2 -g    ionapp_export.c ipcsocket.c ionutils.c   -o ionapp_export
> > ionapp_export.c: In function 'main':
> > ionapp_export.c:91:2: warning: 'heap_type' may be used uninitialized in
> > this function [-Wmaybe-uninitialized]
> >   printf("heap_type: %ld, heap_size: %ld\n", heap_type, heap_size);
> >   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > CC: Shuah Khan <shuah@kernel.org>
> > CC: Pintu Agarwal <pintu.ping@gmail.com>
> > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > ---
> >  tools/testing/selftests/android/ion/ionapp_export.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/tools/testing/selftests/android/ion/ionapp_export.c b/tools/testing/selftests/android/ion/ionapp_export.c
> > index a944e72..e3435c2 100644
> > --- a/tools/testing/selftests/android/ion/ionapp_export.c
> > +++ b/tools/testing/selftests/android/ion/ionapp_export.c
> > @@ -49,6 +49,7 @@ int main(int argc, char *argv[])
> >               return -1;
> >       }
> >
> > +     heap_type = -1UL;
>
> Initialize it to one of the valid types. ION_HEAP_TYPE_SYSTEM
> is one choice.
>
Yes, the test requires at least one of the heap type.
If you want, you can set it to the default value (0) at the
initialization time and not -1.

>
> >       heap_size = 0;
> >       flags = 0;
> >
May be we can set the heap_type as 0 here, to avoid those
uninitialized warnings.

> > @@ -82,6 +83,12 @@ int main(int argc, char *argv[])
> >               }
> >       }
> >
> > +     if (heap_type == -1UL) {
> > +             printf("heap_type is invalid\n");
> > +             print_usage(argc, argv);
> > +             exit(1);
> > +     }
>
> This check isn't necessary. The test requires two arguments,
> -i <heap id> and -s <size in bytes> and won't run without either
> one of them. heap_type is going to be ION_HEAP_TYPE_SYSTEM or
> ION_HEAP_TYPE_SYSTEM_CONTIG at this point.
>
> Interesting. Looks like this test doesn't cover all ion_heap_types.
>
Yes, all heap_types were not supported. As per Laura's request I removed it.
Other heap_types actually requires explicit declaration of reserved
memory or CMA region.

If you require other heap_type support then may be you can look into
my github version:
https://github.com/pintuk/LINUX/tree/master/android/ion


> thanks,
> -- Shuah
