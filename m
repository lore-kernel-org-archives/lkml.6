Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CC2C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9062A205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:12:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lKf0/7kJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9062A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbeJWBb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 21:31:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35235 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeJWBb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 21:31:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id 14so36808226oth.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 10:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jkakasLwlhnO9Hp6F8zE3txRCGefIaHKJ86vPFtCuuw=;
        b=lKf0/7kJcck1KrvWvlNQsFQ7njsHsFaYzcgPD7HcI442z+6hHQOzBWqf6jHojm4bdH
         N961Gy6VIk06mfBj09X9GsJFDA0mKzzY6kzoBw1CHg+YXXrZqMk16W6ThZPP/CIHiog7
         adHbIJ4Pe+tLPLXZznj74pMKYNoyJBU4DU/khspvM0MIBmPgvk0fT7CsACSp8Etki670
         X/WIjWAiwZFjfCvQaR6CdpwjB/MTeqfAv9nWlAFws1OZhNfTkgT5WnBEngRa1QzWiBw/
         zGcDbt4iLrLo93E4lnU49PmbkwI/FNBrL6T4HUlu0X1PSkhTCesYBV0mhgmkJEeYZCyc
         VE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jkakasLwlhnO9Hp6F8zE3txRCGefIaHKJ86vPFtCuuw=;
        b=sxEzqhgPbjCRP5zjuzpj74LC6ND8poB9gv7kA0DXW1klJL7XBsJzjdb7sN8rVLKbUW
         9JLyK4syWwkurOIPVWGz+V+92Q6znNAVG2Fc/aSz+XwQmj0Il62gKFJNerFJh1T4e2QH
         vtC5jcKtdEeiJf4wIgeKPlonWOluZBFed831suj4nn/suzH7EYgO5I945GAPKGwKfYLv
         3a/+g3p5TRV6sSjYMtPDakXeUI6QIdT6b2pVIf23zUlhueirEGRtNr2cr0m9KyHY3uXY
         vkY+PwkI9ZZOAPu7xRKqa+dt3MhC3Mip51FLS80EC9d/7sAOrs9GSpwbxmHL0p8n++yg
         EP4g==
X-Gm-Message-State: AGRZ1gKQmtQCN4KVveqsZtd2QoUMw4dWa6grmRjU+PrFKpdGXRCp+8Pz
        ZjYGLrtS0Hl8J8eXsMKTmiDRaxOpWhVS+TynMkft3g==
X-Google-Smtp-Source: AJdET5dGg0D4h8UxeOjozJ5WiWINSSn4JQJrSn+YB+Z4EgkUlNWBQLb5jmZ+rU6gDNt8vkgtlsH2oxSpKm1MRqC+D+0=
X-Received: by 2002:a9d:51cf:: with SMTP id d15mr828151oth.0.1540228357996;
 Mon, 22 Oct 2018 10:12:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:2ac9:0:0:0:0:0 with HTTP; Mon, 22 Oct 2018 10:12:37
 -0700 (PDT)
In-Reply-To: <1540075827-21270-1-git-send-email-karahmed@amazon.de>
References: <1540071779-20848-1-git-send-email-karahmed@amazon.de> <1540075827-21270-1-git-send-email-karahmed@amazon.de>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 22 Oct 2018 10:12:37 -0700
Message-ID: <CALMp9eRphx7zZEMS+K8uRjJUj_LYgpZrDZg47djQRM950f2RMw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM/nVMX: Do not validate that posted_intr_desc_addr
 is page aligned
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 3:50 PM, KarimAllah Ahmed <karahmed@amazon.de> wrot=
e:
> The spec only requires the posted interrupt descriptor address to be
> 64-bytes aligned (i.e. bits[0:5] =3D=3D 0). Using page_address_valid also
> forces the address to be page aligned.
>
> Only validate that the address does not cross the maximum physical addres=
s
> without enforcing a page alignment.
>
> v1 -> v2:
> - Add a missing parenthesis (dropped while merging!)
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Fixes: 6de84e581c0 ("nVMX x86: check posted-interrupt descriptor addresss=
 on vmentry of L2")
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
Reviewed-by: Jim Mattson <jmattson@google.com>
