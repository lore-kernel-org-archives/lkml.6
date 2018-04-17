Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbeDQPHr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:07:47 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41233 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbeDQPHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:07:44 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180417150741euoutp02ed1e5ef384f3a68759e4474e3dbeef8b~mQZvvlwpp2001420014euoutp02W
X-AuditID: cbfec7f2-5ffe19c000011644-3f-5ad60dbbc92e
Subject: Re: [PATCH v2] X.509: unpack RSA signatureValue field from BIT
 STRING
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-id: <f29df54e-48e1-12e0-f2d2-fd8353cc445f@partner.samsung.com>
Date: Tue, 17 Apr 2018 17:07:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.7.0
MIME-version: 1.0
In-reply-to: <6f5cdb8a-809e-6651-0e32-711d415a8b38@maciej.szmigiero.name>
Content-type: text/plain; charset="iso-8859-2"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djP87q7ea9FGcy5ZGwx53wLi8W7pt8s
        Fj+uTGKx6H4lY7Fu/WImi613mtgs7t/7yWRxedccNosPPY/YLA4ufcZscf7COXaLI1P2sTrw
        eLRe+svmsWXlTSaPbQdUPa7tjvTY13+YxaPne7LH+31X2Tw+b5IL4IjisklJzcksSy3St0vg
        ylgycwpbwU72iqOPNzA3MP5i7WLk5JAQMJF49eQNmC0ksIJRYtmUrC5GLiD7M6PE7uYmNpii
        E/1tjBCJZYwSVz5+ZYFwnjFKfF91nBGkSlggQOLwnl1gtohArMSr2StZQYqYBV4zSbx985gF
        JMEmYC7xaPsZJhCbV8BNYnnjK7AGFgFViaur7oLFRQUiJJqe/2SHqBGU+DH5Hlgvp4CnxLTn
        r4GGcgAN1ZPYc8QYJMwsIC7R3HqTBcKWl9i85i0zyF4Jgf9sEi9n3mWBeMFFYuWJq+wQtrDE
        q+NboGwZic6Og0wQdrnEpi1r2SGaGxgl1rxvYoRIWEscPn6RFWIDn8SkbdOZQY6QEOCV6GgT
        gijxkLj05SQzhO0o0bb3AjSE5jBKtD5vZZnAKDcLyT+zEH6YheSHWUh+WMDIsopRPLW0ODc9
        tdgwL7Vcrzgxt7g0L10vOT93EyMwPZ3+d/zTDsavl5IOMQpwMCrx8ErsuBIlxJpYVlyZe4hR
        goNZSYR352OgEG9KYmVValF+fFFpTmrxIUZpDhYlcd44jbooIYH0xJLU7NTUgtQimCwTB6dU
        A+P2uxHVvztehiw5Jz0pO2r9Xu9Lv5TUri1+2lJsu7v9idVHVj1HQfm9pqpaogdLOSyM3Yoc
        2WL/nGWR6nCQ3pU16w3TvXm3ThrFqr1edGORyUpRvuSbfJu2HNyqe2NBxN0XnzcU7z2dFr8j
        0zq0+YJDWonXkvNzY++fMyw79cCZ0by5YJ1A7gYlluKMREMt5qLiRAAKku/3SwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4Zd1dvNeiDNZPk7aYc76FxeJd028W
        ix9XJrFYdL+SsVi3fjGTxdY7TWwW9+/9ZLK4vGsOm8WHnkdsFgeXPmO2OH/hHLvFkSn7WB14
        PFov/WXz2LLyJpPHtgOqHtd2R3rs6z/M4tHzPdnj/b6rbB6fN8kFcERx2aSk5mSWpRbp2yVw
        ZSyZOYWtYCd7xdHHG5gbGH+xdjFyckgImEic6G9j7GLk4hASWMIosXH1VmaQhJDAM0aJI0tr
        QWxhAT+Jd1f/gDWICMRKXPt3gRmkgVngNZNE6/mzjBAN8xglZn32ArHZBMwlHm0/wwRi8wq4
        SSxvfAVWwyKgKnF11V2wuKhAhMS985/YIGoEJX5MvscCYnMKeEpMe/4aaBkH0AIdia+TIkDC
        zALiEs2tN1kgbHmJzWveMk9gFJiFpHsWQscsJB2zkHQsYGRZxSiSWlqcm55bbKhXnJhbXJqX
        rpecn7uJERhB24793LyD8dLG4EOMAhyMSjy8EjuuRAmxJpYVV+YeYpTgYFYS4d35GCjEm5JY
        WZValB9fVJqTWnyIUZqDRUmc97xBZZSQQHpiSWp2ampBahFMlomDU6qB0TPlvroWm++TkuOr
        rSa9nvTjucyhR3zrJ0T326bLvTrZcEW54tp7i3Nbf3e8ZNm225tNv3C3RdP10/nOD9oCL57n
        +GSkaLOxZlrYVq15cffrjFc+z+d97StqES9d/Pgq55sI9aK3ynOybHNDOBJ3crPeKuSK+rji
        i8OElzptKTsDhBWP3HpyRomlOCPRUIu5qDgRAJkeUGucAgAA
X-CMS-MailID: 20180417150738eucas1p17e5c715fdd41d59888a9dd747f5bb330
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180417134032epcas3p21dbb2d3a6d8650cd64e147d2ce89e6ea
X-RootMTR: 20180417134032epcas3p21dbb2d3a6d8650cd64e147d2ce89e6ea
References: <CGME20180417134032epcas3p21dbb2d3a6d8650cd64e147d2ce89e6ea@epcas3p2.samsung.com>
        <6f5cdb8a-809e-6651-0e32-711d415a8b38@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.04.2018 15:39, Maciej S. Szmigiero wrote:
> The signatureValue field of a X.509 certificate is encoded as a BIT STRING.
> For RSA signatures this BIT STRING is of so-called primitive subtype, which
> contains a u8 prefix indicating a count of unused bits in the encoding.
> 
> We have to strip this prefix from signature data, just as we already do for
> key data in x509_extract_key_data() function.
> 
> This wasn't noticed earlier because this prefix byte is zero for RSA key
> sizes divisible by 8. Since BIT STRING is a big-endian encoding adding zero
> prefixes has no bearing on its value.
> 
> The signature length, however was incorrect, which is a problem for RSA
> implementations that need it to be exactly correct (like AMD CCP).
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

your e-mail address looks incorrect

[...]

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland
