Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B79C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B67520882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJlXT0p1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B67520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeIMOwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:52:02 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35317 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbeIMOwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:52:02 -0400
Received: by mail-it0-f68.google.com with SMTP id 139-v6so6966289itf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gd7gGUDhqQXE3vo/qE5F82mb4Zfb6f4/mX8P79lI0uA=;
        b=AJlXT0p1fpBoap60tU+Te+5kBlyQFEQMdMt7Skuk64K7yIGHVSUD5JlnVq4H/tsMSc
         nz8uWnujGhumqnGq5a9SEF7wQ37+HwYL6ImwViEKRZ0Nl8J/SdmCs2rGt9IwEYiOG/Yk
         N/DXz6Kb8+Y9RQ1hn9mCRiqkaJ9gU6fnuMs5ntDeGdvANBLQcqQkWnMJ9/kmsumqXniP
         1AkKv87i28gzmdan2k5XBhZ6aRRSxZixf4wys1rBmBi4+H0U4L9i3Gh8Upjich9ST/J5
         qcDZrzaTezAR7MM2wR2C9SweRicpgBGmYRGeUd29ijgJabn51m4+Ex2M4LMHTh+aV8VT
         ykZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gd7gGUDhqQXE3vo/qE5F82mb4Zfb6f4/mX8P79lI0uA=;
        b=WBzpeCNnsLkY3eccbwMtQq22fTdQVBSbPVAvQ7AQjrANrq2BBALWGota3WezlebwcO
         kNBRdjpqTgtcHVN0wjAWlXDgNPZtTVDcpC/AEpfhQyQA54uQpKQyVyXZ8CLLlaGLlVxo
         zXJ2EsFK+2YgDbAeVtAaDUtByB1eF8mt5da+l9nt5I0C/BKhyVQUfUQtHRt/g0HMSoIH
         fSb/nzAXSKS15jZ6hZaee79jl5o2M49dtPrSpSqzwLRyxt7HCJPHMe3XxvaeRdt0fKkc
         Hu5w0kbtuGsTIQgbXOS2eIk0PE4nzaaOWLxG2M7ESDBmGvxC1vtz4sLhR90aH7GGdX6w
         SWXA==
X-Gm-Message-State: APzg51DeUD+BqrhDpqvfuJ4IrT/E1s+rVxnUUaTnZdISLLQHLsTFpnuW
        NjlZU/5h9j4a/LnQ20PD5YWT3l3ZDb2SqNC0Vyc=
X-Google-Smtp-Source: ANB0VdYVMzcY34pud18gKnW3fidcyRqvUEn0ZwkVIIa4kVD6bFd25prcavGy6/ZCwsREirVTzJbVAytW+7yR4WYWKRk=
X-Received: by 2002:a24:355:: with SMTP id e82-v6mr5241011ite.64.1536831800275;
 Thu, 13 Sep 2018 02:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536517047.git.lukas@wunner.de> <f53ea40a7487e145aa1a62c347cef1814072e140.1536517047.git.lukas@wunner.de>
 <20180910094454.GJ14465@lahna.fi.intel.com>
In-Reply-To: <20180910094454.GJ14465@lahna.fi.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Thu, 13 Sep 2018 12:43:03 +0300
Message-ID: <CA+CmpXtUHwu97tA6bTDJKbVyiPrYT0aEWr1SGrP88DFKNybEcA@mail.gmail.com>
Subject: Re: [PATCH 4/5] thunderbolt: Correlate PCI devices with Thunderbolt ports
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     lukas@wunner.de, Andreas Noever <andreas.noever@gmail.com>,
        michael.jamet@intel.com, stephen@networkplumber.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 12:45 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Lukas,
>
> On Sun, Sep 09, 2018 at 11:42:01PM +0200, Lukas Wunner wrote:
> > Ideas what we can do with correlation:
> >
> > * Represent the relationship between PCI devices and Thunderbolt ports
> >   with symlinks in sysfs.
>
> I wonder is that really useful? I don't think we should be adding sysfs
> entries without any real reason why it would be needed and who would be
> using them.

I think Lukas mentioned where it can be useful, even if it isn't used right now.
We also know this can be useful for some QoS configurations (even if we didn't
found it useful enough for now).


Lukas,
What I'd like to ask is: if your point is mainly for OS-controlled tunneling
management, I'd hope this future Connection Manager will have better ways to
determine the assigned PCI bus number of the PCI devices it tunnels than the
walk over the PCI tree the current patch does. Isn't it?
