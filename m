Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AB1C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E67B20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TVDgqoUX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E67B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbeGXWEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:04:34 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51504 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388750AbeGXWEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:04:33 -0400
Received: by mail-it0-f67.google.com with SMTP id g14-v6so5751995iti.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5z8QBCb1+WU7KddsQteXqZLmiC50etz5tUj6z/ercs=;
        b=TVDgqoUXALwCwc0vDoDchQm9uRj+Dl3SZg02exWxoh4ln6XFW0E1qyCgaUfcQeaOEC
         WcT4UAk9YDl29bKyVC+E+9MxK2lwzyNIVNDYvqOJhuNIH+J9lK0lDvJ9OjHSMV2jyCXH
         Y+eNd6vtk02qbbzKSrKT6HmX/ur/lq1vW4UAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5z8QBCb1+WU7KddsQteXqZLmiC50etz5tUj6z/ercs=;
        b=BYNPk88sXxHx6zxQ7Taw0MS4xci5Dx1Sv+8s1v+CTS3muExxLGdHl/7zQdfPhEyENb
         EIR8++dq6ue2OSHiVhCpHxtH7ZegDQMNAMxYbo92loPjYhmmXYOWG9hBjnxJ0YK+4rY8
         Xndzfx1/q2n1wZzSW6jSOKn8hQ9GrKTAL/Y3QuSDlNAJBaQ6zkoLCvUenuerSzbvbqdm
         3NF6Vtm9hfmRsN4qfwx8TskEM/Zoeqf9EAtXN/GDEjhK9uzkgT7rYW/OXVd+4DlscIEa
         PMmr+NZH5RTHhu++nJZoXPyrF35Sg088x0SVq9AVVDD3yPwufLP+Q+i7a72ndODzRRHW
         qhtg==
X-Gm-Message-State: AOUpUlGc2kVPkeoyLjio9rKV6/NxEZTAe3Dzopvm8fYI6I0njNJNkWpz
        AM89MJYfGD2zg46LeSu++G1X82DJBRahBCNlnBk=
X-Google-Smtp-Source: AAOMgpcqSWdoaSaLAw+x+0g7Vgx4mPAJ1Y7JRtyRhOt8lE2Ym4iwHZYsW1TGJJp/tFB2/rwEjidd7VG3tLbCrO+ElcY=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr3944239ite.1.1532465776461;
 Tue, 24 Jul 2018 13:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <87efft5ncd.fsf_-_@xmission.com> <20180724032419.20231-20-ebiederm@xmission.com>
 <CA+55aFxNijeenFd6o7fg3iJFqAjdTZLaFV2=Eaqbg1fDOzx26A@mail.gmail.com>
 <874lgo5xdg.fsf@xmission.com> <CA+55aFw_CTTRTZfUf1e9yg04X_djG3q7HrCG-XqnyQorpKjaTQ@mail.gmail.com>
 <87fu084cxj.fsf@xmission.com> <CA+55aFxUc3ttEAuRS7GKs9aTjTFw1poE80DASFSXudVQCuWpHg@mail.gmail.com>
 <87a7qg4bb3.fsf_-_@xmission.com>
In-Reply-To: <87a7qg4bb3.fsf_-_@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Jul 2018 13:56:05 -0700
Message-ID: <CA+55aFxe+Ku78ZEvd_F2TD_3gTmLXw0kzo4HDE-ngkYfSHQfPw@mail.gmail.com>
Subject: Re: [PATCH v2 20/20] signal: Don't restart fork when signals come in.
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

On Tue, Jul 24, 2018 at 1:40 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> +       if (signal_pending(current)) {
> +               retval = restart_syscall();
> +               goto fork_out;
> +       }

Oh, the previous version had this too, but it wasn't as obvious
because it was just in a single line:

        return ERR_PTR(restart_syscall());

but it's just crazy.

It should just be

        retval = -ERESTARTNOINTR;
        if (signal_pending(current))
                goto fork_out;

because it's just silly and pointless to change the code to use
restart_syscall() here.

All restart_syscall() does is

        set_tsk_thread_flag(current, TIF_SIGPENDING);
        return -ERESTARTNOINTR;

and you just *checked* that TIF_SIGPENDING was already set. So the
above is completely pointless.

It is not clear why you made that change. The old code had the simpler
"just return -ERESTARTNOINTR" model.

Did the restart_syscall() thing come in by mistake from some previous
trials and it just hung around?

            Linus
