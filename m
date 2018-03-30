Return-Path: <blackzert@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522408225; cv=none;
        d=google.com; s=arc-20160816;
        b=UycM7ms9Vqvdsbdx1lWkVoWrrVOkSu9LUnQOhIIomWBixINxENrVLRZgEn4WyDaUYF
         OZwI2Mbj1W9UOllaze9o3V8tz1kJJIK3vMR8x54BET4TsHY2zMlvpzIYIGxh4nUMCegu
         VVVntUIjelwVw1vAGURr3vnTFtb7glPIFQxDHcpd7ugWC71lhA3VSBr1UfygBZ6uIQRX
         CIyJmOr1A9alQBBy87ps2aX9wpx9sEs0m4EhSxhVcEhiI3WftJrW/4mF+EMsUYIqFbcr
         TtmZB+unpGk4llGgTJNrrUIX2psmxpSSeDZZLNb33Vws1bqcaiIE/FILSrGeZyXf6jiY
         8jYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=DMv1OHAJmnEuxAnHztpCW3t3RuKwa0Ou1+EXusdSHqQ=;
        b=BK+vLICowjuZBMf4t/wdBKABUrGmWojMOFBbDdNPj16CmawVO7RydURCQ2+8iU6D05
         lUnN+roylT+LqogTTIwERkeg1+uheJ41YQun+ad1qoTaqnEwHR/YBtpiKqvYFuQ7dYf4
         /eYE69LOj+79KwldBsVtd6k5xmcN5hCqR43vkhybeDnYyhOBVPSTWTfvm/v4t3vtOdqw
         +sFvYyED+QZnMXsxOcX7jH3KMX87SeaKoEGMZiqEQEfp0aCKrXTpChEmPgKvkDQ37zjX
         vB9AbsyhLx4Lxx6ezL50ILm5Wqg4IUKst1IlBwS7HkQkLumFVRwLwPaIHvt0wTwjSbu5
         qRPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=c6OeY3LG;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=c6OeY3LG;
       spf=pass (google.com: domain of blackzert@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=blackzert@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+dzpT91FvaFhoZ3xkzYjDGaqjJ1sxmduVWasDti8HbRZkC+lXIRBvsYzSdr/NnlAoBmc9Y8g==
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [RFC PATCH v2 0/2] Randomization of address chosen by mmap.
From: Ilya Smith <blackzert@gmail.com>
In-Reply-To: <20180330095735.GA15641@amd>
Date: Fri, 30 Mar 2018 14:10:21 +0300
Cc: rth@twiddle.net,
 ink@jurassic.park.msu.ru,
 mattst88@gmail.com,
 vgupta@synopsys.com,
 linux@armlinux.org.uk,
 tony.luck@intel.com,
 fenghua.yu@intel.com,
 jhogan@kernel.org,
 ralf@linux-mips.org,
 jejb@parisc-linux.org,
 Helge Deller <deller@gmx.de>,
 benh@kernel.crashing.org,
 paulus@samba.org,
 mpe@ellerman.id.au,
 schwidefsky@de.ibm.com,
 heiko.carstens@de.ibm.com,
 ysato@users.sourceforge.jp,
 dalias@libc.org,
 davem@davemloft.net,
 tglx@linutronix.de,
 mingo@redhat.com,
 hpa@zytor.com,
 x86@kernel.org,
 nyc@holomorphy.com,
 viro@zeniv.linux.org.uk,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 deepa.kernel@gmail.com,
 Michal Hocko <mhocko@suse.com>,
 hughd@google.com,
 kstewart@linuxfoundation.org,
 pombredanne@nexb.com,
 akpm@linux-foundation.org,
 steve.capper@arm.com,
 punit.agrawal@arm.com,
 paul.burton@mips.com,
 aneesh.kumar@linux.vnet.ibm.com,
 npiggin@gmail.com,
 keescook@chromium.org,
 bhsharma@redhat.com,
 riel@redhat.com,
 nitin.m.gupta@oracle.com,
 kirill.shutemov@linux.intel.com,
 dan.j.williams@intel.com,
 jack@suse.cz,
 ross.zwisler@linux.intel.com,
 jglisse@redhat.com,
 willy@infradead.org,
 aarcange@redhat.com,
 oleg@redhat.com,
 linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F529F89-6595-4DE9-87C2-C3D971C76658@gmail.com>
References: <1521736598-12812-1-git-send-email-blackzert@gmail.com>
 <20180330075508.GA21798@amd> <95EECC28-7349-4FB4-88BF-26E4CF087A0B@gmail.com>
 <20180330095735.GA15641@amd>
To: Pavel Machek <pavel@ucw.cz>
X-Mailer: Apple Mail (2.3445.5.20)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595656488556903336?=
X-GMAIL-MSGID: =?utf-8?q?1596360726944205959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On 30 Mar 2018, at 12:57, Pavel Machek <pavel@ucw.cz> wrote:
>=20
> On Fri 2018-03-30 12:07:58, Ilya Smith wrote:
>> Hi
>>=20
>>> On 30 Mar 2018, at 10:55, Pavel Machek <pavel@ucw.cz> wrote:
>>>=20
>>> Hi!
>>>=20
>>>> Current implementation doesn't randomize address returned by mmap.
>>>> All the entropy ends with choosing mmap_base_addr at the process
>>>> creation. After that mmap build very predictable layout of address
>>>> space. It allows to bypass ASLR in many cases. This patch make
>>>> randomization of address on any mmap call.
>>>=20
>>> How will this interact with people debugging their application, and
>>> getting different behaviours based on memory layout?
>>>=20
>>> strace, strace again, get different results?
>>>=20
>>=20
>> Honestly I=E2=80=99m confused about your question. If the only one =
way for debugging=20
>> application is to use predictable mmap behaviour, then something went =
wrong in=20
>> this live and we should stop using computers at all.
>=20
> I'm not saying "only way". I'm saying one way, and you are breaking
> that. There's advanced stuff like debuggers going "back in time".
>=20

Correct me if I wrong, when you run gdb for instance and try to debug =
some=20
application, gdb will disable randomization. This behaviour works with =
gdb=20
command: set disable-randomization on. As I know, gdb remove flag =
PF_RANDOMIZE=20
from current personality thats how it disables ASLR for debugging =
process.=20
According to my patch, flag PF_RANDOMIZE is checked before calling=20
unmapped_area_random. So I don=E2=80=99t breaking debugging. If you =
talking about the=20
case, when your application crashes under customer environment and you =
want to
debug it; in this case layout of memory is what you don=E2=80=99t =
control at all and=20
you have to understand what is where. So for debugging memory process =
layout is
not what you should care of.

Thanks,
Ilya
