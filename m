Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F89C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24C120857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eaRX2V7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24C120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbeG0J1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:27:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51299 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0J1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:27:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180727080647euoutp0298eef2926f042a344aaa6b8ae3ef4334~FK0EsAub-2355223552euoutp02F;
        Fri, 27 Jul 2018 08:06:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180727080647euoutp0298eef2926f042a344aaa6b8ae3ef4334~FK0EsAub-2355223552euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532678807;
        bh=8f6HHFYRk4K3cIuA0/vCC1zuOxtQp+m2aDhJy+OjvIY=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=eaRX2V7KpiBlKCpsUrWMBhxA4THYpuyHqEpf2lPLrQI6SBA6o3n9zFxeFItE9jciu
         CXxYgnaNycDsTJHjb276ewIftMIx8Phq7v0NPoObAr4QtB9w0ndaNcpPieEz82qnr8
         HUNy/icvQ3PUJhvYRkCNO3szT9Ufd+SB9UQedKAo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180727080646eucas1p25a3160b5d2e2dd25bf7bdf231619af83~FK0ESczLf3108531085eucas1p2F;
        Fri, 27 Jul 2018 08:06:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0C.7E.61560.692DA5B5; Fri, 27
        Jul 2018 09:06:46 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180727080645eucas1p19ca982312aa46dd2049bf532fb24054c~FK0Dksczh0285602856eucas1p1Z;
        Fri, 27 Jul 2018 08:06:45 +0000 (GMT)
X-AuditID: cbfec7f5-634db9c00002f078-3e-5b5ad2963713
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E8.A5.04178.592DA5B5; Fri, 27
        Jul 2018 09:06:45 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCI00A23MJ9U210@eusync1.samsung.com>; Fri, 27 Jul
        2018 09:06:45 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] video: fbdev: broadsheetfb: Possible null function
 pointers
Date:   Fri, 27 Jul 2018 10:06:45 +0200
Message-id: <5031064.Ea5icxSZ3H@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <c95d4381-1278-e561-29d8-ae84be2c680e@gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsWy7djP87rTLkVFG3y9LWqxbuJCJosrX9+z
        WZzo+8BqcXnXHDYHFo+ds+6ye9zvPs7k8XmTXABzFJdNSmpOZllqkb5dAlfG53+vmQrm8las
        Wd/D1sDYy9XFyMkhIWAi0fGslb2LkYtDSGAFo8Sr1W3MEM5nRonfa16zwlR93DifDcQWEljG
        KLHsnhRE0W9GiWsXjoMl2ASsJCa2r2IEsUUE1CVOL9sF1swskCBxetE9FhBbWCBA4u/OJqB6
        Dg4WAVWJiyuKQUxeAU2JXc0aIBWiAl4SW/a1M4HYnAK2Ehuf3WAHsXkFBCV+TIaYwiwgL7Fv
        /1So6ToSZ4+tYwQ5R0JgBptE+5dXUDe7SLyetJMJwhaWeHV8CzuELSPR2XGQCaJhOqPEm19L
        WSCc9YwSa84cg+qwljh8/CLUCj6JSdumM4NcKiHAK9HRJgRR4iHR2rsfGlobgEE3tZdtAqPM
        LCTXzkJy7Swk1y5gZF7FKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRGN2n/x3/uoNx35+k
        Q4wCHIxKPLwBryOjhVgTy4orcw8xSnAwK4nwrrkOFOJNSaysSi3Kjy8qzUktPsQozcGiJM4r
        7RMRLSSQnliSmp2aWpBaBJNl4uCUamBUdD8aXLzwz57UP6ulf3/+rqlluuwHi5FngfT0kLuf
        He5N2Gq/WvlDY3/QxJWtl2KdNPhfmWX/9VJ1uzevRWPa+iT56R9qAw5mM9ULz6y68yhj+fTT
        DYVzHioulfkn1KDP0riq5ob2zFwRpwfB3ZaPDR/W2N5YdXv/2/OHdfjeZu1d+LDgU8BSJZbi
        jERDLeai4kQASL1TF+oCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsVy+t/xy7pTL0VFG7RcM7RYN3Ehk8WVr+/Z
        LE70fWC1uLxrDpsDi8fOWXfZPe53H2fy+LxJLoA5issmJTUnsyy1SN8ugSvj87/XTAVzeSvW
        rO9ha2Ds5epi5OSQEDCR+LhxPlsXIxeHkMASRomJP4+ygSSEBP4ySmy+Jg5iswlYSUxsX8UI
        YosIqEucXraLtYuRg4NZIEHi2bwUEFNYwE/i8rs8EJNFQFXi4opiEJNXQFNiV7MGSJ+ogJfE
        ln3tTCA2p4CtxMZnN9ghlm5glPi/YylYgldAUOLH5HssIDazgLzEvv1TWSFsLYn1O48zTWDk
        n4WkbBaSsllIyhYwMq9iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIDMltx35u3sF4aWPwIUYB
        DkYlHt6A15HRQqyJZcWVuYcYJTiYlUR411wHCvGmJFZWpRblxxeV5qQWH2KU5mBREuc9b1AZ
        JSSQnliSmp2aWpBaBJNl4uCUamBMs+FRlf6yRuyDxrOD8cIzUiY9S35jsMVzzoGC7L8RT3iS
        pmw7+e70Y5FDsdlM3obnO5q4t5yt6kg/se3OhDX/O+baWL9m28G/LvPsPUb2KK3g9h3PoyKu
        7n0a/GXt8ocpMov9dh/h9YsONXV/fcOpR7T/lWjNy965bSrarVk6ir/m/JoaGuSgxFKckWio
        xVxUnAgAI1C0F0UCAAA=
X-CMS-MailID: 20180727080645eucas1p19ca982312aa46dd2049bf532fb24054c
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180726141748epcas1p28f6f11fea0152ed22113351e3a0affbc
References: <CGME20180726141748epcas1p28f6f11fea0152ed22113351e3a0affbc@epcas1p2.samsung.com>
        <2568790.PcaMMF1rzM@amdc3058>
        <c95d4381-1278-e561-29d8-ae84be2c680e@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 27, 2018 09:49:41 AM Jia-Ju Bai wrote:
> 
> On 2018/7/26 22:34, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday, July 26, 2018 10:17:44 PM bai wrote:
> >> In Linux-4.16, drivers/video/fbdev/broadsheetfb.c,
> >>
> >> 158. static void broadsheet_mmio_send_cmdargs(...) {
> >>               ......
> >> 163.     par->board->mmio_write(...);
> >>               ......
> >> 166.     par->board->mmio_write(...);
> >> 167. }
> >>
> >> For x86 kernel configuration, I find that there is no assignment of the
> >> function pointer ".mmio_write" in the kernel code.
> >> So calling the function pointer in lines 163 and 166 may cause a null
> >> pointer dereference.
> >>
> >> In this file, there are many calls to this function pointer...
> > This is a platform driver and it won't be used on x86 (actually it is
> > used only by single ARM PXA board). The dependency for FB_BROADSHEET
> > in Kconfig file could be improved to i.e.
> >
> > 	depends on FB && (ARCH_PXA || COMPILE_TEST)
> >
> > but there is no bug there.
> 
> Thanks for the reply :)
> So I want to submit a patch of updating Kconfig in 
> drivers/video/fbdev/Kconfig:
> 
> config FB_BROADSHEET
>      tristate "E-Ink Broadsheet/Epson S1D13521 controller support"
> -    depends on FB
> +   depends on FB && (ARCH_PXA || COMPILE_TEST)
>      select FB_SYS_FILLRECT
>      select FB_SYS_COPYAREA
>      select FB_SYS_IMAGEBLIT
>      select FB_SYS_FOPS
>      select FB_DEFERRED_IO
> 
> 
> Do you think it is okay?

Please read Documentation/process/submitting-patches.rst.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

