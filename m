Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1442817-1518444707-2-5323352047574985109
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518444706; b=aPO/6eQOGQtDvOAGm+IFmzhLt6hXSegxQ8W5jMVLolwRDHX
    NWlnALq0ubZXxg29/h5CSu4vBSHTaWH/YPkxzpxZmmps+Z6CYd5QTYBlpKb3jhOn
    XFk2TJnaovQqrSrfnqxXZRnBbUcYZD6yF2iywHQtOhCZQpLWECD10L7TnAVSlLT1
    RjF6mIVdLwmcLbj5HmeRyidrS7b5Ku2SeAzDNtNy88EFb6qasXM4zYU0ucUH4Yvm
    9XEyUsGeNE4nOASMoo3lORWF8FiH/z0Ojd0vlXjFDhncmEe6t+awdoePCYzk/bKe
    POgXzdO/FLcW4b/bR7WOx+80QUx3VDlPin8HLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518444706; bh=L
    rMP8FhULid4OWTiQVXz9LoIwmsl6b4Phgwj3+WkQhI=; b=B0m+f0+ETMhlhR1O+
    HAZ/UIYe9+Qx02fJ6S55LqBiNRUxmI0OL+/lCpMSxeIAizknEnQrIj1kIffEQldi
    b5FopDQmyce8rAr7q0bTna1tVTWRa7vGz1wvm9o5eTTMRabcULYmgsHzlTCvsuO5
    gckh703WnvzDY/VPZT40iKEid27Xh9GIJ7l2iPDKrzjNox9BVsBcwXxsf2BWCM64
    lgU6CiinK9wGwgxOzSKMMloipFrrhPG84F4EAUbhqRxKWVJgVrhMZuv2Ifman2yS
    /4grCPONNsDriwGhT0xlJJiv+q/BQH4eCvYFLzR354qIYTuFW3mYZGkEExlehPd+
    nBmJg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=nexb-com.20150623.gappssmtp.com header.i=@nexb-com.20150623.gappssmtp.com header.b=jySArmWv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nexb.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ON5GOf17;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nexb.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=nexb-com.20150623.gappssmtp.com header.i=@nexb-com.20150623.gappssmtp.com header.b=jySArmWv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nexb.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ON5GOf17;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nexb.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x225PVxvETbBE8o3H8+UO5NUiNv66DQwRSnrvmXzGv2hfMcttBP4QFdVXu/SL1+87RtAZrxi5g5g6b1u9n5tmP0M=
MIME-Version: 1.0
In-Reply-To: <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 12 Feb 2018 15:10:56 +0100
Message-ID: <CAOFm3uFOy+Rea8yz798sEoCGRfavsR9gwY9-d_RQ75K5yoq1=g@mail.gmail.com>
Subject: Re: [PATCH 4/4] staging: iio: accel: Move adis16201 driver out of
 staging
To: Himanshu Jha <himanshujha199640@gmail.com>
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
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 21cnbao@gmail.com,
 LKML <linux-kernel@vger.kernel.org>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 12, 2018 at 12:54 PM, Himanshu Jha
<himanshujha199640@gmail.com> wrote:
> Move the adis16201 driver out of staging directory and merge to the
> mainline IIO directory.
>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

<snip>
> --- /dev/null
> +++ b/drivers/iio/accel/adis16201.c
> @@ -0,0 +1,315 @@
> +// SPDX-License-Identifier: GPL-2.0+

<snip>

> +MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("spi:adis16201");

Your MODULE_LICENSE does not match your SPDX license id.
MODULE_LICENSE("GPL v2"); means SPDX GPL-2.0
MODULE_LICENSE("GPL"); means SPDX GPL-2.0+


-- 
Cordially
Philippe Ombredanne
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
