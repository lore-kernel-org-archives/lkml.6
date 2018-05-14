Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-837036-1526306429-2-7522225923314694431
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526306428; b=jWMoY+OqdC4YLh7NU0Gfo5Ad5OO5p3z/IF4MBOjjfGSwfJnv4f
    gKhV4cYL/0I9idQFDB+4vHFahj+wMvlS7x61m7mGsGkdXyfABcODOe6vJpiENy36
    R1XKSZpYl1fmGJAISeNV1sFlhJ42Fp6WJ76mK5EO+cJCUU91VgBtpG1i3IPqpObh
    sdTsnXtZhuVYd6DogUFmVS5X7hJ3Mwla97Rl+j3YPmGzmoZE6Hl45qiEtDqc+nJS
    Z62Nd6FLIu0pmCgud0R+BbabayWPSPK10q3/gG7uQeQYggRost/NP+vJcsbQ8lnG
    i0hK+Z4kUDVNaqnUG9Ta4GRg2XOGXKhbi6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526306428; bh=+/Ius
    cvF29l5cTDv4D6KaaVA6DAKEfIHSf3h0YfDueM=; b=ja0/kmCBriwSvOsmrSNhN
    cQkrGoLUt7xPK+L7WqrlTqH6BPuL17tgh+u4xy+nQ7PeZurDk8nvBpHxV2/TtqdY
    ujG2OvZdzoVg3jpNHraGU4YgeI+5ic9SRKLkqnCE+yqDluRTznjBrmLEFIXfii1X
    XGwxQkKd7D00b7bOPhHwFLHVmUrqzPYAHBpa55LWfPZHE5MaMZ5ITuXqpYUSXv3y
    ygVZlTmdVbUHnVrF3vvGe43O084pFTQe3VNz5qoiebDmdEcrp5To0AGMGh8JYxaR
    /hxjY3PhJFHrfdJ942D0fC5FKIuQELaqYtkPQo2liNtOapJrpOH8ixBlUDj7Jawo
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=Shfel975 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=gyk11yI+;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=Shfel975 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=gyk11yI+;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linux-m68k.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFaCzGI9PJlK9j38BgWowSWdrvLfi1EJh6JpNiXfMNmn55MYRdwIIXnqToZHGqpWbhBJHqgYbkGyts8N/G1awoWMaRg1q7IANGNrzTzvTjhPAESzULRw
    qkVPYyn0i/zOCudosJson7eNwdDfj5TfHFVh5+ExuK2wx41D5sErpoG0dWTvF2rYyB8HeyC/sevXlK8HX657sTPQ9poYR1n6OP2D1YYbBsWayfQecT2031ZK
    6y4g4I+iNXbJe5jTkO5jrA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=JfrnYn6hAAAA:8 a=QyXUC8HyAAAA:8
    a=tBb2bbeoAAAA:8 a=DDOyTI_5AAAA:8 a=nh_LVQl3oKaPZXWo1lQA:9 a=CjuIK1q_8ugA:10
    a=1CNFftbPRP8L7MoqJWF3:22 a=Oj-tNtZlA1e06AYgeCfH:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpjgH7j1+mX1Hdo7hxpgXGRbw6KGIEFhzSA7FK1rHHjboXpZfWasynQYdbt3SBGqvjflkrc3N7hkJ1I4ZDMXjM=
MIME-Version: 1.0
In-Reply-To: <20180514120338.GA5265@infradead.org>
References: <20180504195728.72932-1-maco@android.com>
 <201805060540.zjwonWcp%fengguang.wu@intel.com>
 <CAB0TPYG-Q6Ki_FMM1u+i_g+0ykQgeUTRpm00qycAUVQOqVH6eQ@mail.gmail.com>
 <20180514120338.GA5265@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 May 2018 16:00:19 +0200
X-Google-Sender-Auth: XCJ7KbOcuUA30kSkvstCm58Ji-A
Message-ID: <CAMuHMdW0nxOmq7gjJiySg0fho2XDYkyrCgp88OOuULRLH+jt6w@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binder: remove 32-bit binder interface.
To: Christoph Hellwig <hch@infradead.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Amit Pundir <amit.pundir@linaro.org>,
 "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Greg KH <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
 Martijn Coenen <maco@google.com>, John Stultz <john.stultz@linaro.org>,
 kbuild-all@01.org, Linux-Arch <linux-arch@vger.kernel.org>,
 Martijn Coenen <maco@android.com>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Christoph,

On Mon, May 14, 2018 at 2:03 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, May 11, 2018 at 09:57:52AM +0200, Martijn Coenen wrote:
>> On Sat, May 5, 2018 at 2:10 PM, kbuild test robot <lkp@intel.com> wrote:
>> >    drivers/android/binder.o: In function `binder_thread_write':
>> >>> binder.c:(.text+0x6a16): undefined reference to `__get_user_bad'
>>
>> Looks like m68k doesn't support 64-bit get_user(). I could just have
>> binder depend on !CONFIG_M68K, but there may be other architectures
>> still that don't support this. Another alternative would be to
>> whitelist the architectures Android supports - eg arm, arm64, x86,
>> x86_64. But I'm not sure if arch-limited drivers are considered bad
>> form. Does anybody have suggestions for how to deal with this?
>
> The proper fix is to just support 640bit get/put_user on m68k instead

I hope we'll never need 640bit support in {get,put}_user() ;-)

> of working around this.

Patch sent.

BTW, sh also doesn't seem to have 64-bit get_user().
There may be others.

BTW2, does the Android Binder need to care about endianness when talking
to userspace?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
