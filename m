Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3747066-1521230646-2-16429490841647643888
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521230645; b=NiKK0JSsaQlEmX4GIOW1whXSTJEN8FwYUeHlxUgdYWg8Uy2
    52yIac1O3Q2fj2x21msrgQwN5Bo7Ug3HM9ljlgaBTegvtVmIPC2/ydmQ6l4AZQoe
    Bv05wncSYP606pxzGqzIy03eRGiwBg3gAEGnP7j6C0bM5B21YUjhuAFiRlrqstE6
    BpyCPMSEdVObNXKwoszlgMr6Smv/BNlhTYdUacSFdl8EHtS2lbXhpQnFBHOlrIQa
    1iIqf4Q36wrnrVuxSGd+BPBT01X5+fZrYTd069K6hJypjKH65pox7O71KtHlVIwq
    89Zp3Ui6W75QkzRoGkYgpldvhWUaW/UuZ/6Ripw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521230645; bh=s
    wGU9eLKpT4uFo6u/0g5Ext1IwaQlsxIP/IFcDbbga8=; b=rF0XgE88gf0kF95No
    ld9EZeEJjRUJfHCiHqtEehnNtmwolRU4X6tk9+yVxme55a94x81FB0JeN3do8Wxx
    dYtJIfsBXJoaIcIVUQc0+ctBtr6HXJ4jLkcwifvyfz2f76qfzsDtJLnt3CW8rsGB
    +JEwHK3GVUiuWchlsb0Wks/DW4TJCn4g75qQzSc8AAS4mSHZgfNNP9qtbNv+G3kJ
    Kq3RYEfqmI6BoVmS9MEmxe6qCEdlXGn2GcfqZIvUdNTkebn7IdGsgtE1jgW7QkMt
    qEtfqYTrtFBEWxqjtIU+VmDRhbOhls6mHpIypwj3XtK7YdAVbg47uAnbFemw1+zK
    6Y1wA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WwWKeidl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yu+BH53O;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WwWKeidl x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Yu+BH53O;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELtSiA1AESNE5/S7IKPLdDNaduOWBKGk8HJtemccYx5jMF3QbqI2uqDY8+FawncB0nL1DoADuQ==
Date: Fri, 16 Mar 2018 17:03:53 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 7/7] staging:iio:ade7854: Add proper error handling
 condition
Message-ID: <20180316200353.dgcdiduupslxtmng@smtp.gmail.com>
References: <cover.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <72d5aaef3445edaca08498b4d7aaff19d4ac0232.1521037060.git.rodrigosiqueiramelo@gmail.com>
 <20180315121115.iwkx2dfikgpjeeec@mwanda>
 <20180316002800.mvy75in42y5j2dpz@smtp.gmail.com>
 <20180316080257.dlglfjespmltwo3u@mwanda>
 <20180316135946.b7elcisgkfs4ibwy@smtp.gmail.com>
 <20180316141727.ia3mrwnmtkge7elm@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180316141727.ia3mrwnmtkge7elm@mwanda>
User-Agent: NeoMutt/20180223
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
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16, Dan Carpenter wrote:
> Generally, it's better to fix the bug in the existing code, and then
> do the cleanup later.  That way the fixes can be backported to stable
> kernels more easily.

Hummm... the backport argue make a lot of sense for me. I will generate
a v2 with the bug fixes in the beginning.

Thanks 
> I don't know this subsystem very well.  Perhaps Jonathan doesn't care
> for one reason or another (like maybe he's not going to back port the
> fix).  So it might not matter how you do it.
> 
> regards,
> dan carpenter
> 
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
