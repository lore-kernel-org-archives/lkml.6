Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-995127-1526313589-2-259765792200960443
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526313588; b=LlqvjwpbjrycBYTeatPjIWK2PzNP7d2SHsAPs5AdqWmBynU1S4
    ZmlA9xgTqxVn033NQJef/CvZRbs25kF0QGugFWmxMrpV0dNvUvuvH7nx8Fct7jrU
    otDOfgHyR7p9bSep/PgYU3/LhqIuViKvZkIuYtGh3v9sai6Al5JXBctgNb1/q06T
    9RPO+YmUqzW9i4MAzbvwAZC7OQB3iWZfVBTCjZW69l1Vbs1zMaBcrjui+UREIRmG
    g3YQwMBtcXFUvEtRltguMfFGtXgmxLl1MXGMNvdFAfpFLHwv1yIpupIe/vAxCDHa
    olygCZDMaP7oXsO3ghm9zmLwKRnbXsqAk9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526313588; bh=6OfL7
    pTLPQCjIozYmfobCbkKaWTjzwn/1npOfGpvEp8=; b=EYAQlK4CTTB0VYZFRhjaa
    0gdcpL+IJZXHC5MsI5Sg3kUmz6b5RZbOmd5Kq6Ba6LfujnCgJ04sf8IxUne3z/EP
    TsvPwFNcY2XLeBeSMwqgfkrpMWbYdVxWrKa64O3Gx/0uv5goe9FAncNks/oZZu6z
    g7ChjpLEFut7jx6fs3THyIcVsVDekngmN8uNkLQeVMOZYIXs/7Lf9VKotmxEDTT/
    yRJd77QJF8ItCV33YHeMYCR/VRrhCCpMpsEFit+870XcvaX/vLgQaP/MkDZSmNlo
    0NgFPEjS1LOJ4iouOQA3brfHQf4HHHj+xJ7q4frEOWrjZu/WMnDb1iBBvnfk0LmH
    A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=isVcPP7O x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=isVcPP7O x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO9+DDMg0qOmCZJPmeLb1DJW/S3qsj2xuJD4i/1U3tc3lFpFpgJiZgRNnbKhnz4ecCOesxSb4PLnPykZBGDZMC+OKZrqGXivzgZZ0cpZPQbZi9+5qUcF
    9oaSLZzK6PY3mbiDE4K8dZiKD/vPNyFeBCuZw1NCDueN3WI9wL0IuVjD6A5/5IjFWM+CuWa3SIFpNZ4LjoyaQootkupnjECd+L6tAGP68/N/Y336F4MTdvkG
    +ETjVpuew0wB+8MIlJtCrQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=9RsZRA7jHqb_7m4GWx8A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 14 May 2018 17:59:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: John Whitmore <johnfwhitmore@gmail.com>
Subject: Re: [PATCH 02/13] coding style chages to the switch statements in
 the file.
Message-ID: <20180514155926.GB30973@kroah.com>
References: <20180514155318.32195-1-johnfwhitmore@gmail.com>
 <20180514155318.32195-3-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180514155318.32195-3-johnfwhitmore@gmail.com>
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
Cc: kstewart@linuxfoundation.org, devel@driverdev.osuosl.org,
 tglx@linutronix.de, linux-kernel@vger.kernel.org, colin.king@canonical.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 04:53:07PM +0100, John Whitmore wrote:
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 93 ++++++++++------------
>  1 file changed, 44 insertions(+), 49 deletions(-)

And I can't take patches without any changelog comments at all.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driver
