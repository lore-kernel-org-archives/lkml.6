Return-Path: <kernel-hardening-return-12456-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsiKZWjzqvExBoqB3RvF3PnFPgh61e5SL4XG2B+SWG0b69lmlkEsTPYbKATKPgyREEj9VnN
ARC-Seal: i=1; a=rsa-sha256; t=1520858997; cv=none;
        d=google.com; s=arc-20160816;
        b=SKOK/VDdEcUd29k+JYHaCo1URCLx6aDrRW7V/XBNqUWO0kqInt1luReGndKveD2k4U
         DpiZ1X0z0USmpdqHyFNxG+tLg/X0nayk/hWH1MAfHzGHu9rOy9zfwUsHViemuQGGejy9
         j4KLMCMjvRO/7OxwhfmbdUslWUHEcGvxq+eoje8YMUS20XqYxVkzWhlEGFHfN9goHbLz
         ET/bNZKC8KUQl9CQOW+D8303DxCI6JutcOv3Ng582bcuZ9aFwo/bDc65ZfiAuuMxD8lJ
         xW3hepksPp+FsbCI11G4f1P9q9AXrkQKv3BqEcUJKv9kB3tv+w3LO0g+WREBX3UBKEnZ
         2cvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=2FNm3bUzfq1YFprYhNvw1Pm//3cTquFDtVyI3eSr+Tg=;
        b=pJcH1xN0kEp0HSnvEJQ/ZhjsXCoYJvc6xiD21FWsCM2AiVAcyDGc8WdyuEKlJHhqKP
         uZkB8U1pFNyqRMbT8MbrakHh/54rBVET2L9ICfvpnK8oVe7NRSTRU05JVvQeTLqSRyMO
         0l1qpflprd77llNw9szdbLy0e4NEOwjsfhLer1DduWdKU7YlldUB3WYbnieST7ZB+IZ8
         9zdfv4aLVrK1qL8Hk3WFAwdNQQ507FNjh2nsNApRG1d1ClDUKfd9wL7umu8dVHOP8rd5
         IMEOythFHTOIdbKKT2Plv3VFv371fEaZCMdjwZWyDRZLnYD69gFjpy/NSOLi6+UUan3B
         hoTw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=TbUnyjfw;
       spf=pass (google.com: domain of kernel-hardening-return-12456-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12456-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=TbUnyjfw;
       spf=pass (google.com: domain of kernel-hardening-return-12456-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12456-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/2] net: rds: drop VLA in rds_for_each_conn_info()
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>, linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>
References: <1520802470-17374-1-git-send-email-s.mesoraca16@gmail.com>
From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <9f197147-c050-dd70-23ea-ec880d205201@oracle.com>
Date: Mon, 12 Mar 2018 00:06:01 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520802470-17374-1-git-send-email-s.mesoraca16@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8829 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=734
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803120084
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594677115997192072?=
X-GMAIL-MSGID: =?utf-8?q?1594736243454842032?=
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
Thanks for both VLA fixes Salvatore.

FWIW, Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
