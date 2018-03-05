Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-819802-1520231247-2-5473841445902526020
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520231247; b=eLKVCC2Bm4NwWOE/5q4o8f6xyDIv1g9fus8uQ2lRVkuKmRh
    M+XhB6o2BfXxpnwA6i3bitmiQw1HTrnHFoNMm7uYiAVDyWfGEOuHMMRC8KAM9h0C
    lQ1TtkFo8b3uFuqNIYWmG8V+90H9vTUdAQi7UtGwDJ7IlxXEuP3cUCASGVe4NIrM
    fY40lG62kGgPWH5BNls85UcdkQf169cTpevUvFJRoI4FAfLFZuL0l5/HbvyxJ8Pm
    Msssrq/MHpP2D1TJ73YJilxCU1c2PGW0yv+DOLSu9hVvVoX7K0CHn9wUN7pUfAR1
    eAunqu6ciFY30cpZzGwHyTxP6jqP3mcFvqXrxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520231247; bh=T
    yuv88YtbL3BASbmxlE8+NZ9SxPpz0qenPuECg49mDM=; b=FUOlkbwfqHq8yLtnj
    82ljTM1QQLYWzsO3vg2qw7Zil4ds+mfrx2amgyJzx/fmDkmW+23gTD7blBBf7Hsb
    tcCHPgEab57fhtwBUmxgD62Rwk+qEKHGTKo+geHfAhWHsioZ2vbCV69DBh2SqzCy
    gtDn0mxy2hPwpO/Z3j1nf0L2zDAS0mTpYr+Cu4AZ8ICkqgi4nIvyKvG1FHBwJEFR
    KNJY2jYdcDwplmkS7DePgNZ8uQ4FNJiPUdsLlAxzJlexUDL+hwIQeuOAqiBDCuAn
    vZfT0AxNoFtLikdTAE53eOT+PBVZaVJPfiQRQcqbjP4G8V4aYN0YOMyUBkN5WPhe
    SOluA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 5 Mar 2018 07:27:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: Re: [PATCH] staging: irda: Replace printk() with appropriate
 net_*macro_ratelimited()
Message-ID: <20180305062719.GB13208@kroah.com>
References: <20180304223205.GA31416@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180304223205.GA31416@seema-Inspiron-15-3567>
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
Cc: devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 04:02:06AM +0530, Arushi Singhal wrote:
> Replace printk having a log level with the appropriate
> net_*macro_ratelimited.
> It's better to use actual device name as a prefix in error messages.
> Indentation is also changed, to fix the  checkpatch issue if line is not
> exceding 80 characters.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Your subject line does not match the file you are changing :(
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
