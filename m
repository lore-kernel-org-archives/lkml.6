Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD1BECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01DD120C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Rop5IAU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01DD120C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbeGQORh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:17:37 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42836 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbeGQORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:17:36 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so2076937oib.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 06:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/gj9UXV+m0T8obDmQcVANVoPQ82+1ce4bte4zv/4+Vc=;
        b=Rop5IAU0aFdkDnABp2aRXYueArr0AbLBMZNRKqqWU+/6+MJSgO/lf/Orhw3y1EwlUs
         Rjg7T8oLM23ZsR+8gHcd9JW22tHWaS1gIMjwT8xKExDGqGRD1D5P6s4VZH9ulvmrJp9R
         lXkY92zPdlnLZAJz0nt/C1RS+u4g6RTp5w7Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/gj9UXV+m0T8obDmQcVANVoPQ82+1ce4bte4zv/4+Vc=;
        b=e74Iwl+7t+i+X+jBuTojb7ay1pl/KLt409hx7p3RybuSgUe7IOmckcf85T8YCB37+X
         pjo/VPGkqVW58iSQnoJorUlLEJJngBjcNpxRalUTOjmKUYgwxX2ZMdhbvI+XslsnGqdX
         gVXPp3th/H5cLU9Bu4bLH11rXpFMOMhTErkUp3Evgx/D0DgUzkqv8d2WEu1wqOfNocDm
         Zfs4id3LzoRCxln/kQn6l7OhogXKRsgWY1GlZiUWYfRpFcET0CqAxn8wQ1iQ98unXi/X
         Vt9F0nuMhts18tvAgKgZgU4xIkIk5K+yidWMD8Sg9ZbtxJyk289Pq4orY8LzPSXw9MSr
         aPlA==
X-Gm-Message-State: AOUpUlFCBWyvKMMZ1Z623HwjdNe6sZ6P2lFO9z0ofSaFazijiapN5pua
        R4G9bzkICxyY36u3MQjMMV8A1PREaSpfGb1f2wWgCw==
X-Google-Smtp-Source: AAOMgpey6WQkgc+HDCG0h+byeHrqJDzJyhNGgqNnB+SEx7GQ/dZVnHHPcqaKYT/au+cfK0zpinpoThb/YP9vj2KPrfQ=
X-Received: by 2002:aca:c257:: with SMTP id s84-v6mr1847608oif.104.1531835092451;
 Tue, 17 Jul 2018 06:44:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:113c:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 06:44:51
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <20180713143525.3144656-1-arnd@arndb.de>
References: <20180713143525.3144656-1-arnd@arndb.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Jul 2018 15:44:51 +0200
Message-ID: <CAJfpeguUfMtZ0G0uCNbxaM-F+6xKz5wcbbKZQ3YYQcH2v9J94g@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] fuse: convert last timespec use to timespec64
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 4:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> All of fuse uses 64-bit timestamps with the exception of the
> fuse_change_attributes(), so let's convert this one as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I submitted this on June 20 but got no reply. Miklos, could
> you pick this up for 4.19?

Applied, thanks.

Miklos
