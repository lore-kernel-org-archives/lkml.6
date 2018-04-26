Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524754438; cv=none;
        d=google.com; s=arc-20160816;
        b=Ar0W1dK0RIpKyuOFbtNmm85e0eFyybA+huG73An7OBkUSsv8+LzP+hTYTMFVvTvSr5
         N39w5a6TJTzRH9IH1pZWyIas+5QqqDg+8Gza8sinXBBKsXIIWHEI5SBVFlWcgkeeCxcV
         zwHPKiLBSMD9Fxiux1bLDJFKwDgzvu56v9YbMirYz1CKnHYMOyp9rUhQsPN3GmXyA6PG
         mq5URmFNWYpd9F7Gd5+of7js06LIZBllbcISZ4e0IjJiS5/E5h53oN+RQrA+bKhdOhNQ
         BwBMmjQU1s1w8HYVkTvkrLZxlANAh76j8O/tcLmTEvRco5CUgwwt+5rJ4MNis0IltwHy
         EB7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=7ccfudGlDA7XfFxjOOHrk5/Q2HVM7aBOQAPzF/WVTp4=;
        b=eXTNOvumYv/8Fs6zdXuUiZqI8mTk2Bhjvo2hC8Vd+1NCpRLKABKC6DbmuYgSeqiNQ9
         qLUmm2xQv1l93rt3KujhMj+WstpYX5s6SUVtlA3jgu4Os8LqLRQQH42qAf6qUG8L1LF2
         GrIPzQFPa2X7rXbUxCuJfLAwQo+6LjO2mzneYlf/n6D2Ah0NuN9npgvaiVwwAc2VLBIe
         iZNjbdV6Oj7mx/Pbe/9QtjpFDBPv7nOk3eCaFaKZARqMspI5kT0VTdPCySiaod6o+ILL
         SGzUiqxKLR1oZACfQDpmlKAS7nG+FmYiVugd7myXUYS165uLxr29M4qC6ryp5a0nES/7
         K3bA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fzp4ejpk;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fzp4ejpk;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZrP1rsfxWdzGAm98ykCuVEPLccVqCbqL2dW9Mjltgo/MebfBmgoomvW1mJfosqp27EgVCWBQufd+b/4laTPqIA=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1524147242-220936-1-git-send-email-john.garry@huawei.com>
References: <1524147242-220936-1-git-send-email-john.garry@huawei.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 26 Apr 2018 16:53:58 +0200
X-Google-Sender-Auth: V5ehJSiWSPHZjsuxnj35nxj2QGk
Message-ID: <CAK8P3a1HJXPVKDLUi14jdpXfZ+ZsJTJh6fUJt5RdsMxnBLob0Q@mail.gmail.com>
Subject: Re: [PATCH v2] HISI LPC: Add Kconfig MFD_CORE dependency
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
X-GMAIL-MSGID: =?utf-8?q?1598820910558161755?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 4:14 PM, John Garry <john.garry@huawei.com> wrote:
> For ACPI support of the HiSilicon LPC driver we depend
> on MFD_CORE config.
>
> Currently the HiSi LPC Kconfig entry does not define this
> dependency, so add it.
>
> The reason for depending on MFD_CORE in the driver is
> that we model the LPC host as an MFD, in that a platform
> device will be created for each device on the bus.
>
> We do this as we need to modify the resources of these
> derived platform devices, something which we should not
> do to the original devices created in the ACPI scan.
> Details in e0aa1563f894 ("HISI LPC: Add ACPI support").
>
> Fixes: e0aa1563f894 ("HISI LPC: Add ACPI support")
> Reported-and-tested-by: Tan Xiaojun <tanxiaojun@huawei.com>
> Signed-off-by: John Garry <john.garry@huawei.com>

Applied to fixes.

      Arnd
