Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeCWS0w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:26:52 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:40041 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCWS0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:26:51 -0400
X-Google-Smtp-Source: AIpwx4+/UFq1lKhH8thXQu6ZC3T5BZ/bOQkrJ5Vom6YHB65ZxCNIhRDrInWLG0LylFxZpxyNvRwZYAZRIkIMygXMoig=
MIME-Version: 1.0
In-Reply-To: <20180323174447.55F35636@viggo.jf.intel.com>
References: <20180323174447.55F35636@viggo.jf.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 23 Mar 2018 11:26:49 -0700
X-Google-Sender-Auth: QV--bTN45FlpKU6-_KlxIlGTQHs
Message-ID: <CA+55aFwEC1O+6qRc35XwpcuLSgJ+0GP6ciqw_1Oc-msX=efLvQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] Use global pages with PTI
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, namit@vmware.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 10:44 AM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
>
> This adds one major change from the last version of the patch set
> (present in the last patch).  It makes all kernel text global for non-
> PCID systems.  This keeps kernel data protected always, but means that
> it will be easier to find kernel gadgets via meltdown on old systems
> without PCIDs.  This heuristic is, I think, a reasonable one and it
> keeps us from having to create any new pti=foo options

Sounds sane.

The patches look reasonable, but I hate seeing a patch series like
this where the only ostensible reason is performance, and there are no
performance numbers anywhere..

             Linus
