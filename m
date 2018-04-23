Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1187135-1524490895-2-16925084302927066582
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524490894; b=YOYdFa89H5NLvI/LdHmXaRtQx5xUB0OT86mwV0A+UX9O3XI63X
    YShORhrYDQlQaQIwjhwyijusxuMqXikuGKXJH+8mXVBo4TMJMnC2WUiIXO8gzOeo
    OybojpO7W8rQm3ws9f5nz43KV7TOASkNgGiAHzHOdotRPfkhXUoB77ZSg4Qcl51p
    KFcuN5+ahXDIsMqEGMR7HGFQ5tFC2le3VFlJpMHckXKQ9gJHK1X5pkH/UqCgXES1
    WnABtp7wR8RpuOVD1ky0o362Bd139wjN9yvHUAHetcBOTPANXZOmr6Q8R6DqTrXD
    gs34QrPqOnVKtydBIMUt+BittgNcT3uf87Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524490894; bh=3aYiP
    zAg3YQrVkVSCgJL72fObRSuUW5XsRcW2J3phGA=; b=Kid/ZYAFuQoqiPiYN1izC
    AlKP9xX96bdwHw8Iz4lyeIGP8v6yj5hVTuThtzvIvjlwsWgnbPu+0sgVi8fcY6C+
    adAYqX3WhZVWuCYyZ6UoocwId8MDO7wswpyXTD/KlIR4cM26HBF72ckEcQvtu5fG
    4eZDfrb9ArOhGtj8JR9OMcREHDvo5jZpO8yH7DMDQibkY5/RJLDBcpgogie1mibg
    gNBwUHehaOUkjvocAjPIUf4IvgRLZvC3bI/HTwaTHPTS8VDDRhTFjgYO+gWJzmdp
    cpsylBGtFs3UNGqf3J3QOEGMqUmE81X5Iz0HS/TnfgEAPgx8MSdVTT0BrPdDyrYa
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL9el+IUQQuokWu6CApGIE8fAwBG7ZKVx2XUvDm+PSEfm8V5zD1W92u0GBdJe5CR75jtc0YJLDe7jwA4opoZUK70ShMUwzmnZHzxpf7WeVIEUeaNAXr3
    UwSwQT5UqXF9DydOsIVNoOAGxhzfwc8vwGzQRsPZ81fGKQyqVQkcfUbe0cliUcgwtmFGSFfLaQvQsHW0sjafWzladhpYRvSPXed92KwcxXunyhQ3ZzVuWSHl
    fMRNdbrgM8unSFFKA12iUw==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=zorEJiejVOJgWR3OWRsA:9
    a=wPNLvfGTeEIA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 23 Apr 2018 15:41:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Subject: Re: [PATCH] staging: pi433: break long lines in pi433_if.c
Message-ID: <20180423134123.GA7986@kroah.com>
References: <20180406204817.7470-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180406204817.7470-1-simon@nikanor.nu>
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
Cc: devel@driverdev.osuosl.org, Valentin.Vidic@CARNet.hr,
 linux-kernel@vger.kernel.org, srishtishar@gmail.com,
 linux@wolf-entwicklungen.de, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 10:48:17PM +0200, Simon Sandstr=F6m wrote:
> Breaks long lines in pi433_if.c, fixing checkpatch.pl warnings:
> "WARNING: line over 80 characters"
> =

> Signed-off-by: Simon Sandstr=F6m <simon@nikanor.nu>
> ---
>  drivers/staging/pi433/pi433_if.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

This patch did not apply, please fix up and resend.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
