Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585F8C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157F124426
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 04:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157F124426
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbeF1ELC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 00:11:02 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37093 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752095AbeF1ELB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 00:11:01 -0400
Received: by mail-qt0-f195.google.com with SMTP id a18-v6so3619017qtj.4;
        Wed, 27 Jun 2018 21:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=klbQPSsOLLpy/VtYVTKQlUbMDkY28WTiDKCNM79IKA4=;
        b=rVsycF/2tAuWFit2hAO5sY0LnnhKMWaZAtJ4gj01avYhzONo1Eji9qHUSLZPPJfcWo
         A16yLN+fOp21qhaLloT1p0ROeU/MnpqI2dnjrn4cLpb23TlriNLN1sXMNXhCSfzzJKNF
         +ews46OUNApgoATWbHY5PkdutG/yuQL1xP6OhLI/5f5WrlQbIbUAtbfEioxE09fVzM50
         sRAc6vAAdElOKMtuq7IrHqvuZ6BCJAJjfV+sm75xJSzykxNM9X40e/BdAimXPzGuP8im
         LCXkDSjXKlCFlfODzIMvOYeQNf+JyztYFumaLhA7hy6IsN5WNE57crMolkdG6+IwwJfk
         FCig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=klbQPSsOLLpy/VtYVTKQlUbMDkY28WTiDKCNM79IKA4=;
        b=e44RVlvnk16cvJ6XfHcP8GubU3XpylJBwAcKWo0pXL66KuEwTNGdoQUA2CAXqLzwkF
         pcxAch0hh6cWunFrULGNiPTJlmW4e9H6Yf0bzdvjjtxyrfQP3rH2x8ZQrvaMflfmN26j
         nLSOebIjalK4+C8m36Dl7tRm6ieBgo2qM++4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=klbQPSsOLLpy/VtYVTKQlUbMDkY28WTiDKCNM79IKA4=;
        b=i03ETdulf7SEcFuEX2tWmb5X1Gf5EA02ZMjDukkwXs4TEjtvAOe4vKP9e5sNurl+46
         WWWwze1Ed7737SUbIxb6oI+/0L0QwEB5ZkcGB93A/4ztqf+2dgKDfpwmnBNSeApL6pgI
         oi6m3Nr0n//gVrGdIEv2wjeeTrDu6Kjri+8u9x86KeVQA7hZ73lAHfQ/3swNAd0/ROxq
         pIGt0KZ1rC2DIm3QGFhFqGM7UxJmTWCeEgs21eeYXDUuIdJ2xDxFtMhseZJ4eLBqQhfn
         c+CjSSq+g0ljZjo2n3JvXGaWqoah/quOwPZqJvlLW3sG95+Il87rSYJWBj5Z+V1zAPdC
         UmIw==
X-Gm-Message-State: APt69E0HA5SkmWDJ36FhP1AzoAYEqA02wb3IO1rZT70ldgUfuI/jC/Jd
        6iZxFaHOQFtYIGKycM34YPCkaiTNIAglBhr5ahQ=
X-Google-Smtp-Source: AAOMgpd85NGIzZ9hTJacYA7KdV4eROWbJykTnfUy7oRG03vwpL4sM/+V5kHhPqbmCWWPFIGZvChVs20LH5oIrXQ14Qc=
X-Received: by 2002:ac8:260f:: with SMTP id u15-v6mr8182523qtu.368.1530159060222;
 Wed, 27 Jun 2018 21:11:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 21:10:39
 -0700 (PDT)
In-Reply-To: <20180626232321.12372-3-benh@kernel.crashing.org>
References: <20180626232321.12372-1-benh@kernel.crashing.org> <20180626232321.12372-3-benh@kernel.crashing.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 28 Jun 2018 13:40:39 +0930
X-Google-Sender-Auth: w3ifmJWNKrAbBwgBP1oOfx8864Q
Message-ID: <CACPK8Xey6O43avYBVsfvFujvanNaSsMdNBRLJa21DqXPnn5vuQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] fsi: Move code around to avoid forward declaration
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-aspeed@lists.ozlabs.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 08:53, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Move fsi_slave_set_smode() and its helpers to before it's
> first user and remove the corresponding forward declaration.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>
