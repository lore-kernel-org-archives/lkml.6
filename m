Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F06ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0991F21470
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNTMENG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0991F21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJTANX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727289AbeJTANX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:13:23 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40CC02087A;
        Fri, 19 Oct 2018 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539965198;
        bh=j3uplFitsOvsTR4G3hhmUQEIP1JLMzK0uNBbPUSk4hQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WNTMENG/S5yDn2dTPeXKTZlSO4pDX8APQuXF81c4Rf4LejvbB2QGiZXKUfRUvb+aV
         mI81w2zcZXkS7WUH2oNpDKbxfCTHVYTeLwxqq+g52evn+4rlUjQSJYJJQKj/pG9m7L
         Ya7BcrKict5c2Rt1HAfkMvDiBOAg1H8Npu+ouCvk=
Received: by mail-qt1-f175.google.com with SMTP id u34-v6so38863306qth.3;
        Fri, 19 Oct 2018 09:06:38 -0700 (PDT)
X-Gm-Message-State: ABuFfogBPIdvzdW5yfgzjzmIU1dxUwXZe22Nmt/Pcys7Gm3eU25ne8K8
        HI6AHf2QgwQnRRqpPngwbBUkiIFe/CzajYaLfA==
X-Google-Smtp-Source: ACcGV60T1WDLhWWq2OVbCbVPvXHyX1bh16puBms7i6h1Eot/RQze98ZQa71aPYLdpy5UDQRxW7Rrk8zw7DwqxdNnu+k=
X-Received: by 2002:aed:3ec2:: with SMTP id o2-v6mr33937861qtf.26.1539965197390;
 Fri, 19 Oct 2018 09:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <1539736466-28638-1-git-send-email-frowand.list@gmail.com>
 <20181018193216.GA9971@bogus> <2f99d700-6276-cfa4-8878-4eb161126330@gmail.com>
In-Reply-To: <2f99d700-6276-cfa4-8878-4eb161126330@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 19 Oct 2018 11:06:25 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+=OiXTSSEr4QuiyqCzyrKdH0M8HhmOjVha3SWM5Y62Gw@mail.gmail.com>
Message-ID: <CAL_Jsq+=OiXTSSEr4QuiyqCzyrKdH0M8HhmOjVha3SWM5Y62Gw@mail.gmail.com>
Subject: Re: [PATCH v3] of: overlay: user space synchronization
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Tull <atull@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 7:06 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/18/18 12:32, Rob Herring wrote:
> > On Tue, Oct 16, 2018 at 05:34:26PM -0700, frowand.list@gmail.com wrote:
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> When an overlay is applied or removed, the live devicetree visible in
> >> /proc/device-tree/, aka /sys/firmware/devicetree/base/, reflects the
> >> changes.  There is no method for user space to determine whether the
> >> live devicetree was modified by overlay actions.
> >
> > Because userspace has no way to modify the DT and the ways the kernel
> > can do modifications is limited.
> >
> > Do you have an actually need for this outside of testing/development?
>
> I do not know if anyone uses /proc/device-tree for anything outside of
> testing/development.  If we believe that there is no other use of
> /proc/device-tree we can simply document that there is no expectation
> that accessors will see a consistent, unchanging /proc/device-tree.

I didn't mean whether /proc/device-tree is used outside of testing. It
is. The question is whether any users care if there are changes
happening. If so what is the use case?

kexec used to be one of the main users, but I think it has switched
over to the exported FDT which matches what the kernel was originally
passed.

>
> That would be a much smaller patch.
>
>
> >> Provide a sysfs file, /sys/firmware/devicetree/tree_version,  to allow
> >> user space to determine if the live devicetree has remained unchanged
> >> while a series of one or more accesses of /proc/device-tree/ occur.
> >>
> >> The use of both (1) dynamic devicetree modifications and (2) overlay
> >> apply and removal are not supported during the same boot cycle.  Thus
> >> non-overlay dynamic modifications are not reflected in the value of
> >> tree_version.
> >
> > I'd prefer to see some sort of information on overlays exported and user
> > space can check if that changed. IIRC, Pantelis had a series to do that
> > along with a kill switch to prevent further modifications. At least some
> > of that series only had minor issues to fix.
>
> The kill switch addresses a different concern, which was from the security
> community.  The kill switch is on my todo list.

Yes, but there could be other uses. It's not a big step from wanting
to know if the DT has changed to wanting to control it changing or
not.

Perhaps the kill switch needs 2 levels: a temporary freeze and a
permanent freeze. In any case, they don't seem completely unrelated
and I don't really want to see userspace ABI added bit by bit.

> I don't remember exactly what info the overlay information export patch
> provided.  I'll have to go find it and re-read it.
>
>
> > Also, shouldn't we get uevents if the tree changes? Maybe that's not
>
> Yes (off the top of my head).  But a shell script accessing /proc/device-tree
> is not going to get uevents.

No, but userspace can get them. Accessible from a shell script is not
a requirement of kernel interfaces.

Rob
