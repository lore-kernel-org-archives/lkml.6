Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2048875-1526368936-2-516782642837667082
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526368936; b=VUBfw0fFGqlhyhZwIUKlovHwCzn84gC4swAQbyWFJJaWokCbj7
    XyUyAnbAlPqCJTIKbzlq6f36YjzTsT5Jj/iNM/AmOb11Vn+yMgObzv7IJa47/GSf
    Ot3V2SOXeSRkCBMfIZLugjzAdWoChH/e2M+ip5msBSC52aEeXILvEN5VPfRub2Qw
    vjB5o6cEOsujK6X8bgTMiyQGLWi+86blITjc1x80b3QDrXpyRKmsVfjRpP+rGuLY
    UIaELFJosDOsgltUONCJ1xNrJLk+ooW6Xl8nJVdaNDbxz46+YQh6dkOKPpNy61PT
    vW4K+AYs70FSMK2Ryjypz1d2f31eQ8AfsLgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526368936; bh=J7meW
    UvG00XbvGJCoqvONONouQZsd8POiiIRRO3xV78=; b=RnDnzwKRzrzmQ92ArEe4M
    RXL6+pAQWWnyOOjsN/rsZCyKJ+g93Mdj5mMrEWIwfBmIYS92wYU1NptuLQg6o22C
    5SsdEAbQUq/1cAA5707GxD7P8MnksfnMj0i2BN8K7Y1GoDbpdKxT6qBUFmo5WCxA
    dUxHbSBhF5A4oq+KYhrdJkkGKRqONR3Rs+4YEATGGrqy7AGeUGGJ2M9hnMpnNFnU
    rqbWgTSp1u9zxAlvtvksWdPa5Dvf19oHpCSoTooMzdZXrBXRy6QdGYE6oC3QsBxU
    RuEGCqogyC2Pv2YKrJvO1XGGbsXqFZu5/gELYghgfOmXlBvW7mtZwhU3rBUUxG1A
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=pci1Qksj x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=pci1Qksj x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH99+P636iqhg3a2QXF++d3rhi2IOVIuO8cLn6IBtQZVGmu0H+kTNwqljNnYpbdxqi9wjWh6sd34kkojUSrb7vfwHFjPYPAVi5ItM9xTmH6oktcZgMdI
    Ywb8MaIFZ+ksNy9uuJ6le8Tt6bheWrRSnE7VgMW2XaA9Ljrtl997Fr0ikXwCPTO2rRsnwCSDk1DpcO3b6E3sxxxr0/3LKXclcCBMBrqXB+htOD3tlmHYStpW
    Psej+SNc8ad0FWv8aq3XKw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
    a=DDOyTI_5AAAA:8 a=t0xJehoyR9jt5xtS2vAA:9 a=CjuIK1q_8ugA:10 a=D0TqAXdIGyEA:10
    a=xa8LZTUigIcA:10 a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 15 May 2018 09:21:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: John Whitmore <johnfwhitmore@gmail.com>
Subject: Re: [PATCH 01/27] drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc:
 correct braces
Message-ID: <20180515072151.GA7761@kroah.com>
References: <20180514212434.17514-1-johnfwhitmore@gmail.com>
 <20180514212434.17514-2-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180514212434.17514-2-johnfwhitmore@gmail.com>
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

On Mon, May 14, 2018 at 10:24:08PM +0100, John Whitmore wrote:
> Coding style edit to clear the checkpatch.pl errors of the type:
> ERROR: that open brace { should be on the previous line
> 
> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---

Any reason why your subject line has the full path and not the shorter
description that I suggested in my last email?

Also, when resending a patch series, you need to version it, and
describe what changed.  The file Documentation/SubmittingPatches goes
into the details on how to do this, see this section specifically:
	https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

Please fix up and try again.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
