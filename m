Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-171315-1519308133-2-12800872901263313490
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519308133; b=CbHYuqz7qwQjvuyfT6XHET57Yivzw0pXVZImOhiZ7TUzpy3
    FeePOcbsT+q/d42LvU+Yoegsmom7GAzz0+sR0t1QTRgl6ujfajCxsrNP77b/yXyk
    7IAfUu0KA8cVAmkownux0y7PwuZ5LRFQhAZGJOckMYS5yJCGCu7yels1cDsSByAo
    bIJsGqtxqIETVR9Z2SxW0D57g/lZPS2VuM3gVy/KVvIgK02zxU1O3fSgWQOP9M5P
    qgZFlLh2PFJBYQCMO58KUHbgjEz/hTV8Zy/wDfFCjWIm7xEWN8T1AULf0Qa0eBwp
    p4hg8AzcyQwvGwvO8cc/XxDV7AxaJK8SdSkd7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519308133; bh=9
    Cf9btRmBIixmOKFDjGo4TnCqA/LEycmRxp0nxE/9ao=; b=nqBHoD/ifH8ByldEF
    mz3KbfTmNktP2Bz7xsNwX+lDY9A0s0JKlZz01rv9zgYf6SQ2GoSOP1REjad4Eyfa
    n3vThnjYnraKTYq+c319xuvyhjHSdvgfQDBfmAiUT+8nnfgBsHkvH5xc6u6Eoc38
    OF2lJEsllsTjrvU5f+5FPUMsCeM8CwTAqmez4ol5C3knJQMdBbpLkbwiQWP2/u2u
    WSy1zzhKEH1vCClnEd5Mq8KreNeLz0rmnwTkHk0O435TmwQOWF62FanB1SZf+TK1
    a8/hOHeT84zOSzWzYNiio684HE4GWQCAsyw0WE0wO/a40MMENERdPuisF5NoDXYd
    qIvdw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 22 Feb 2018 15:02:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH 1/2] Staging: gdm724x: Simplify the struct gdm_endian to
 a variable.
Message-ID: <20180222140208.GA17403@kroah.com>
References: <20180221104306.zq7fdbgzjmfdrqju@mwanda>
 <20180221131237.10960-1-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180221131237.10960-1-quytelda@tamalin.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
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
 linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 05:12:36AM -0800, Quytelda Kahja wrote:
> Since the testing for host endianness and in-driver conversion were
> removed in 77e8a50149a2, the gdm_endian struct contains only one member,
> and can therefore be simplified to a single u8 variable.
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>

This patch series does not apply to my tree :(
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
