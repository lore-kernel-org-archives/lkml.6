Return-Path: <atchleyes@ornl.gov>
X-Google-Smtp-Source: AG47ELu1gZUOOzmR3cf3C3inQCUPvOjD6xo22ck7OAlzw2T057ZATVFrIqkxye9zoxCfpUqLYvYU
ARC-Seal: i=1; a=rsa-sha256; t=1519859525; cv=none;
        d=google.com; s=arc-20160816;
        b=gd6SdKRyCWoXsjW7UmutLVgZo5Pw28bGHXGPTXBRzMFtBpfDbaI3zeQhp40vimrkNc
         U//lZTKC7XEhMaxzPzUr2VYyDQg8nSHIdn1RxGh2018qzrIbwjMERE2xIX4Us3qdmZ/H
         ybrGa8X4cv19wWJBVJxJZFRzWAd0jb2uIZzPKUjuBIG70v4B/5Q1qFDXQpMq9iK3E20X
         jNJeeiTJAyUBf1DgNdZFtwg+pENIrxfdaa2TORTKJgLFTxe7ATHLrLE+U/hefUHEXAq0
         JEVFg+gUjLGEGw2WDoCA3EXpNNqKlpU+iLNspQjKEM/aIx1i9wKUWxiwUFQRDxh4TQe3
         0Ytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-id:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=UYvGqNJF8v6TgpoQZxtUrSjswsr8z7WGTtFmJ9hnHW8=;
        b=z8+O5HfOLXV642CoVyZjOBALLMUTOscAw8IK8vAzXFfIpLt8GUcxOaAyIRQbhGBMR2
         ZmJ4dqOdES0d/49SR3WirSr14Pb1sUwRawoLWRtxHioN+qCUjC4VmzrRB1s95LemObHN
         vglRQzzFmkSsJvFMcPq89vfXQmwJVWEVqiTEVayGwL8ObZSPGUWUVv4U1MC5DjMVBOSP
         gqdNuKVLwSeDW3Do/xjTaiGBzkWM2V4Lw9OrhXChru5JGNmC3LDcTI2Nr5Q/Z06lnfbI
         9ZP2cevKEtqBtTkvOSHZ6eK7U1zeZacKaW3MpIwu0MQdt/KoZulhH44VH9yAsey3CKPH
         dicQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ornl.gov header.s=p20151116 header.b=RipEBCLe;
       spf=pass (google.com: domain of atchleyes@ornl.gov designates 128.219.177.137 as permitted sender) smtp.mailfrom=atchleyes@ornl.gov;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ornl.gov
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ornl.gov header.s=p20151116 header.b=RipEBCLe;
       spf=pass (google.com: domain of atchleyes@ornl.gov designates 128.219.177.137 as permitted sender) smtp.mailfrom=atchleyes@ornl.gov;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ornl.gov
X-SG: RELAYLIST
X-IronPort-AV: E=Sophos;i="5.47,406,1515474000";
   d="scan'208";a="33641716"
From: "Atchley, Scott" <atchleyes@ornl.gov>
To: Open MPI Developers <devel@lists.open-mpi.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport
	<rppt@linux.vnet.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, "criu@openvz.org" <criu@openvz.org>,
	"gdb@sourceware.org" <gdb@sourceware.org>, "rr-dev@mozilla.org"
	<rr-dev@mozilla.org>, Arnd Bergmann <arnd@arndb.de>, Michael Kerrisk
	<mtk.manpages@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Josh Triplett
	<josh@joshtriplett.org>, Jann Horn <jannh@google.com>, Greg KH
	<gregkh@linuxfoundation.org>, Andrei Vagin <avagin@openvz.org>
Subject: Re: [OMPI devel] [PATCH v5 0/4] vm: add a syscall to map a process
 memory into a pipe
Thread-Topic: [OMPI devel] [PATCH v5 0/4] vm: add a syscall to map a process
 memory into a pipe
Thread-Index: AQHTrx77SUw08zht9EKLMPo/QSRNsaO6B1GCgADBW4A=
Date: Wed, 28 Feb 2018 23:12:03 +0000
Message-ID: <B748ED06-77CC-47F6-AA5C-0D9E2AD1BDB2@ornl.gov>
References: <1515479453-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180220164406.3ec34509376f16841dc66e34@linux-foundation.org>
 <3122ec5a-7f73-f6b4-33ea-8c10ef32e5b0@virtuozzo.com>
 <20180227021818.GA31386@altlinux.org>
 <627ac4f8-a52d-0582-0c9e-e70ea667fa7e@virtuozzo.com>
In-Reply-To: <627ac4f8-a52d-0582-0c9e-e70ea667fa7e@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3124)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [128.219.12.132]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37B81FBCB154B54D891DDE89E76BC0D1@ornl.gov>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589095397169234429?=
X-GMAIL-MSGID: =?utf-8?q?1593688222071128829?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> On Feb 28, 2018, at 2:12 AM, Pavel Emelyanov <xemul@virtuozzo.com> wrote:
>=20
> On 02/27/2018 05:18 AM, Dmitry V. Levin wrote:
>> On Mon, Feb 26, 2018 at 12:02:25PM +0300, Pavel Emelyanov wrote:
>>> On 02/21/2018 03:44 AM, Andrew Morton wrote:
>>>> On Tue,  9 Jan 2018 08:30:49 +0200 Mike Rapoport <rppt@linux.vnet.ibm.=
com> wrote:
>>>>=20
>>>>> This patches introduces new process_vmsplice system call that combine=
s
>>>>> functionality of process_vm_read and vmsplice.
>>>>=20
>>>> All seems fairly strightforward.  The big question is: do we know that
>>>> people will actually use this, and get sufficient value from it to
>>>> justify its addition?
>>>=20
>>> Yes, that's what bothers us a lot too :) I've tried to start with findi=
ng out if anyone=20
>>> used the sys_read/write_process_vm() calls, but failed :( Does anybody =
know how popular
>>> these syscalls are?
>>=20
>> Well, process_vm_readv itself is quite popular, it's used by debuggers n=
owadays,
>> see e.g.
>> $ strace -qq -esignal=3Dnone -eprocess_vm_readv strace -qq -o/dev/null c=
at /dev/null
>=20
> I see. Well, yes, this use-case will not benefit much from remote splice.=
 How about more
> interactive debug by, say, gdb? It may attach, then splice all the memory=
, then analyze
> the victim code/data w/o copying it to its address space?
>=20
> -- Pavel

I may be completely off base, but could a FUSE daemon use this to read memo=
ry from the client and dump it to a file descriptor without copying the dat=
a into the kernel?=20
