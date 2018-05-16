Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1084986-1526513570-2-4777239615501118351
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526513570; b=buQPaDBNmoaHABhDOPzZ5jXbxcwoUtf3HYJy8XzODNl3yYZ3hC
    prVa8iPt5XtXevRaEv4jhRJ6Qn72Q2RKCLZgy6sjkqr7S/vGLgtbVZQNeIFEY0bY
    WLNYIrSoqWLa/nlo5p0hi7DdzzWHYmdw/ApicS8ptASLLcJtNcNP1merHYnVfNi+
    Ulojd3aNWNNRRnGmVC4Osl+Gnprk+FWfwbU/I4H4XS0mc23SfTRnzHGIpmy21yTk
    qZwi4NGA5v6Wo+HS4IhayQDoFoy74D/OnAbadvM2rmG1gGvOjo/0klvKj1i3QfPM
    GjYZzhwGeBDonnVlY5YryuOjY7vJ5TKoKyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526513570;
    bh=xCWbS07vN9OgwzniaO/qMf0mjM6bf4nkYuMhuimZYfE=; b=M7UtGZuTByoY
    lkkDYKy0tCEZxsEok3vRgNmhvJ9WWTdXkSS97gnvS/tUpaJc6IUHMWWzILNV4QCQ
    wkiYLvIfDeYL641+1fTX+lNQrxildY5eJFnUC/VkiRMFoXUD+ll4XZ7Vwg459WM0
    YdH3nvS5tQA4gVTk/RU/Yj+4WCWwMzCNIktvoxhGJO39AJ9J+YSp6av/LaE6uZS+
    QX5G6Z90m3iigdazhP9jjfH2R3N/lIogcJP0LqCxcIXJn1kIoR/BanvUiSRTG8Dk
    60Om+EWili9RpgJB6GVfMfNLHjJRmrBG6l9AG1SPS/Qxyc4xoTPXb1qJ7aM4Zk83
    kkMZchcWAw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codethink.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codethink.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBOBTgCZx8TgOwSXNSIaUtkzVz8H31kr63JSfS3IwR4kT4gYq15r8lS1izdGJwA42CIDeC4gLaYMueD0VLK55+G+6RtSBl77P1HX8H12fod9XtFNJ0ff
    iqtoxuYdBlJrhfqGTjFJFXNjeCm0AWQvbfEUBc+a47NcWjy4xZ+Tejk+aZ3QhhVhcn+aYcQq7/VDDdD50JWxDBFjpuWj2/8+1cn19pPsV6ciotaNcxGRIa82
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=rTDo_5_6WMYnJkmuBBkA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbeEPXcs (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 19:32:48 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:52728 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751150AbeEPXcs (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 May 2018 19:32:48 -0400
Message-ID: <1526513565.9159.153.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 60/97] clk: mvebu: armada-38x: add support for
 1866MHz variants
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Cc: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Thu, 17 May 2018 00:32:45 +0100
In-Reply-To: <20180422135308.591594256@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
         <20180422135308.591594256@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 2018-04-22 at 15:53 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> 
> commit 9593f4f56cf5d1c443f66660a0c7f01de38f979d upstream.
> 
> The Linksys WRT3200ACM CPU is clocked at 1866MHz. Add 1866MHz to the
> list of supported CPU frequencies. Also update multiplier and divisor
> for the l2clk and ddrclk.
> 
> Noticed by the following warning:
> [    0.000000] Selected CPU frequency (16) unsupported

So the frequency selection field is read as 16...

[...]
> --- a/drivers/clk/mvebu/armada-38x.c
> +++ b/drivers/clk/mvebu/armada-38x.c
> @@ -49,7 +49,8 @@ static const u32 armada_38x_cpu_frequenc
>  	0, 0, 0, 0,
>  	1066 * 1000 * 1000, 0, 0, 0,
>  	1332 * 1000 * 1000, 0, 0, 0,
> -	1600 * 1000 * 1000,
> +	1600 * 1000 * 1000, 0, 0, 0,
> +	1866 * 1000 * 1000,
>  };
[...]

...but this only adds entries to the lookup table at indexes 9-12
inclusive.

It looks like this fixes the clock settings, but not the warning.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
