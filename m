Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526308591; cv=none;
        d=google.com; s=arc-20160816;
        b=OIJD61nSHoH/rou8/u+mZUjB3dbUAB1n8VO9GsDg8YdfAVe81zY3lPDA45WVcvh4wF
         1pvkIgvwris91rKyd3e6uJXysPK9IAb4+UqHuUpDV9MbcjLHmsz6jMuNAopUbIbVBrRB
         6zW7WtqryJQ5JFb7ZJSJrqcux9eNC9WSYf1MPBSM3SWLZZx521ax8OWIuJZ13HkZoq57
         NTjU/unXCj9VhW19k0HXMnDryWwGxwy5MGsKHbi+1H5Q9cWWFtnYObv21RQKU2f6UxkU
         7RI/shKUHMts7HQWn5W0l9xuN2ugNoS+ZR9w91qsx3OJwnyQZwbpCPGRVERn9ffcZ54o
         L1tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Sw83LEopRBFf+pO6TQULBQmejngt9FDxg1JxfjdJ2vM=;
        b=nNwV6HxDqA3hdA+U73iChkwcwLzfaSbLIDLMm83StDxRNUd+JhSLSaVKLTPn3KuhnV
         WKTSy9322T9q0ZFBZ0gjjN4j19P0EANWAbJVHRWdUHOTjdUNXLjHnnN9O1u7DXKWYisa
         AtB6zxPoCH8VOnZkOozYTPliIaigvP2HAs+OCgynAXVso7tN/yUsFNror8eFcMCYszX/
         s9qpBlia0zkEJ294lB/0JiVdLUwrQMZtAU8BLWXGSyiZyH+IcQHX9BUW7+vpjfaELRPz
         fQdxylTLG9uhOZnTP9+eaDA705p5k/pqV9d4Xn54ERIDOaBROMu+VefQsAFRAuKeW+dp
         D1jA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=ojYFY6qS;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=ojYFY6qS;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AB8JxZqvfq3M8YpjmCCV5/Hrw8rJW+MvZMz0sJPkKHwGrtw2Z+FKRoNJ65ncNCR8+X9ZWBtzWcyeOLAi68O9Pw2nFAg=
MIME-Version: 1.0
In-Reply-To: <20180425203703.650160358@linutronix.de>
References: <20180425203020.594959448@linutronix.de> <20180425203703.650160358@linutronix.de>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 14 May 2018 16:35:50 +0200
Message-ID: <CAOFm3uGECug6Hr8_UJt5QTGd_=Fae_Hvm_1Y9xyJri008EoHEQ@mail.gmail.com>
Subject: Re: [patch V2 7/7] scripts: Add SPDX checker script
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>,
	Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598752952851638430?=
X-GMAIL-MSGID: =?utf-8?q?1600450558056123627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Thomas,
Sorry for the very late reply!

On Wed, Apr 25, 2018 at 10:30 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> The SPDX-License-Identifiers are growing in the kernel and so grow
> expression failures and license IDs are used which have no corresponding
> license text file in the LICENSES directory.
>
> Add a script which gathers information from the LICENSES directory,
> i.e. the various tags in the licenses and exception files and then scans
> either input from stdin, which it treats as a single file or if started
> without arguments it scans the full kernel tree.
>
> It checks whether the license expression syntax is correct and also
> validates whether the license identifiers used in the expressions are
> available in the LICENSES files.

Looking good to me! And the use of ply is sleek.
-- 
Cordially
Philippe Ombredanne
