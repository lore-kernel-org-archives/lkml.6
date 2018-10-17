Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB42ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6028821480
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrXjuZHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6028821480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbeJRFO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725745AbeJRFO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:14:59 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F37921473;
        Wed, 17 Oct 2018 21:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539811045;
        bh=g2il2KgyF0vLxwMylQFDgfxo+XL4J5qudxh9j/KR35g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WrXjuZHZ824L7He7U1uvSiBNpx9QBSCtBr9wVYZ1T5aapuFl4NzhNVVE+U/zD8siF
         upTWTXPMCfcC25luy1HX+O28/Hked8dd52902RKqjn3PPCd0mrcYC49E6oYUHNq609
         zcVvrsG754iSk+Pm6yQdJc7zROvG/7a1h52Rf+IU=
Received: by mail-ed1-f43.google.com with SMTP id y19-v6so26259090edd.2;
        Wed, 17 Oct 2018 14:17:25 -0700 (PDT)
X-Gm-Message-State: ABuFfog0QE0wicVAXB4LNILJaEVRMEfJ7S2NbQMlvLW9Plg0J6bDdMMr
        sb+WmeElHt41h1LxZFUaixrdkb7kU2Nnc5FIQMU=
X-Google-Smtp-Source: ACcGV616i1NX6BUJvbOs8GjNFRy5Boj0HC7hOVmHumIBdrfNuHf+DMwGpsYLlnNvNAfTlu0bTE8YlDYvFoCrfL4H8Bo=
X-Received: by 2002:a50:cd57:: with SMTP id d23-v6mr1716930edj.60.1539811043733;
 Wed, 17 Oct 2018 14:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
 <87murekyts.fsf@concordia.ellerman.id.au> <bbbbe52c-8415-e22a-48d7-95f919942c68@gmail.com>
In-Reply-To: <bbbbe52c-8415-e22a-48d7-95f919942c68@gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 17 Oct 2018 16:16:47 -0500
X-Gmail-Original-Message-ID: <CANk1AXSa1bMHxp7-PiTtfniDukDO51M=4P5u98Xc=rRo06zP7Q@mail.gmail.com>
Message-ID: <CANk1AXSa1bMHxp7-PiTtfniDukDO51M=4P5u98Xc=rRo06zP7Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/18] of: overlay: validation checks, subsequent fixes
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Moritz Fischer <mdf@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:08 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/16/18 02:47, Michael Ellerman wrote:
> > frowand.list@gmail.com writes:
> >
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> Add checks to (1) overlay apply process and (2) memory freeing
> >> triggered by overlay release.  The checks are intended to detect
> >> possible memory leaks and invalid overlays.
> >>
> >> The checks revealed bugs in existing code.  Fixed the bugs.
> >>
> >> While fixing bugs, noted other issues, which are fixed in
> >> separate patches.
> >>
> >> *****  Powerpc folks: I was not able to test the patches that
> >> *****  directly impact Powerpc systems that use dynamic
> >> *****  devicetree.  Please review that code carefully and
> >> *****  test.  The specific patches are: 03/16, 04/16, 07/16
> >
> > Hi Frank,
> >
> > Do you have this series in a git tree somewhere?
> >
> > I tried applying it on top of linux-next but hit some conflicts which I
> > couldn't easily resolve.
> >
> > cheers
> >
>
>
>
> git://git.kernel.org/pub/scm/linux/kernel/git/frowand/linux.git
>
> $ git checkout v4.19-rc1--kfree_validate--v4
>
> $ git log --oneline v4.19-rc1..
> 2ba1b7d353dd of: unittest: initialize args before calling of_*parse_*()
> 4f9108209f79 of: unittest: find overlays[] entry by name instead of index
> 353403c76ff8 of: unittest: allow base devicetree to have symbol metadata
> 8fc37e04a01b of: overlay: set node fields from properties when add new overlay n
> 05d5df0e5151 of: unittest: remove unused of_unittest_apply_overlay() argument
> 8c021cba757a of: overlay: check prevents multiple fragments touching same proper
> 797a6f66e039 of: overlay: check prevents multiple fragments add or delete same n
> c385e25a040d of: overlay: test case of two fragments adding same node
> c88fd240f0e0 of: overlay: make all pr_debug() and pr_err() messages unique
> 1028a215d32a of: overlay: validate overlay properties #address-cells and #size-c
> f1a97ef74ce4 of: overlay: reorder fields in struct fragment
> ffe78cf7a1fb of: dynamic: change type of of_{at,de}tach_node() to void
> 5f5ff8ec0c0c of: overlay: do not duplicate properties from overlay for new nodes
> 06e72dcb2bb0 of: overlay: use prop add changeset entry for property in new nodes
> a02f8d326a08 powerpc/pseries: add of_node_put() in dlpar_detach_node()
> e203be664330 of: overlay: add missing of_node_get() in __of_attach_node_sysfs
> 8eb46208e7c8 of: overlay: add missing of_node_put() after add new node to change
> b22067db7cf9 of: overlay: add tests to validate kfrees from overlay removal

That branch is a real time saver, thanks!

ALan
