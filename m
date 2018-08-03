Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A95C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D66521779
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T3l7ZV1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D66521779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbeHCTaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:30:39 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:37059 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbeHCTaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:30:39 -0400
Received: by mail-it0-f45.google.com with SMTP id h20-v6so9450535itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 10:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i6Qm6rE9hqJzvzsuLLcWwi/AdFMgBkHEy1Cs+Ul15TY=;
        b=T3l7ZV1zLn1EpdyHn0VokSIB9RT9dNeGP8RWuCqyhe4VSRb6McWUPAFv//G5QY/93u
         E7U0NAKky+QGNNauqRFFs/IRqwUd3TEgiVHokzL4nih0MNe0cx6Y8pQ5J0NcwO4vr3DJ
         2aussLc9F1Eg8V/U4I1bix7tGsSkMk9rfnTjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i6Qm6rE9hqJzvzsuLLcWwi/AdFMgBkHEy1Cs+Ul15TY=;
        b=V/i2SBUKmCnN5CTaGx+elu1H3obONNQ5yB5+6JcvwUkB5AZPJpkjccq1V1V/p1/Sar
         i6KTQ0On+D6QjCeeG3LLHj7Jq39VSro2pqX0Nl4zuxxjpCDarA7LnC6khZrLNCLMuf6V
         PPnDMy+z0nsRMRt91yZ/4zdmVPwoJ79CZmGDbLZhz7AOGRYHbKVqaWp1ENOoaQbcxUWt
         CfRF1HnCAs2elFhGNUa/YsuLfuo0M2TTzS+PenTf2Xr85MDyxP6y/SGQpzDXRfsPsxNk
         7iHeZvK5GDCQXEXxyiySgsUgv7L72bUR6r9GoMYKvjnfJAPLrnNrL1rVIW2hAywt7raN
         FTaw==
X-Gm-Message-State: AOUpUlFx4Sj+w42q1M4kDVzKS8sEbFriOWgmx51akaYRJw1QG/pAAW7T
        4X9EGRgVfjCKKHVZbmBNxLwWDzqdS/A0W1UsARtZgx7N
X-Google-Smtp-Source: AAOMgpcw3m5wL8zyajRXxKXjb/jcJZW8pg7xD21XFg+Q+/jiJVPBIhFmsa4DYa1OSJWqfrDKeR38KX8NAM0ittE82mM=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr7299193itc.68.1533317603373;
 Fri, 03 Aug 2018 10:33:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 10:33:22 -0700 (PDT)
In-Reply-To: <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CAHCPf3tFGqkYEcWNN4LaWThw_rVqT316pzLv6T7RfxwO-eZ0EA@mail.gmail.com>
 <alpine.LRH.2.02.1808030212340.17672@file01.intranet.prod.int.rdu2.redhat.com>
 <CAKv+Gu8DeuksZhk1g3q_msSKV_hSY_2e1uzVten9-oGO3j9Sqg@mail.gmail.com>
 <20180803094129.GB17798@arm.com> <alpine.LRH.2.02.1808031235410.31584@file01.intranet.prod.int.rdu2.redhat.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 3 Aug 2018 19:33:22 +0200
Message-ID: <CAKv+Gu-aNFh1fsr_05SEwDp99n3pLrguP7=tEcFQPNY53=K7Fw@mail.gmail.com>
Subject: Re: framebuffer corruption due to overlapping stp instructions on arm64
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Matt Sealey <neko@bakuhatsu.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(- libc-alpha)

On 3 August 2018 at 19:09, Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
> On Fri, 3 Aug 2018, Will Deacon wrote:
>
>> On Fri, Aug 03, 2018 at 09:16:39AM +0200, Ard Biesheuvel wrote:
>> > On 3 August 2018 at 08:35, Mikulas Patocka <mpatocka@redhat.com> wrote:
>> > >
>> > >
>> > > On Thu, 2 Aug 2018, Matt Sealey wrote:
>> > >
>> > >> The easiest explanation for this would be that the memory isn?t mapped
>> > >> correctly. You can?t use PCIe memory spaces with anything other than
>> > >> Device-nGnRE or stricter mappings. That?s just differences between the
>> > >> AMBA and PCIe (posted/unposted) memory models.
>> >
>> > Whoa hold on there.
>> >
>> > Are you saying we cannot have PCIe BAR windows with memory semantics on ARM?
>> >
>> > Most accelerated graphics drivers rely heavily on the ability to map
>> > the VRAM normal-non-cacheable (ioremap_wc, basically), and treat it as
>> > ordinary memory.
>>
>> Yeah, I'd expect framebuffers to be mapped as normal NC. That should be
>> fine for prefetchable BARs, no?
>>
>> Will
>
> So - why does it corrupt data then? I've created this program that
> reproduces the data corruption quicky. If I run it on /dev/fb0, I get an
> instant failure. Sometimes a few bytes are not written, sometimes a few
> bytes are written with a value that should be 16 bytes apart.
>

Are we still talking about overlapping unaligned accesses here? Or do
you see other failures as well?

> I tried to run it on system RAM mapped with the NC attribute and I didn't
> get any corruption - that suggests the the bug may be in the PCIE
> subsystem.
>
> Jingoo Han and Joao Pinto are maintainers for the designware PCIE
> controllers. Could you suggest why does the controller corrupt data when
> writing to videoram? Are there any tricks that could be tried to work
> around the corruption?
>
> Mikulas
>
>
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/mman.h>
>
> #define LEN             256
> #define PRINT_STRIDE    0x20
>
> static unsigned char data[LEN];
> static unsigned char val = 0;
>
> static unsigned char prev_data[LEN];
>
> static unsigned char map_copy[LEN];
>
> int main(int argc, char *argv[])
> {
>         unsigned long n = 0;
>         int h;
>         unsigned char *map;
>         unsigned start, end, i;
>
>         if (argc < 2) fprintf(stderr, "argc\n"), exit(1);
>         if (argc >= 4) srandom(atoll(argv[3]));
>         h = open(argv[1], O_RDWR | O_DSYNC);
>         if (h == -1) perror("open"), exit(1);
>         map = mmap(NULL, LEN, PROT_READ | PROT_WRITE, MAP_SHARED, h, argc >= 3 ? strtoull(argv[2], NULL, 16) : 0);
>         if (map == MAP_FAILED) perror("mmap"), exit(1);
>
>         memset(data, 0, LEN);
>         memset(prev_data, 0, LEN);
>         memset(map, 0, LEN);
>
>         sleep(1);
>
>         while (1) {
>                 start = (unsigned)random() % (LEN + 1);
>                 end = (unsigned)random() % (LEN + 1);
>                 if (start > end)
>                         continue;
>                 for (i = start; i < end; i++)
>                         data[i] = val++;
>                 memcpy(map + start, data + start, end - start);
>                 if (memcmp(map, data, LEN)) {
>                         unsigned j;
>                         memcpy(map_copy, map, LEN);
>                         fprintf(stderr, "mismatch after %lu loops!\n", n);
>                         fprintf(stderr, "last copied range: 0x%x - 0x%x (0x%x)\n", start, end, (unsigned)(end - start));
>                         for (j = 0; j < LEN; j += PRINT_STRIDE) {
>                                 fprintf(stderr, "p[%03x]", j);
>                                 for (i = j; i < j + PRINT_STRIDE && i < LEN; i++)
>                                         fprintf(stderr, " %s%s%02x\e[0m", !(i % 4) ? " " : "", data[i] != map_copy[i] ? "\e[31m" : "", prev_data[i]);
>                                 fprintf(stderr, "\n");
>                                 fprintf(stderr, "d[%03x]", j);
>                                 for (i = j; i < j + PRINT_STRIDE && i < LEN; i++)
>                                         fprintf(stderr, " %s%s%02x\e[0m", !(i % 4) ? " " : "", data[i] != map_copy[i] ? "\e[31m" : "", data[i]);
>                                 fprintf(stderr, "\n");
>                                 fprintf(stderr, "m[%03x]", j);
>                                 for (i = j; i < j + PRINT_STRIDE && i < LEN; i++)
>                                         fprintf(stderr, " %s%s%02x\e[0m", !(i % 4) ? " " : "", data[i] != map_copy[i] ? "\e[31m" : "", map_copy[i]);
>                                 fprintf(stderr, "\n\n");
>                         }
>                         exit(1);
>                 }
>                 memcpy(prev_data, data, LEN);
>                 n++;
>         }
> }
