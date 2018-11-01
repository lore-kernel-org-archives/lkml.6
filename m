Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15B6C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B690020830
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B690020830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeKBCxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:53:20 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40303 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKBCxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:53:20 -0400
Received: from excalibur.cnev.de ([213.196.202.171]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlfGs-1frQnW186M-00ilkM; Thu, 01 Nov 2018 18:49:00 +0100
Received: from excalibur.cnev.de ([213.196.202.171]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlfGs-1frQnW186M-00ilkM; Thu, 01 Nov 2018 18:49:00 +0100
Received: from karsten by excalibur.cnev.de with local (Exim 4.89)
        (envelope-from <merker@debian.org>)
        id 1gIH5W-00060g-0g; Thu, 01 Nov 2018 18:48:58 +0100
Date:   Thu, 1 Nov 2018 18:48:57 +0100
From:   Karsten Merker <merker@debian.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     anup@brainfault.org, zong@andestech.com, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, alankao@andestech.com,
        greentime@andestech.com, linux-kernel@vger.kernel.org,
        vincentc@andestech.com, linux-riscv@lists.infradead.org,
        deanbo422@gmail.com
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
Message-ID: <20181101174857.du2zu4vnrhpu5asf@excalibur.cnev.de>
References: <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
 <mhng-01f0ac6a-c2fd-41be-9d53-44d1c139d453@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mhng-01f0ac6a-c2fd-41be-9d53-44d1c139d453@palmer-si-x1c4>
X-No-Archive: yes
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:tUOLTyi1OuMqiWoSJtJD7MQCytwhy4PpEEBTgMGAU8nEmOdagoI
 +9nAgF8L5sni3jCk2QRBnggBT5EeNdj7Vaa8SrJ4Ejts7F7/TDqsTq4ZUtlC8UsNftR4pdJ
 GTWs/vyevt5qWaQbrO/hFF79vFpAIPG67G5rw/wTB4cU1atgring34lZ3v3hAd9Kn2pyUg7
 sqs1dikjyg3tZ6ytIJw/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RbnT+6yzs0g=:hptnew0/RBH6Akk4UbXkar
 aAwjwjWkSMtYD4bN9YMm+K7yoZWu24PC2saniJZoASW5BXrw1qkxDET1MgAWUoXOxZmaMn/dQ
 LOaL2cYNOooX74o66JRfG1v5MRslu4RYzzwYjm2DDjMj3Ct/g2Mk1M0sQtE4MDi+IO8cs6G8b
 2x0KFQO4Ii73iFUdEQf7AiprCll6BNRpz2fkj7ydOhzGzqBAoSqEBtYCWxqsoe51n/es98F2B
 KeOeQPjvvDWI1gmfRXawg5HlLdA8Teg6//hY8IhMEkkhWskneeGaUymjJOVcAEqKacGYcemzf
 IQGGZMNosVVZPojasdpAXmWwFCs0lVvTgBNzdw9+p+oZ4wCR1ne/CuG/m8k3jbpbOwAKGennM
 2h1uhQ2m0tFnhiP0wBe1Wha8LVyA24oyHENTgtONXQbU2e5DDe5fvx36V61AO4weG7TeHruKg
 xvftFZP2k4eJeqhnxg4DYalDfYfxGxZ8PH+8mcuGmPByKPNMhWGiN97ej5dHFq8YkQhvmJznt
 /pkfOFiD4Hb4btPIm+IYSZ7UeBs+72jYp+6RYx1+e8YRbi3ubZ+6z8gxSYy0fac2OnDp7wr11
 b5JTnzoI7UGaZV7FK16x5YAj2oKcEfrkxf+u0IvJaqo5cRSaPjJ66vYGTnzuT5/oMjX326RQ0
 bmSu0ooCG2KcBHABSbnHs98dhkAcNtqIEfCbmXj0aV8s4W40tQrfRd49yu68ai37PZrw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 10:27:05AM -0700, Palmer Dabbelt wrote:
> On Wed, 31 Oct 2018 04:16:10 PDT (-0700), anup@brainfault.org wrote:
> > On Wed, Oct 31, 2018 at 4:06 PM Vincent Chen <vincentc@andestech.com> wrote:
> > > 
> > >   RISC-V permits each vendor to develop respective extension ISA based
> > > on RISC-V standard ISA. This means that these vendor-specific features
> > > may be compatible to their compiler and CPU. Therefore, each vendor may
> > > be considered a sub-architecture of RISC-V. Currently, vendors do not
> > > have the appropriate examples to add these specific features to the
> > > kernel. In this RFC set, we propose an infrastructure that vendor can
> > > easily hook their specific features into kernel. The first commit is
> > > the main body of this infrastructure. In the second commit, we provide
> > > a solution that allows dma_map_ops() to work without cache coherent
> > > agent support. Cache coherent agent is unsupported for low-end CPUs in
> > > the AndeStar RISC-V series. In order for Linux to run on these CPUs, we
> > > need this solution to overcome the limitation of cache coherent agent
> > > support. Hence, it also can be used as an example for the first commit.
> > > 
> > >   I am glad to discuss any ideas, so if you have any idea, please give
> > > me some feedback.
> > > 
> > I agree that we need a place for vendor-specific ISA extensions and
> > having vendor-specific directories is also good.
> > 
> > What I don't support is the approach of having compile time selection
> > of vendor-specific ISA extension.
> > 
> > We should have runtime probing for compatible vendor-specific ISA
> > extension. Also, it should be possible to link multiple vendor-specific
> > SA extensions to same kernel image. This way we can have a single
> > kernel image (along with various vendor-specific ISA extensions) which
> > works on variety of targets/hosts.
> > 
> > As an example or runtime probing you can look at how IRQCHIP or
> > CLOCKSOURCE drivers are probed. The vendor-specific ISA extension
> > hooks should called in similar fashion.
> 
> Yes, I agree.  My biggest concern here is that we ensure that
> one kernel can boot on implementations from all vendors.  I
> haven't had a chance to look at the patches yet, but it should
> be possible to:
> 
> * Build a kernel that has vendor-specific code from multiple vendors.
> * Detect the implementation an run time and select the correct extra
>   code.

From a distro point of view we definitely want to have one kernel
image that is bootable everywhere.  Debian won't support any
platform that requires a per-platform or per-vendor kernel, and I
assume that the same will be true for Fedora and Suse.

One thing that I have stumbled upon while looking at the patches
is that they seem to assume that X-type ISA extensions are
strictly per vendor.  Although that is probably true in the
majority of cases, it doesn't necessarily have to be - I could
e.g. imagine that the DSP extensions from the PULP cores might
be used by multiple vendors.  If such an extension would have
state that needs to be saved on context switch, it would need
corresponding kernel support.  Using "PULP" (or any other
open-source project) as the vendor in such a case leads to
another potential issue: the patches base everything on a JEDEC
vendor ID that is compared to the contents of the mvendorid CSR,
but such a JEDEC vendor ID usually doesn't exist for open-source
implementations; the majority of those have mvendorid set to
zero.

Regards,
Karsten
-- 
Gem. Par. 28 Abs. 4 Bundesdatenschutzgesetz widerspreche ich der Nutzung
sowie der Weitergabe meiner personenbezogenen Daten für Zwecke der
Werbung sowie der Markt- oder Meinungsforschung.
