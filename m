Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218E8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABF32089F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 02:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="f20McIH1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iV/BnrYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABF32089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbeGOCpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:45:19 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36737 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731983AbeGOCpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:45:19 -0400
Received: by mail-yw0-f195.google.com with SMTP id v197-v6so675327ywg.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 19:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sq42jYP1I2gFhTUC7scj04KOxbzZNRUY48WMtr+unbk=;
        b=f20McIH1rYb12bNrKobEHMY3Q5xfDfvZD9qeN8VIBTxSkUliM6zr54sPHwYhCjfcJS
         84GTH6rJ5rz5l7WpcbZP6njSCfQua+pNLNTgKR1yUP28mpR4UIyYgvWH+USK5Bu7D7Gg
         6yp4NqFdagWf8I1iTfJsPjkhn41YYkQgC4QQsBF0PwVvgjVb98nl5hfhienUTPQ60oVI
         isO5LN3Cs5RFZB0sNU+FFRq6zEt3d+c2kYnt9VjU9svVVe/zUK0+GNZ0vxr9Ny0dF44m
         XupstFppJYhT3tEH69ZgVsMH3NjzbppCgo/VpPu2WDndWhO75Jsgh/3DLHY4IZaMWe2P
         PUfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sq42jYP1I2gFhTUC7scj04KOxbzZNRUY48WMtr+unbk=;
        b=iV/BnrYGLkPker+PnkfJ2OEPnuARbCV5+eTqkNuqiCsLhgWDYbYwgCRaOtDOJ5pBd5
         Pak0Scael4jfHRL+I9qmyjPW3B0yOEQkEjZlT43gjZWKS0j7AlTVb7oHgAv0U+4p8HhS
         Od29/tw629AFU+UDS0ZoLYtB0h6HQs76VrUNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sq42jYP1I2gFhTUC7scj04KOxbzZNRUY48WMtr+unbk=;
        b=KP1dRMH2mDoWWa1D0RD2uCjJK5VorGsJLmb9PbCJWAiGczCyeUmalnCTidt8YhgtFs
         08J3chxpzadf8UFFTyOptzkfj9HYSCpR1RJV0plKs+Ixg++lA4G8ida/SLSEvNu0dtcb
         LiyR6fYrs+9IF3zjcJ5YQpiDzgn8P7ikDoqXZ1iowk7E3Gq3bMzz7KcoMhgfMaOs6341
         HxcwaIpUOFOsDTbDKy3wP62YZ787FP/jZwICY98Q9xqGJkVfIPz7Cvz4g9BFM39p3vW/
         OHwncu6Nh/FJa35Yi6VL6V1gWkem01Ko8IghZvwQ2hLreLBKAExT/lul+rZk+dooMeOf
         DLOQ==
X-Gm-Message-State: AOUpUlHh4sfVxTfevqMB7YyZOggUbt0qQjfrv7UN+eEDx+oohv5UAlhH
        WtALFgU00zCWpF143La9EnTVF7NG6K2qx8O5inQb883F
X-Google-Smtp-Source: AAOMgpeGKDqmIwnnQg+wM0hlJcxkgWk2xG8NxLCHlam+x5bRHxdrMmmVcJBEEveF/ZMGhU1pH4YJNlW9I2GJehJ/tMI=
X-Received: by 2002:a0d:f002:: with SMTP id z2-v6mr6120755ywe.116.1531621448468;
 Sat, 14 Jul 2018 19:24:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 19:24:07
 -0700 (PDT)
In-Reply-To: <1531505163-20227-5-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com> <1531505163-20227-5-git-send-email-zohar@linux.vnet.ibm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 14 Jul 2018 19:24:07 -0700
X-Google-Sender-Auth: 6wvUabYS0kK6vvwswGTuffIR7Go
Message-ID: <CAGXu5j+GTMeX=TNO3mEYivBd1_9MGQBfOivnMYg5+63HboyXMA@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] firmware: add call to LSM hook before firmware
 sysfs fallback
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:05 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> Add an LSM hook prior to allowing firmware sysfs fallback loading.
>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
