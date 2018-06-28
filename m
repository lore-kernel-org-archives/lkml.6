Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F38C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C3321778
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 19:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YMF9r/I1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C3321778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935718AbeF1TrD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 15:47:03 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54745 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935611AbeF1TrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 15:47:02 -0400
Received: by mail-it0-f67.google.com with SMTP id 76-v6so14473892itx.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWU0Xp7JA/FGX2Fb2WJeuA7JaRaDjFR7O7CmCjL8mxk=;
        b=YMF9r/I1BgufjSCJcvegN6/TOMiYZ1MubzIlQjEJ3ADJaVrOWsZ02EtSoPJ7gBXGF8
         DIWw0yS5KMg2SkP0fiEIGQJz6dlHjNzoLoFDQRUrlnP6HCb/a4dwIwwIVofyQ24J5EFP
         uRoJ+wiYRCIH+H7KRmfwRVeavXME8PcwFDgyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWU0Xp7JA/FGX2Fb2WJeuA7JaRaDjFR7O7CmCjL8mxk=;
        b=lKTKknyHJ9bgkY4AeW7nupTjOWX+56dSpgLSVp9tWwtQZEh8Lf4la8G0tmSA1l9edZ
         sXN1IF9dhVNq9PwinhunfCoHZZEaEILSUBUJRLWkL5XGz7Pn7Ay5GzbKbTTAgBXF9eKX
         hV3LHpChVfJ8/1uNM5F23T/ICbOI07T+JuSr+rTpkSVusfQGpFbNEZ/GLmPzjt8W8Knl
         iWioqo4b17XcLS3Et5QtmpcN+3qiWCxO2E29IVfPXAb7FU0BSWpzAagO+y3mwKT7MC8o
         dZuOqTTN7cTgkppDt3ZEgKVDnbe8EPbgGOQSrc0zJ1kVJdwkwzDGem4DiJMfBD4+Ehs+
         AYxQ==
X-Gm-Message-State: APt69E3A9LGmXPWty7jYH8w5eW2jZ9S5dTr2Y5p+nMM6nY6iads/DclO
        A3tciamDJEpzLixiOC40GivUgG5F1ePLAdEYCOz0Qg==
X-Google-Smtp-Source: ADUXVKLqQ+LA5uuNXN23GiUsqDzIRkt4UdNVObouKTqzbZFDRUtkZJ66OwsfjJP73GZz3rX/S3EkVuEr9MWLSUzbi9s=
X-Received: by 2002:a24:8046:: with SMTP id g67-v6mr9442411itd.16.1530215222036;
 Thu, 28 Jun 2018 12:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180626141300.4tkw3lculx6seyeh@pathway.suse.cz>
 <CA+55aFwStj80KBHxn31r=Rk_M-zEMph3P6EWaT4-aJYCuvXuRw@mail.gmail.com> <20180628084056.nmjwk2xqndycdhfd@pathway.suse.cz>
In-Reply-To: <20180628084056.nmjwk2xqndycdhfd@pathway.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 Jun 2018 12:46:51 -0700
Message-ID: <CA+55aFxOFQ5eWETag4Ni=6+xhYvQO=ZuZkueF_j0JbPdz=n1_w@mail.gmail.com>
Subject: Re: [GIT PULL] printk for 4.18-rc3
To:     Petr Mladek <pmladek@suse.com>
Cc:     SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        thierry.escande@linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 12:03 PM Petr Mladek <pmladek@suse.com> wrote:
>
> I am sorry for confusion. Anyway, it seems that Andrew is going to
> send it as well in the meantime.

Hmm. I got a patch queue from Andrew this morning that didn't contain
that revert, so I pulled your tree.

             Linus
