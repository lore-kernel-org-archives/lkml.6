Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952A9C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4619721EFA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 17:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hgPSvTaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4619721EFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbeHITmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 15:42:25 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:56117 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbeHITmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 15:42:25 -0400
Received: by mail-it0-f66.google.com with SMTP id d10-v6so1237322itj.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 10:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dpQZxP3/ZML9USwTqLo8fgQKj74PHR3apUxGAct2yQE=;
        b=hgPSvTaYlQnTrV8J4kvG3x7cXWQ+t36SSnnUo90DtAIkU/Wpu3sKRtiY7MCNCyHQwa
         mAkt1OaQa2Xn66eNoirJ/q8oU5eOT1k5+ZX9UAU93v7ZFtvNCaPcqaemzVMntnFM4+bO
         lB8e3LYy+0cfPD8y+v9ta0qQJ05s8+zyg4dVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dpQZxP3/ZML9USwTqLo8fgQKj74PHR3apUxGAct2yQE=;
        b=SXPBV+KygZP2asUxfpUuLF8ZfXgBY+SfVHBb3Nchg/bIg5hHZvjsZDESsa4+0f/DyP
         lzXXGyTo7TcC4wr5Z9S610+7/8cnb80ztN8tpvENT8A/isIrFVBh3xyd6os3qtsmjnKg
         6g1DAeHN06rzz2vlXf8CkbBRLQoTLsgL6GLz4Yl/MMvfEu9Z4t2JtSxuhejDuh92xASe
         5eMvNEgtqwA4J6VhRogag6n3J9T4XT2IfCzyUObLh7SQHy/nvmE1igJwFA5M4NrLTgM5
         HFI7k1csgp2E8n54VVzMrCkLuXsl+sSEQL2ENYkBhvdOAT7mZUFhdncHPG/QpqT2556U
         Hgew==
X-Gm-Message-State: AOUpUlEZfc7SidBz35Dsw1E9h3izxdiLuakc9uWMFcgfoyUwfMG2NaLq
        KxMZJlC1EzmTxZF573iXd2js7Tn9IjGeyIOhS4A=
X-Google-Smtp-Source: AA+uWPxTYJ9XU77YFeI3PxfqTCV4+WZo+TyBLjrOSFI5hbrZotkHXyY2WIFmBWuP8xUNqa/eW2lAERj6WHIXpNCawLQ=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr2749274jaf.70.1533834996590;
 Thu, 09 Aug 2018 10:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <bug-200447-5873-b2kAsSyE1X@https.bugzilla.kernel.org/>
 <CA+55aFyOaEGc_wjRuAxYZH7D4zi4xUQTqUwMmUzxFJQ__2pXuQ@mail.gmail.com>
 <87h8l9p7bg.fsf@xmission.com> <20180709104158.GA23796@redhat.com>
 <87sh4so5jv.fsf@xmission.com> <20180709145726.GA26149@redhat.com>
 <877em4nxo0.fsf@xmission.com> <CA+55aFwq90_KeRUesktap7L_4Hp3gatKZ28RYw1jXBYeOqUoeA@mail.gmail.com>
 <87lgakm4ol.fsf@xmission.com> <CA+55aFz1XFvOgJySKVNQD9VS4hys0J7rozxqd3s5ND0z80tfVw@mail.gmail.com>
 <20180710134639.GA2453@redhat.com> <CA+55aFxcjSYAj-CZFEuDwiwZyMg+prV_jeP_Vuh06RJA0BboSw@mail.gmail.com>
 <877em2jxyr.fsf_-_@xmission.com> <87efft5ncd.fsf_-_@xmission.com> <87wot0yqsx.fsf_-_@xmission.com>
In-Reply-To: <87wot0yqsx.fsf_-_@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Aug 2018 10:16:25 -0700
Message-ID: <CA+55aFyk3=ZeZytsK0L0QAmoCjWGrdJ9zrhnn8ygPV8qgQQOLQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Not restarting for due to signals.
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 11:53 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> This builds on patches 1-15 of my previous patch posting.  As those are
> non-controversial I am not posting them again.

Other than the one nit I just replied about, this looks fine to me.

              Linus
