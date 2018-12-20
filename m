Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED22C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11982186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kwzAOckJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbeLTM1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:27:46 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37295 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbeLTM1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:27:45 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181220122744euoutp0154915cd749559af4cc3195c1899d8dbb~yCjmMLdVK2150821508euoutp01o
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 12:27:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181220122744euoutp0154915cd749559af4cc3195c1899d8dbb~yCjmMLdVK2150821508euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1545308864;
        bh=Cw3DdqCKr3SKDlrUZLWOJxtsVC0jIssC1KyVfRIzyTA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kwzAOckJtKo35ZKCeGeqlf2IckB+uiB3/2M5wI1Q8q3hga34D3kbJEImPOu8wP0Us
         4ucJsSZi7m9edN0+A2xF60InOLoyP67IaEytIddcsKFUkz4xS73OoobVtV6cGuWGOb
         e70ROV2HNS26o8+hKlZiWn49/AncfQQp2JP9mY2o=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181220122743eucas1p297f022e703da115e7d1853f70fb66d23~yCjlYikSY2820628206eucas1p2e;
        Thu, 20 Dec 2018 12:27:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 42.C8.04806.FBA8B1C5; Thu, 20
        Dec 2018 12:27:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181220122742eucas1p14614fd6417d91aca49c6b319f11d9ffa~yCjkUko5-0230602306eucas1p1m;
        Thu, 20 Dec 2018 12:27:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181220122742eusmtrp2c17122f07d57248eab94e75ded70e267~yCjkF39dv2401724017eusmtrp2Y;
        Thu, 20 Dec 2018 12:27:42 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-1a-5c1b8abf11a0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 64.2A.04284.EBA8B1C5; Thu, 20
        Dec 2018 12:27:42 +0000 (GMT)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181220122741eusmtip293e460dcb8fd14c78754ead25a4adfe6~yCjjrwUQs2864028640eusmtip2u;
        Thu, 20 Dec 2018 12:27:41 +0000 (GMT)
Subject: Re: [PATCH v4 2/3] driver core: add deferring probe reason to
 devices_deferred property
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        javierm@redhat.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
From:   Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <cca5a8fd-24a6-511c-e5a5-2c6627fce247@samsung.com>
Date:   Thu, 20 Dec 2018 13:27:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jW3qu+ctS8h3BwZeQBD_6sF+yCPoQ1P-hEBidmOyWRkw@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7r7u6RjDG5tELB4OeEwo8XGGetZ
        LaY+fMJm0bx4PZvFwmnLGS02Pb7GanF51xw2i0NT9zJarD1yl91i7pepzA5cHpevXWT22Dnr
        LrvHplWdbB77565h99i8pN7j/b6rbB59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVse72KcaC
        xYIVq5aeZG5gfMzbxcjJISFgIrF26l+2LkYuDiGBFYwSqz/COF8YJd5cWccC4XxmlPiw4T4T
        TMvpvh1MEInljBK/pv6AannLKNHT8ZQdpEpYIEnix+tTzCC2iIC2xJJFV8FsZoFFzBLvdmiA
        2GwCmhJ/N99kA7F5Bewknj1exNjFyMHBIqAqcXclH0hYVCBCouP+aqgSQYmTM5+wgJRwCgRK
        zLyXDTFRXmL72zlQ08Ulbj2ZD3abhMAjdomXEyaxQhztInH560dGCFtY4tXxLewQtozE/53z
        oR6rl2iaeYUZormDUeLE4uVsEAlricPHL7KCLGYGunn9Ln2IsKPEsYlnmUHCEgJ8EjfeCkLc
        wCcxadt0qDCvREebEES1osT9s1uZIWxxiaUXvrJNYFSaheSxWUi+mYXkm1kIexcwsqxiFE8t
        Lc5NTy02zkst1ytOzC0uzUvXS87P3cQITF2n/x3/uoNx35+kQ4wCHIxKPLwzoqRihFgTy4or
        cw8xSnAwK4nw9nZKxwjxpiRWVqUW5ccXleakFh9ilOZgURLnrWZ4EC0kkJ5YkpqdmlqQWgST
        ZeLglGpgXDJVjPFK6YrMuuM+K5uUT9uHexjGn/2cLcr49qObTsiqA7opJvnesfINrS3vjffp
        Orw3iVgkpxZYbns4/dcT18nmzwobTpzmPNGq+SF4Qd+W2g4FQZX7Njz8Dcv2b7v1VrhMk3XB
        52ufA+u4Cqa/82+9oR5Zufbj1N8Reee4e37cCyky8fuvxFKckWioxVxUnAgA618R01kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsVy+t/xe7r7uqRjDL684bB4OeEwo8XGGetZ
        LaY+fMJm0bx4PZvFwmnLGS02Pb7GanF51xw2i0NT9zJarD1yl91i7pepzA5cHpevXWT22Dnr
        LrvHplWdbB77565h99i8pN7j/b6rbB59W1YxenzeJBfAEaVnU5RfWpKqkJFfXGKrFG1oYaRn
        aGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CXse72KcaCxYIVq5aeZG5gfMzbxcjJISFg
        InG6bwdTFyMXh5DAUkaJSavXM0MkxCV2z38LZQtL/LnWxQZR9JpR4nj/FLCEsECSxI/Xp8Bs
        EQFtiSWLrjKDFDELLGKW2DmjmQWio4FJ4nrTKyaQKjYBTYm/m2+ygdi8AnYSzx4vYuxi5OBg
        EVCVuLuSDyQsKhAhcfblOkaIEkGJkzOfsICUcAoESsy8lw0SZhZQl/gz7xIzhC0vsf3tHChb
        XOLWk/lMExiFZiHpnoWkZRaSlllIWhYwsqxiFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjNdt
        x35u3sF4aWPwIUYBDkYlHt4ZUVIxQqyJZcWVuYcYJTiYlUR4H2dJxwjxpiRWVqUW5ccXleak
        Fh9iNAV6bSKzlGhyPjCV5JXEG5oamltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi
        4JRqYEzdNdH+lZsUu3qsqZ3ozZqFVaWT4uzkcjsm630K5u15qVUi8mW9fP+ahOkHDyUzML/k
        PCG/mFc5enHzzzl9hgvbp6T8M69dGtKU8XivR0fcq+37lgRK+L585ODWlnt66zendRu+S2yN
        t+P7el9K8cG3Ld173uyN1ZT582R7x8LJe/L/7dvxsUKJpTgj0VCLuag4EQCeO41A7QIAAA==
X-CMS-MailID: 20181220122742eucas1p14614fd6417d91aca49c6b319f11d9ffa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181220102259eucas1p1884a0b68ce342239c2a43a74cc50725a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181220102259eucas1p1884a0b68ce342239c2a43a74cc50725a
References: <CGME20181220102259eucas1p1884a0b68ce342239c2a43a74cc50725a@eucas1p1.samsung.com>
        <20181220102247.4911-1-a.hajda@samsung.com>
        <20181220102247.4911-3-a.hajda@samsung.com>
        <CAJZ5v0jW3qu+ctS8h3BwZeQBD_6sF+yCPoQ1P-hEBidmOyWRkw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.2018 12:04, Rafael J. Wysocki wrote:
> On Thu, Dec 20, 2018 at 11:23 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>> /sys/kernel/debug/devices_deferred property contains list of deferred devices.
>> This list does not contain reason why the driver deferred probe, the patch
>> improves it.
>> The natural place to set the reason is probe_err function introduced recently,
>> ie. if probe_err will be called with -EPROBE_DEFER instead of printk the message
>> will be attached to deferred device and printed when user read devices_deferred
>> property.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> ---
>> v4:
>>   - removed NULL check before kfree,
>>   - coding style tweaking.
>> v3:
>>   - adjusted deferred_devs_show, to accept newline ended messages,
>>   - changed conditonal check to positive,
>>   - added R-b by Andy.
>> v2:
>>   - changed __deferred_probe_set_msg args - like in __dev_printk, fits better,
>>   - use kasprintf instead of bunch of code,
>>   - keep consistent format of devices_deferred lines,
>>   - added R-Bs (again I hope changes above are not against it).
>> ---
>> ---
>>  drivers/base/base.h |  3 +++
>>  drivers/base/core.c |  9 +++++----
>>  drivers/base/dd.c   | 21 ++++++++++++++++++++-
>>  3 files changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/base/base.h b/drivers/base/base.h
>> index 7a419a7a6235..effbd5e7f9f1 100644
>> --- a/drivers/base/base.h
>> +++ b/drivers/base/base.h
>> @@ -75,6 +75,7 @@ struct device_private {
>>         struct klist_node knode_driver;
>>         struct klist_node knode_bus;
>>         struct list_head deferred_probe;
>> +       char *deferred_probe_msg;
> Many drivers will never use this, so is the memory overhead justified?


I can try to move it somewhere else if it is a problem.

Putting it here seems quite natural - near deferred_probe field which
should have similar number of users.


Regards

Andrzej


>
>>         struct device *device;
>>  };
>

