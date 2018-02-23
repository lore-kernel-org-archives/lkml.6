Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1550584-1519348583-5-8407550254372935075
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519348583; b=uVxGckxjkovxE/4g4XtbmR20OJZRePcF2stGI0Ir4SieRiU
    JpkHSmpc3KMfjH/ntnJkIgDnWscOp10sYT/9tMlqDUKROoduv1UrA8q8kMWCLvww
    KPWyYkdiiBVpdFzDH3AyEMju/Iya21q1fmtUS9QCG2zdxB+OST/a3MIObUy/vvEf
    pK8Pu6fBGm/nMJfQfojJoRJnAWLs0aD5cxEzCWemMbUQ0nFILA1egyuQ2ZHzKilG
    auG0WDIur6LCLIcZLE6Li8iwBX2eIB2kta9Sg3axoROUDW1QRlDfzmjMOEZf2FCb
    WZiPrDNGlK+5clm2lUVPSC/D1lAVriw3/xFJAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519348583; bh=m
    WqAs6X38LUmbn1VxmMGrNuS8nMiVrjnRWgjswP31hQ=; b=W3xMk2I1kkBx9cnG5
    bisHSjLu10SrklT57ti09Jn5Z7LtWlJ35Y6GE9SGOuBa8ftjzl5DAH7BXL4P1Nk7
    z+Vu9Q8KMZVhR66pCYoTrCuvdXAn26Hc2s0nyNV9lX9MEfBE+5MaDrlQDDhccBRR
    Xn/uKKkNjZVPoO39FyXWjC7KihuPeTAOBvxCBEifJVYln8PpSbgzwe3LjLuOjvBx
    mQqqXp1Yfa4VLmJUqI2WRXo9elC1K93uQ1PJZb6gYFvaDoG+D2tttJHHl0oJyAAG
    6JzyqwrypTTYrFeTJH5wGFfi2XPDVDkEKaPPo08ovN5YGLZu+sviWgMSuMC68M8a
    Yg2XQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tamalin.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tamalin.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x226bFzynrY+ZGWg8p44fEjwrGuYOShh/fsK8+BsiLOnZQ60PfZyv1PiRfZMydFVXc3NBAr6FSpV1GSErzJ4hsFc=
MIME-Version: 1.0
In-Reply-To: <20180222140208.GA17403@kroah.com>
References: <20180221104306.zq7fdbgzjmfdrqju@mwanda>
 <20180221131237.10960-1-quytelda@tamalin.org>
 <20180222140208.GA17403@kroah.com>
From: Quytelda Kahja <quytelda@tamalin.org>
Date: Thu, 22 Feb 2018 17:16:13 -0800
X-Gmail-Original-Message-ID: <CAFLvi22mENRoFd3Z6=a5tAcbiOGw3CCnvJy_7N4u783_k3jH5g@mail.gmail.com>
Message-ID: <CAFLvi22mENRoFd3Z6=a5tAcbiOGw3CCnvJy_7N4u783_k3jH5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] Staging: gdm724x: Simplify the struct gdm_endian to a
 variable.
To: Greg KH <gregkh@linuxfoundation.org>
X-Provags-ID: V03:K0:7ztLmR/ZWKoLpsFjcT1DvqmvYPHgLH0tVRv1LUkUXZynZ6brQj7
 9L4h2+5wTr/lIp2CQfvqb/oh+RUJxXWKgJ6qE70lyfTlPoQRIkjPcWXliTgVfhgdaoLRJ+l
 sjxnqGPRYMTh4KLH7IdGz7mO2NTr+6B4mI9OUrBAi99D1UgcQCTIukvLCx62EHMJfha3US7
 MYEmeI1gtHYoZ9uli7Ljg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0ARcWuQwZlY=:iwUhwzd4PCKCl/2xbobLnM
 L7mWwWpidBr6wWpd4t2CaGFNzh3ws33qJmssvPQlh0AiB1b+hfKMZXDtcATBom55Lv76Xn8XJ
 gPQx0E5ZDoJ3dARHKBUdyTVAtDzoj7TEtNtcw+qQQep0v3iput81mp3x5z17u62Ra2DikD5TL
 EHMXJvywybF/ROk+4Pn/WonhqlRP+eL5wI/RojqUCcx/bLIHCAa76SvBVzZ9hF3MIt8B9tunm
 Rq8TiwoGB/kNEdbTmW5ItIHhDx9O7hajGHYsUetNsZANQ8grn6AnW5pEow6YiT6+lmN5LDOPN
 XgL722kC09wwZS7EV7Pix00e5tNRAyWXm7Q7ZO8L4ripHaOxkPNIG24M3BGduzysDSPfk2OMM
 U0vbSoeHVqiYF6tGiY8xyCQdDLhAEvBd5lJsqCBrmn5cH2NNMAjTA31tbVGqpxUQTvJzHHKn3
 rgCQ3VYYaTJrJ52WuEBlER7JAhQNWS9FgVnspJdXaOqPEBSmmDjy9O/5tGfz1z2kuvVCKNmRq
 y8+q/dUeJ5SsKIWDSqJkYIhTUiPPZe+D6a8q6a6HcWRM/ZKGS8hPEKmemEUg6yTdCxhJu3xpk
 3bP8sWP46TLa5OPRaTE6zZ/NiJW3K6zEijTwul2FWUvvxpNQcvRdTZDBdW6SsVOpFYl0hFT6k
 cKKaNDMpsmEtSOUXFNQ4PGolahRsDmyKq2sw6RXisbv7w0N/mUp4Sa2FldjFsfKOiThKueRPR
 zHreFquq7lHq3knruTySpQAut4jqisgW/rIdVgKh7/Kf6vTnq7Vw2ovwaZw=
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
Cc: devel@driverdev.osuosl.org, deanahn@gctsemi.com, jonathankim@gctsemi.com,
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sorry, it depends on the several patches I submitted earlier in that
email thread, since they were in response to several suggestions for
earlier patches.  I will resend all of the patches in that thread as a
consecutive patch series in response to this email to minimize
confusion.

Thank you,
Quytelda Kahja

On Thu, Feb 22, 2018 at 6:02 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Feb 21, 2018 at 05:12:36AM -0800, Quytelda Kahja wrote:
>> Since the testing for host endianness and in-driver conversion were
>> removed in 77e8a50149a2, the gdm_endian struct contains only one member,
>> and can therefore be simplified to a single u8 variable.
>>
>> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
>
> This patch series does not apply to my tree :(
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
