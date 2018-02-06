Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2507369-1517961398-3-32646732206331373
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517961398; b=VagYFWLDUPyAlpWJKFmMsmUbMRVMcJGMJhahHBRXARc4XVM
    8d8taB3x7JRNEKrJsKCUCUlH+l1ZxEoSa/+ZhGxaGvAmfe0qwmAsQ1S0Pe3kbU5X
    6xLsmlLNovQzzkJW5OMGSNRrtIwVhKqdn9pP0PzHFhSG3l72DUT4eFxjB1C+y48j
    2hwnxEQEi2Nb5BE9QpFzeD8q89W7OuiO12zaSlDwJojYlb9T94pZagl3ltCsTjSo
    LtNH0LX2DVZc/yodLGWu4OzLVIV7uEJYPuk//E0jXb+430SzN5+QesmlNhPRy3Hn
    54jro1ZFWwUyzOh7sJTbPvTfG6wZBB996jp0NwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc
    :content-transfer-encoding:content-type:sender; s=arctest; t=
    1517961398; bh=WVhL+08YYxVlXyiad6U07UVc1FED+u2NYN/jsX28hH8=; b=C
    asGVc1Qvc/7ObXGxzz4ftTqSopo4v0qkBpI8k5TTckPo79we2pNyA7CNqApps1II
    BenInOOtrwZpJN7SoQhBOI1S/Di30OqXD9L21iQLp1lM9CgWCYWIqD7X8x3RZqE0
    FXOlLqX8woazGBCLIaiXOT9CnjjmmZRP6HV4rFaKl8XzRYDJ92KFeIa1szDKlyhf
    Co09G0uJeXzuxWIm7nmI2+UmnKpRk9d9yKPtjczMCCHHVFAM2T59UMkdSlRo7qm+
    t9HOVG72VRA/2+mUZ+aDAW5KzKIr57Kos3qH+Odfhc7g0UpYcU7dQ8s2Ss1Yfnei
    PcJ4MFT3KlvEiJCNDoNMg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nYL7uCo0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nYL7uCo0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AH8x2250G4xCrfjcOci2Dm4+trStbO9D5dq1BSgaLR7F3By+IIh0bL4LgBajulFlKGZhfjQZ1IsodQ==
Subject: Re: [PATCH v3] staging: android: ion: Add implementation of
 dma_buf_vmap and dma_buf_vunmap
To: Alexey Skidanov <alexey.skidanov@intel.com>,
 Greg KH <gregkh@linuxfoundation.org>
References: <1517400222-2854-1-git-send-email-alexey.skidanov@intel.com>
 <20180131130047.GA22917@kroah.com>
 <89be45dd-ac0e-4efb-2b21-e6c07b0cd66e@intel.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <bf909d75-21a4-9d6d-2f72-887492821252@redhat.com>
Date: Tue, 6 Feb 2018 15:56:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <89be45dd-ac0e-4efb-2b21-e6c07b0cd66e@intel.com>
Content-Language: en-US
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
Cc: devel@driverdev.osuosl.org, tkjos@android.com, rve@android.com,
 linux-kernel@vger.kernel.org, maco@android.com, sumit.semwal@linaro.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/31/2018 10:10 PM, Alexey Skidanov wrote:
> 
> On 01/31/2018 03:00 PM, Greg KH wrote:
>> On Wed, Jan 31, 2018 at 02:03:42PM +0200, Alexey Skidanov wrote:
>>> Any driver may access shared buffers, created by ion, using dma_buf_vmap and
>>> dma_buf_vunmap dma-buf API that maps/unmaps previosuly allocated buffers into
>>> the kernel virtual address space. The implementation of these API is missing in
>>> the current ion implementation.
>>>
>>> Signed-off-by: Alexey Skidanov <alexey.skidanov@intel.com>
>>> ---
>>
>> No review from any other Intel developers? :(
> Will add.
>>
>> Anyway, what in-tree driver needs access to these functions?
> I'm not sure that there are the in-tree drivers using these functions and ion as> buffer exporter because they are not implemented in ion :) But there are some in-tre> drivers using these APIs (gpu drivers) with other buffer exporters.

It's still not clear why you need to implement these APIs.
Are you planning to use Ion with GPU drivers? I'm especially
interested in this if you have a non-Android use case.

Thanks,
Laura
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
