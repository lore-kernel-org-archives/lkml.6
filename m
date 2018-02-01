Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4154219-1517505061-2-18059495396695601967
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517505061; b=w+R5XU+oG7303XkXs39wZf+SMfkEzcUy7IyGvt3g/tl0b95
    DupJ1vx1jCbiyxYqppesuzcCF1FeP55ir/SDb/qLPLNC3FRc2AysSOm+RvDNG3eA
    ETcemhchaE8TGV2/JbyBcxyovzphnmo0z9ca4rV0YWwuBThHULTBztW6JP7CGnHR
    jxHFs26eB3bCX0KFrQZ1g593FNYd+fUuI/+xjqLaGCN6cQwcxuBT6gC2A/J/MB2w
    AAMPO3fCyMISvPHm+UIJO1CNxjJ8O9OXohUSH0IV5sQWsX2VFXa63e7RR2lKUo5k
    aFnAp+9bKfBoU9jJAbpK+6aOQPTGebsEKtvRGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517505061; bh=N
    ATbnzcHy/OTBD9b9SC7AJpxPEnUNxgKpts0nZgD6Gs=; b=BtIYvNc5kQv7NnHUC
    oNdYTTa0GXWYXOl2rRIcT+cUsyGisDq5leD+LkdNWnfbYDcCLnSL1qWjRv8xqYba
    pJ8bgSWBMK7yBc+21zqw6rTss3/iHwjGb18B/g71YZ9aZyFUKU5oAw6//Bb2l05a
    Z6QkhodtqYqAE8PHO6GQGkLfbZwd+Z7F5fqyGTW0UlYdkpkvZNAcQotEQ+UgyE0V
    1zqgi3fbxcwtcxRow3B5nLEL6eOtlxeXxU0/dkHL52yrqVW8jxGchrOB9IuHXYj4
    zQy4LldSTs4mMM+4x6q91+MGUB4+x86pt+cAl6fbdBZFhCvNgpfatYY83Lx3LE2u
    u3ZeQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=GEDzPFpl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=GEDzPFpl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w11HAbdc025880
X-Nifty-SrcIP: [209.85.217.175]
X-Google-Smtp-Source: AH8x224ny6jt9GQGUnvlA7f921h83fOiAJmCIXd0vEApcl65QoBhyvHy9W/zPcyiONJFTSdnR0jjWRzWsNOxBLguSR4=
MIME-Version: 1.0
In-Reply-To: <20180131093434.20050-6-ulfalizer@gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com>
 <20180131093434.20050-6-ulfalizer@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 2 Feb 2018 02:09:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZkYpxY62ku1+6s_pL_yNjGJOT=mRNjXVE5eRUunWG+A@mail.gmail.com>
Message-ID: <CAK7LNARZkYpxY62ku1+6s_pL_yNjGJOT=mRNjXVE5eRUunWG+A@mail.gmail.com>
Subject: Re: [PATCH 05/11] Staging: rtl8192e: kconfig: Remove blank help text
To: Ulf Magnusson <ulfalizer@gmail.com>
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
Cc: devel@driverdev.osuosl.org, Paul Bolle <pebolle@tiscali.nl>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Luis R. Rodriguez" <mcgrof@kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-01-31 18:34 GMT+09:00 Ulf Magnusson <ulfalizer@gmail.com>:
> Blank help texts are probably either a typo, a Kconfig misunderstanding,
> or some kind of half-committing to adding a help text (in which case a
> TODO comment would be clearer, if the help text really can't be added
> right away).
>
> Best to remove them, IMO.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---


FYI.

I picked up this patch to kbuild
because I need this to suppress warning messages
introduced by 11/11.

I am planning to send a PR for this series next week.




-- 
Best Regards
Masahiro Yamada
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
