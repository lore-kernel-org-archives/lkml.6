Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3175828-1521474232-2-7778239195137479348
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521474231; b=ZkMLlFWkCXl3xpkkDmZXRfBtka9dmAY2CgBGr5ijNihf3PH
    p3xDem5ajWiM/l6ALuNUfd2z8Olm9DUUDrBkk6Itx1UBdQ3zfmQEU3HqxzXzTYfB
    GrHO5P3AQS3+2ee5GzGzStLT1I4ttvIezGCRFB7MrdQkzJUCEzcOCj8o3X7fdvHU
    IQSy9TAQLWT0pGefDxcnZlS07lsMnj2QZmOVeoX9Sw4EdSye7iSMGcH3LD2oYB6R
    N0P++mvYsQAkU3Dfm4jTKd1AS7GyoVqgVWlrkf6MQkttWbtep1+3W9hmrOhhJufC
    UYxgkZ8mATC0Lkmb0iaAz4NGnt0pAqTkyjm0F7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521474231; bh=O
    YvM4Nz05CG22hMAeYK9f2yiKuRzlQjHfHvFY8DEoXQ=; b=YfyzrWuBmUbV4aLob
    PJQp5EScmXfpEwmaF1BIBOK+oadK3s4aM0l29pp1k7V8PIC4RJnc9z0HO1dpjDSp
    /iKxWpHhTPPF/bm6knBuEx5oJDr03j/AhESOCAfmqRlAgEcSswrEJSfzkdWoiIRv
    mlLP8O7Y8jNxykG2FYwjjQKf/Lh7nJHwdznhtHsxZFpMiI0SF/1VwX4mXAKkB0fu
    u8Zxsr+gBMqYUBP/af1g+NQI53wTDbTaiGO40d18Bi3XsJd89mo4HqeFqudcLCSk
    q8aMuhpLjswug8kCgYy5jazkxeoUo+7gN6TAs1iftn3jBz+SzV1n8dGZMZVEJBju
    uqFZw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggujggfphejjfegudeftdgtgfgvshesthejredttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudeffedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeefpdhhvghlohephhgvmhhlohgtkhdrohhsuhhoshhlrdhorhhgpdhmrghilhhfrhhomhepoegurhhivhgvrhguvghvqdguvghvvghlqdgsohhunhgtvghssehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghequcfukfgkgfepfeelkeekuceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdejkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggujggfphejjfegudeftdgtgfgvshesthejredttdervdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgheqnecuffhomhgrihhnpehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghenucfkphepudegtddrvdduuddrudeiiedrudeffedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedugedtrddvuddurdduieeirddufeefpdhhvghlohephhgvmhhlohgtkhdrohhsuhhoshhlrdhorhhgpdhmrghilhhfrhhomhepoegurhhivhgvrhguvghvqdguvghvvghlqdgsohhunhgtvghssehlihhnuhigughrihhvvghrphhrohhjvggtthdrohhrghequcfukfgkgfepfeelkeekuceuqfffjgepjeeukffvnecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 19 Mar 2018 16:43:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul McQuade <paulmcquad@gmail.com>
Subject: Re: [PATCH 1/5] Staging: rtl8723bs: os_dep
Message-ID: <20180319154344.GA30651@kroah.com>
References: <20180319143500.19623-1-paulmcquad@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180319143500.19623-1-paulmcquad@gmail.com>
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
Cc: devel@driverdev.osuosl.org, keescook@chromium.org, johannes.berg@intel.com,
 linux-kernel@vger.kernel.org, Linyu.Yuan@alcatel-sbell.com.cn,
 hdegoede@redhat.com, arnd@arndb.de, colin.king@canonical.com,
 arvind.yadav.cs@gmail.com, davem@davemloft.net, Larry.Finger@lwfinger.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 02:34:56PM +0000, Paul McQuade wrote:
> ERROR: do not initialise statics to NULL

You are going to have to do a bit more writing in the changelog than
just dumping in random output from checkpatch.pl.  I know that's where
that line came from, but no one else will.

And your subject lines also need a lot of work.

Please fix up for all of these patches and resend the whole series.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
