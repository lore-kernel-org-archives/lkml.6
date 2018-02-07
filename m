Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754616AbeBGPVI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:21:08 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:33400 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754417AbeBGPVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:21:05 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180207152103epoutp03fbfbc10f39dc04e13ba553d2d681a99a~RFEtrvexS0573105731epoutp03b
X-AuditID: b6c32a36-ca9ff70000001028-0f-5a7b195e9afc
Subject: Re: [PATCH 2/8] ASoC: samsung: i2s: Ensure names of supplied clocks
 are unique
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, jcsing.lee@samsung.com,
        sbkim73@samsung.com, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <db8df557-fa55-9eac-d9cf-f3dc111c93c0@samsung.com>
Date: Wed, 07 Feb 2018 16:20:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <CAJKOXPeUPyX89u1csm98huKLEGX_xjaPr_wuqwuyoQWwurQbUg@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7bCmgW6cZHWUwa9DChZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xcUVX5gc
        eDw2fG5i89g56y67x6ZVnWwefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlTH10nnGgibWim+r
        PrI1MB5m7mLk5JAQMJHYP2kOK4gtJLCDUeLvfq4uRi4g+zujRNPTZ3BFXb9esUMkNjBKrDx+
        kgnCuc8ocfrlBTaQKmGBSImtu1vZQWwRAU2J63+/s4IUMQu8Y5I4c+oO2Cg2AUOJ3qN9jCA2
        r4CdxPwnXWC7WQRUJU7v3AdmiwpESCyc+hSqRlDix+R7LCA2p0CwxMyL08CWMQMtePFlEguE
        LS5x7P5NRghbXmLzmrdQZ39nk7h1OBPCdpHo6e5mhLCFJV4d3wJ0KAeQLS1x6agtyJ0SAv2M
        EifWNDNCODMYJe60T2CCaLCWOHz8IivEAj6Jd197WCGaeSU62oQgSjwkdnxZzAJhO0r8Xr2M
        DRJCHUwSjbOvsU1glJuF5J9ZSH6YheSHWUh+WMDIsopRLLWgODc9tdiwwEivODG3uDQvXS85
        P3cTIzgRaZntYFx0zucQowAHoxIPr8GGyigh1sSy4srcQ4wSHMxKIrzu7NVRQrwpiZVVqUX5
        8UWlOanFhxilOViUxHkDAlyihATSE0tSs1NTC1KLYLJMHJxSDYwKUl8uX9u95KKqhcd5H96f
        fZsabRnEa246/4nlXnx60Y/wnP2GXU8FlfVPfow9Z/5p7eZU/WvHM7o1/lx/bdG9NmNhfM67
        BwqSLrz6Qts31026+C9SV+v7Teb3R6eceZ8UMSFl1WadrR8XvQxmli1xZviy88HhzoV7C0/y
        Rk/2UcycF93wWc1TiaU4I9FQi7moOBEAqf6MRUADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42I5/e+xoG6sZHWUweFtFhZXLh5istg4Yz2r
        xdSHT9gs5h85x2rxdn83s8X58xvYLb5d6WCyuLxrDpvFjPP7mCzWHrnLbtG69wi7xcUVX5gc
        eDw2fG5i89g56y67x6ZVnWwefVtWMXp83iQXwBrFZZOSmpNZllqkb5fAlTH10nnGgibWim+r
        PrI1MB5m7mLk5JAQMJHo+vWKvYuRi0NIYB2jxIVnCxghnIeMEm82HwOrEhaIlNi6u5UdxBYR
        0JS4/vc7K0gRs8A7JokDsy4yQ3R0MUk0XfjJClLFJmAo0Xu0jxHE5hWwk5j/pAssziKgKnF6
        5z4wW1QgQqJz5XwWiBpBiR+T74HZnALBEs/PfgLq5QDaoC4xZUouSJhZQFzi2P2bjBC2vMTm
        NW+ZJzAKzELSPQuhYxaSjllIOhYwsqxilEwtKM5Nzy02KjDMSy3XK07MLS7NS9dLzs/dxAiM
        nG2Htfp2MN5fEn+IUYCDUYmHt2NTZZQQa2JZcWXuIUYJDmYlEV539uooId6UxMqq1KL8+KLS
        nNTiQ4zSHCxK4ry3845FCgmkJ5akZqemFqQWwWSZODilGhgNq1Ne5OSl91f6rpTdffth2I0T
        ZnUqx24mr5bKWPfhReIFTmWDohVdk0TyT3EoX1l+be2jZo1bs1jWsaxX0J0auneV/mV3ZquI
        Beav2c9c0DD0+5brk/dDzKJhZfr/QxpnTa5JF2S8ybNpnOWqGnb75dn/jw5w7b8eGF6uMffq
        4+01Pr6ndM2VWIozEg21mIuKEwHkWsQMmAIAAA==
X-CMS-MailID: 20180207152101epcas1p3bba8baaa503ec3ecddb7bcb8d25247b3
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180205154511epcas1p14dccb00b68fdb688f2c427c56e01c052
X-RootMTR: 20180205154511epcas1p14dccb00b68fdb688f2c427c56e01c052
References: <CGME20180205154511epcas1p14dccb00b68fdb688f2c427c56e01c052@epcas1p1.samsung.com>
        <20180205154403.13520-1-s.nawrocki@samsung.com>
        <20180205154403.13520-3-s.nawrocki@samsung.com>
        <CAJKOXPeUPyX89u1csm98huKLEGX_xjaPr_wuqwuyoQWwurQbUg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2018 01:20 PM, Krzysztof Kozlowski wrote:
>> @@ -1214,30 +1216,35 @@ static int i2s_register_clock_provider(struct platform_device *pdev)
>>                 clk_put(rclksrc);
>>         }
>>
>> +       for (i = 0; i < ARRAY_SIZE(i2s_clk_desc); i++)
>> +               i2s_clk_name[i] = devm_kasprintf(dev, GFP_KERNEL, "%s_%s",
>> +                                               dev_name(dev), i2s_clk_desc[i]);
>
> kasprintf() might return NULL and later it is being used as clock
> name. I think you should handle such error.

Right, I will fix that in next version, thanks for your review.

-- 
Regards,
Sylwester
