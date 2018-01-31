Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752965AbeAaDTX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 22:19:23 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:52482 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752377AbeAaDTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 22:19:21 -0500
X-Google-Smtp-Source: AH8x226OWTBSgXvqlD2VTLeOIaWQtsK2Cnzgzg4NwyoE38iPl4vyD9WD6VVFOK0hhovt6dzAQC4eAf4LaJfN8AiOqdk=
MIME-Version: 1.0
In-Reply-To: <20180131031300.GE29051@ZenIV.linux.org.uk>
References: <20180130183939.GB29051@ZenIV.linux.org.uk> <CA+55aFz8UL883+rj0nYsU_gtX6jLhriPGncDb1XDteEu817HRQ@mail.gmail.com>
 <20180131031300.GE29051@ZenIV.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2018 19:19:19 -0800
X-Google-Sender-Auth: bt_4RvrTjepZtqH1hMQLUF77Mfo
Message-ID: <CA+55aFyMh_cHUb37X6=8=DU2Zm8Cz=mhXYJcGGWqiC8LKLAoFA@mail.gmail.com>
Subject: Re: [git pull] vfs.git: poll annotations
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 7:13 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> As for the place for mangle/demangle... where would you prefer them?

If we can make gcc generate ok code for the generic case and not need
any arch-specific ones, why not just do in <linux/poll.h>?

(And I guess POLLIN/OUT/ERR are standard, so it's only a couple that
need to have potential help translating? That would make the helper
inline smaller and simpler)

                Linus
