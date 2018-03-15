Return-Path: <john@phrozen.org>
X-Google-Smtp-Source: AG47ELu9h5Qekc6uNDSM9hfo6T+D5Y1GpgZxwl2e1x8m3iY+JtH6+gIpyuyREvRFzIGzn14tAppl
ARC-Seal: i=1; a=rsa-sha256; t=1521112050; cv=none;
        d=google.com; s=arc-20160816;
        b=m/e8S0zdkzIdME7CXtBhsKImmubhO5FRkjtTuWIrMQQwsW8MM/hp2Y/W7UtMEd0hNJ
         ucpF0IiKu3swhAit8G2sN7QbD+9hcKtocnsZF8Y50OHqBh5gnx7kvLiWKqgeL/LONoqZ
         qxUpx83WbtXrepUij7l7ywt3eOQLxZH+cQG/6XG9UfD6KiPzQ4Z6bgGDv5FMsm3gl7ZB
         PzYGZDxgwdbGHDsOEy+3KtU+um7rGfDScpRiwc5doeIGJWCaUJg5pO+bebIUjyCD3rUv
         A/LKrMVT6Jt7gAuR9fDsQ9W5PpQzJKAZCivSYaBCUfxQ8PNfku58KcJoViLAYGfXgHtB
         aDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=j7mnWp3OK2XlkNQFl2/2WcaSwAGSAIkCslGhSQLV7T8=;
        b=mumtW/xszPBkJSop0favBU5/P9RDGLS0xPT+Lwf9npmco5uIrw5icxtvb16SuuazzJ
         w/iz/pyy8/0y4Ifs3e1/j0ApMrLNZXj/c1QZTn9ewM02fmeFWXBHbMgWviii2atn5fdY
         NjwhjPoyLF6Q1aul9Y6ggYwRoUUp1a0Ac671IVaKtV6fxuQr5aTVOWvCHsEvAg22r8Dt
         CoZdFa1tcJUAQneqnofqQB34ZELmG0c0ZSE3dvj2qiY6AD9Ust54dKMhmfDEEorjC+lX
         2Iz/kEQKjT5m1ff0XSF8usPefHsn+CiK2bVUCA3+WfUuzcZjI2lALVTTz5gQV7TlVg42
         nV2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john@phrozen.org designates 2a01:4f8:221:3d45::2 as permitted sender) smtp.mailfrom=john@phrozen.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john@phrozen.org designates 2a01:4f8:221:3d45::2 as permitted sender) smtp.mailfrom=john@phrozen.org
Subject: Re: [PATCH 00/13] staging: add drivers to support Mediatek mt7621 in
 gnubee-pc1
To: NeilBrown <neil@brown.name>
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
 lkml <linux-kernel@vger.kernel.org>
References: <152105892255.22262.1902152685410223215.stgit@noble>
 <20180315104853.bthffdd4hzklzo6d@mwanda>
From: John Crispin <john@phrozen.org>
Message-ID: <be0d1e2d-67c5-bac1-63d4-72568dbf9d23@phrozen.org>
Date: Thu, 15 Mar 2018 12:07:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315104853.bthffdd4hzklzo6d@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594945943746723387?=
X-GMAIL-MSGID: =?utf-8?q?1595001589433579051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 15/03/18 11:48, Dan Carpenter wrote:
> This all seems fine.  Generally the requirements for staging are that it
> has a TODO, someone to work on it, and it doesn't break the build.  But
> some of the patches don't have commit message and those are required and
> some of the commit messages are just the changes you have made not don't
> describe the actual code...
>
> John Crispin's email is john@phrozen.org.
>
> regards,
> dan carpenter
>
Hi All,

looks like i was CC'ed on the openwrt addr, which no longer exists. This 
series makes no sense. None of the stuff posted is anywhere near ready 
to be upstreamed.

* we dont need a dedicated pinctrl driver, pinctrl-single will work fine 
on these SoCs
* the DMA/sdhci driver is a hacked up version of the SDK driver.
* drivers/net/ethernet/mediatek/* works on mt7623 and is easily portable 
to mt7621, same goes for the gsw driver.

     John
