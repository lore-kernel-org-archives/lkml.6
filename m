Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2680741-1525780145-2-10694941501261116197
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525780145; b=SB+sqiQSyuHRZE7mz6zsAElZfCnTBbhFdfDL6Ci6LOZbs8RErN
    LYincPCXuOntRVXKTNKl7uLie6sfFGVFAH8fupFeqey4qe2Z1T2uGmIldpGWl753
    viIjLBg5SDPDW0Lvo3/Ikavsq5uq7OvXRD1q7SoE0VxV7RUourNfi4HtYU5BNnfg
    mivy/QpnQQw49IcSluz44Im3z2mjAXX1hEI41RjAlj+KcUnxs7GfsTpiAzOUjl0A
    /94QFSw5DzJW9PY/g+YEH7BIJnbJ059ZCRrpLQywCixwn5uBdLpoz4vFIwK6HvMZ
    yjhBId8HpqDExVEJo6SMvFQvP9zdnCPHjAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525780145; bh=8Vh4mBfj6AwSomI5DBMw/WhSq+SIGaAE626h942FwYI=; b=Q
    dhaNxIFxixU1pRxzYQLu6/XIIGAiuA4TVddi1rU2Bdhnebd0Xg2yXVKLgWTLicpk
    EBB3tIF/UAJLlewxxjxpFW7yTF455TXk5Hx6eoLh+2IIJ/a86yl84Cokh1fV0XoA
    8oDcz972NH25ZGRhq1TPQy/uA8lvdbOUiEYoZiwFuFgDxu/fBHz+cmBEy6Ge/2n7
    ZpwK3liGF3n/hPfJWZoV4khkecsPVSzp3DzEAyAFzjtdoC8TenHjGM+yxaglDZlh
    0uCRe9XDx6XZFZnLIiHGcpOi4Qeq6y9Z8Ybst2zRi1nK2Z2AP4Q7vpyfhbl03EA5
    Vm5zrsev7xsdMAy0JUxhQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=uUSHsX31 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=psukfkw/;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=uUSHsX31 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=psukfkw/;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKX8CkPdr7HlcNLBYghAXnpLTAOlq1eJOZ+5/8KaMVtRebgy2xbCXkg7gVjewGqrGuWE3XFUR9mqST1xRc8Yb0W7mT5sAgFQVJLTMx1k+M3BwE+fHj/R
    tygyThLAA5yKalvDrZA7uBHmhHj/GFKI/OJVn0rei3s2xI7oT8k6syVbEsKjDvf8ArNY2UdOUlWqLiZ/cJoy5fv9bXrYIu96kg/XIyP3ti2oASDeyTLPcaMW
    pPLexyzyUwZ0LdLEVDXh+A==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=x42tTbUH5sAA:10 a=kj9zAlcOel0A:10
    a=x7bEGLp0ZPQA:10 a=xfq7aEqWmQcA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8 a=LMjEkvjLm1FACiCTnlUA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22
    a=EuMvGzoevXUWrpekGtjw:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrF29Zqp5oJFYWDMZkyXGHlIDxag1JUAY1ExthAy1/FpzvOhtLxon31hEzQD/CiBXfN2xHk6w==
Date: Tue, 8 May 2018 20:48:45 +0900
From: Wei Yang <richard.weiyang@gmail.com>
To: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link sibling resource
Message-ID: <20180508114845.GA19459@WeideMacBook-Pro.local>
References: <20180419001848.3041-1-bhe@redhat.com>
 <20180419001848.3041-2-bhe@redhat.com>
 <20180426011837.GA79340@WeideMacBook-Pro.local>
 <20180507011429.GG30581@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180507011429.GG30581@MiWiFi-R3L-srv>
User-Agent: Mutt/1.9.1 (2017-09-22)
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: nicolas.pitre@linaro.org, Brijesh Singh <brijesh.singh@amd.com>,
 devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>,
 Keith Busch <keith.busch@intel.com>,
 Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Frank Rowand <frowand.list@gmail.com>, dan.j.williams@intel.com,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, linux-nvdimm@lists.01.org,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, linux-input@vger.kernel.org,
 Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, josh@joshtriplett.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>, robh+dt@kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Jonathan Derrick <jonathan.derrick@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, akpm@linux-foundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 09:14:29AM +0800, Baoquan He wrote:
>Hi Wei Yang,
>
>On 04/26/18 at 09:18am, Wei Yang wrote:
>> On Thu, Apr 19, 2018 at 08:18:46AM +0800, Baoquan He wrote:
>> >The struct resource uses singly linked list to link siblings. It's not
>> >easy to do reverse iteration on sibling list. So replace it with list_head.
>> >
>> 
>> Hi, Baoquan
>> 
>> Besides changing the data structure, I have another proposal to do the reverse
>> iteration. Which means it would not affect other users, if you just want a
>> reverse iteration.
>> 
>> BTW, I don't think Andrew suggest to use linked-list directly. What he wants
>> is a better solution to your first proposal in
>> https://patchwork.kernel.org/patch/10300819/.
>> 
>> Below is my proposal of resource reverse iteration without changing current
>> design.
>
>I got your mail and read it, then interrupted by other thing and forgot
>replying, sorry.
>
>I am fine with your code change. As I said before, I have tried to change
>code per reviewers' comment, then let reviewers decide which way is
>better. Please feel free to post formal patches and joining discussion
>about this issue.

Yep, while I don't have a real requirement to add the reverse version, so what
is the proper way to send a patch?

A patch reply to this thread is ok?

>
>Thanks
>Baoquan
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
