Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93097C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D9D21B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549910542;
	bh=XwpXck09n+XrE6jTTsfLh7grF48V/Gnjf7rMH/trpC0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GI2VvfJ315V/9LhLn/9BKFusAw4OnIZXHgaXwxNuBDN52uCVWnZ5ziBGCwGzE25d6
	 g8zT0OBODVmKJP+O/VfssArrXwlfgnjBOt6XN/cYRiCuNscTGf0lcAICF/l3UjOCEp
	 x7A11BlHoRyc19quU7Mi6A6K1nEiRIHnwlPHFA04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbfBKSmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:42:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfBKSmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:42:19 -0500
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CE502229E;
        Mon, 11 Feb 2019 18:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549910538;
        bh=XwpXck09n+XrE6jTTsfLh7grF48V/Gnjf7rMH/trpC0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yiC+jGetYOpDYmX2SCSv2jC/shCrWyDEeu1ZE4XBsujmvX6CQUgcicpmYA6UcK23q
         RkuE69ys/PIG36jk69BpxGcWO+BnAAiRVLyWGlLi+/C1JSJezE8/Tdnf2sJZ04S8ml
         lp309E2y7Z3Ux1KPDrgaL1XW3uDUP34GseHPNBc0=
Received: by mail-ed1-f43.google.com with SMTP id b14so9791708edt.6;
        Mon, 11 Feb 2019 10:42:18 -0800 (PST)
X-Gm-Message-State: AHQUAubN8lUQbjZTwF+FD4GKCUIdxiXYe2Kd7npao4XgSguiqTKi+J5l
        gxToC7SNm2YV9/tT5Yf826R6qzWQqVpxYfP3Afk=
X-Google-Smtp-Source: AHgI3IYtyW5M8It5PqAuKXjrtvCQtmgxsU+H29n5/00dCRNqgjeSxbaoTdAXgKigAsV7EzjxISixZNNiWXvfCBfSQ3I=
X-Received: by 2002:a50:b964:: with SMTP id m91mr30204714ede.184.1549910536949;
 Mon, 11 Feb 2019 10:42:16 -0800 (PST)
MIME-Version: 1.0
References: <262419e9-5c9f-1193-f119-33f373d81e43@gmail.com> <b113e03d-95f9-96bc-2a50-bc61307e780e@gmail.com>
In-Reply-To: <b113e03d-95f9-96bc-2a50-bc61307e780e@gmail.com>
From:   Alan Tull <atull@kernel.org>
Date:   Mon, 11 Feb 2019 12:41:40 -0600
X-Gmail-Original-Message-ID: <CANk1AXS=4fT6LbOHqK4DYhSMcO9Q60mDcQsFFnwoJLHj8wRsTA@mail.gmail.com>
Message-ID: <CANk1AXS=4fT6LbOHqK4DYhSMcO9Q60mDcQsFFnwoJLHj8wRsTA@mail.gmail.com>
Subject: Re: [GIT PULL] of: overlay: validation checks, subsequent fixes for
 v20 -- correction: v4.20
To:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Moritz Fischer <mdf@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 12:58 AM Frank Rowand <frowand.list@gmail.com> wrote:

What LTSI's are these patches likely to end up in?  Just to be clear,
I'm not pushing for any specific answer, I just want to know what to
expect.

Thanks,
Alan

>
> On 11/8/18 10:56 PM, Frank Rowand wrote:
> > Hi Rob,
> >
> > Please pull the changes to add the overlay validation checks.
> >
> > This is the v7 version of the patch series.
> >
> > -Frank
> >
> >
> > The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> >
> >   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/frowand/linux.git tags/kfree_validate_v7-for-4.20
> >
> > for you to fetch changes up to eeb07c573ec307c53fe2f6ac6d8d11c261f64006:
> >
> >   of: unittest: initialize args before calling of_*parse_*() (2018-11-08 22:12:37 -0800)
> >
> > ----------------------------------------------------------------
> > Add checks to (1) overlay apply process and (2) memory freeing
> > triggered by overlay release.  The checks are intended to detect
> > possible memory leaks and invalid overlays.
> >
> > The checks revealed bugs in existing code.  Fixed the bugs.
> >
> > While fixing bugs, noted other issues, which are fixed in
> > separate patches.
> >
> > ----------------------------------------------------------------
> > Frank Rowand (17):
> >       of: overlay: add tests to validate kfrees from overlay removal
> >       of: overlay: add missing of_node_put() after add new node to changeset
> >       of: overlay: add missing of_node_get() in __of_attach_node_sysfs
> >       powerpc/pseries: add of_node_put() in dlpar_detach_node()
> >       of: overlay: use prop add changeset entry for property in new nodes
> >       of: overlay: do not duplicate properties from overlay for new nodes
> >       of: overlay: reorder fields in struct fragment
> >       of: overlay: validate overlay properties #address-cells and #size-cells
> >       of: overlay: make all pr_debug() and pr_err() messages unique
> >       of: overlay: test case of two fragments adding same node
> >       of: overlay: check prevents multiple fragments add or delete same node
> >       of: overlay: check prevents multiple fragments touching same property
> >       of: unittest: remove unused of_unittest_apply_overlay() argument
> >       of: overlay: set node fields from properties when add new overlay node
> >       of: unittest: allow base devicetree to have symbol metadata
> >       of: unittest: find overlays[] entry by name instead of index
> >       of: unittest: initialize args before calling of_*parse_*()
> >
> >  arch/powerpc/platforms/pseries/dlpar.c             |   2 +
> >  drivers/of/dynamic.c                               |  59 ++++-
> >  drivers/of/kobj.c                                  |   4 +-
> >  drivers/of/overlay.c                               | 292 ++++++++++++++++-----
> >  drivers/of/unittest-data/Makefile                  |   2 +
> >  .../of/unittest-data/overlay_bad_add_dup_node.dts  |  28 ++
> >  .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 ++
> >  drivers/of/unittest-data/overlay_base.dts          |   1 +
> >  drivers/of/unittest.c                              |  96 +++++--
> >  include/linux/of.h                                 |  21 +-
> >  10 files changed, 432 insertions(+), 97 deletions(-)
> >  create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
> >
>
