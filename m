Return-Path: <samitolvanen@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523305989; cv=none;
        d=google.com; s=arc-20160816;
        b=W6VyfL3u1gNHHTazmRqmlhuouT8a36/4rqCLluMUQKW2YcYcUHruNTyVjDNe7KuGnv
         d3es72fs2YfEPX/j1bm/A+C7JaeQEhvmLYRdIbb7stwRHUTX6KuS85KnNkL6Nfh/9u/M
         KD3rx0zOfsuJLg7NOQD3zyGgPBdU4n95Xs6zUuZjYUNnskFug8cFBbRJ+1MqHefHIV1v
         jAd+AsUESneV5BUpdtxs+X66uGkA/hx2eVOG51H2wH7XMm5fm8lfygst4A+UiGx2pn7S
         Z8dJTaAN0wUjZ4cPd2pheU2d+urOnOghbPNJQPLJrtBnsU1+bv3W9trECNQcjtWEIsU+
         LH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=T8Knn7kupbc717aMrtHaLZhltfEEKuOhpc10+xL5Ue0=;
        b=tgQRf2WxgUV1A/txczpMZ4JzHAq/Cfe2V53hhxxOjc5VKLF0VgNdKWOlq8bWo4NT2X
         wShvWriUQNAU0vgwFMto1lCDIMK2D1/At/f358eRXoLnYMAP00XTs5dEMMusTQQNhRaz
         IOkB+bRFZv75gb9sq3PNc3GM8kds63T6vIRqSolTAkog02R0rhfOAkl9i1b1eBWUhli1
         MR8Z3mdrRaZhwzt+h/b83pyoFMkTK5Mmml1pE5kHhY2bXQ6OX2fG+RXCM4wg6HbHadCF
         8Qf87kiUXQNCs88o4zHdH3hswMzAAnGTJSetFRK2NQ8Z8DyNtun4vDYx6GaZsEu+fvLM
         bVYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=E45W7M7L;
       spf=pass (google.com: domain of samitolvanen@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=samitolvanen@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=E45W7M7L;
       spf=pass (google.com: domain of samitolvanen@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=samitolvanen@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/lt3ZPCq6gmPLsZGLb20K20Xw5hgmrMxZOMllM/Y94rlykHlzlupd/6jy04b61xVxIRm1SQYyX++nMjCwcTn4=
MIME-Version: 1.0
References: <20180409180534.1768583293d0abe207168c5a@essential.com>
 <20180409093028.GA3398@kroah.com> <CAKv+Gu9Ny=EatuqrVOEFbOt+h0rH5uqxxDyHFT-PLH72ZzvZiw@mail.gmail.com>
 <20180409185751.247a0ac7@jbtheou> <20180409114146.GA20636@kroah.com> <fbd6de8b-d2ab-9fcd-75b6-7151f24309e9@google.com>
In-Reply-To: <fbd6de8b-d2ab-9fcd-75b6-7151f24309e9@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Mon, 09 Apr 2018 20:32:57 +0000
Message-ID: <CABCJKud4BrqTQXTf6x=opEKuY5LZBffaHCTN8KWKzGeoP6aOpw@mail.gmail.com>
Subject: Re: Linux 4.9.93
To: Greg Hackmann <ghackmann@google.com>
Cc: gregkh@linuxfoundation.org, jb@essential.com,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
	LKML <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, dan.rue@linaro.org,
	mark.brown@linaro.org, marc.zyngier@arm.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597258846269332204?=
X-GMAIL-MSGID: =?utf-8?q?1597302101749315102?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 9, 2018 at 10:02 AM Greg Hackmann <ghackmann@google.com> wrote:
> Sami, what are the plans for upstreaming this work?

CFI is a clang-specific feature that depends on LTO. Based on the earlier
LTO discussion, we decided to collect some more evidence that clang's LTO
doesn't actually break anything in the kernel before sending out the next
revision of these patches. I will look into upstreaming this code again
once we have sufficient test coverage, hopefully by the end of the year.

Sami
