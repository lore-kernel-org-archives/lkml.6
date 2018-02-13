Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2797766-1518484847-5-5786475088389046762
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='ISO-8859-15', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518484847; b=FX91bao9XtsSbBUfGiACs6L1V0gKNSTSvmNhEQCDVvGBAeU
    Xf3/MNdssiWQmjLccXDl+GdVC/sVhkB2coJfgWwFPhilHpG23A0NKw4/mnBpy25G
    2EguFmGBudpTNgwH4ReussY+KLos0Vo7mp0EKmhB5cClhmxMtMIsLDXumvtydfzD
    Ws0iLs6W7HfZXInslp/8EGYvlN6LHhBsLTHJEYZ77OZcCQVqc5nf6VfjzeWOiP8s
    MnVvcuXA0tf1ofC9/K6S3cSZSoibF8gWGOYzkBlnrmIktKbzDoEyvLg7osNzyv/S
    34RsFBfGT43v9AeKYcwyaIwGEnyS7470qai7Unw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518484847; bh=+
    PQsYRH8R5fGOQBKpVck6x+R50dziE5kOo8VMs5ja6o=; b=qq8PyY78dPfX0eryO
    SKyorOEgdmAAWnIZM34QTYyc7WKHTJvcjNxRmt/hWywYcNH5pZ/I1oAhW0mI9lG/
    vyKXAME1+lsMnJ+gOuc71WY6d/Wy5yvdw943TrbWuKpI1A1C7J6GKE7k1NdO3S7V
    CEMpPapPS2xvNQCpKpP78p7PSIUuh1jq7BvJJW8bBWjeyAMX4nAmwGJi5645ncqx
    WOFqq0QH9sxaRoqKW1/hmdZG5DRvDp3c1KvhOHToW4Pl1aiacdBOvW4f5JbY0v9j
    brgZ3La2wi0QMvPCDceJpcGAesj/V0U2bbTOVyartBVihrgcB2ftY1ktbuP5WAoY
    kj6tw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=e++O1XQ/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=e++O1XQ/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=e++O1XQ/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=e++O1XQ/ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=codeaurora.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19AA16055B
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org;
 spf=none smtp.mailfrom=lmark@codeaurora.org
Date: Mon, 12 Feb 2018 17:20:38 -0800 (PST)
From: Liam Mark <lmark@codeaurora.org>
X-X-Sender: lmark@lmark-linux.qualcomm.com
To: Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH] staging: android: ion: Restrict cache maintenance to
 dma mapped memory
In-Reply-To: <6c61b218-c56d-659a-47f8-2cd5d44d28ca@redhat.com>
Message-ID: <alpine.DEB.2.02.1802121644130.3305@lmark-linux.qualcomm.com>
References: <alpine.DEB.2.02.1802092217010.2846@lmark-linux.qualcomm.com>
 <6c61b218-c56d-659a-47f8-2cd5d44d28ca@redhat.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
 linux-kernel@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 =?ISO-8859-15?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
 Martijn Coenen <maco@android.com>, Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 12 Feb 2018, Laura Abbott wrote:

> On 02/09/2018 10:21 PM, Liam Mark wrote:
> > The ION begin_cpu_access and end_cpu_access functions use the
> > dma_sync_sg_for_cpu and dma_sync_sg_for_device APIs to perform cache
> > maintenance.
> > 
> > Currently it is possible to apply cache maintenance, via the
> > begin_cpu_access and end_cpu_access APIs, to ION buffers which are not
> > dma mapped.
> > 
> > The dma sync sg APIs should not be called on sg lists which have not been
> > dma mapped as this can result in cache maintenance being applied to the
> > wrong address. If an sg list has not been dma mapped then its dma_address
> > field has not been populated, some dma ops such as the swiotlb_dma_ops ops
> > use the dma_address field to calculate the address onto which to apply
> > cache maintenance.
> > 
> > Fix the ION begin_cpu_access and end_cpu_access functions to only apply
> > cache maintenance to buffers which have been dma mapped.
> > 
> I think this looks okay. I was initially concerned about concurrency and
> setting the dma_mapped flag but I think that should be handled by the
> caller synchronizing map/unmap/cpu_access calls (we might need to re-evaluate
> in the future)


I had convinced myself that concurrency wasn't a problem, but you are 
right it does need to be re-evaluated. For example the code could be at 
the point after the dma unmap call has completed but before dma_mapped has 
been set to false, and if userspace happened to slip in a call to begin/end cpu 
access cache maintenance would happen on memory which isn't dma mapped. 
So at least this would need to be addressed, maybe for this issue just 
move the setting of dma_mapped to the start of the ion_unmap_dma_buf function.

I can clean this up and any other concurrency issues we can identify.

> 
> I would like to hold on queuing this for just a little bit until I
> finish working on the Ion unit test (doing this in the complete opposite
> order of course). I'm assuming this passed your internal tests Liam?

Yes it has passed my internal ION unit tests, though I haven't given 
the change to internal ION clients yet.

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
