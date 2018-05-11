Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3632397-1526026105-2-8185371944553186590
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526026104; b=TH65mRWfhGdMhUHZmaqQN0hxeqSedqVApRbZaQmByWqKbMkdcx
    71KZoApYRT89WHT2YLjfX4se9sSyBJFmeRMhHvBDQVrSowhz+pO3O4Awb32ie0/b
    R8xk9H8WIymwOdA9Te6Fz2Yb5p9h+krQKwy5AaTjiEpg44rXX2jZ8qB8YH7EhrWc
    VxBstkbqDrYddSNRKXscbDw/BFYiLAdWSVR7y122qODWgRgsrAuk1aWBBpk6yRne
    qdhzXYZMWQwUcIQmAKnt2OjHyajQeB07WjF8UJ9Upp7PZvnJe/Z9bIx8Qma41jM6
    JI2e+Ceq8s+NOGQK4482uM50vte4x1ZoiHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526026104; bh=ZPKSS
    xPnY5aS/ldST/5mgv3MdsDuzY1m+l5j8SR1xUk=; b=dabWrttTGLzjkb5Q519UM
    dSeLXzYBFuBYlB4yZxJoY0N8OnQozWZCsGduPPcGjYwU/2cpf3hBI63zCP32/p02
    7kbcTj0xsDI98HXR7VuyaKukJevU/75OpPfBfr3KgKZwlhcxyTpGN69nCRkKD981
    Pei4WGedVCdcupyuS/eYjv0BbT6w2RGysUxIwzrWkpUrsh2Ol0nfBA1ThVp2iGSe
    30Yrv5Mp7wrlp1t7ryUclEfNjAu6V9M/KwCPTzM/0PAm95QR1CF3L84R5vlZ8w/G
    q3oXjNphLeBcRf4gWu3Njih7/K9Onf3wpkx4xpBxBS4xnt8PK4ALVkQIYCAwru3h
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=msekUfY3 x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=msekUfY3 x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEt9sUfTXQVeqp8KnCcR2ByhOTaZCQbi2rHWVok0RrklqwHBhiUV+JRkFiu+tBlKFr3IMRNEqVIAdpFrTnYcw2Jum44NvZnflbdJCA+6d+nlT66GHU6K
    tqRMbRiLXlvr2R+jJpSrwt2YuRuwBdkNZ/Ehzt/PnKepk5h/0Uf2Z8W3pko/BDc+dW5qsymyozgStfk+V1iEI36OZhkv/xYFnXOw5O6DpX2/Dbk2y6SyFlVx
    78gCXhkdCf5f53syZ792bQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=DDOyTI_5AAAA:8
    a=oB94jDWfNX5zfG3FFZQA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 11 May 2018 10:08:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Martijn Coenen <maco@android.com>
Subject: Re: [PATCH] ANDROID: binder: remove 32-bit binder interface.
Message-ID: <20180511080801.GC3258@kroah.com>
References: <20180504195728.72932-1-maco@android.com>
 <201805060540.zjwonWcp%fengguang.wu@intel.com>
 <CAB0TPYG-Q6Ki_FMM1u+i_g+0ykQgeUTRpm00qycAUVQOqVH6eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAB0TPYG-Q6Ki_FMM1u+i_g+0ykQgeUTRpm00qycAUVQOqVH6eQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
 Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
 Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
 Martijn Coenen <maco@google.com>, John Stultz <john.stultz@linaro.org>,
 kbuild-all@01.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 09:57:52AM +0200, Martijn Coenen wrote:
> On Sat, May 5, 2018 at 2:10 PM, kbuild test robot <lkp@intel.com> wrote:
> >    drivers/android/binder.o: In function `binder_thread_write':
> >>> binder.c:(.text+0x6a16): undefined reference to `__get_user_bad'
> 
> Looks like m68k doesn't support 64-bit get_user(). I could just have
> binder depend on !CONFIG_M68K, but there may be other architectures
> still that don't support this. Another alternative would be to
> whitelist the architectures Android supports - eg arm, arm64, x86,
> x86_64. But I'm not sure if arch-limited drivers are considered bad
> form. Does anybody have suggestions for how to deal with this?

I think using !CONFIG_M68K is a good start.  We can blacklist any other
arch that doesn't support this, and that list should be small as I doubt
any new ones will be added without this support.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
