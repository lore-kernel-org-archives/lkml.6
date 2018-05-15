Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2259651-1526369918-2-5340506925665486962
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526369918; b=OPJgcP+AA2/MMs8EXEIqPgJ7BKH0ACyiOILh9vQY/uCB8uLfKj
    hq3dDGXYhC572qho0zullW7WVQhAWS5WNUYLXydgtgT8eb8YSl/oncTcKZTtooQN
    8+7MpdZHks5bZq9T1jknQyNnPTRpfGDUKDHltx8R3mfzCi39bQesdKpY+1cJDdZH
    xWZHXLFfK8ZNzCVcdCoOq9HEx/Tju9VISn95Fh70nx5mqYP3xp2IrPEBO/UioJQb
    nGesf2Qjb5jQkgiDqBSsyJ0rcuXwpLizF51qrRb0XFsXaUD8V9g3jfPsugTRxD7A
    Sc5ymgTqvjFopigFDSBPGzUG2RTYsuW1RkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526369918; bh=fFaf3
    Yg2ShJvSSLhX0nn5ZoDm2TCe3G/l1LGOdYGzks=; b=UNEF8c48NFeWQlOwzuXg2
    I/Z6vn4XSAAWPZvrSk4oMrOO4rtp8Bzucp5jFJS9D9SuNpLmkY4bjCZYRUc5c6fn
    z/gy26vF+HKuh8vLhKRKpmYVdRxo3s4PnqMD8wVl4xWj3hw7yyG1YSo6rq0iQ3eX
    vcQ2m7YIpXjJv1zjD72xBPQZznUm1Z50CxXhHDmCPjAjhwvoQt1ZN2hnW3yl9Nsu
    jyfDlnL8T8zZyQQGiS0qTc53Ll+3ff5y8mk25O6UlJ+9CwXaOtt2AfONM3PYAulM
    gzIcJ6n8Q+mwEU/NK+gtkKrqWafGRPibfsooFYXYfeWwuThEfxeCsuSXvrQRC1f6
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=Gpexjrhz x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-80 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=Gpexjrhz x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFTcxrnJshDOkUKhNN2wUcob1j1J5L/XWjPF/KT3m9c7S9DYZs1o9NvIk9Nzv2TkuTROyi/pjNWo5QAv7P669SBL12hbSe3ZbMlImQWLw/dswEa0dzt3
    2odYeys7AfQ9pTu8DQ3i+Qfq7RnKLYNZR0u53boPASoNCfwFc/sczHEvKwRMGmm4Jq3+pb/WkvvOUOeE7n/t145V9VTXnc2g6EymCrM2qdBYho2feMF6rMds
    ffM0/j5qxnV4fO6XJLf9Cw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=DDOyTI_5AAAA:8
    a=lF0WfDy3dMF9Ji0hKbsA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 15 May 2018 09:38:16 +0200
From: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] Drivers: hv: vmbus: Removed an unnecessary cast from
 void *
Message-ID: <20180515073816.GA29923@kroah.com>
References: <SG2P15301MB00156C41A4CBCFCC94EB8061BF930@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SG2P15301MB00156C41A4CBCFCC94EB8061BF930@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: "'driverdev-devel@linuxdriverproject.org'"
 <driverdev-devel@linuxdriverproject.org>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 12:25:01AM +0000, Dexuan Cui wrote:
> 
> In C, we don't need such a cast.
> 
> Fixes: ae20b254306a ("Drivers: hv: vmbus: enable VMBus protocol version 5.0")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>

Should be "Reported-by:", I'll go edit this by hand :(

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
