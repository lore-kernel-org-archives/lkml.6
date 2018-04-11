Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1229218-1523416954-2-7335120469966825509
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
    1523416954; b=Qhdnm4+eGeXH2fAcM8IsUFSfQ1XTu0rLBD6FgfWopgEmb+L8Ql
    Q1aGWTeUFdh76jzcFOPyehpChE31M0CXak2d63rUzOPkxLDBYdVtd6kuBohGDA/H
    cpjy65iAUfB1fXY+tfCJ2M6mBsRVbK7O+K/ds7pSjq2Xza3V+0qmusxtE4MqzisA
    ruDGvKncgBoMzWjDSKuMDf/w8p5do8e2m0d3QBxFvZb0Q/gmOnP3cmuU4qGDeKmg
    Y2L4OdPtDh3NfqE0J2wjaQIWbXI4EKTBCJwzK2dvLpRgdxXGUTlJtrZAP8Dy3wYl
    mig2tve6EYYtPVftlEazq8l0Zijas7mSA/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:reply-to:cc
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1523416954; bh=QgjCxbf9yfDNPG/vqEfK4Ousx99gNxIvEHJjVh9aSyk=; b=c
    GgCEJng9eMuLPVlmTEYcRu3dEy114NrOMQPDrWEbhTdrfQ4QhbUiQyDSFy7kk+c4
    xORhOxGzSONVd49pVVTVBOkOr/mSlqEBo8lNrVcoJItk8HBioZl6FUObWJK15AQ5
    PtEWxn08qv1YE2OkOHPc3Z3pLugiYeGiHr5vGnYJQJfTA/wMqBPHcOe+IIL8K82J
    suEQgWKnT3AG/65JWDLsp4wC8tWU8c9ITkH8fuaQDXzxopEGlWTDCHRHvrSk65+A
    Nj4L54GpAnDNyjr+3NH9OHkfgi98aUCt6lMqCoGvDU1A4tmIKssaSF9zIsCKMR0a
    HbN2RxnVRp+dnu+zzYG0w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DY5mGoXm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g4BozwxB;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DY5mGoXm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g4BozwxB;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfADc1wHsyhtOy0Hq34nE++60S6eyOd96wiRFL/oc14o4FNrjvYuJtGAH5cdb8datAN3dCnh6l3Ut9joeGEKVX+cKktuemAX5J+8JSMo9bSFXIeAot6qq
    qnasbDaJL6tW/vL1R3GmbP1qN0hKHBIsMOAau0mVCcHyD3kCF3h3uOkLbIuq+b4xyfLkmJxiqRsmdMmMJ4UEQj1RsviD9xF731wvych4cfqqZrjvTy/mBvwu
    ieWF6S534IFhszeleXEHCg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=x42tTbUH5sAA:10 a=kj9zAlcOel0A:10
    a=x7bEGLp0ZPQA:10 a=xfq7aEqWmQcA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10
    a=jJxKW8Ag-pUA:10 a=20KFwNOVAAAA:8 a=D19gQVrFAAAA:8 a=DDOyTI_5AAAA:8
    a=T_og7bgVABq07wJk65wA:9 a=q4MvVujFF5fOru5g:21 a=xlijgfSD5Ia_m02l:21
    a=CjuIK1q_8ugA:10 a=W4TVW4IDbPiebHqcZpNg:22 a=_BcfOz0m4U4ohdxiHPKc:22
    a=EuMvGzoevXUWrpekGtjw:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx49uXUMYLRHJ3+zUs2PBrL0m9/rz9PeZ4at0izaXR+LZy6D5u0yOluMG2CdJIwSlm67/AyuYwQ==
Date: Wed, 11 Apr 2018 11:22:20 +0800
From: Wei Yang <richard.weiyang@gmail.com>
To: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 1/3] resource: Use list_head to link resource sibling
Message-ID: <20180411032220.GA49071@WeideMacBook-Pro.local>
References: <20180408024724.16812-1-bhe@redhat.com>
 <20180408024724.16812-2-bhe@redhat.com>
 <20180409090853.GJ19345@localhost.localdomain>
 <CAL_Jsq+xxa9ep2LK3H6YWhwrZtc-T73Y84ry6Hs-JJ3XEXoGsw@mail.gmail.com>
 <20180410134416.GM19345@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180410134416.GM19345@localhost.localdomain>
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
Cc: Brijesh Singh <brijesh.singh@amd.com>, devicetree@vger.kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Wei Yang <richard.weiyang@gmail.com>, Keith Busch <keith.busch@intel.com>,
 Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Frank Rowand <frowand.list@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>, Nicolas Pitre <nico@linaro.org>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, linux-input@vger.kernel.org,
 Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, linux-nvdimm@lists.01.org,
 =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Derrick <jonathan.derrick@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 devel@linuxdriverproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 09:44:16PM +0800, Baoquan He wrote:
>Hi Rob,
>
>Thanks a lot for looking into this and involve Nico to this thread!
>
>On 04/09/18 at 09:49am, Rob Herring wrote:
>> +Nico who has been working on tinification of the kernel.
>> 
>> On Mon, Apr 9, 2018 at 4:08 AM, Baoquan He <bhe@redhat.com> wrote:
>> > The struct resource uses singly linked list to link siblings. It's not
>> > easy to do reverse iteration on sibling list. So replace it with list_head.
>> 
>> Why is reverse iteration needed?
>
>This is the explanation I made when Andrew helped to review the v1 post:
>https://lkml.org/lkml/2018/3/23/78
>
>Because we have been using kexec-tools utility to search available
>System RAM space for loading kernel/initrd/purgatory from top to down.
>That is done in user space by searching /proc/iomem. While later added
>kexec_file interface, the searching code happened in kernel, and it
>only search System RAM region bottom up, then take an area in that found
>RAM region from top to down. We need unify these two interfaces on
>behaviour since they are the same on essense from the users' point of
>view, though implementation is different. As you know, the singly linked
>list implementation of the current resource's sibling linking, makes the
>searching from top to down very hard to satisfy people. 
>
>Below is the v1 post, we make an temporary array to copy iomem_resource's
>first level of children, then iterate the array reversedly. Andrew
>suggested me to try list_head after reviewing. In fact we can optimize
>that patch to only copy resource pointer into array, still the way is
>ugly.
>https://lkml.org/lkml/2018/3/21/952
>
>Then Wei pasted a patch he had made as below. He didn't mention if he
>also has requirement on reversed iteration of resource. That is an O(n*n)
>way, from personal feelings, hard to say if it's bettern than v1 post.
>https://lkml.org/lkml/2018/3/24/157

I don't have requirement on reverse iteration of resource structure.

My approach is almost the same as current walk_system_ram_res(). Since each
resource keeps parent, we could get previous resource by search on
res->parent->child.

The complexity of a whole iteration is O(N * W / 2), where N is the number of
resources in the tree and W is the average number of siblings of each
resource.

And this approach doesn't need to change current structure.

>
>That's why I would like to have a try of the list_head linking.
>

-- 
Wei Yang
Help you, Help me
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
