Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523901381; cv=none;
        d=google.com; s=arc-20160816;
        b=LYbE3iUl6RRNhoVZNakW282j6YicnqhEGj5YvMGgsUkaZfYZcmXg4bSbCa/aNid4Vz
         L6TFFUItxgaN18e6vNlqTl6DM3VLfNrWPPaCUEdAmRSxtVR/n3IBdPRACt/4HwEeK7Uk
         EcUes5NWRnxrFki9H9IS7UUa9J9gX223f9K9Q2NCvyH8AVn43GPWjESfgVT6P/r0xa4F
         mcLqjbrMSNrBQD/7TiIn3TsxPvryX/jW4Xk6eOaPiyTcbOF5cRgfhec9j15PfEEiECpm
         ZDedA3FhhaW7Y8nQFiHhM7Pq+Q2GAR586HbwHGQ73CjtvQh6RG63eiFCpqeBBvBruxGu
         h6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=YB7Ri3DsSn6aDrymIkxvc+n6v5H0iSBPxbzTgGjhI/Y=;
        b=Zas3/HgC23I2FbObxPtHuwcPz46tzdCUA+d1AgQ0Ci2s4vmT1y5WHV4KMgt3s2AWMC
         jbWsAWFn+OSBJPOSkEpaXEiV7HvaArFN+HpUWTtVvKut6eJC7VFeyZaqxzvFDbnb7RqH
         hAe6bYMyMOXSciRVMPOdfVXbr6gvwLCLYBvXbw/kNXC6dhA5TJh7KWguqP82pLhRYUxq
         +N0eIToHawnSKbVVPX7hG1EWusicIFqq0vobN46TaJxCHS+uMTO8NsbhjaIycS5oRdMv
         wNOcicZPk/CZEazA6EqXbQULwW2yTCjtki9bn5d9TeZ4mME+/PXnM7ypu2jWqDieUhFw
         cgdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HBn1d/LW;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=asp+xSI+;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HBn1d/LW;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=asp+xSI+;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx48NcbIYj74bRdal6+evsJQHYqqLg0kWqi9oQH2O2iLefBDihlt+gOOBPOiMVf16Dzm5gn7e0i1cdm1isvuvNPE=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFwE1SR87+Xkkmfr+D0Yq3R0HRkdf1GdgScEfXXWN4ba6w@mail.gmail.com>
References: <1dcd116c-9384-6885-2d9e-f620c14bd955@osg.samsung.com> <CA+55aFwE1SR87+Xkkmfr+D0Yq3R0HRkdf1GdgScEfXXWN4ba6w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Apr 2018 10:56:19 -0700
X-Google-Sender-Auth: X96pqU8dNNjKkHawqM_0OXmpyWU
Message-ID: <CA+55aFzotCBw7S=dNzyFjZkNqS7MMeKVgUoK6Dgb9gRPV_ywVQ@mail.gmail.com>
Subject: Re: Linux 4.17-rc1 - kernel paging errors running x86 selftests
To: Shuah Khan <shuahkh@osg.samsung.com>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597922964171604923?=
X-GMAIL-MSGID: =?utf-8?q?1597926414209515860?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 10:43 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I don't see *why* it would be badly set up, and that test works fine
> for me, though.

AHHAH!

I'm wrong. I can see it too. My desktop was running 18b7fd1c93e5 (my
kernel from Saturday, I hadn't rebooted it since), but I had 4.17-rc1
in kvmtool and on my laptop, and I see the problem in both cases.

So this came in recently, and I bet it's the global pages series from
Dave Hansen, although there were a few other things that came in
during the last day.

That should make it easy to bisect, there's only a handful of x86 changes.

                Linus
