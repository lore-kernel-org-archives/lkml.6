Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeBTVfd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:35:33 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:37885 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeBTVfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:35:32 -0500
X-Google-Smtp-Source: AG47ELuJtsNCJGeYzP+HQ1Oz9Nv9gWIiXTXBJn13NL4r/Jjjnd9tBlCZg4i77PZC7MyZGRMYfKHA88NEFuUPQt0l9MM=
MIME-Version: 1.0
References: <20180215182208.35003-1-joe.konno@linux.intel.com>
 <20180215182208.35003-2-joe.konno@linux.intel.com> <6680a760-eb30-4daf-2dad-a9628f1c15a8@kernel.org>
 <20180220211849.fqjb6rdmypl6opir@agluck-desk> <CACdnJusL1Vj_rvhZY+0_KZkrk=fwnQcr1y+vxOBmUXa4xdHHsg@mail.gmail.com>
 <20180220213246.43y2vbiiikqyx2ys@agluck-desk>
In-Reply-To: <20180220213246.43y2vbiiikqyx2ys@agluck-desk>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 20 Feb 2018 21:35:20 +0000
Message-ID: <CACdnJuvR1h+qn=EqiWDAR3m1LcPyqMszLbQbO0j9b3HYkc1nDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/efivarfs: restrict inode permissions
To: tony.luck@intel.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        joe.konno@linux.intel.com, linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, matthew.garrett@nebula.com,
        jk@ozlabs.org, ak@linux.intel.com, pjones@redhat.com, luto@kernel.org,
        James Bottomley <james.bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 1:32 PM Luck, Tony <tony.luck@intel.com> wrote:

> The immediate problem is the denial of service attack.  I have
> a nagging worry that allowing a user to cause an SMI at a precise
> time might also be a problem. But I don't know how that could be
> leveraged in some other attack.

The thing that worries me here is that if it's possible for root to
potentially attack the kernel then just changing the permissions is still
allowing an escalation of privilege. The other approaches would also block
this.
