Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3571979-1525822896-2-13487767790204626535
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525822895; b=dWxA80yx0A1233EjH1vZrAS2GDmnjkfwxhiFd0BSagwu/uoYzz
    SkzsFDE1P4aVW7o2G8IvNO7/Cti+ZB6rL3rs4Xo4B9XE97zRoMfn6RdpaTVcd6gG
    aQ897/fMl0W1yjGxxt34ueyCtFOeELYx38nLX7uNpJV9AOlD902S3hsLN/bafkl7
    qKsiN4ewwkgUl76cdVBOdxgT8l8Azkna72aIoq15qqAoK6UDUAYJiUjsBZcz8/M2
    vKcwlYmsIRfMgfb/trT+zlZN1ohZfnxnaWpLyarBJr/66a4MdYHG5/bK1eqavlRy
    aQJFnJyTUdbfUhsrhEBou/sVn7Zh+fEYqpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525822895; bh=z8790jWQZpXGk1VNL3qWM9B5/4FUgQuPNBypKh1aoZo=; b=S
    P5+Mf3fiJ6E1FayY/kgwJKgBI82p3ugOMnLRnVLwV8m7y/9YoKo6SVbzXrRcESqH
    DuWte1vMF4dgsdo9Mw4CC6MfOL1d5C25cxnn+PYQmIan+FnD+xLQ/yzVRGJcedf1
    ziKozVHo7BevdJtf3pPsdGCYm6k9cuC80sLYGue4GfQ4PeVglByRPd/YuA19Hxz9
    hZuPbHGTHJLRwJjaA/33xL51NhUCdLLU8Gk+t/R9Eazo73fExX0fl2MFiOiPsNMt
    4RKzlICGF2O7uFV1yMh7zNM2JrWiUhCKQbtoiXAu4mMqaDYvmqsHIRuz447zbWqL
    K+2AORWzBDZuBLKvLZ2cg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=hM/iDPB+ x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=cTuc9O0n;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=hM/iDPB+ x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=cTuc9O0n;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=gmail.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPQavYLlJ56xpAJ+q9DYnX35L34wnAlH3VlRHTnF/LIG3EsyeY0BlIgvJFXEB1/5cVg3eN4yw9kWjiqHOfJYROhxLFEe88UzV5ObdQfntuX2gTCnBTOX
    n9LOOilSLNIczF481a18rUAnkVnI6oriyH/C6ok7uiALa40GMLiAq6cijt67K3bBygxGSGqmPnBV9XqBfKRKt257K6/3l7kKArcCHPpaPlUBFLCv3WMEqvm2
    vwt+97Jqqv63v9vRAcdiFg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=x42tTbUH5sAA:10 a=kj9zAlcOel0A:10
    a=x7bEGLp0ZPQA:10 a=xfq7aEqWmQcA:10 a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=VwQbUJbxAAAA:8 a=DDOyTI_5AAAA:8 a=KpyH_01ORFipDaOD53YA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22
    a=EuMvGzoevXUWrpekGtjw:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZrmUCdHSz7o7ZER8l3HQQG/V7w7tQiwPy5g8hGI++5ggPun54XCGWhNEs8xwGXt9NXFlb51Pw==
Date: Wed, 9 May 2018 08:41:23 +0900
From: Wei Yang <richard.weiyang@gmail.com>
To: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link sibling resource
Message-ID: <20180508234123.GA23307@WeideMacBook-Pro.local>
References: <20180419001848.3041-1-bhe@redhat.com>
 <20180419001848.3041-2-bhe@redhat.com>
 <20180426011837.GA79340@WeideMacBook-Pro.local>
 <20180507011429.GG30581@MiWiFi-R3L-srv>
 <20180508114845.GA19459@WeideMacBook-Pro.local>
 <20180508121123.GI30581@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180508121123.GI30581@MiWiFi-R3L-srv>
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

On Tue, May 08, 2018 at 08:11:23PM +0800, Baoquan He wrote:
>On 05/08/18 at 08:48pm, Wei Yang wrote:
>> On Mon, May 07, 2018 at 09:14:29AM +0800, Baoquan He wrote:
>> >Hi Wei Yang,
>> >
>> >On 04/26/18 at 09:18am, Wei Yang wrote:
>> >> On Thu, Apr 19, 2018 at 08:18:46AM +0800, Baoquan He wrote:
>> >> >The struct resource uses singly linked list to link siblings. It's not
>> >> >easy to do reverse iteration on sibling list. So replace it with list_head.
>> >> >
>> >> 
>> >> Hi, Baoquan
>> >> 
>> >> Besides changing the data structure, I have another proposal to do the reverse
>> >> iteration. Which means it would not affect other users, if you just want a
>> >> reverse iteration.
>> >> 
>> >> BTW, I don't think Andrew suggest to use linked-list directly. What he wants
>> >> is a better solution to your first proposal in
>> >> https://patchwork.kernel.org/patch/10300819/.
>> >> 
>> >> Below is my proposal of resource reverse iteration without changing current
>> >> design.
>> >
>> >I got your mail and read it, then interrupted by other thing and forgot
>> >replying, sorry.
>> >
>> >I am fine with your code change. As I said before, I have tried to change
>> >code per reviewers' comment, then let reviewers decide which way is
>> >better. Please feel free to post formal patches and joining discussion
>> >about this issue.
>> 
>> Yep, while I don't have a real requirement to add the reverse version, so what
>> is the proper way to send a patch?
>> 
>> A patch reply to this thread is ok?
>
>I am not sure either. Since my patches are still under reviewing. And
>you have pasted your patch. It depends on maintainers, mainly Andrew and
>other reviewers who have concerns.

Ok, thanks.

-- 
Wei Yang
Help you, Help me
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
