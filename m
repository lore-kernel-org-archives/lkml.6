Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B63AC46475
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAA520824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 01:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E3LlH1q8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CAA520824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeJZJfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 05:35:39 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44358 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeJZJfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 05:35:39 -0400
Received: by mail-lj1-f195.google.com with SMTP id v6-v6so9958147ljc.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 18:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xoQACLJZvhzK/bKutGFyBK/lqwettaZmgjaHxnlUfBo=;
        b=E3LlH1q8UUHXSSCEMrDmuVcEHco/z5sOeD2G8sqVQAvirq924gvrEx48EPzxRmNQ6E
         7vm0BBlMM2GHAcjbgQHq+rGEzM9EDj0OebwGKHwLhVEkXlLZUQEZ2d5WEyPE0X6oqWvg
         ltS4YaklJ/W/Ry7Fv7PntsEXC2DfamVQmCXMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xoQACLJZvhzK/bKutGFyBK/lqwettaZmgjaHxnlUfBo=;
        b=khO0Q6JCR2COReutgQZvpMls3raCyT+fWjCTN46vCryrX0e6nHFDgJOm6Fc3DVJ1UD
         2Df2w0Xp4cElZw4Br3q3qtRUNh30yOY5fmQ4DjpP2DhexRrbWfHECVUiQu5up1uXz9hh
         yOFzZhYlfTC/T6RblxAiVmw+Y7xMnxMg6XCaQCCZ8XskInsRVSvFIM2Ci2EVolcgUCUI
         lsfoXb+KsSGonw8Rvx5nBETTmiVwERd8Gm5PPEPW7lOGIQ/kE9eboabeanCjsHgUxFs9
         OeXkHeRk+KLbDTHH3y7iINPTzXDl3M3v2m4cC5fgQu+qvBtqiDYsV5OgJhXPD+6FMTDA
         eyhg==
X-Gm-Message-State: AGRZ1gI1rAnxVH1uKzi6Mlyy7m9TzL+tNpI70qJQjhd4sQhd9LNUwRwt
        Sn1E/LGkxWkPa336N3TqpHn+vPkVpY4dLg==
X-Google-Smtp-Source: AJdET5f3sRljqXoCTEvv39ZGfDPYwoQ+GlZYzSCZ+5yVPnWEJBClxE4zoqyMM/u2sRo+mHs4/tpDkw==
X-Received: by 2002:a2e:8884:: with SMTP id k4-v6mr852705lji.145.1540515643746;
        Thu, 25 Oct 2018 18:00:43 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id s4-v6sm1364441ljh.14.2018.10.25.18.00.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 18:00:42 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id j4-v6so9952474ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 18:00:42 -0700 (PDT)
X-Received: by 2002:a2e:9d89:: with SMTP id c9-v6mr792332ljj.120.1540515642066;
 Thu, 25 Oct 2018 18:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20181024111410.GA2221@potion.hotspot.internet-for-guests.com>
In-Reply-To: <20181024111410.GA2221@potion.hotspot.internet-for-guests.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 18:00:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgtAx_2cSpfztUPTgyaa3gziNC-O4nPd4Qud=YCPAh8VA@mail.gmail.com>
Message-ID: <CAHk-=wgtAx_2cSpfztUPTgyaa3gziNC-O4nPd4Qud=YCPAh8VA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM updates for Linux 4.20-rc1
To:     rkrcmar@redhat.com
Cc:     pbonzini@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 4:14 AM Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat=
.com> wrote:
>
> KVM updates for v4.20

Pulled,

                Linus
