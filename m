Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1717850-1521165240-2-516678799211245689
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES caenda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521165239; b=aXr9ykYx2AZswa7kyFSjEvOTelTsYtumOhoQzD9VJFqeD0F
    69Zptg95nRYqg+QZvSQUTcFD3fOFUC8If/KHHJA/yBevElnu0yjxd1ek02/78wKp
    4DZ74fxPn1KQDhVutp3CIXR3uLNLWaN6iQWRA0sZppVV8/ca3z1b+45qFMJhBKSp
    /804y1vAq2PG6c3QQqIsbyRmIly6RZFwvDfk9zIqBdVZspyDpH647dUwFsbHOM/n
    7+z2b8qvMONDdmB95BlsjqJPfWip1wEUH/b1+9+C4ZDynUSOAHxtyMhn3rKDgYhI
    bD1YvdnGfiLYKv7HnbIZMb7quB4UbhsQRD/4WNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521165239; bh=Z
    TUFI7oE5rzLTZ6/Gb6zYQ2GTe5LQhN0frViabc2J/s=; b=pqhJhX7p0blZBiDA2
    MZH3Fn0rncdrRuTfAc0N61S+JNSO+cNptn1uRkvUOVo59afQ7umtBfeYSt+q6Vak
    9V/9cPs/d4eSVzsrF8uyCoKNSZ+W/kB1ltKW70Jw04F5+xQ+xDNnkQNoZe94XFTf
    o9IoQXSPJlcOf08SmlPUXLRgg4P7qBYnKks2Co8NlgLlz7PFv5G9hC8JGYNvkOvY
    bcUzr0z7qzhlWqzIshoMyVdTL43E/uFB7SAn2h8shMD8xBGbqFrBEHjnq2p0zRFS
    b+wNLKWYScdNcOgLQBhHmQ+7ynPJ8pfkqVNqRHRs9qPAmS29pX9NeESlCDAXdp2J
    N8TiA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=AjW0jrQe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZyQY26og;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b=AjW0jrQe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=networkplumber.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ZyQY26og;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=networkplumber.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvGxnpvLPOE0BDDNW/i2ssBUPlYkVURrNAf/2cPzzztUVYKn3Nq9haX77V7M4ji37GI5a2/WQ==
Date: Thu, 15 Mar 2018 18:53:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@exchange.microsoft.com>
Subject: Re: [PATCH] storvsc: Set up correct queue depth values for IDE devices
Message-ID: <20180315185342.6190f1e9@xeon-e3>
In-Reply-To: <20180315235223.19844-1-longli@exchange.microsoft.com>
References: <20180315235223.19844-1-longli@exchange.microsoft.com>
MIME-Version: 1.0
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "James E . J . Bottomley" <JBottomley@odin.com>, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 15 Mar 2018 16:52:23 -0700
Long Li <longli@exchange.microsoft.com> wrote:

> From: Long Li <longli@microsoft.com>
> 
> Unlike SCSI and FC, we don't use multiple channels for IDE. So set queue depth
> correctly for IDE.
> 
> Also set the correct cmd_per_lun for all devices.
> 
> Signed-off-by: Long Li <longli@microsoft.com>

Looks correct.
Acked-by: Stephen Hemminger <sthemmin@microsoft.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
