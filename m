Return-Path: <kernel-hardening-return-12457-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsxbMXOrk1Yrk9URIcGlw/hIRuJD/l0QGLWdSsfRiaBZqkik/NU6IfUVX6JKRCw4DBXw1Bu
ARC-Seal: i=1; a=rsa-sha256; t=1520859009; cv=none;
        d=google.com; s=arc-20160816;
        b=WFOPu2tUYefpkbdC7IpFzJZHBVLuSacM/yrgMh2U7re8y5sVN/Kf1SB8IKW0Wyi9UI
         eCxHzPLEXvVD/ounwPSffZLPmr+WG6gPXhawjL8H6B4frNsjhNXGOtxpihi0yoU6iI5l
         VtGan4f2XE9lAp4NPje8tGT1tX3W0vwxONLhRvs1sc/W+ZgyzwJY0h5e1INNKptProrC
         104O8aDB5r9Zdqv5Un992XdRzmLnTBUuNa3v1bCEy9r2jptLfhOLW6N/NEKcHtllMA19
         wlJt2ZDNXr0ZLXzZKGz9PcWpsQbc+T6TtHNVw+m/0iSeyJqGfaCIwwlz7h6wADrpKasu
         UShw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=8wlAk3YOvUbRhzm+hjNOKR9cn9kr/vFGCjAGsscwrgI=;
        b=ez48bpYN20e7ZdwL22I/QLrjVl8nuPc9e5rENeO0s2tsn9mqjykoyGnXQ2iQaRUyIn
         utDRZoSvJzZ8t5H+API4CLwzmdLTb6fP0pBqhqaKvsvCLGv/iM+pPvheY5n9VsVpg3I9
         eQwSmH8QnasKOYwSbdUazTjjao4SKz51LUF0M3LSlTgQZVhjOG/tDIvjh7+YZA6I2fx+
         Rf2bX7Q3vf2ffpMZDD3Ouu7wx9lMn75JIKN+vL2jaB4xu0RRNHVOVLe9zrA0Dtb3JL8v
         D+rlovfVwOScINUED8sFHX+uxCxPGWUjiA5Lt5tQRXa7h1MAXOnXjtqsGDcDjes7GQ6Y
         UexA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=FapQJmAs;
       spf=pass (google.com: domain of kernel-hardening-return-12457-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12457-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=FapQJmAs;
       spf=pass (google.com: domain of kernel-hardening-return-12457-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12457-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 2/2] net: rds: drop VLA in rds_walk_conn_path_info()
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>, linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>
References: <1520802470-17374-1-git-send-email-s.mesoraca16@gmail.com>
 <1520802470-17374-2-git-send-email-s.mesoraca16@gmail.com>
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <07a52b72-5ecf-2027-0e87-e16dc0a70d09@oracle.com>
Date: Mon, 12 Mar 2018 00:06:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520802470-17374-2-git-send-email-s.mesoraca16@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8829 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=699
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803120085
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594677132836039871?=
X-GMAIL-MSGID: =?utf-8?q?1594736256882766251?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/11/18 2:07 PM, Salvatore Mesoraca wrote:
> Avoid VLA[1] by using an already allocated buffer passed
> by the caller.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
