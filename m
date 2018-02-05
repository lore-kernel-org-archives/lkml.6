Return-Path: <kernelnewbies-bounces@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-2984760-1517850465-2-14445207734477873396
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517850464; b=eNosh3u2vBoL6a7/93lej97x9EpONcXA1gZxv7WiRLPofe+
    FBdzWYjaDLJPpgo7cpa0uXxXMtZn3r3zoRtXQLs5ah9KtlnxpoPmsVGfOCpvldzX
    5qVu0MMM7ENrxlf6RGc1MpKVN2Ra3b+nGW5ReRjGpf6GdcK6eavI2fwHw8CMqozo
    hoBdJyjFLxp0c6gu1aVzBG3AR007Iltvh1b6xW7Xv5UNHie2sZfiSkKz+eAyd+kI
    gDbUha4gRQxTH3P/d5Fps3Lh8M0eqFhlhI7MyF0wpBDExCiyZ3RPa+H3+bNyy2NM
    /fQtykYr2Blu00RoXloL2b9umULRSAFthAAQjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding; s=arctest; t=1517850464; bh=jDpy2voK
    Dqk/x5MV0sv+5Ul5dbuw5DWgYSsdYCSuThY=; b=XVM2u8nAnzg8sryxhbNh2N3G
    BJ61B+saA/k6vLeHGZeXVXQP9UgOaMVWKUfVJthnw9lhIm4NjRDog6USEcvoXtPT
    1sSwNwx/N45bh8s4rfhD6u7uroZTZPdrYIl46C8fpFaTFOcaPVJqNZaCWW9l/ixR
    XNXgYhg1StRcuSrViC/zat6xvzEIqRAtyOGkDkdsNWfUnQAk5wBYd5eiV38oYG7M
    vNrkrx/mcFajXH30+D0I6kBUK45RGwIPejo9XGenszHWLVQB8PF44eT6/ZtGRbjb
    xjAViMQZ9JlNQGIw3GlWCcs8BoC7Y0zHcGuc6a4sPSM0RWm9BzWwX/a0conm5w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=X/Xmcrs2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uTfbG3MA;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=X/Xmcrs2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=uTfbG3MA;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x2250c400VHUXYr0EUsYwoxENhQXhNAPr7iiEnwFGC9ZsqxWpmOkh9dmQUfCXHsvGMgJknMFv7CbtN9KRivWvOo8=
MIME-Version: 1.0
In-Reply-To: <20180205225402.f0b2448650763bc5cb8099a8@kernel.org>
References: <CAOuPNLiVQEroimgO1jhSdbyPAUvBtpA5-qscBY3N1yoNYpa82Q@mail.gmail.com>
 <CAOuPNLiropE67OWuh3mWzzN3q-8+UivKuNT+PU51aDoQwrJjNw@mail.gmail.com>
 <20180203221935.bd3036aba7637a4de391a20e@kernel.org>
 <CAOuPNLgnazHNKoMozZq7Ef=rEwRG=rwktsnp8jCKCD0gMH+hbg@mail.gmail.com>
 <20180205225402.f0b2448650763bc5cb8099a8@kernel.org>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Mon, 5 Feb 2018 22:36:26 +0530
Message-ID: <CAOuPNLjsj+ocT9TO6H-nAe5FDG+mMVUuGehYybxaToMzLQHLYw@mail.gmail.com>
Subject: Re: [perf] perf test BPF fails on 4.9.20
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Wangnan \(F\)" <wangnan0@huawei.com>,
 Alexis Berlemont <alexis.berlemont@gmail.com>, daniel@iogearbox.net,
 kernelnewbies@kernelnewbies.org, alexander.shishkin@linux.intel.com,
 linux-kernel@vger.kernel.org, acme@redhat.com, peterz@infradead.org,
 mingo@redhat.com, huawei.libin@huawei.com, naveen.n.rao@linux.vnet.ibm.com,
 quentin.monnet@netronome.com, maddy@linux.vnet.ibm.com, davem@davemloft.net
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kernelnewbies-bounces@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 5, 2018 at 7:24 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Mon, 5 Feb 2018 15:17:41 +0530
> Pintu Kumar <pintu.ping@gmail.com> wrote:
>
>> On Sat, Feb 3, 2018 at 6:49 PM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>> > Hi Pintu,
>> >
>> > On Fri, 2 Feb 2018 19:03:30 +0530
>> > Pintu Kumar <pintu.ping@gmail.com> wrote:
>> >
>> >> Hi All,
>> >>
>> >> I have fixed both the issue with perf test.
>> >>
>> >> 1) 16: Try 'import perf' in python, checking link problems      : FAILED!
>> >> To fix this issue, I have to install:
>> >> pip install --upgrade pip
>> >> pip2.7 install perf
>> >>
>> >> 2) 37.2: Test BPF prologue generation                           : FAILED!
>> >> To fix this issue I had to enable full version of CONFIG_DEBUG_INFO in kernel.
>> >>
>> >> Now, my question is:
>> >> Is it possible to pass BPF test without enabling CONFIG_DEBUG_INFO in kernel ?
>> >
>> > It depends on what BPF test does, but it seems to access local vars. This means
>> > you need to enable CONFIG_DEBUG_INFO. With debuginfo we can find the assignment
>> > of register/stack for each local variable.
>> >
>>
>> OK. Thank you so much for your reply.
>> I think we don't need BPF test at this time.
>> Is it possible to disable/skip it ?
>
> It depends on what you want to do with perf. If you don't use BPF, yes, you can
> skip it :)
>

Yes I want to skip the BPF.
What is the best way to skip it.

I found out that by commenting 'bpf' under :
tools/build/Makefile.feature -> FEATURE_TESTS_BASIC,
I can turn BPF feature OFF during compilation.
However, I still need to execute BPF test and check, if it skips.

Is this good enough ?




> Thank you,
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
