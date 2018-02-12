Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2131322-1518464788-2-7202111714656938237
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518464787; b=k8AOLUYd58lBVMuQFunNvRLgq8l8XTgLCcrGaFdw8Q2sI1z
    aXF7LidH1pWMatrW3Nm0VdFENjKZ1RfwsNJV0k3o3irkOxc8eZ+vsH6FPSeoccUI
    O2Btf+xUjhk3CBXEp+cawArfUvENHMc7qbyJXd9F3Ket788Erw/8suI+rX0PQevE
    /RWhkz2PNyymNq+LqW8G8nIt9SjxK8yoicPRDiOluLi1n6/dgiFuXvO9RTafyiui
    rDha90M/zYIzaZNLQ8zj/bQhTHXL3Rd//1KY5i5FSlCbZigr66EQ1KfE3bUzaAAi
    cOw3OWHzj3/kXa8lLhK+sp6YTaM1Ta2vxG112jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518464787; bh=M
    mxmI0ht//uuMmEeFT9V1xeostQVfOo0a2cgIeBLPwE=; b=VlkEXC9pllGdJWOMm
    XPj2HExVVPzRNzBiAdUgwXkAQqri9w6fCl11a7MGu6c2bYYIEbybdaRi3m0/otSA
    yl0ALm7rxQz3rFhuc4wEVZxSm1NJLzcsol5swbW/heLno/jJIgxRVF+blzA7qOzD
    G6K3miNHSDmYG1ZzNYoU+N1jWhTsETNprebz0sKu9laOXPK8OoWriHE2i5eTPJIi
    wv/gNDakvkfqdorCg2SfcU49zM1iFBpzu5CSUjnZT1W9XC12FQPNRZpRR6uY2WWY
    ERsfSyDmbwUoMUp/v4NdLMwrc9f/ObhXGisD0TJVyOh63GQpNDDtqxCYMKLIDK8i
    5bgqw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ESLGzL/T x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kANlAg1e;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ESLGzL/T x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kANlAg1e;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x224zc8InKjy5uVSF3wJCwd15ZOVa0/F+YYgpELT78QcqGoyeaKgWyrMmyG+0FgE8V0Xi+p0AHQ==
Date: Tue, 13 Feb 2018 01:16:05 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 2/4] staging: iio: accel: Remove unnecessary comments and
 add suitable suffix
Message-ID: <20180212194604.GB15335@himanshu-Vostro-3559>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-3-git-send-email-himanshujha199640@gmail.com>
 <20180212125312.cjo76spuu6agjawc@mwanda>
 <20180212143522.GA12142@himanshu-Vostro-3559>
 <20180212145731.kws25sjinzqq6ax6@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180212145731.kws25sjinzqq6ax6@mwanda>
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
Cc: devel@driverdev.osuosl.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, gregkh@linuxfoundation.org, 21cnbao@gmail.com,
 linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
 jic23@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 05:57:31PM +0300, Dan Carpenter wrote:
> On Mon, Feb 12, 2018 at 08:05:22PM +0530, Himanshu Jha wrote:
> > But these should be done when we have *more* instances.
> > 
> > For eg: 
> > I added a tab space in function static int adis16201_read_raw() argument
> > to match open parentheses in this patch. But I also added tabs while
> > removing and adding suitable suffix to the macros. So, should it also be
> > done in a separate patch ?
> 
> If you're changing a line of code and you fix a white space issue on
> that same line, then that's fine.  If it's just in the same function,
> then do it in a separate patch.  In other words, adding tabs when you're
> moving around macros is fine, but adding it to the arguments is
> unrelated.

I will try and divide my patches next time :)

> This patch was honestly pretty tricky to review.

I am sorry for that. Might be easy for IIO reviewers ;)

> Jonathan assumes reviewers have the datasheet in front of them and I
> assume that that they don't.  He's probably right...  But especially
> comments like this:
> 
> 		*val2 = 220000; /* 1.22 mV */

They are pretty obvious as you can see from the return statements
just below that which is :

		return IIO_VAL_INT_PLUS_MICRO;

These comments are obvious because we know 'val1' will be responsible
for Integer part(1.0) and 'val2' for the Micro part(220000 * 10^-6 = 0.22).
Isn't it ?

Although I am new to IIO please correct if I'm wrong.

-- 
Thanks
Himanshu Jha
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
