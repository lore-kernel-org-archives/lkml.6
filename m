Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932481AbeD0Jev (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 05:34:51 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:17784 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932420AbeD0Jes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 05:34:48 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180427093445epoutp0206f60ec5dc8a4a83cf9b52f65ae9f92c~pQT6YpLwh1823918239epoutp02h
X-AuditID: b6c32a45-8dbff70000001020-3b-5ae2eeb55778
Subject: Re: [PATCH 3/3] ASoC: samsung: Use gpio_is_valid()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        alsa-devel@alsa-project.org
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <5f7a27fc-27ae-c1ed-73cc-497f46d2668b@samsung.com>
Date: Fri, 27 Apr 2018 11:34:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <f7e9ff7d5d7c559967e9d63f3caff478e05017e8.1524819053.git.arvind.yadav.cs@gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7bCmme7Wd4+iDE6cVrW4cvEQk8W13oXM
        FtenbGa1uHW8ldFi95zFLBY3P31jtbi8aw6bA7vHhs9NbB47Z91l99i0qpPN4/2+q2weZxYc
        Yff4vEkugC2KyyYlNSezLLVI3y6BK2PX6jXsBZeYKs4svMXcwNjN1MXIySEhYCIxu6+PtYuR
        i0NIYAejxNWHR9khnO+MEpPXTmGHqZqxcDczRGIDo8SKnhNQzn1GiS0X7zGDVAkLWEv0N19l
        BLFFBHQkNs38zQhSxCywgFFi1e4lbCAJNgFDid6jfWBFvAJ2EufO/mYFsVkEVCV2dN4CGyQq
        ECHR9PwnO0SNoMSPyfdYQGxOgSSJWT+XgtUzC2hKvPgyiQXCFpc4dv8mI4QtL7F5zVuw6yQE
        brNJfDk3ixniBxeJn2cWM0LYwhKvjm+B+k1a4tmqjVDxaonOti52iOYWRok/0y6xQSSsJQ4f
        vwi1mU+i4/BfoCIOoDivREebEESJh8TFp1eh5jhKvLx5igkSRM8YJT4dfMk4gVFuFpKHZiF5
        YhaSJ2YheWIBI8sqRrHUguLc9NRiowJDveLE3OLSvHS95PzcTYzgJKPluoNxxjmfQ4wCHIxK
        PLwK7x5GCbEmlhVX5h5ilOBgVhLh3XEbKMSbklhZlVqUH19UmpNafIhRmoNFSZy3wfdMlJBA
        emJJanZqakFqEUyWiYNTqoGR9Za/plKnY93ehcvypu5Ibr7JdNKIN+z9rTePoi68vlV9XulU
        sMm9200+rGtnutUyBjZoijE1accWrpf/Wax8Ldt2pqTvq+ZVc72TK1suv9G3e/ZN8IGBDvuW
        iaIy+hXx8ax1CwOibub+1prTGCspKpj/LSNqw8+k76w8r96+2ybrdLh4/nQlluKMREMt5qLi
        RAB0nDMkLgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t9jQd0t7x5FGbzZYGZx5eIhJotrvQuZ
        La5P2cxqcet4K6PF7jmLWSxufvrGanF51xw2B3aPDZ+b2Dx2zrrL7rFpVSebx/t9V9k8ziw4
        wu7xeZNcAFsUl01Kak5mWWqRvl0CV8au1WvYCy4xVZxZeIu5gbGbqYuRk0NCwERixsLdzF2M
        XBxCAusYJT52f2KBcB4ySizruMYMUiUsYC3R33yVEcQWEdCR2DTzNyNIEbPAAkaJL8/a2CA6
        JjFK/No3jR2kik3AUKL3aB9YB6+AncS5s79ZQWwWAVWJHZ23wKaKCkRI3Dv/iQ2iRlDix+R7
        LCA2p0CSxOE/T4Du4wDaoC4xZUouSJhZQFzi2P2bjBC2vMTmNW+ZJzAKzELSPQuhYxaSjllI
        OhYwsqxilEwtKM5Nzy02KjDKSy3XK07MLS7NS9dLzs/dxAiMiG2Htfp3MD5eEn+IUYCDUYmH
        V+Hdwygh1sSy4srcQ4wSHMxKIrw7bgOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhP
        LEnNTk0tSC2CyTJxcEo1MCZtqO6uqIzc+svJ4GbQ2vykqumGz9dvPJt0T/ume/ub+dWnNpcm
        WbnEKjVlSj9uUH44zVn2hPrBgv92D46sO7f7/1QuBfWlNacCi7Mrb29cMDH3T+cyoH/bBSru
        VegUBvx4e+p75b2z7X8ZRWZpXrk2t7y3/q3DrXMLYvU4Z7Sx8d7Y8NRkphJLcUaioRZzUXEi
        AF7uxMWEAgAA
X-CMS-MailID: 20180427093444epcas2p185dbba85e2d37bde95ce3929a57c1f01
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180427093444epcas2p185dbba85e2d37bde95ce3929a57c1f01
X-RootMTR: 20180427093444epcas2p185dbba85e2d37bde95ce3929a57c1f01
References: <cover.1524819051.git.arvind.yadav.cs@gmail.com>
        <f7e9ff7d5d7c559967e9d63f3caff478e05017e8.1524819053.git.arvind.yadav.cs@gmail.com>
        <CGME20180427093444epcas2p185dbba85e2d37bde95ce3929a57c1f01@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arvind,

On 04/27/2018 10:56 AM, Arvind Yadav wrote:
> Replace the manual validity checks for the GPIO with the
> gpio_is_valid().
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

The patch looks good to me but you need to send it directly
to the ASoC maintainers to have it applied.

-- 
Regards,
Sylwester
