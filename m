Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeBEGH5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 01:07:57 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33321 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750861AbeBEGH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 01:07:28 -0500
X-Google-Smtp-Source: AH8x224EFpIs/ZSFy4leJp7PlUf6RgMhKDqwvCaWNoKUvcz/DCIKUCxq5CtaEG4KfhCMUNMV3wUgRQ==
Date: Mon, 5 Feb 2018 00:07:26 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Rowand <frowand.list@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] of: change overlay apply input data from EDT to FDT
Message-ID: <20180205060726.s5kvcvzlxat42wa2@rob-hp-laptop>
References: <1517194414-19932-1-git-send-email-frowand.list@gmail.com>
 <1517194414-19932-2-git-send-email-frowand.list@gmail.com>
 <CABGGisyx_aXCxKO5x-5M5mEM7s=jMYZDaQZ9jdL6hapMCOyM=Q@mail.gmail.com>
 <d2ad9f6f-bf66-10bc-6156-cb006ab9447d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2ad9f6f-bf66-10bc-6156-cb006ab9447d@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 04:01:38PM -0800, Frank Rowand wrote:
> On 01/29/18 06:42, Rob Herring wrote:
> > On Sun, Jan 28, 2018 at 8:53 PM,  <frowand.list@gmail.com> wrote:
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> Move duplicating and unflattening of an overlay flattened devicetree
> >> (FDT) into the overlay application code.  To accomplish this,
> >> of_overlay_apply() is replaced by of_overlay_fdt_apply().
> >>
> >> The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
> >> code, which is thus responsible for freeing the duplicate FDT.  The
> >> caller of of_overlay_fdt_apply() remains responsible for freeing the
> >> original FDT.
> >>
> >> The unflattened device tree (aka expanded device tree, EDT) now
> > 
> > Not really a fan of a new acronym.
> > 
> >> belongs to devicetree code, which is thus responsible for freeing
> >> the EDT.
> >>
> >> These ownership changes prevent early freeing of the duplicated FDT
> >> or the EDT, which could result in use after free errors.
> >>
> >> of_overlay_fdt_apply() is a private function for the anticipated
> >> overlay loader.
> >>
> >> Update unittest.c to use of_overlay_fdt_apply() instead of
> >> of_overlay_apply().
> >>
> >> Move overlay fragments from artificial locations in
> >> drivers/of/unittest-data/tests-overlay.dtsi into one devicetree
> >> source file per overlay.  This led to changes in
> >> drivers/of/unitest-data/Makefile and drivers/of/unitest.c.
> 
> I should have reversed the cause and effect in that sentence to
> instead be:
> 
>   The changes to drivers/of/unittest.c require the test overlays
>   to be in FDT form instead of unflattened devicetree form.  Move
>   overlay fragments from artificial locations in
>   drivers/of/unittest-data/tests-overlay.dtsi into one
>   devicetree source file per overlay and thus create
>   one FDT per overlay.
> 
> 
> > Why the rearranging? That should be a separate patch.
> Bisectability.
> 
> I can make the changes to the devicetree files in a second patch.
> After the first patch, there will be 29 self test fails.
> 
> I will make the change unless you respond back to this saying not to.

One patch is fine for me. Unit test is special.

Rob
