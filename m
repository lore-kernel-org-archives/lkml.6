Return-Path: <zajec5@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524950720; cv=none;
        d=google.com; s=arc-20160816;
        b=LwGjLVEeU1md/xhbDR3h5dE14tRwng37uMLBv0j0FDAEFR4FdxgrJDYhSFiyEnFHvb
         Bp6/o+XKpjNCvkGSUGBROu/uN4taVWyJT7uKXIu+WUdlezIPD7YGODu56dZD0fYpt/nV
         1ojDDli7ThPdhjg4yUA2HJUR/673DGetdIMFVJ3XsCbsG1J0fnxK4N+3+24jgCRbCAS4
         XawFNwBuElXdfAmjy8bubJTWPbQhWhH0kjoHLkSxw4qGuQSdkea1Vctq4UwVj6fufqZL
         +x1U/ku/44f9d5hxRmQH16NrUbgsBmgN8s8y74GSnvRjYRIRt74LlBrKHCxhx8k2RPH0
         I2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature:arc-authentication-results;
        bh=m61hR7gM6DBfl5no6flWHqdPGsfUaMoV6TpZ5/mE/as=;
        b=CoZP9jMEz3lN9Nb4GJoXSxlLVPI3z6C2nGhtC93nan3ZtpY/HC7r/18kK8Pmc1VXQs
         +JS7BIDNNcRzIzQdGm+ZUs/soVYXzWGtO1+TrOT6YmcTATDyXy4cNjLzI+JHS0Wd1rfV
         DiTxhPUnpTbyWYrUdtMeZifJVDZfY8+lDaOSe3MPSsZN4Br4kO0XJiFZ3b3zHG6q7bFf
         2Y1zOaso/Mi1nt+su5cyP/csJeuVwPD9/biZQ1vL+gVfRcqGf4dzWGUdxGz0CSpoNpHZ
         VaIcAZunLGGvw5V7ke+260MzXYkWw9v7b10rKgyrtPed3CrNCRpyB5e+CblukZD2Dude
         qHyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VyFJ0nMt;
       spf=pass (google.com: domain of zajec5@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=zajec5@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VyFJ0nMt;
       spf=pass (google.com: domain of zajec5@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=zajec5@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoowZCJd1lMYR7R/fp+rO6em8h2vF+ZwPUBFsgoLQHvJ+ypXGAuR0xcdpDVYd+s+XTLaSp9dk6cf3zHDvNU7Ls=
MIME-Version: 1.0
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Sat, 28 Apr 2018 23:25:17 +0200
Message-ID: <CACna6rz_Ms2Uv1P6E0gCGNsRwK4nm=PMAOaJ5Uk9aJxs2VSamQ@mail.gmail.com>
Subject: LICENSES: Missing ISC text & possibly a category ("Not recommended"
 vs. "Preferred licenses")
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, DOCUMENTATION <linux-doc@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>, Andrew Morton <akpm@linuxfoundation.org>,
	Kate Stewart <kate@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>,
	Russell King <rmk+kernel@armlinux.org.uk>, Rob Herring <rob.herring@linaro.org>,
	Jonas Oberg <jonas@fsfe.org>, Joe Perches <joe@perches.com>, linux-xfs@vger.kernel.org,
	Kate Stewart <kstewart@linuxfoundation.org>, Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599026726440039181?=
X-GMAIL-MSGID: =?utf-8?q?1599026726440039181?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Due to some maintainers *preferring* BSD-compatible license for DTS
files [0], I was writing mine using ISC. I had no very special reason
for it: I was choosing between BSD-2-Clause, MIT and ISC. I've chosen
ISC as I read about its "removal of language deemed unnecessary".

I took a moment to look at the new SPDX thing and noticed that:
1) File license-rules.rst provides "LICENSES/other/ISC" as an example
2) License file LICENSES/other/ISC doesn't exist
3) ISC is listed as an *example* under the "Not recommended licenses"

First of all, as ISC is used by some files in the Linux kernel, I
think it's worth adding to the LICENSE/*/ISC.

Secondly, it isn't 100% clear to me if ISC is preferred or not
recommended. File license-rules.rst suggests the later by listing it
as an example for "Not recommended". It's just an example though, so
I'm not 100% sure without seeing it in either: "preferred" or "other"
directories. Also if anyone finds it "Not recommended", can we get a
short explanation why is it so, please?

[0] https://lkml.org/lkml/2016/5/4/707

--=20
Rafa=C5=82
