Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8996AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A35820652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1vkjqwWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbfAQRBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:01:39 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46996 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbfAQRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:01:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so11705404otm.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=74xntSFv45P5uxE02fT3KOtvmrgwIhR0LyAitbgHaOQ=;
        b=1vkjqwWqoRVTksMinxWeVGVBSsjSLUgN1Q/hGR3KFSqsaaMBIO9Z9oHjuIHGdo1FNx
         V60G+ZQhQoPkLRfXTFn3+J/3a0P7VLmfyebr8mgORCZ/eEkw1/DF0ed0nTbmctifvEr3
         1LceNfAOvOHO+/v/O/EgwPEjsRzT2+aNjoU1oc3/iUhROT/dyeOQOFtYNsTEaM1M0qpX
         EaHpp3e/Xntx1Rokn2yVQflFS9B4yLCKZNcGefD4ciGd13UCiJG82d2x2FVpNhuL811n
         Ylzl87Uiw9tybaxfqKttKiCdIaFgIrQPY8qIWjoETCA3g7FroNmoCybWFriYfds/qjWL
         SxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=74xntSFv45P5uxE02fT3KOtvmrgwIhR0LyAitbgHaOQ=;
        b=LGhNUgeZfhtc1w2IyntiDgAAQBkoE1Kc72aSZfALgkMU6pn+GOaryaiIMCeXnK018H
         0L5ExtzujCoOO/+g0pUcrH4xO38EIG8Vg1WuLfTnqjzf0HYAz0jsoGzxnnULxLjOkchQ
         Rw8LwNtPq5yFkINxxGVKfcSEgzzh1xfQBZxgUCY19x4kPrXdXKK8VS5B7/P4MES87p/l
         UZVvRwqE670gDni7Ihs4nht3c2r93Neet0KaN6zTAG1dlom7W3tlJZ3GyYAeSBqgc+ob
         OgkG2z8pbrWcZyp0EWt/SknUiJ0mwzfx8DLNFeb7K6hgdRzgQBtCHD90Z/agN15UXBPk
         Gtng==
X-Gm-Message-State: AJcUukfk2N0Ua35GNozAguE8WfbUB5DzHb4QUrLv3wRnjdOoA6wPaPhF
        2nrcYxwdGiPWct/g1ACcFmDq0OLJUrbHCYrae+yKuQ==
X-Google-Smtp-Source: ALg8bN6xqWDc5Sq/06QYqdFQqN+1zYDMZD1kHAWmw2YWq2byOr9l4p48xyBuSkHzQ6yOO3aXhbzVNeGWi58roAGpDGw=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr8756724otn.95.1547744498320;
 Thu, 17 Jan 2019 09:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-7-keith.busch@intel.com>
 <CAJZ5v0jg24sNVQiA1AvVwP-uCCq1Uo9rxkAERyb_zDL_W8AATA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jg24sNVQiA1AvVwP-uCCq1Uo9rxkAERyb_zDL_W8AATA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 17 Jan 2019 09:01:27 -0800
Message-ID: <CAPcyv4i9Doi_cE8KkB-PjzPyU2GoscvJbKTJzaX1esVQQ=dxMA@mail.gmail.com>
Subject: Re: [PATCHv4 06/13] acpi/hmat: Register processor domain to its memory
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 4:11 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>     On Wed, Jan 16, 2019 at 6:59 PM Keith Busch <keith.busch@intel.com> wrote:
> >
> > If the HMAT Subsystem Address Range provides a valid processor proximity
> > domain for a memory domain, or a processor domain with the highest
> > performing access exists, register the memory target with that initiator
> > so this relationship will be visible under the node's sysfs directory.
> >
> > Since HMAT requires valid address ranges have an equivalent SRAT entry,
> > verify each memory target satisfies this requirement.
>
> What exactly will happen after this patch?
>
> There will be some new directories under
> /sys/devices/system/node/nodeX/ if all goes well.  Anything else?

When / if the memory randomization series [1] makes its way upstream
there will be a follow-on patch to enable that randomization based on
the presence of a memory-side cache published in the HMAT.

[1]: https://lwn.net/Articles/767614/
