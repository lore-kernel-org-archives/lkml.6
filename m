Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1856102-1519228523-2-14687189073376810429
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519228522; b=tsOEqo7MMCH2GxbBllYmQCynwzTMQ+CrvGGJwEQaZ4tc7V3
    6bvQBX9oFuBSQcdl9w2jXPIha2GKDuntmkL30BMjt+0TYQd/+yvPskJhrI4IvJ5z
    fI4ZxsX3sBEQAFTHosQJVCVhK/FkaN36yaP9v9c8popXcLAeuR77udNUu2VX6T6l
    C1PK38VGsci3GvQYxRFScxPXVFJCyGon0WvqfqlsfIs1Sd2p00IymhsoyirSL6BN
    cUX3nsbwu6k/SLmg6pdIKn6Tq+uERGxzl50egrgSEquz3hz46sUtMvukemvVfty/
    3usy4zHRlkdKr75xSKCkvWsutrBe2BG53uGS/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-transfer-encoding:content-type
    :references:sender:list-id; s=arctest; t=1519228522; bh=Td7OYByG
    wkPAhD8Sk836fbZdnSv3/lM+2jmjFXzB/vs=; b=LOm/dbgvnMNy/DID2312jiXf
    BxK29Xl9REDLqWPCNGvHHF7RSj1afwjNgEZ04YTHpZOa48tYs0rUVWFFqf5dXnWy
    WU6xUIntPO3RiR3CV3UFjfRQAtILr1LjkoGn2yUuvmokN88gHSJaB550nml3puK4
    frtzN9DaSMvoMwp1GhMKVBYx4fgjW/rSBowxhy4TDDnteFMs+Fr1brtqVc1nkClx
    VTORiBQFmEXsxzNvtdk8c4pc3Nu0XKdsOlgvG15bwWyhgJ0K/E1MMiYMX5F41v9M
    OnXC3IMp2bdG8y1P3qnTVxScXlEKqmasyNIrQqAHIiq16yTxbyN9zH/rNLPN/A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=eK9xlEZk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=eK9xlEZk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754483AbeBUPyz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 10:54:55 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59289 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752692AbeBUPyv (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 21 Feb 2018 10:54:51 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180221155449euoutp0211f4228b3842312799eb4600f8dfe777~VYkMA0bLq3097130971euoutp02b
X-AuditID: cbfec7f4-713ff700000043e4-d2-5a8d964630fa
Subject: Re: [PATCH v4 5/6] extcon: add possibility to get extcon device by
 OF node
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org, USB <linux-usb@vger.kernel.org>
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <6da27f54-76d0-2ac8-666e-e3ebfc71b2c1@samsung.com>
Date: Wed, 21 Feb 2018 16:54:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdxGDCGQBN05bL3_h8P62-v6+5oGW3M7CA+701o15ZXnQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zln58xcfE5lb9kFF5EGaok/DlajIOrkL/1RhGG58mCRTtt0
        lUHZxcu0ldlFXRcrTG0omnelNLxNjVwy8VKZRlYorAuboWXatlPkv+d7LjzvAx9DyKaolcwx
        dQqvUasSFGIPsqF7rj9o1y1D9KaJkkB2Kq8DsReybRT7pLCKYocdnym2uLOfYgdnvorZ/PE8
        krVYqmlWf62EZms+DFGsteWOmC20tIrYh6UZBFvZOUazj4YHRGzGs056O+Yq7lUgznrFIOKa
        jWM0dzu7iOJqTHoxN55rFnG1Jee4K3UmxNlr1kRKoj22xvEJx3S8JkQZ63HU8XiBTL7oeWou
        U52O7klykIQBHAbDTdfoHOTByHA5goZ5C+0SZNiBoH42QhDsCPrsJvQvsdBdSQhCGYIyg/Vv
        3IYg33HJHffGeyH37SiVg2jGB4dAm85lIXAXBW3m86TLIsaB8Lt2VOzCUqyEtr7P7gISr4f3
        g+/c2Bfvhwc3PyLB4wW9RZPurARHwcKlb+4sgddCo+0OIWA5vJ4sFrnKABsYyKrrEQtX74QL
        T39SAvaGaXMdLeBV8OL6ZVII5DpntuoJ4XEDgWXaKhJcW6DDPOBMM86KQKhqCRHobdD8dpB2
        0YCXw4jNSzhiOeQ3FBACLYXsTJng9ofxl/WEgOXw6NWMOA+tMy6ZZlwyx7hkjvF/731EmpCc
        T9UmxvPaUDV/MlirStSmquODjyQl1iDnB3yxYHY0oZb5w+0IM0jhKa3WGaJllEqnPZ3YjoAh
        FD7SnlgnJY1TnU7jNUmHNKkJvLYd+TGkQi49GHA2WobjVSn8cZ5P5jX/VBEjWZmO1P6zooiS
        qPC7afquyMb8E5lJ4b77lpWmRa2uKO9oGZ1+7xkh/1SrSagN7R5L71KqAp77buhYY5vyi2k4
        ELY7o2pOOvFyRt1mXUwu2BEU9qU3N/jX4g97j/7NotIwoBvUPagDU9bOWU/D918x1NXyduWK
        oYGRM+BjV+yZ80t5d0ZBao+qNm8kNFrVH6/zA998AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsVy+t/xu7ou03qjDJ79N7R4OeEwo0VTx1tW
        i40z1rNaXP/ynNVi/pFzrBZXvr5ns5h0fwKLxfnzG9gtOicuYbfY9Pgaq8XlXXPYLGac38dk
        sWhZK7PF2iN32S2WXr/IZNG69wi7g4DHmnlrGD0u9/UyeeycdZfdY3bHTFaPTas62Tzudx9n
        8ti8pN6jb8sqRo/Pm+QCOKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTt
        bFJSczLLUov07RL0Mr6s/MdS0MxT8bMtr4FxHmcXIyeHhICJxL9ja5m7GLk4hASWMkq8uTmb
        CSIhLrF7/ltmCFtY4s+1LjYQW0jgNaPE4n9aILawQKjElfuNQDXsHCIC+hL7y0DGMAscZ5V4
        8LqdFaK8iUlifW86iM0moCnxd/NNsDG8AnYS+089ZwSxWQRUJR5euQdmiwpESHSunM8CUSMo
        cXLmEzCbUyBQ4l/LB7BeZgF1iT/zLjFD2PIS29/OgbLFJW49mc80gVFoFpL2WUhaZiFpmYWk
        ZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzAeN927OeWHYxd74IPMQpwMCrx8G4o640S
        Yk0sK67MPcQowcGsJMJ7IgEoxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnAVJRXEm9oamhu
        YWlobmxubGahJM573qAySkggPbEkNTs1tSC1CKaPiYNTqoFRsOLOU+EYR/U3DT3Hzh3JVEtW
        efKIoVqIoT/H83uV2rob87TC1p6Qvb7xyN2uAv7blyaUcP3N7UttcwyZsFb0v1uRfU3OY3+Z
        2HvrvVZPXCfFqla/yDhrz+Sb6ZyJZzzPScy10jhf/rU5ZVrPXI/bnAekDgX/ebGuOsJX/2Tz
        5sQOJUUn71dKLMUZiYZazEXFiQB26EXADQMAAA==
X-CMS-MailID: 20180221155445eucas1p26eea2346d98df0482955a34c9d48bff5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180221155445eucas1p26eea2346d98df0482955a34c9d48bff5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180221085608eucas1p162d2e579a1cc887672b722458edb98fe
X-RootMTR: 20180221085608eucas1p162d2e579a1cc887672b722458edb98fe
References: <CGME20180221085608eucas1p162d2e579a1cc887672b722458edb98fe@eucas1p1.samsung.com>
        <20180221085541.14556-1-a.hajda@samsung.com>
        <20180221085541.14556-6-a.hajda@samsung.com>
        <CAHp75VdxGDCGQBN05bL3_h8P62-v6+5oGW3M7CA+701o15ZXnQ@mail.gmail.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21.02.2018 15:27, Andy Shevchenko wrote:
> On Wed, Feb 21, 2018 at 10:55 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>> Since extcon property is not allowed in DT, extcon subsystem requires
>> another way to get extcon device. Lets try the simplest approach - get
>> edev by of_node.
>> +/*
>> + * extcon_get_edev_by_of_node - Get the extcon device from devicetree.
>> + * @node       : OF node identyfying edev
>> + *
>> + * Return the pointer of extcon device if success or ERR_PTR(err) if fail.
>> + */
>> +struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)
> First of all, the all other similar cases use "_by_node" in the name.

OK, looks better.

> Second, it's not _get_, it's _find_.

The patch splits exisiting extcon_get_edev_by_phandle function into two
functions, nothing more.
Thus it followed naming convention present in extcon framework. I can
switch it of course to _find_.

>
>> +{
>> +       struct extcon_dev *edev;
>> +
>> +       mutex_lock(&extcon_dev_list_lock);
>> +       list_for_each_entry(edev, &extcon_dev_list, entry)
>> +               if (edev->dev.parent && edev->dev.parent->of_node == node)
>> +                       goto out;
>> +       edev = ERR_PTR(-EPROBE_DEFER);
>> +out:
>> +       mutex_unlock(&extcon_dev_list_lock);
>> +
>> +       return edev;
> Can't it be done using bus_find_device()?

There is no special extcon bus, so I am not sure. Anyway if it can, it
should be done probably in another patch.

Regards
Andrzej

