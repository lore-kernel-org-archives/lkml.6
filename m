Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-923319-1524475110-2-11395403755669337014
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524475110; b=cmVb4ZBWyUB0vUUYo4xtxOe3XRRj4F/o5HGvZq9xUEKutOknmb
    +JFsLeaXmXDN6ddqzrV8jQoXA4qtWD3i2ZOz/rReu1mBi5E51MKLktbzolZ7auzg
    nWqLL675PpTyxCXK+xvWFmHmYBFl9TzVi/mOD7lcTFzn7R6MNdTMe/tRNA/AmHoc
    tzzDZVN2b0nlnMcquexkDQpfcrWqPldetaX//3NQJvSmnZhdGvopzGul+Z+LZu1a
    XIF/5a37n6FTuORfdrzpR9aUUu9qsPTPbKFfy+keKN3kTc8Yd2hwGmbjdQTSjKpb
    SpsTGm6VIFGY5jzdBQWfrJBYaFc4ZtmRy7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524475110; bh=7Z55l
    I4d5eEn27DTh37Jl9oYxOC1fuSlCV0He3JaUeA=; b=U2t5p1uhindf42kjwJSzj
    V53K9ZkwmeFub63xCtuGj5OhZGNZfqchzpcdHHNwFRk4Kh+Sn7rcE4uD2iY4IGms
    OgF9b7Ex53X2RlhWVz9C0YuqSzsKwkm65o06wAzWdMWvlcfc/+X7Ftj9AH070iS7
    nRglbFtq4rXaX+tpWN8I8Ed3LB+LZ+q2fRqv1UAS3CKdbBQemgW7ecdrf4OhM8uw
    GwIIBnP4GCTJFmwWmn+G8kQlmvWYyyre8jUX4tt6DfR+XvH8/nJHSuCYgMlJdbRs
    kGzajX5oL9uD/Nsxi2iH69Q0sGqB1N0lzPK6lekQqsNSrXjl5e92X47XIXF4EGeV
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=AsYBHVEZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QUDccghj;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=AsYBHVEZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QUDccghj;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKHkqM3gLNrNEw1k1W+VOv/qL65y2KRBJ/WYmKDAeH1FUV8vgQ6ZxZL1gSwO6jD7vRl/AWH4sPhSbXuW5as7Tl17n8lICCTEG3NHYeewAawniji2b/fP
    iGoJVpwyQr4Tp5Qvbf1LfMciJoRMkbAEp37MkVxrqJL6hJyxfgNjbvW/fRdoSPsSVRj7Q1BT3FsfQv3T0nqkf9Bq7yF8+SbtxotTiq4qNo0Zabpi2tkZ0di5
    y5xUZfd4uW2hW6f9D9b7fw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=DDOyTI_5AAAA:8 a=wHUY5koFTz62ROXOwQQA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZpebZnYJLv7grOgejQ1mCHUixfQ2v1YlhBNcEZ+T2GQKMPeIJCYtcFhoTkAM2vlFFE0emfSbLfhgipOloxly7Q=
MIME-Version: 1.0
In-Reply-To: <20180419213517.GA13221@gmail.com>
References: <001a113f8f14113e790568fd0c02@google.com>
 <20180419213517.GA13221@gmail.com>
From: Martijn Coenen <maco@android.com>
Date: Mon, 23 Apr 2018 11:18:19 +0200
Message-ID: <CAB0TPYGC_e9FZfDzVRQEJbjB7HfRvHZ+TUGAySzhOT3AHUUq8w@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in binder_release_work
To: Eric Biggers <ebiggers3@gmail.com>
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
Cc: "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
 Todd Kjos <tkjos@android.com>, Greg KH <gregkh@linuxfoundation.org>,
 syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
 syzbot <syzbot+0cf1f1aa154f56ff2e8d@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 11:35 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
> Martijn, this is going to be fixed by
> https://patchwork.kernel.org/patch/10312345/
> ("ANDROID: binder: prevent transactions into own process"), right?
> The syzbot bug ID in that patch is for a bug that is already closed,
> so if it's not too late you should use this one.

Yeah that should fix it. Why was it closed? I think the syzbot bug ID
I used in that patch was from the original report to LKML. Greg
mentioned the patch was already in his queue.

Thanks,
Martijn

>
> - Eric
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
