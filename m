Return-Path: <bsingharora@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519277572; cv=none;
        d=google.com; s=arc-20160816;
        b=ZFSLzUBnX6fQgt5bSnKK5tWRE/jCEn4BRl11VOstJRE6Lodzu1YjBR4GQEtooFVjAn
         o5spsKbrGHOpE8bO5q5ppGGLiSWlNK34VhIwrgUGeRolYRoSK8wqnU7i3O9DrUz8I5Ow
         NN4GOsk8RiHdFyS9j3KdG4eZ174Vj3qY1VqFny+TldidEZP55cNIAQ7g3WzPrDp1W68q
         jSN+n/eVYnSpGlvO1IcyjlrLQvnGGuCwet/wLHwwgrlbwJwowkhbE8Fd/NgFeGewXAfn
         MPyJEI08RNthc9mk8BPxoziCs63aCPKcYJx0trU4KEE022HIi+xw2oXI2IYZlsaHCIda
         Mp3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=29712lvrACN4EvQL4blLzCTyWvFCKHqnElORG847zg4=;
        b=rjYcZ5l8XvG6NtPURRUWe4RDGfkkKV7wZUGJ05wfAcxM3a4MTI1v4K62hs2lHxg8JH
         3ttF8d32aM+P+p9vSPuiT0bUMVOx4OQLa5Uei0NSCVZw91DXqy/YieiqDCJbl5J0bh25
         mnqocse04sDJ4NCWPbRL+uTUXF37ePeRNx+8Dd/JBkZE+Hwug+ALV9XQUxT4NtAACPsL
         CA8o/jI3YWXneWYllI4n/rjYOidlhEf3Djd0W95tk0agjY/9g/jt3d8Y+qxPEFgUGY5l
         hhp3BUHodj5YCmKlne/W224lngrjjXgRNYSg4HeFX4tdB2/8eRY5whNz4qm+bJ/YHJQO
         S5jw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=G0ZtsSSN;
       spf=pass (google.com: domain of bsingharora@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=bsingharora@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=G0ZtsSSN;
       spf=pass (google.com: domain of bsingharora@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=bsingharora@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224/Qdkg1P7Ex1pe9bLgL3uAy3bxbDxM2MeP7JXMF0/YZlfk/UZHcEVldaeVzNOzA75JxRCAG37HvpTMP/M9Wsk=
MIME-Version: 1.0
In-Reply-To: <1519271512.2867.14.camel@au1.ibm.com>
References: <20180221045736.7614-1-alastair@au1.ibm.com> <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com>
 <c6017f9f-67f0-10eb-1eed-527c9c5298ba@linux.vnet.ibm.com> <CAKTCnzkwwmbU4vzrmzW=eNnr2QW+rj=OUcAdOVxz+qKGC=9Q9A@mail.gmail.com>
 <1519271512.2867.14.camel@au1.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 22 Feb 2018 16:32:51 +1100
Message-ID: <CAKTCnzkjbNVxBVTKmffbxsyqMb83y2tXN1Xv4Zm3VT+sxePdpg@mail.gmail.com>
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information to userspace
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Cc: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	frederic.barrat@fr.ibm.com, Greg KH <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1593077999512639093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 2:51 PM, Alastair D'Silva <alastair@au1.ibm.com> wrote:
> On Thu, 2018-02-22 at 14:46 +1100, Balbir Singh wrote:
> <snip>
>> lpc_size could be added. It's currently useless to the library, but
>> > doesn't
>> > hurt. The one which was giving me troubles on a previous version of
>> > this
>> > patch was the lpc numa node ID, since that was experimental code
>> > and felt
>> > out of place considering what's been upstreamed in skiboot and
>> > linux so far.
>> >
>>
>> Yeah, I think metadata will evolve for a while till it settle's down.
>> Since ocxl_ioctl_get_metadata is exposed via uapi, a newer program
>> calling an older kernel will never work, since the size of that
>> struct
>> will always be larger than what the OS supports and our
>> copy_to_user()
>> will fail. The other option is for the user program to try all
>> possible versions till one succeeds, that is bad as well. I think
>> there are a few ways around it, if we care about this combination.
>>
>> Balbir Singh.
>>
>
> We have a number of reserved members at the end of the struct which can
> be re-purposed for future information (with a corresponding bump of the
> version number).

Good point, agreed

Balbir Singh.
