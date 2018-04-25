Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753822AbeDYMuX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:50:23 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:23106 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753329AbeDYMuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:50:02 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180425125000epoutp035dbadaac1047978ab9964364fbf37667~orrz4rGRH2859228592epoutp03U
X-AuditID: b6c32a46-145ff70000001024-88-5ae079774a68
Subject: Re: [PATCH 05/61] clk: samsung: simplify getting .drvdata
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-id: <215c52b1-3044-8dd9-c021-dc2b8ff78afe@samsung.com>
Date: Wed, 25 Apr 2018 14:49:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <20180419140641.27926-6-wsa+renesas@sang-engineering.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-GB
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH++3e7V6l6XWanhwpDQw0MrXAG4U9fHSjgoiCWqCNvKj4ZFct
        jUw0p1tqoRCx/KPCQQwz382piW9Yomnl1HKKG2pGqfgMNGO7Bv73+Z3zhd/5HA6JSRqF3mRC
        SjqrTFEkyUTOeFOXf+iRu1lT8iC1NZg2r8wK6cZxKf3E+hOjBwdrCLrOOiKkl4otQvqzsUJE
        N/74LaCfD34Q0EOmSPrvSC1O642biC4dOH9GzCyMFhBMs3aCYOr0ahFTX/mQKW3QI2bm1Tuc
        Wa7zuULInU/FskkJmazyaNht5/hV1UdRmkpwzzRdK8xFZqRBJAnUcSjscdEgZ1JCGRBs9S2L
        +Mc6guk1o0CDnByhvOo5ZGcJVYPgzftIPjSJYKm7wNFwp87B7NsvmJ09qGNQlf+CsDNG1WJQ
        oYqxs4gKhpKeUkdeTIWBtXLbwTjlB8Nl87id91E3IG/2D8Fn3GCj3OKoO1FRUF3ED4RR/jC3
        Uobz7AW9k2OIZ1+or/qF8UMXEjBUfovnCFBNbe/IuMN8XwPBsxRm9LWI5/ugVmkIuxhQjxBs
        PhsW8Y2T0NU3JOQ/cIGiri2CX50YilQSPsLAgk2H8+WzUGjc2c9XBPk1regp8tHu0tHuUtDu
        UtDuUniJcD3yZNO45DiWC0kLCeQUyVxGSlzgndTkOuQ4poAoA6ocuNSJKBLJ9oqDbk7KJUJF
        JpeV3ImAxGQe4jYfi1wijlVkZbPK1BhlRhLLdSIpicu8xLmX++USKk6RziaybBqr/N8VkE7e
        uUjSfsEIvWvctea5jcVWc3Bb2x7d6MWOq+bsxzbTIh3BrWcYhAHKbzW+WTn7cw5LWwy2Qbhu
        cmFK8AcinV+P7rSXAZP5hEQXm10PLYYvS10NOf2WCpvpRPSn19+L4ECopWlGL9tu98xfF2+4
        tfiNrU7mNCccdJroHld3hCfKcC5eERyAKTnFPye+SkhIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsVy+t9jQd3yygdRBo0/FC2uf3nOarH1lrRF
        /+PXzBbnz29gt9j0+Bqrxceee6wWl3fNYbPY+vIdk8WM8/uYLC6ecrX4d20ji8WqXX8YLfrO
        uTvwery/0crusXPWXXaPTas62Tw2L6n36NuyitHj2cL1LB6fN8kFsEdx2aSk5mSWpRbp2yVw
        ZXxtO81W0MZUcerRRtYGxuuMXYycHBICJhJN614A2VwcQgLrGCWO7b/EBuE8ZJRomvaRDaRK
        WMBJ4vnaK8wgtoiAscSa5tnsIEXMApuZJXr3PWeF6LjKKDH9VCsrSBWbgKFE79E+sB28AnYS
        j5f8B7NZBFQlLk16xQJiiwpESNw7/4kNokZQ4sfke2BxTgE3iXUdu5i6GDmANqhLTJmSCxJm
        FhCXOHb/JiOELS+xec1b5gmMArOQdM9C6JiFpGMWko4FjCyrGCVTC4pz03OLjQqM8lLL9YoT
        c4tL89L1kvNzNzEC42nbYa3+HYyPl8QfYhTgYFTi4b0Rdj9KiDWxrLgy9xCjBAezkgjvXrl7
        UUK8KYmVValF+fFFpTmpxYcYpTlYlMR5+fOPRQoJpCeWpGanphakFsFkmTg4pRoYj5ytD2h2
        N/N59upPVttx4ZS5t/J2smRxzeXqXGfEejzh3eU5tyuj7ISWfuvviqyRCvRwqJSJ3zwr9K3M
        zk9RYub75+R/4p2T7Zgkncc3qS/h7Mm66So9BhYmZknnt1oeL7eSzzxQWyiXq/l60XvGpt1v
        ts7oCtgl/2BWkEf3y6mapWYX2CyVWIozEg21mIuKEwEseq8sowIAAA==
X-CMS-MailID: 20180425124959epcas2p44fca8e61125377709d26c2f52f8b3af7
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180419140651epcas5p22119a061c760dd54c0c3e630b053ec1b
X-RootMTR: 20180419140651epcas5p22119a061c760dd54c0c3e630b053ec1b
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
        <CGME20180419140651epcas5p22119a061c760dd54c0c3e630b053ec1b@epcas5p2.samsung.com>
        <20180419140641.27926-6-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2018 04:05 PM, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch applied, thanks!
