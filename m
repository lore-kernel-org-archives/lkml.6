Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524139240; cv=none;
        d=google.com; s=arc-20160816;
        b=cwuZNy857lPwMMtd74tyUPO/ALr8irlulmmzvdeYQcWrrU2V7qBMHgp4LlHLT6XqvP
         GAULXwDcjs/Zctq/rg0S+B2CI/mpfnHqRZy9HGeLLfVVWytNXydL1XDW6FOIjIFepeug
         +HhbHw20qfVXOlMDki2a/Yp0WBTm1q+o0uLCY1smp1nkXTA5OHls7BgIKgSkMYbdZkxI
         ZfWBAdBywBTD3KdQerkKLeOAeEJW08iZsim9yOWHNYo5ZHt+AyolYc6dGCnZQNJ2SDAj
         FBLSybB7hGu+Oqzc5MeHOy9YD390/dRN0f3Llq7G974F9AJRpjr9+/IKfk/+t/QZbW64
         IW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=7HfKs2/hLNgWFFKFBwvnagRSnw4dZIb+81Bb8/4QzEk=;
        b=PmngYeXNzWwS3MqG7ngOU96npyH+QwoKnYO7BA3qf86TV/5iG1R4beEiGCbTEShNh6
         WD0+esXNOURyM6ZFF1zci6ON/rlDSsn1CBNby3CAcbUG2Iqhsxv/u6zKqUsg/TGJ6TDy
         0S21Dm8fAfPYW6GvRZHHn0UA+FVscyznd8RLs6311WoUzTqh2nauKXjeP8xGB29ofdrT
         Rp5sLFhcBcbUQRpPoXmLq+tXn9p2QZYZGYKNvzYxEP85dJNUGspWeriCFmALi9/wy3by
         FQcO6KR42JIpFEDS9T0+JGiCJ8uxLQtpVdbvrzawSIfDL1qfBwYx6AJv+zfN4oHehjEc
         klAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TCVCNSMn;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=TCVCNSMn;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AIpwx4+qL3zfxsOLlWYH6qzN9VVqouklhmClfosErarWHMTEmLCP/3S4LJon0w9mCTaM9vCkFHMq6B2IWbO6J/YTmTg=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1524138946-136701-1-git-send-email-john.garry@huawei.com>
References: <1524138946-136701-1-git-send-email-john.garry@huawei.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 14:00:39 +0200
X-Google-Sender-Auth: UXJ3anBttmH4sFo0K-UUqTLX9vo
Message-ID: <CAK8P3a1nen_EoyZ63p_EfSu51wUAbLigzbrv3K4byS2gUo9CjQ@mail.gmail.com>
Subject: Re: [PATCH] HISI LPC: Add Kconfig MFD_CORE dependency
To: John Garry <john.garry@huawei.com>
Cc: "xuwei (O)" <xuwei5@huawei.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms+renesas@verge.net.au>, gregkh <gregkh@linuxfoundation.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>, Robin Murphy <robin.murphy@arm.com>,
	Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>, bogdan.purcareata@nxp.com,
	Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linuxarm <linuxarm@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@kernel.org>, tanxiaojun@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598175575431248949?=
X-GMAIL-MSGID: =?utf-8?q?1598175828168088463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 1:55 PM, John Garry <john.garry@huawei.com> wrote:
> For ACPI support of the HiSilicon LPC driver we depend
> on MFD_CORE config.
>
> Currently the HiSi LPC Kconfig entry does not define this
> dependency, so add it.
>
> Fixes: e0aa1563f894 ("HISI LPC: Add ACPI support")
> Reported-and-tested-by: Tan Xiaojun <tanxiaojun@huawei.com>
> Signed-off-by: John Garry <john.garry@huawei.com>

Can you explain the specific dependency? Normally MFD_CORE gets
selected by an MFD driver but not other drivers.

       Arnd
