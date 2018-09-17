Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6466BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECE420671
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHQuCzHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECE420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeIQRWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:22:39 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33843 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbeIQRWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:22:39 -0400
Received: by mail-ua1-f67.google.com with SMTP id r15-v6so10313507uao.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 04:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C3bSki2yN/h8jeM9zWKULZALvkJObqmJwVTpdghaOXU=;
        b=ZHQuCzHhoBjDd3cv0yPKvh19YWIQD3TyIn4qKIgcyZfwmEaNB94+NSA84CNgWjQTw7
         YzoS0UeLaqBa10NFzXQaazf0z6WNHFBWjYx0hog0ybYCKDcU/K9OsbV4u4kDhIYZ+eLn
         Eg5a7NWgUmdeZu+Kf3scM/jp2ITqOEGaU+ZFwK5HZw8aBVdu5vfokF0EmoEaVTG9RSji
         ANI1HnGkJnqgJfQq/NZzXhDLTPH+gRuQnHzmL0LPl9HBu41fDb35lKRLTaNdZ2sEr3tY
         QEDwrZVpObhR0MWVTuqUPaxr7WVfHZ4zDK9B1l+yJIZWk72hWSdN86X2wYrfVXGbpQ3D
         xTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C3bSki2yN/h8jeM9zWKULZALvkJObqmJwVTpdghaOXU=;
        b=b9GT0Byo10eKsVSMXRLKW7Bcra/tMJp08YN103rhbZcMDA+8dIlGAOPI37NM6wZ9+M
         F+y8cayZ153SeKpgG9tWuliVo39kJ+HGgeth8RCLnUe5bryNMQWUWDI4PPlkEBISWq5P
         C8w5wAZDaMShIRqDCrRSBlW8FXLXJctQhO/tFkf42EKGwXkONOj/deGUDWcO+cz2A0tX
         XXrJDp7cMYksVrnsLEeJ0hCu6rQjd7aiy5EwlE4Zor/D838ZH/I2rkycoWtP+eUbIEaB
         Hqr8cYYvhNOrnf7ICvDQPQhd5Bf6wWdLWpf2VX12CRpUQz2JuIiFHpTjlDnfkHdbZqTb
         mokw==
X-Gm-Message-State: APzg51DiYp4P19JpnyWitY9tJsDxfszhXHplsykK7ydEYKR5H5a2cyGv
        A5Sfny5dAhhenfBpwwc6hcMCIykEVzMdhHDCtf0=
X-Google-Smtp-Source: ANB0VdbG7SYzkKvv3pLtcVolH7KhjFc2CfBT1l5M260esGz5ZFCi1odvM3uywMestqPFKARz7PLUmxlLN4fx5pTJN7w=
X-Received: by 2002:ab0:4fda:: with SMTP id t26-v6mr7295798uah.1.1537185338604;
 Mon, 17 Sep 2018 04:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLj1wx4sznrtLdKjcvuTf0dECPWzPaR946FoYRXB6YAGCw@mail.gmail.com>
 <20180916153237.GC15699@rapoport-lnx> <CAOuPNLj0HyC+yzwTpN-EWpzHTJ58u7pBfOja1MyweF4pbct1eQ@mail.gmail.com>
 <20180917043724.GA12866@rapoport-lnx> <CAOuPNLidXFHgkBmwOPj_xFkU_OpLaXbpJg04Le7MPxu8cYg_RQ@mail.gmail.com>
In-Reply-To: <CAOuPNLidXFHgkBmwOPj_xFkU_OpLaXbpJg04Le7MPxu8cYg_RQ@mail.gmail.com>
From:   Pintu Kumar <pintu.ping@gmail.com>
Date:   Mon, 17 Sep 2018 17:25:27 +0530
Message-ID: <CAOuPNLj+4pMnEy5EyZmzDWszqMb_PQb3q7t_hvG_50BTz1He2Q@mail.gmail.com>
Subject: Re: KSM not working in 4.9 Kernel
To:     rppt@linux.vnet.ibm.com
Cc:     open list <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 11:46 AM Pintu Kumar <pintu.ping@gmail.com> wrote:
> > > But still no effect.
> > > And I checked LTP test cases. It almost doing the same thing.
> > >
> > > I observed that [ksmd] thread is not waking up at all.
> > > I gave some print inside it, but I could never saw that prints coming.
> > > I could not find it running either in top command during the operation.
> > > Is there anything needs to be done, to wakw up ksmd?
> > > I already set: echo 1 > /sys/kernel/mm/ksm.
> >
> > It should be echo 1 > /sys/kernel/mm/ksm/run
> >
>
> Oh yes, sorry for the typo.
> I tried the same, but still ksm is not getting invoked.
> Could someone confirm if KSM was working in 4.9 kernel?
>

Ok, it's working now. I have to explicitly stop the ksm thread to see
the statistics.
Also there was some internal patch that was setting vm_flags to
VM_MERGABLE thus causing ksm_advise call to return.

# echo 1 > /sys/kernel/mm/ksm/run
# ./malloc-test.out &
# echo 0 > /sys/kernel/mm/ksm/run

~ # grep -H '' /sys/kernel/mm/ksm/*
/sys/kernel/mm/ksm/full_scans:105
/sys/kernel/mm/ksm/pages_shared:1
/sys/kernel/mm/ksm/pages_sharing:999
/sys/kernel/mm/ksm/pages_to_scan:100
/sys/kernel/mm/ksm/pages_unshared:0
/sys/kernel/mm/ksm/pages_volatile:0
/sys/kernel/mm/ksm/run:0
/sys/kernel/mm/ksm/sleep_millisecs:20


However, I have one doubt.
Is the above data correct, for the below program?

int main(int argc, char *argv[])
{
        int i, n, size, ret;
        char *buffer;
        void *addr;

        n = 10;
        size = 100 * getpagesize();
        for (i = 0; i < n; i++) {
                buffer = (char *)malloc(size);
                memset(buffer, 0xff, size);
                madvise(buffer, size, MADV_MERGEABLE);
                addr =  mmap(NULL, size,
                           PROT_READ | PROT_EXEC | PROT_WRITE,
MAP_PRIVATE | MAP_ANONYMOUS,
                           -1, 0);
                memset(addr, 0xff, size);
                ret = madvise(addr, size, MADV_MERGEABLE);
                if (ret < 0) {
                        fprintf(stderr, "madvise failed: ret: %d,
reason: %s\n", ret, strerror(errno));
                }
                usleep(500);
        }
        printf("Done....press ^C\n");

        pause();

        return 0;
}


Thanks,
Pintu
