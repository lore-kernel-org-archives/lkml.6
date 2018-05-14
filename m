Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-701366-1526299168-2-1317348197056984225
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
    1526299168; b=U97JLV8z/eFSEcao/HRWX6Kr1DSt1gQXiN65bN/hq/gonzM1nj
    T+Vo4vd5s62VfVSDhMqQS6G7HwZu41GRvt3qMnQCDNorl2TcHduy7iX0JNUxfE1h
    TZIXFVdYKvEQ40jXFLoCmHiryrVPTDgOvz+tzVZ/c1zfCPxCnVjIboklOyDslUDJ
    cTxSypYnuQTFdb/mRifcO0XS0rVKUpjVDRcLYQYNDBX9n3PUqxChro/qFZV3VaF0
    hPOhxXTF/y8ZnzlhJcaSu3p93d44LfOC8As7JYiXt9cOUP+X9IuNy4nMtmH6svmV
    HyGchA7dLBfaqi9dCt23Q0pfpBblqlmhbSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526299168; bh=Hijcz
    +UYTjffqX/t9a5hQKvUxJewusxZow/0jDjS1HY=; b=kWGylljWxiaWzJgbS247R
    9QZJjlKtQyZXGT12H2YHubd8YkSXc900LwT8kf8nTSYYBuQJxNoMruNhk6blQ1JU
    T/TiO+3imQT818COoj+AeV/nHbSVpHYbexm1mBANCPJ44bAjHjCsXWw9Ec5I8fSG
    UA/QOBNCNt1C+YJaisDa2c4DfoTQiuTCY2fe9G9SBrzfqKi2CWvwMPo3EnDytQnk
    lJqX5eSATPbbHIKwKH+4mXwVZWNQ+gFahY1LeQcJcoKuc9yUKpeMdEM7ncufTJ7G
    xPdnqC8NbBq5DNy07Y0WwMZsZmx5Ljjlzr/7TyPPeTFUxlc7u5mYRJraVZWI/MXs
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=HtFD1saG x-bits=1024
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
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=HtFD1saG x-bits=1024
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
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFuRlJkDKPb/EVRdXAaCllleqFjzwnNC7xmEl9x80Rj3Ju5mJuc0u3oUjq9BNs+XFbwZvbgoLc6QttsjO6YwyVXwIA1aj5TRq6JOoUMBDYdYlTLeatVN
    OPgDZJZ13xwwLyn57ksA6zjzjJ3IDs5tNBID8udk2VzImAIFn3D4CglYZ4jRedKUitJmgHL9WXjLUGXei2RKQTpsWwkKEGVcmi2X0BCp2gjXtCdJycvG5wxw
    nZcW5JGUoEnMon/MnR6HMg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=2P-bhcr-6JV6n8XOo1kA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 14 May 2018 13:59:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Stefan Schake <stschake@gmail.com>
Subject: Re: [PATCH] staging: bcm2835-camera: Add TODO for removing overlay
 support
Message-ID: <20180514115901.GA3756@kroah.com>
References: <1525993965-4317-1-git-send-email-stschake@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1525993965-4317-1-git-send-email-stschake@gmail.com>
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
Cc: stefan.wahren@i2se.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, eric@anholt.net,
 linux-rpi-kernel@lists.infradead.org, dave.stevenson@raspberrypi.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 01:12:44AM +0200, Stefan Schake wrote:
> The overlay code is non-functional since it relies on firmware control
> of the HVS.
> 
> Signed-off-by: Stefan Schake <stschake@gmail.com>
> ---
> Dave, does this match your understanding?

This doesn't apply to my tree, can you rebase and resend?

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
