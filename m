Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1528056-1521027721-2-14270478179347857910
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521027720; b=Vs/3gDeppKCtWzzMH1a4VP6UBLBM82eNPsopRrABabhVpT3
    dn+hO/6PNHPvIbl4FdKrRIHi1U+z5tQoBFMU/dsoaMYi0hAxpTi0ZpU5JmJ23YtZ
    6vQahcAoIsVUxvR4BLDIWcTNnnzNPpqjsvJKT3icGB2CpjezPSqH/sZQluzWiG9t
    k4U4ASEbeV58kZ7e+zLUC+wqPmpYz2+txy57BJllq2fVcSUb8wl2soBSll6FYZET
    ckRA8XbXZgS4pSu/D01G0GJNDB8Dts8WKnJPYC/+Uc7va6rZgj7uj1OeJ3GfwYCM
    QDueDNwnQrSQMwKXR+eVLufr3bA4KFkJslO/qKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521027720; bh=n
    uCHdSNo72o+LedILgNGTJlP9BBH+2sReDVJAUWA3Io=; b=Er9wio9Amzc85WFks
    0T9m+fnoRQX0IcS7oDtokYGSax6qAImEx+lMHW3oP6QNGDW2lgZ6ZY6OJP9JGbOG
    1v2TbST0W+kPzTKVIyreWMgMFS0UPdx2oMDsOj+HU4FnX3DdBHV0jyCUe9lPRgHh
    +SzscWA6kqVCm114IfFtJiDBZ0yoLOCxvMAA7PkxG0tuXceReiLq1ZkLLYznyfgF
    hvCogkjyaDWepppjtZacBh4PO2BCSEUrHBbIm8WQGW9MBGyfi42kp/rH52Ol4SJI
    Cztn9VpKkQVWmBLy+dsD26G0Z+nfDdzOVZVVmqhQ6crjXwQRQDhCGyY1acPsmxnq
    0miZg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=BuljVcO5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=BuljVcO5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Sender: <xms:gQqpWgCatQyMT6TdQJxK9dRHVuHrrK7NY41KAjlJW_VmGnbCdKs2JA>
Date: Wed, 14 Mar 2018 12:41:53 +0100
From: Greg KH <greg@kroah.com>
To: Horatiu Vultur <hvultur@gmail.com>
Subject: Re: [PATCH] Fix partial warnings of checkpatch.pl for
 drivers/staging/greybus/i2c.c
Message-ID: <20180314114153.GB7169@kroah.com>
References: <1520362366-10294-1-git-send-email-hvultur@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1520362366-10294-1-git-send-email-hvultur@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 07:52:46PM +0100, Horatiu Vultur wrote:
> Fix partial warnings of checkpatch.pl for drivers/staging/greybus/i2c.c

What do you mean by "partial"?

And why did you not cc: the people that scripts/get_maintainer.pl told
you to?

Please provide a better description here in the changelog text and cc:
the correct people so they can review the patch.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
