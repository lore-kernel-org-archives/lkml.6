Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeEVIzd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:55:33 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:43160 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeEVIza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:55:30 -0400
X-Google-Smtp-Source: AB8JxZp9XqnY+Y+yiznq0fWkDm6Zy4EVbKLXi6BjPQYadHTCVrKdyO9D7fSsLr4Z34McTv83D9GE0FSASgZ3e+hPNQE=
MIME-Version: 1.0
In-Reply-To: <20180521135003.32459-2-mr.nuke.me@gmail.com>
References: <20180521135003.32459-1-mr.nuke.me@gmail.com> <20180521135003.32459-2-mr.nuke.me@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 May 2018 10:55:29 +0200
X-Google-Sender-Auth: kD8NZTbOE3l_UbJsVDZjOs8B7nY
Message-ID: <CAJZ5v0hKfgTOJb47NjeOP1BBPXPjWqdfu_TXVwWMzOHicEx0Xw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] acpi: apei: Rename ghes_severity() to ghes_cper_severity()
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 3:49 PM, Alexandru Gagniuc <mr.nuke.me@gmail.com> wrote:
> ghes_severity() is a misnomer in this case, as it implies the severity
> of the entire GHES structure. Instead, it maps one CPER value to a
> GHES_SEV* value. ghes_cper_severity() is clearer.

It looks like the *real* reason for this change is that you
re-introduce ghes_severity() as a different function in the second
patch.

There are a couple of reasons to avoid that, one of them being that
people will now have to remember what the function did in which kernel
versions.  Also, the current name is good enough IMO, so I'm not going
to apply this patch.
