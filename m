Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeC1Nql (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:46:41 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:21973 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbeC1Nqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:46:37 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180328134635epoutp02d60e6a01e5909b326507d17e2c738184~gGZOEhvkt1176511765epoutp02B
X-AuditID: b6c32a35-139ff70000000fee-ea-5abb9cbbbd40
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Steve Glendinning <steve.glendinning@shawell.net>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3 1/3] video: smscufx: Less checks in ufx_usb_probe()
 after error detection
Date: Wed, 28 Mar 2018 15:46:32 +0200
Message-id: <1923231.ySCFlVkifY@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <03be4276-520e-1d22-1c6e-e35c8df2b1e8@users.sourceforge.net>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCmru7uObujDK6eZ7W48vU9m8X5zuXM
        FltvSVuc6PvAanF51xw2i+ZPr5gc2Dzudx9n8vjffJnFo+lUO6vH501yASxRXDYpqTmZZalF
        +nYJXBl3PnxnKXjBVnHn2G2mBsZ9rF2MnBwSAiYSE3avZ+xi5OIQEtjBKDHnyG1mkISQwHdG
        iSVdGl2MHGBFj8+wQYR3M0pMnBMPUf+VUWLhsr2MIAk2ASuJie2rGEHqRQRMJf6cCAEJMwvs
        ZZT4eYEDxBYWSJK48OQbO4jNIqAqcWLSdrAbeAU0JT7O3Qm2VlTAS2LLvnYmEJtTwFPi9M25
        7BA1ghI/Jt9jgZgpL7Fv/1RWCFtH4uyxdYwQv2xhkzi7Hcp2kWhfspoNwhaWeHV8CzvEK9IS
        l47agpwvIdDMKPFtxx5miJoJjBJ71gtB2NYSh49fhJrPJ/Huaw8rRC+vREcbVImHxJS1B1kg
        wo4SrzYEQkLkNqPE5KaVrBMYZWchuXoWkqtnIbl6ASPzKkax1ILi3PTUYsMCQ73ixNzi0rx0
        veT83E2M4CSgZbqDcco5n0OMAhyMSjy8BTG7ooRYE8uKK3MPMUpwMCuJ8L7X2B0lxJuSWFmV
        WpQfX1Sak1p8iFGag0VJnDcgwCVKSCA9sSQ1OzW1ILUIJsvEwSnVwLip/d2yO/YZBzTsGc8X
        dnRaMJYuNSoQt6kQX3w/qejv/bZihov33lzpbHx+rG/W91dMB3dFilqK9Av/VLu9MtLqEbve
        Nd2WxiK92Dti65dN7Vn9/s/dix+r4pyiGtdoTMz7/OJt2i+fKt5Ig0+Vq3RWcxqW2Ot4Ozl1
        nDCJvfc36HR9X+j7RCWW4oxEQy3mouJEADqdQ/3+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jAd1dc3ZHGbTf1bW48vU9m8X5zuXM
        FltvSVuc6PvAanF51xw2i+ZPr5gc2Dzudx9n8vjffJnFo+lUO6vH501yASxRXDYpqTmZZalF
        +nYJXBl3PnxnKXjBVnHn2G2mBsZ9rF2MHBwSAiYSj8+wdTFycQgJ7GSUONCzGcr5yiixYfMU
        9i5GTg42ASuJie2rGEEaRARMJf6cCAGpYRbYyyjxqfsqK0iNsECSxIUn38DqWQRUJU5M2g4W
        5xXQlPg4dycziC0q4CWxZV87E4jNKeApcfrmXHaIZXcZJRo+b2eEaBCU+DH5HguIzSwgL7Fv
        /1RWCFtLYv3O40wTGPlnISmbhaRsFpKyBYzMqxglUwuKc9Nzi40KDPNSy/WKE3OLS/PS9ZLz
        czcxAgN422Gtvh2M95fEH2IU4GBU4uEtiNkVJcSaWFZcmXuIUYKDWUmE973G7igh3pTEyqrU
        ovz4otKc1OJDjNIcLErivLfzjkUKCaQnlqRmp6YWpBbBZJk4OKUaGNsui2lOnu0Y0vv9xvqW
        f4K9cvU/f5m8bxPmns9mmF1lWpqyf/NqQS33SUJr8sKDBOoP3Z2/38RuT9ChU/emfI3OuVDR
        4vi18fmtz9Oet0zceUTqgYL9nwlTb+is/sJu1iIlvDTl6DG924kXBV47iia/a7OJvzNNLLFt
        zqnUnSvvHxK+EDjzR6QSS3FGoqEWc1FxIgA5HjmdXAIAAA==
X-CMS-MailID: 20180328134634epcas1p28ec498b51d8834599d4bf863a5836a59
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0
X-RootMTR: 20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0
References: <CGME20171125204312epcas2p149d6487ac83e886f95aefe0b35aef1b0@epcas2p1.samsung.com>
        <a36fa112-40a1-703c-c2ac-ce7e88bb8609@users.sourceforge.net>
        <03be4276-520e-1d22-1c6e-e35c8df2b1e8@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, January 07, 2018 05:02:21 PM SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 7 Jan 2018 15:56:11 +0100
> 
> Up to four checks could be repeated by the ufx_usb_probe() function
> during error handling even if the relevant properties can be determined
> for the involved variables before by source code analysis.
> 
> * Return directly after a call of the function "kzalloc" failed
>   at the beginning.
> 
> * Adjust jump targets so that extra checks can be omitted at the end.
> 
> * Delete initialisations for the variables "info" and "retval"
>   which became unnecessary with this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch queued for 4.17, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
