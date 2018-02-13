Return-Path: <tfiga@chromium.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518526488; cv=none;
        d=google.com; s=arc-20160816;
        b=ZbCX6cIA5YyTFuEgM/uJRJZlOhqYfxxRoNeW/xHjk3DTfMJpzEzOdnefBH7ZBKl/Iv
         p0biUyUPP+n4Vr26of1UmtnT3TnSrNTx2bniL9JDafrYDdqchGbL2521bitZMo6ctOa/
         vFCgbjqGO+3n+PAdf2UhDyhAwRDOjUL5K80C+F+9WeSIz+WJNrKWcQHNnF2spIka10hl
         Q3yTQJWxMUAQG0j88IZYpCMuB9SYNxwxQgkudBfaf+PEREXpu73bOzzsHOdqVS7OvlSk
         hkglSGsyQ5nSC8gP6c+CdWJDYju5Rs79zLcZhJt/4B5L+zutkNDD27ljN81qbKmPUGhw
         eegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=nybD7bIzo40TK7fHArBCZP1tRwEiCf27gktxkvceKY0=;
        b=ObS7mpaGIkNd+1YAqGlCSmlV+0zv23LvU03f4mh27tps/fcBWteRfhsx0yrDyvImG6
         7cFxOUV6SNR1Q52QQ2XMTh79rdINfpk298aZeOAKKYCBoXlZm2Glckg9Cjto2gYC21w5
         BmVL6+Qkb6K+wsqTzC21lCrGEclOsWiVIia59/ENsHgKpClrsFMSXl1JzjH9jqgdShOW
         1qp4N0sq66BRIkj2PLr7q5RRPOLbILToU9jrUfDBMkhbIxmuIPWPpKBZf+/Ydc8rRj7O
         bGt/JCZ6MuKJ0QZbo8/DHjhAcFKf/WabBYPmmlPup7G2yhNCyISmpgmPt+Ly03EljjpG
         uTAw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=F1f/hq2G;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=F1f/hq2G;
       spf=pass (google.com: domain of tfiga@chromium.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=tfiga@chromium.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AH8x225G4HGapmmdiTD91z/ho98t1GU9Pyx9bVKOVxhjfHAc+OeScioYD3Rrgd+9PMd/SlbYOZM/yg==
MIME-Version: 1.0
In-Reply-To: <65d707c0-76cc-d59e-ff18-1fdd89306900@arm.com>
References: <1517999482-17317-1-git-send-email-vivek.gautam@codeaurora.org>
 <1517999482-17317-2-git-send-email-vivek.gautam@codeaurora.org>
 <CAAFQd5BmroRf-C8dQkvTKHWK1psGnNi1t7g-q=Xce6KjrGTsdw@mail.gmail.com> <65d707c0-76cc-d59e-ff18-1fdd89306900@arm.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Tue, 13 Feb 2018 21:54:26 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DNzGYnTRuc2hDr1osQ2=6ruM0wQqV8svP=a10hxTVOGQ@mail.gmail.com>
Message-ID: <CAAFQd5DNzGYnTRuc2hDr1osQ2=6ruM0wQqV8svP=a10hxTVOGQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] base: power: runtime: Export pm_runtime_get/put_suppliers
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vivek Gautam <vivek.gautam@codeaurora.org>,
	"list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>,
	freedreno@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
	Greg KH <gregkh@linuxfoundation.org>, sboyd@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591737849838824813?=
X-GMAIL-MSGID: =?utf-8?q?1592290431002034743?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 9:00 PM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 13/02/18 07:44, Tomasz Figa wrote:
>>
>> Hi Vivek,
>>
>> On Wed, Feb 7, 2018 at 7:31 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>>
>>> The device link allows the pm framework to tie the supplier and
>>> consumer. So, whenever the consumer is powered-on the supplier
>>> is powered-on first.
>>>
>>> There are however cases in which the consumer wants to power-on
>>> the supplier, but not itself.
>>> E.g., A Graphics or multimedia driver wants to power-on the SMMU
>>> to unmap a buffer and finish the TLB operations without powering
>>> on itself.
>>
>>
>> This sounds strange to me. If the SMMU is powered down, wouldn't the
>> TLB lose its contents as well (and so no flushing needed)?
>
>
> Depends on implementation details - if runtime PM is actually implemented
> via external clock gating (in the absence of fine-grained power domains),
> then "suspended" TLBs might both retain state and not receive invalidation
> requests, which is really the worst case.

Agreed. That's why in "[PATCH v7 3/6] iommu/arm-smmu: Invoke
pm_runtime during probe, add/remove device" I actually suggested
managing clocks separately from runtime PM. At least until runtime PM
framework arrives at a state, where multiple power states can be
managed, i.e. full power state, clock-gated state, domain-off state.
(I think I might have seen some ongoing work on this on LWN though...)

>
>> Other than that, what kind of hardware operations would be needed
>> besides just updating the page tables from the CPU?
>
>
> Domain attach/detach also require updating SMMU hardware state (and possibly
> TLB maintenance), but don't logically require the master device itself to be
> active at the time.

Wouldn't this hardware state need to be reinitialized anyway after
respective power domain power cycles? (In other words, hardware would
only need programming if it's powered on at the moment.)

Best regards,
Tomasz
