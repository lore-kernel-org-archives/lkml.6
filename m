Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4174165-1517505034-2-9589395696164824335
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517505033; b=QXqCJAOo1E7LJdSGpT1z/OkE+V56SvULibB1UWFslVkKWo+
    WbZK8vVN/Io2rqwJDQpxuWXz6Y1UmIfsb/IMuicEOnQjA+QwHTNF/aIOqI+rRGza
    RSNrdfgHCEcukLg1w8WApyrPeZTtlNSnq7K1jyE94GKETCsBEP/qU9yfF6ZNdsyw
    nOp3K6YHV+Ot5oA17VZKOp1fzRC58ZMQnEeXMKPY17T1wxQTgbugdoHlVOhofo5u
    SG0AA0tEkPJKpVGVAJyOVfVfewWv+Tleqa6vJR3/Sh9YuOj5uWHkpc5nLERJfGWH
    2sJ3q3alds3JvvRj7hK9rPnHe4Tesnu1sK7z9Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1517505033; bh=M
    Dg7pgFoS6XHrOLw5wYDlQwwhT0U/FSQDd1Efmw4QJg=; b=LYyivhSzI9svyT9YU
    MNC2GXpNLMbdur8cL543fit/e5uk89T3egMle00KBEKjq1lowazEizAmg8lpeGjh
    1OT+7aHON1EAaXRVH7CYtUqZb/W/OcD1Ynwmk6QtVq60yeatgJczIa1R0AEi89wA
    mRfgwCFa8WvBOqO1G8TnyyKVeBT94NvMzRioCwm6aOETR303+XaR7U1GOONqr58y
    svptGzYK5WxnI6VCuBhKNafmJcZyirPvMIuJfV9diDYMKljgGl0pssysJtTOnZVQ
    Gyfx7zqqx6MdMhxw51PTu3LXUo8gdrC3X9SbMZHXnikfvYyJpos86ZfDiQNMUjZQ
    zXQ1A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=KAtgsMMs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=KAtgsMMs x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w11HAEXK021807
X-Nifty-SrcIP: [209.85.217.180]
X-Google-Smtp-Source: AH8x2265ym87kfJDVAAxuSgr5BF3dqS3eKgQRaB42zfCbLxbXQc5VysQTLib6zbvolB2iJP1L83iBkxprpKazt0P6Pg=
MIME-Version: 1.0
In-Reply-To: <20180131093434.20050-5-ulfalizer@gmail.com>
References: <20180131093434.20050-1-ulfalizer@gmail.com>
 <20180131093434.20050-5-ulfalizer@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 2 Feb 2018 02:09:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ-R2w=JH6aEPvwK=c02iOJ3xjwHk6bfkckKo+kgKYpRw@mail.gmail.com>
Message-ID: <CAK7LNAQ-R2w=JH6aEPvwK=c02iOJ3xjwHk6bfkckKo+kgKYpRw@mail.gmail.com>
Subject: Re: [PATCH 04/11] Staging: rtl8192u: kconfig: Remove blank help text
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
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
