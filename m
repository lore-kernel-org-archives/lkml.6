Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BC9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8AB2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="n673wRqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8AB2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbeKFEqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:46:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbeKFEqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:46:09 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 076ED2086B;
        Mon,  5 Nov 2018 19:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541445896;
        bh=JUwiEmbXq+H4MsWlLFBgjQ1WC+Ur5DvVP/wFVjoTg9k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n673wRqwHXSw8UDWjGUtVCx8mC+Zf4Vlv+ROSMkeNkmA/daGwN8sCvx/PqXdbqr3B
         idstWz+UFPVhi0AMTtnO30fRV6S6SZ2EsvEcQggMV4re9OHR9rwVeoEmCNFf53yh7g
         UT5Rp6iQ61KfMIiBnx0mGiZq4fqg3jqWXVJYxBew=
Received: by mail-qk1-f179.google.com with SMTP id 131so16881680qkd.4;
        Mon, 05 Nov 2018 11:24:55 -0800 (PST)
X-Gm-Message-State: AGRZ1gKZiiY9RErzra6Je7Aqt6jvtlSyX5QnLnZSaQ5e/daDnZziaS4h
        pjRkiRbs2dx2YBbL9Ov0dso4jDMU5OLeVx/Anw==
X-Google-Smtp-Source: AJdET5ebYs1JEHWQ97qMnQxD1a0zK5Q3YTaEGWHQJjd5cz4rULLqoFIA9EMwk7Dq03RcXr0lkO0COFFOALHeG+DQXgQ=
X-Received: by 2002:a37:9201:: with SMTP id u1-v6mr20549576qkd.29.1541445883088;
 Mon, 05 Nov 2018 11:24:43 -0800 (PST)
MIME-Version: 1.0
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 5 Nov 2018 13:24:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com>
Message-ID: <CAL_JsqJ6fJcqH4+YHrEZRb+8-KFEmL8WSTSE_XSyrtO=2+JQBA@mail.gmail.com>
Subject: Re: [PATCH v6 00/18] of: overlay: validation checks, subsequent fixes
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 9:26 AM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Add checks to (1) overlay apply process and (2) memory freeing
> triggered by overlay release.  The checks are intended to detect
> possible memory leaks and invalid overlays.
>
> The checks revealed bugs in existing code.  Fixed the bugs.
>
> While fixing bugs, noted other issues, which are fixed in
> separate patches.
>
> *****  Powerpc folks: I was not able to test the patches that
> *****  directly impact Powerpc systems that use dynamic
> *****  devicetree.  Please review that code carefully and
> *****  test.  The specific patches are: 03/16, 04/16, 07/16

I'm waiting for this to happen. Send me a pull req when it does or
when you give up waiting for a response.

Rob
