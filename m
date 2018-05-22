Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459670-1526947684-2-8669692096869935953
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526947683; b=Qg+UcB2ZwbQotlFYpodr59YLJYWXT6aaeUgQ94QYoaQNlbnXZG
    1kddf03NL6V7G8zWOv3X4Qmpxh7uGg7Ty105nYbhPItFZBpVKiguDUEPrBFFuwp+
    CLuo4CdCmnM+sxIR9xCi8tedgItuWng1awkJqsdpn58G+YX6P5w2kCqianeSSqfc
    eV/BZbC3ZghWri7j5xXXUvSrO8HvQHMV3/oWvllWNINL+B9bYmPwW6r/2d8MeK4G
    2vVUWtqB0GJOcEZHZevKiiJcqjpDHH8xtEoLFU0OAErcDtFPlmjvg1eeIH7a7qiS
    hJKEH4jo6KRNwsy/hPYWX/F1fKxwCLNM2rMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526947683;
    bh=47AIRV9Z+ao724w//S/gpQ8V72icvU4Eu+SHJWE0mBQ=; b=G3tnmZAPNlOH
    IfMogYIq2POOOT0CdkvWYs06h7Ak6NQ+ZlmV6qJ2AzxKwlcgzNnsiRsUBcIJZgbJ
    rBqtakmzMgBV8x8hW8nezBGC9vHqdN8Fh/gTLlO7tz+BUJYTcBn5bdn4Fo5893Cx
    EkwO1vHnIpWE+C9Si4AFKRQMlyDD5F+x7WQxMVXvrjohWqwVMZK5i8/+G0Oxh+wT
    Mk7eDW1GgJlc1H3XZcmuQFnWZv10gUsb5FVcYw+FIrahqn5g5n3aXZunaqTIgvB+
    Y05HPbh5MLix/0AcfpQVGFvrhrrvJTMRia4KL+ljBoel4kknG3zKHkX/Ne2ZKC91
    +HvWXCfsyA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
    header.d=intel-com.20150623.gappssmtp.com
    header.i=@intel-com.20150623.gappssmtp.com header.b=bA3YSWK0
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=JKHDv+uo;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256)
      header.d=intel-com.20150623.gappssmtp.com
      header.i=@intel-com.20150623.gappssmtp.com header.b=bA3YSWK0
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=JKHDv+uo;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA+2roBIS5soqbC0Ak25gaj0w4U8Jz5L7zoaudqzVKt0oRzLHBsvcvOfsguB7jlbjd7vC7ks4kEoDaJpsCbKM0pVFYyJoSnsCasP00q6eJgFygXYs57o
    pwfRpOoQ7InqjEjqW6ZSTvSTSmrX4BMftj6WcQWesfwMERYaNDWq92gwq5t7zu9+WsLRmRq7RB0QSRZnt1BUVQTZeXkAmZt5ATdhw/PcuElTDoe0V4m6hObE
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Z4Rwk6OoAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
    a=gXLdhW2jAAAA:8 a=piV7S2qM-yj5RJYAWmwA:9 a=QEXdDO2ut3YA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22 a=Dn9eIPSr_RzuO0KTJioD:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeEVAHv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 20:07:51 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:46772 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbeEVAHu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 May 2018 20:07:50 -0400
X-Google-Smtp-Source: AB8JxZp8oD2Gi2rnfwzhsqb5noN6GmE5jBap0ZuCO+W4n0RPoDwsFOxM5s3yWhHb5MZwAJTPPJB9oPCNuF2yb1PGSpM=
MIME-Version: 1.0
In-Reply-To: <20180521161026.709d5f2876e44f151da3d179@linux-foundation.org>
References: <152694211402.5484.2277538346144115181.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152694212460.5484.13180030631810166467.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180521161026.709d5f2876e44f151da3d179@linux-foundation.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 21 May 2018 17:07:49 -0700
Message-ID: <CAPcyv4hMwMefMu3La+hZvN6r+Q6_N5t+eOgGE0bqVou=Cjpfwg@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm, devm_memremap_pages: handle errors allocating
 final devres action
To: Andrew Morton <akpm@linux-foundation.org>
Cc: stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[ resend as the last attempt dropped all the cc's ]

On Mon, May 21, 2018 at 4:10 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, 21 May 2018 15:35:24 -0700 Dan Williams <dan.j.williams@intel.com=
> wrote:
>
>> The last step before devm_memremap_pages() returns success is to
>> allocate a release action to tear the entire setup down. However, the
>> result from devm_add_action() is not checked.
>>
>> Checking the error also means that we need to handle the fact that the
>> percpu_ref may not be killed by the time devm_memremap_pages_release()
>> runs. Add a new state flag for this case.
>>
>> Cc: <stable@vger.kernel.org>
>> Fixes: e8d513483300 ("memremap: change devm_memremap_pages interface..."=
)
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
>> Cc: Logan Gunthorpe <logang@deltatee.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Why the cc:stable?  The changelog doesn't describe the end-user-visible
> impact of the bug (it always should, for this reason).

True, I should have included that, one of these years I'll stop making
this mistake.

>
> AFAICT we only go wrong when a small GFP_KERNEL allocation fails
> (basically never happens), with undescribed results :(
>

Here's a better changelog:

---
The last step before devm_memremap_pages() returns success is to
allocate a release action to tear the entire setup down. However, the
result from devm_add_action() is not checked.

Checking the error also means that we need to handle the fact that the
percpu_ref may not be killed by the time devm_memremap_pages_release()
runs. Add a new state flag for this case.

Without this change we could fail to register the teardown of
devm_memremap_pages(). The likelihood of hitting this failure is tiny
as small memory allocations almost always succeed. However, the impact
of the failure is large given any future reconfiguration, or
disable/enable, of an nvdimm namespace will fail forever as subsequent
calls to devm_memremap_pages() will fail to setup the pgmap_radix
since there will be stale entries for the physical address range.
