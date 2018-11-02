Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2712AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE4122082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyLPVGUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4122082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeKCEJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:09:49 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38791 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKCEJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:09:48 -0400
Received: by mail-it1-f196.google.com with SMTP id k141-v6so2734745itk.3;
        Fri, 02 Nov 2018 12:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhU2XrXFH1Kd1kmLevrD6bAw5GU/51Fr/Y3DBQC8Uo4=;
        b=uyLPVGUfxtvGIuY4oZxPSD3ztYWoyWW/md8zYE3HJrjiFR8SRWMUkTetTfbGuOf2Ac
         /Gu7xL5l5a5Tjsn+WW1jdUmlJ5FC6FPZCi4JrM7B8wSOJX/fRirhUg4vSs8jCgnYnyij
         blqDJ4AHO/45pHHV0BYsu19iaefn2112IHa7ELWXJqFpUHrXJaeBJtXvp1DgjznqcNsE
         wtbtMoThH1cmBD7lksigWNSbDSTFNsS+tLmWQdmgPupnTj3DPJuHpbrKUr4ibXqf8NnH
         RV0pyx3hx+rDENUX7S1L3u4NginaXgqgcCrt98cRpWzgnQEZ03LCkr7JeZmP7ic6X/7q
         +8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhU2XrXFH1Kd1kmLevrD6bAw5GU/51Fr/Y3DBQC8Uo4=;
        b=F7RF2bJ1MsWzmCXNEsI6a9hg60ZoZPn0cBGnFuHvrzNxkwzf469ViPpzQZGwUCKqtM
         8AMQR1seVhWyelvfTfGK5QyZywEGatgiDQHXpfr1NV/CvpCPnENmszG8gT1azVRP3kQf
         vt16c2nRZNpUIAo/25RybMsoS5Kflje+HxCG0VKreEdc8rB7zrFCOnXBPt+daBcnO/TC
         ECDhbneSWRtUMDcNAmy12lIs19sCIGWx2TcByzjQvN2uhD7u+c/07OQ/eLn3mz8L4mSc
         7oxtW25XeE8I1LDyMCcKFQTGOz0XMqHAbQRBmnHl99NOV5NQEvnWo59VRux552Aj/XLi
         RAkA==
X-Gm-Message-State: AGRZ1gIeFWBPVda5yYt+Tf7gcbUo4zRof62KEhwtpIZB2UMO9vDF7f+V
        gPkze9XvNCE2l4lIAD280sseP4cpLwrra3YzOJw=
X-Google-Smtp-Source: AJdET5fDhVQWt/uW4HDqoTf0Lfy/8iVLUSxkyZtg3W22fkj9fT8vLPMNiA5NGeZUu9vmxpcl7oBqEBbfjxz/vz1zBU4=
X-Received: by 2002:a24:5712:: with SMTP id u18-v6mr207201ita.32.1541185290207;
 Fri, 02 Nov 2018 12:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181102152637.GA3105@hp-pavilion-15-notebook-pc-brajeswar>
 <20181102182905.3klrdw4dxapeoiib@tower> <CAFqt6zYmBFQ7gDJJkYAhPzPYyLGsDqOdr8ctXmYbd7e9sv75xg@mail.gmail.com>
In-Reply-To: <CAFqt6zYmBFQ7gDJJkYAhPzPYyLGsDqOdr8ctXmYbd7e9sv75xg@mail.gmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 2 Nov 2018 12:01:18 -0700
Message-ID: <CAEdQ38Fh99QmusGbEBi9TjUKQbQDX90pEaUC5Y=s-BL=RQ3o_A@mail.gmail.com>
Subject: Re: [PATCH] include/asm/cmpxchg.h: Remove duplicate header
To:     jrdr.linux@gmail.com
Cc:     Michael Cree <mcree@orcon.net.nz>, brajeswar.linux@gmail.com,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sabyasachi.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 11:55 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> We run the static analyser "make includecheck" which list out files where
> duplicate headers can be removed and based on that we thought to remove
> from this file. Didn't understood about the existence of second include ??


#define ____xchg(type, args...)         __xchg ## type ## _local(args)
#define ____cmpxchg(type, args...)      __cmpxchg ## type ## _local(args)
#include <asm/xchg.h>
[snip]
#undef ____xchg
#undef ____cmpxchg
#define ____xchg(type, args...)         __xchg ##type(args)
#define ____cmpxchg(type, args...)      __cmpxchg ##type(args)
#include <asm/xchg.h>

asm/xchg.h has a comment at the top that says

/*
 * xchg/xchg_local and cmpxchg/cmpxchg_local share the same code
 * except that local version do not have the expensive memory barrier.
 * So this file is included twice from asm/cmpxchg.h.
 */
