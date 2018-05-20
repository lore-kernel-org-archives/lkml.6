Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2979687-1526820406-2-16269715860452157311
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526820405; b=SVOmfeLfUJsvXxzdviaSlYrhHg7gThNN6CSc8IfnYvfynjvjYE
    /kgjqmZdFdScV84o7tLTi32WVs5undLkudYuKyW1zr4U1dqRvbz3HuOUmqkZEFYE
    DtfXT1cqh+rZQnjYPE3aDkOXrSYIEB30RyS7q8Ch04wIpdUvrpB63Qqa8v1aCnjw
    8meSYm5Y4qXKxSMCrmJs1kl3MibUtPpgHfkS0N277K1/GFWMRjkrFem3RNzPq6Cu
    AheYJSLDd3lcxY/90jli/qNu5Qntuni35cMUkG6qWJ9HIJQ1oc/1e4JJP1qc0rg+
    CrqmlpCwLSV2UCAHsZ6moYmMG9+aJtmkwbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526820405; bh=365oZ
    ReCHFCVavXSHxBUC6Hhu7kX47DhQ4IKDoDLGbU=; b=OT66wAjS1ps79Tqco/o9U
    pzIHMMm4Fwmfbwwm/nahgNkt1MnTjZAi4tH8cTNNG7lP/oP+My5qmh3RymjzzbOc
    /3/U+pT8OCOWNdAuOklRyT4gCih9D6hieMpeTru/5ArNiylrSiafr3ijPNc7DHvH
    5/SSxcA1n/rez6iJ+J8AkECveRQjrewLCtjaeiyVXm9+RyBrIycMLuu7FcbhH3AX
    iFUF6OprnvM34zR8DDl08o9QqTDHn2MXE7xHEQ0Gy/0xU5BrNJ4n2IYk/Y7NmYuS
    XHn+a7mQG+wyGg4zezqp3nOvkC2Z1Fb2IRMQIjjzn0FdUk339xgg0RRI96KckNyO
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=0SdnjUp3 x-bits=1024
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=0SdnjUp3 x-bits=1024
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
X-CM-Envelope: MS4wfG6q9vwIWl3c11kb92GcqEr24b7Pbgj0UjAT1D5UdM2ZH81938Z5eeOGVRJPUfiVpV5jq4WGf3vxwjuf1WXAIk8HPwqwSAZG5HuFSsOpzbfBRjTnns/c
    I2rZ9uUa2BR7wT51Cmri/HThufnVStr/2qFIC0Vyvv8uUa5ZZyV14Fz/4sUOVadCWByN0shpftMTBi5TAdygKnJHfBbHWwF2ygJBkYSSFSrpDBxAu1jEgG11
    AI2FGy/XGFx5y75WET9teQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=pfTaJxHuTclOy9Xx9IsA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 20 May 2018 14:46:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Davide spataro <davide90.spataro@gmail.com>
Subject: Re: [PATCH] Staging: rtl8192e: rtllib_tx: fix spelling issue.
Message-ID: <20180520124621.GA17553@kroah.com>
References: <20180519202302.14521-1-davide90.spataro@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180519202302.14521-1-davide90.spataro@gmail.com>
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 johannes.berg@intel.com, davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 19, 2018 at 10:23:02PM +0200, Davide spataro wrote:
> Fix a spelling warning from checkpatch.pl.
> 
> Signed-off-by: Davide Spataro <davide90.spataro@gmail.com>

Doesn't match exactly with your "From:" line :(

Yeah, picky, but it matters at times, sorry.  Please fix and resend.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
