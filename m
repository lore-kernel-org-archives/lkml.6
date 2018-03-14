Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1630703-1521030089-2-8148249901225648360
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  FROM_MISSP_FREEMAIL 1.483, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521030087; b=TnG5nbJiske6/eWc0eDfecVnYUiipLa3rp1+gAdsgpwJZrF
    /r1AuYXAQOX5pxdtxT9sju8kvBysh7Al03aCjMJS/y99adL1QNylOAOUczKt66MU
    QwqqoeYBtsEAl6riTNm4qh6lddt5Z1FkJlfC/7vkg9mWH0hxX2gyq6ndUuPBMTFD
    cIKOkWy2FNMFXYx6yEILqJBNRYAsL54NDdwkNEigOUg6zKH22Sg9HiJzR5I4owCS
    q1sgrp1hCBY/zl6XQOuPi1jucQ+qER940RdQJexnEsbHuh4+YEvo6mSWJwJnNTQZ
    WOil9PbGN1DX8Fi/VH7/yAB3FdRL3z4pqGOsHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:date:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521030087; bh=E
    WXZaqJD1Vsb71CZwXgalVBtpk85ApovFM99hXLolI8=; b=w92ouvy1ZkYOFvmuR
    Hp6qis7n63LIbNgohCVD/XWoEme1q61SVLdUBMr69Ff4blpTPb1rPfoVWWRO4Ihl
    CCJkERuG3sv0YzYpKEhzJP3l0cyZdT8eeiRuM+OVF8S7MqTc0iIY/LmQoelAo7mv
    YcRbzSwYMvwFjEdCD2zgj8QCgwwSuZaZ8Tnb8d76F6qFQLKXwZFmNW6QYV9m8BH1
    ONHc2Kdmpy29QVP6K0B8k4+y3g8413DAZNZH0tfJM16aWAPAym2CpR0OeHlWixEq
    uP9/Y69yV+ytK8RSODWMnD46HrDe9JDNq6IOmGMJ3g1dSHzoeLEi1roKckBYxHDN
    GMKlw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DzRg+9hh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TBNcsxrK;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DzRg+9hh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TBNcsxrK;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELusRJnfxRaE1NtSeRJsTBYa4AuZnYuFD4MW83JWyAUJXs/G32bbBXlfjo1nzSrbSLysx/1jhw==
From: "<Hariprasath Elango>" <hariprasath.elango@gmail.com>
X-Google-Original-From: "<Hariprasath Elango>" <hariprasath.elango>
Date: Wed, 14 Mar 2018 17:51:07 +0530
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: wilc1000: use kmemdup to replace kmalloc/memcpy
Message-ID: <20180314122107.GA10753@hariprasath>
References: <20180313124932.15038-1-hariprasath.elango@gmail.com>
 <20180314113818.GA7169@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180314113818.GA7169@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: devel@driverdev.osuosl.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, hariprasath.elango@gmail.com,
 ganesh.krishna@microchip.com, aditya.shankar@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 12:38:18PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 13, 2018 at 06:19:32PM +0530, hariprasath.elango@gmail.com wrote:
> > From: HariPrasath Elango <hariprasath.elango@gmail.com>
> > 
> > kmalloc followed by memcpy can be replaced by kmemdup.Also added the
> > related error handling part
> > 
> > Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>
> > ---
> >  drivers/staging/wilc1000/host_interface.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> You have sent at least 8 patches for this driver over the past day, yet
> I have no idea what order to apply these in at all.
> 
> Please resend them all as a proper patch series, numbered so I have a
> clue as to what order to apply them in.  Also preserve the acks/reviews
> that others have provided so they don't have to provide that again.
> 
> thanks,
> 
> greg k-h

Hi Greg, thanks. Yes I will send a patchset to make things easier for
you keeping in tact the review history

regards,
hari prasath
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
