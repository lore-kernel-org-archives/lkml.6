Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3370786-1519795997-2-15930481536987853371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519795997; b=ec70uLigswUelfwH2t9OU95tt2z9tEI02KCwSyZUoxSLITk
    2K5TAq+xBBjXcVoDCWHFJdESRbP7K7Pfy+0w2SLZBtb8FXFJvYMVjGHuaPXpm/ZV
    TYh+lprNoo+Yv9qzEhp+9PZx/Ejvro47ab0FnU+bthuLshLIri0j8Kh8oTRc9llB
    S+V4SmrtELhD1IMFCyA1VgPGKX2zIzfvq13j8ZGNA2cwTxmyef1MIIOcT+eow4pg
    7nv5XqxPle7E9Q2StLoTlx31WqlLiIcLXFo47sJdtYITgBaou/i9XmfakrIQH6Ey
    E8TYRNp7tXJX7Ong8JGAjwwIL/qjiiPq47bIH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1519795997; bh=r8T6LJH8ZYHMIklJGLsF9TmvgvSVZRJZ1BnUmBxGZ6s=; b=r
    RrYRcDOpWcI0k3DEIZwJ1+4Uneul4xRg2M7rhgteRLFonFGl9aljmMdYT2YP7f5N
    p09E38e3q23/W8QLM86Z4Ruiq/1/WqrZLGzoykH1mm1r+qoPW+padulwQ2UIpzIj
    JdxYpuUj0GQknMruKBhheLPkIxQTFzfbLGMOWuJRt6x940Hu1bI2Wv8xovq/EwMn
    ErU7U8LqTA88lqTkbQncbLQcTvLxMZISdVjPWsF4xK25fHXH/Ps3TQZI8hmR6XvJ
    AAU42V03lgguel7dHMVTihwoyaiaPCZ6Xxchv0bLXiFBD1J2v9x3uuw3wu4QryWO
    fpOloVeWUH3AajWMzutQw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=B04puYWR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tCLyzibg;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=B04puYWR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tCLyzibg;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELsTbyAsTl/KWnUFtjf+S/KjrBak+R/Jn4avA7omqVRGQaJpk95gbX7hzF12I3MfkK0Mu4Epkw==
Subject: Re: [PATCH] staging:r8188eu: use lib80211 CCMP decrypt
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20180223145742.25783-1-insafonov@gmail.com>
 <20180226075625.kcksm35y4clqvi5l@mwanda>
From: Ivan Safonov <insafonov@gmail.com>
Message-ID: <f1c692e8-7d51-4be1-6db5-8067ff8d0151@gmail.com>
Date: Wed, 28 Feb 2018 08:33:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226075625.kcksm35y4clqvi5l@mwanda>
Content-Language: en-US
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Janani Sankara Babu <jananis37@gmail.com>, linux-kernel@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/26/2018 10:56 AM, Dan Carpenter wrote:
> On Fri, Feb 23, 2018 at 05:57:42PM +0300, Ivan Safonov wrote:
>> Custom AES decrypt implementation replaced with lib80211 library.
>>
>> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
> 
> The new code looks like original RTL code (really bad) so I'm guessing
> you copy and pasted the code from somewhere else?
Unfortunately, your assumption is wrong. Rather, bad code is created 
because I'm not a good programmer =).

Seriously, after each patch the driver gets better, does not it?

> 
> The idea is good, but RTL code is painful to look at.
The basic idea is to replace a _small_ (or trivial) parts of the 
program, because I can not test my patches.

> 
> regards,
> dan carpenter
> 

Ivan Safonov.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
