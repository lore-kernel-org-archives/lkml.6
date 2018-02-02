Return-Path: <sricharan@codeaurora.org>
X-Google-Smtp-Source: AH8x225YEtwZ6isbwe9X1nesyfX6pzRPlOC6/NRgmDlZ2E6mpJ109/SGwsSYBGUs+JvcM89TvIQ/
ARC-Seal: i=1; a=rsa-sha256; t=1517577248; cv=none;
        d=google.com; s=arc-20160816;
        b=TzHwAM2w38eZAierWJEjn/C6HCqKmdkY+Jto0ydLtVpjqdSiECxv0lsplxF0geQy10
         del7CsXXlTNE+2kY2fHwqIQGOlo07pDxxhKXJSI+f2XrRjdibKEtZGyIlFvkXQzPGWU4
         CRnloppZnojyMJ/SZCDk+NMoXUcuRQAth4rmzQuWffIRR6yyo46I+2zj/Dotq6diZZb8
         algzif4gn/5tZrSxaB5fDyGeBZoId5B6RW13UBQ/0GU+3LNojI8m0XpoVff66Fk7tOFJ
         Kb0BuIdifcM5vggMh/mHj5WZtDbggSaBxuIJvrpvpKPgEugnCShWQHD1OmdSx9EzsdvU
         Qjvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=k27Y8M8FCZ/c1caYGG7dEOrvbKBWXD/PVdkOmWNnqLg=;
        b=XwZ2Yhn5HW4MwlWuyUJwAHgLj4ckqpkirC0CKZZrmZPjdIJ21v+IpFr3EOP5K9YaW+
         QjfMUBClE5cLNgsn5CirDCu9yBfnuOSsT6DG5sXg2I4dPE8wBST39O/8J6QU025DqumF
         CpHb63E/NUFbP+kHdnf7Wl8KPgYNto1zVBl7JkLRKvUSd6CD83vCqS+nysKOgiiI2g76
         LnsYVV4f1LF221e120N6psy81+/WndWonyomKRJOkLUQij+KAZNTF6yDzH+rm4ytiYEh
         9OU6LM/ys77pcR2vYbHnNO0lgqcx0PqtBBqDOqZv79zdykAFfW9LddtrsjAmz9p2vVgZ
         aAtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RULFJ8Ak;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RULFJ8Ak;
       spf=pass (google.com: domain of sricharan@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sricharan@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RULFJ8Ak;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=RULFJ8Ak;
       spf=pass (google.com: domain of sricharan@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=sricharan@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E53FE6014B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
Subject: Re: [PATCH v6 4/6] iommu/arm-smmu: Add the device_link between
 masters and smmu
To: Robin Murphy <robin.murphy@arm.com>,
 Vivek Gautam <vivek.gautam@codeaurora.org>, alex.williamson@redhat.com,
 robh+dt@kernel.org, mark.rutland@arm.com, rjw@rjwysocki.net,
 will.deacon@arm.com, iommu@lists.linux-foundation.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, sboyd@codeaurora.org
Cc: gregkh@linuxfoundation.org, m.szyprowski@samsung.com,
 architt@codeaurora.org, linux-arm-msm@vger.kernel.org
References: <1516362223-22946-1-git-send-email-vivek.gautam@codeaurora.org>
 <1516362223-22946-5-git-send-email-vivek.gautam@codeaurora.org>
 <6b930150-cb81-b0a5-601c-16cb576c4341@arm.com>
 <b7887b45-774a-2515-4304-227037b9af1f@codeaurora.org>
 <7cc4caec-4264-db9d-3afa-e3d20d3edfa7@codeaurora.org>
 <f8932e2f-75bb-ce30-ae68-1870477fad5f@arm.com>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <8476fe51-e6f9-2028-82e0-353182e4032f@codeaurora.org>
Date: Fri, 2 Feb 2018 18:44:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f8932e2f-75bb-ce30-ae68-1870477fad5f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590021073891800456?=
X-GMAIL-MSGID: =?utf-8?q?1591295080290962951?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Robin,

On 2/2/2018 5:01 PM, Robin Murphy wrote:
> On 02/02/18 05:40, Sricharan R wrote:
>> Hi Robin/Vivek,
>>
>> On 2/1/2018 2:23 PM, Vivek Gautam wrote:
>>> Hi,
>>>
>>>
>>> On 1/31/2018 6:39 PM, Robin Murphy wrote:
>>>> On 19/01/18 11:43, Vivek Gautam wrote:
>>>>> From: Sricharan R <sricharan@codeaurora.org>
>>>>>
>>>>> Finally add the device link between the master device and
>>>>> smmu, so that the smmu gets runtime enabled/disabled only when the
>>>>> master needs it. This is done from add_device callback which gets
>>>>> called once when the master is added to the smmu.
>>>>
>>>> Don't we need to balance this with a device_link_del() in .remove_device (like exynos-iommu does)?
>>>
>>> Right. Will add device_link_del() call. Thanks for pointing out.
>>
>>   The reason for not adding device_link_del from .remove_device was, the core device_del
>>   which calls the .remove_device from notifier, calls device_links_purge before that.
>>   That does the same thing as device_link_del. So by the time .remove_device is called,
>>   device_links for that device is already cleaned up. Vivek, you may want to check once that
>>   calling device_link_del from .remove_device has no effect, just to confirm once more.
> 
> There is at least one path in which .remove_device is not called via the notifier from device_del(), which is in the cleanup path of iommu_bus_init(). AFAICS any links created by .add_device during that process would be left dangling, because the device(s) would be live but otherwise disassociated from the IOMMU afterwards.
> 
> From a maintenance perspective it's easier to have the call in its logical place even if it does nothing 99% of the time; that way we shouldn't have to keep an eye out for subtle changes in the power management code or driver core that might invalidate the device_del() reasoning above, and the power management guys shouldn't have to comprehend the internals of the IOMMU API to make sense of the unbalanced call if they ever want to change their API.

 Ha, for a moment was thinking that with probe deferral add/remove_iommu_group in iommu_bus_init is dummy.
 But that may not be true for all Archs.
 Surely agree for the maintainability reason as well. Thanks.

Regards,
 Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
