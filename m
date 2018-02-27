Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-302827-1519700866-2-17924577908559808562
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CN'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519700866; b=lsoZNpD5GYhtfFi7gjfKjblpirsPLLnKUFDV1p02l5xykmH
    VVYCKdFKz1XiVKu5qeWYSTVuXcKqrG6uo/YyzOlBkmEHtoZXI6ReyVSIrF7tTMOm
    3tvSuJkfcou6o9Yo+0ZdOG6/Yn1t9S0QDUMcWmvGYtuQSxH3zHX1CzqPbcAaQcwc
    TMia8rgfTgXLjd1Iy7RrGTcoNku3FuElqur6WUB8Q9xjMGa3SCG9M6dhkuhjEpHN
    9mCOik/WQFyeyzOMqoMoOnGHnlfa9X8EwzHIeRAWCXdNbjW+fVh5e9ZvI0w6ZHDQ
    v+cGYuC2ZAaxrV3szwNNPkKNlPJfK6WlmiYvbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519700866; bh=2olEaU1CR9Zmvz2BZbMZmM6hLll8SeGjacqHlJc65sI=; b=k
    LCQvR2+TsCjs7eNGqSZuSvRS4aaQ6vUHQCmUOacfJfbJyoTfy36PE9pLGnuG/H9r
    oEc1xKObnkpbgvtkH/v64LKDFqwr+RTeH2Ko/qAPjwjq5hVZnQW8C3O4WevOeCTk
    aICFI8uBqUBYjEcVQ5dIHZvnbqT52DzclHHiGUaPC26fhKZ9zb/sVqyEqH8EEDiz
    X2J6T+7RK8OKZ7R7PM+mmnBjKO8Y4kgY+w3foBrK3fiFAfrJ3M+Gw+LPvewgZcx1
    1xgdw5LaDt2YEZzCMSBbqq72cIWZrVaZc3Xto+qn5XHOSAIUCIOTs7aQ/HjXF6s+
    Y80zQHN2/LuFCbu6mxG1Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=synaptics.onmicrosoft.com header.i=@synaptics.onmicrosoft.com header.b=C5Xp1DmB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-synaptics-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=synaptics.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synaptics.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=synaptics.onmicrosoft.com header.i=@synaptics.onmicrosoft.com header.b=C5Xp1DmB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-synaptics-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=synaptics.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synaptics.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeB0DHj (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 22:07:39 -0500
Received: from mail-sn1nam02on0067.outbound.protection.outlook.com ([104.47.36.67]:1754
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751411AbeB0DHh (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 26 Feb 2018 22:07:37 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Tue, 27 Feb 2018 11:02:45 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Cc: <linux-mmc@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-snps-arc@lists.infradead.org>, <stable@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 0/2 v3] mmc: dw_mmc: Fix DTO/STO timeout overflow
 calculation
Message-ID: <20180227110245.6d78ff23@xhacker.debian>
In-Reply-To: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
References: <20180226143413.44134-1-Evgeniy.Didin@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: HK2PR04CA0090.apcprd04.prod.outlook.com
 (2603:1096:202:15::34) To CY4PR03MB2632.namprd03.prod.outlook.com
 (2603:10b6:903:75::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b5214a4-62c3-437c-5219-08d57d8f4061
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR03MB2632;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;3:TsXWYtxvQ81fkHZYDVvojQqP3q4x5AlVuDnr6mNdNfserK085XPT8YP9lpqbloY+dBfyUEVnz/Ek36ESFre+BcfANoU8EtYuQ6mdmDxoLIX7wTGEzSxJZgfugP6bOShKMotROh8dIqtwiAY9NVX6q2TmGfmgNa5dfeEGU7Z6yAj6T9Ol8zxkhg4euVEKugAnndUxhtWY0fOckzUDDy8DgGqHyEx0WQTl7uqpyYcIRMXDsoJtSRJqPCvHXdA2ahds;25:azIFjuJAm+BIc4sEl4aT2gGPiiQThxpG5VGSfZWkrg1DsH/1joSEi6zgZXr4llHwTQKXwmCOYnbg9mq405/zYfQtsMzkVGQ08SrrcQNo2m7bGcTo1LYd1teH/u++Y/q8Ci7GyLIp0W0v8u6WucOfew4tAP87PmPFB+TqdjpUKsFsuE0Ff37kLaOuXj7jnU1n0T388RyGyxg04vz8gBxSSSUwuv8xvDNWqYhT4yR/pfBMCQlFBGdD8mEuPhvNrXAlwv8WT9Igx+QSArC6xp4TucE3A1UZpJpY9UYgDNLhcft0auG/39KEdCd3gQ9qygmOKVxVH4V96bF4swUKbq3q4w==;31:78d/KRED17eKbrhS24GwtqGf2tqdmwFqkPOgF5zNDjxSmXsl+N0H9kpZ2QLpmNdEniZv5VZpU9UQPF+vLZgsb+9sSIwx0TYImzIVvrNgV3avy5uEK/WORLAzEBaxwDmgAmegU81U/IKL/3kqi2MFckXLEs3Aja6wC0tU98yMNTUS8Q+Ga5a7hFuvIK300RP9nb006RMbA8eeTUAYxnP8cD+Vzij3/B9vbNoC6BDMCcQ=
X-MS-TrafficTypeDiagnostic: CY4PR03MB2632:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;20:qFIJE5zDcVCHszwkqqMX7fVRb8ZAn+A2OE7YTZx22EH1HwVqWe431h9LR6xj1POdgvJ005l2rQqvptlbwkd7Gkf7PDLJO4DQrk0vyOdwUgaA1zrGdRChf3y4CWI03koNbEBRkGKhjGc1BO2bVoEQo0AH5gYDJtJcXqXoelQuIizqKqCe7jFwhss/BEhEUVnSHSEqSTK3Y6T5zzupB3GtKj88PUoOMXatZ6kfCSKtglLEqxb7PpWqE5SnizHFn8OZ89Q3DCGGqdbNR0awy3BqKwzTPaz+zHCvyx/sN+azW9R6gUjZMfPuNDtUpFblGdT9lhxwXVk9JjmhqLyBT25Cl9ZbaGPsS2xg0D0o+Gv7EiEuRqtSqHvNHA42RAPRmnS7RTHSXbr2lEcULxOAblJtssIh6C/ek+J+OkDAFdCo6Mk=;4:jVKQ89jT/tAHGwQIcFONApRQmYUXXD9unD8B355Jhx+Mi1HoxnvmePPiaBY7QsGf2AqROKRQx8ZLJaQ9NK8kHcUdkxM7O/qdn2N+27SEi3BWPEPUvI3uUXxP6CeQVSRuCMWpYoFqN/eTvcA9t7MEAARc+2NjEUTbIt0csFJoL85fe13WahBFjYftN6wnJ+V4Xi+hdDsmIdWC+OYCH0tlv6oSEQVqaQjWM5kMPvp91WKXicRYYALCRmGml3QX5oiF/RtedsDiZ1vmYVST6MtivQ==
X-Microsoft-Antispam-PRVS: <CY4PR03MB26323DE4366D28AFD55B9A99EDC00@CY4PR03MB2632.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501161)(52105095)(3002001)(93006095)(93001095)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR03MB2632;BCL:0;PCL:0;RULEID:;SRVR:CY4PR03MB2632;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(346002)(396003)(39840400004)(366004)(199004)(189003)(97736004)(33896004)(6506007)(386003)(4326008)(72206003)(47776003)(478600001)(66066001)(25786009)(186003)(26005)(106356001)(68736007)(5660300001)(1076002)(7416002)(6116002)(23726003)(3846002)(2950100002)(16526019)(6916009)(7736002)(305945005)(50466002)(229853002)(2906002)(105586002)(50226002)(230700001)(86362001)(81156014)(53936002)(55016002)(8936002)(6246003)(7696005)(8676002)(9686003)(52116002)(76176011)(54906003)(316002)(81166006)(6666003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2632;H:xhacker.debian;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR03MB2632;23:f9eyXrvMzZQ9vmW8FWG0cXWpRo32w4woKlYQSluwM?=
 =?us-ascii?Q?jrGvOvqp46KVdaSMIMet0/LeOFSxNa1G8dXUzAuFx7UI4jDZialqc4kD1ENO?=
 =?us-ascii?Q?iPXqGRPvTVt8ySoP/GmAzVhmwQRBvf9XiUWABxq9vcjQ1mWliPmbJY00vMPr?=
 =?us-ascii?Q?cMMOd2zR9UWLC1S5v+R+eVEQC2NKmCtfMRMjlf8jTtpfRIeoPLrJsVemWNYO?=
 =?us-ascii?Q?a2msMTrjUm1bBTy9gIzXYr8/olmPEBlV18JUIBcMJYIXxRW5a22MBUH+BSr0?=
 =?us-ascii?Q?9OdU8zlpuZSQwj5d9fBIWFW/fgZIBKDeH/bBWn/2I3W3GUosC180l0P1UcGw?=
 =?us-ascii?Q?YbazD7RLufcJDvxUCfNpCLh+AIajWz+heZeFnK9DrjJmpf+xJVqziu+mZV3B?=
 =?us-ascii?Q?h2nXlzS0232kwXsgcxSHeojtNrEcPoN66buB4Vyz3ITPUcnivhPNmY98gg98?=
 =?us-ascii?Q?ed7jH1e2p0DH2TCnc461Awd5CrKaUpyIZYxKu5nr7e4gjVPYcAOqTYcchNpg?=
 =?us-ascii?Q?Nmh9VEiWakC8V8meJ/nWRYfvXwYxHwi8XHO0/B0KVPV3RmoutigRwiIGJt8s?=
 =?us-ascii?Q?6YIx2CIBpUWX/zVFuqhRYjs/c5h9Siru5ZLpSlXOvaIjKsbRCpcbIO7WGLfo?=
 =?us-ascii?Q?CBdb+2klTSdeoYLhaaKTIMiUgVXTql7dg7/4Tjw0qKtfTdQdYbcsKabhuSzU?=
 =?us-ascii?Q?0JXfhBAnryabVEBkq+k1Vggxi7pYK0AHxLv6IyE9HU7Zu+jC86xEkWRvvsro?=
 =?us-ascii?Q?TT6erJ+bUkMtLty+wRbNgzVguxNqVwtrds8h4jOf856zuO6Xs3x6VVNwr64W?=
 =?us-ascii?Q?m3+5FgTXe6fPoIQXu9N6gGIHvIQTMxQb3XHXVO35YFeurmQJmRnw0akQnqNe?=
 =?us-ascii?Q?QYofnjn0UHgISBzW453r4w7z0kF9ea5+Mnx54dq2RsiFcmt8dZ9E1ee1wmhz?=
 =?us-ascii?Q?RT+eHfpGoG95rEM7BiotEr04K61Lp6sqAbj0cN6UcmYfrORhRaq2mp2yVpu9?=
 =?us-ascii?Q?gZLZ982If6NsXDoYj3d/warbCVD86AAP4wo+If0m1KZllgo8V0WLXDtBADJg?=
 =?us-ascii?Q?yU3UhT8/05kLAtBKp8WvI9Zg/hbEMZJAkv+av4hlr7EmpBE08n6gEGRbPZUj?=
 =?us-ascii?Q?WV9n9ZJCLxoxmIzBnqeeqquY6rUq0tvCQOmPMOdtnp+Rx9oCck4eRblc7O2Z?=
 =?us-ascii?Q?x/a2yYOzRrdhvKr6H0CNPaTo9hwE4BeTqChoimb09lMAszKUTsMiRZU074Nd?=
 =?us-ascii?Q?3swIZ1pSKHzViDB9TA=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR03MB2632;6:+/xuV5Vc5inf5ZZIZUxkTHSQbrLtmGyeF1sephK/Mrd4YQ+9JUwt9NOucFcJiB9R3/2H7QVvDpBx5YFSKd69QPgrPB9F4QSxJ4vhS6a486yRvzuXCQLaS1emdZ86bJXmN86SI3t8AovCHMTp361IVTH4ANHrubpCVqMQwe6l0Rv7bSuqtYd2IgwFYI+KNllZM6WGDFP+/FzhzVl4V/BlFuucLe/heUK4yG+KtfVyKUTVPGoouSkKqfFBPCyp+3YFwqUF5T/xHza9+7NANxiu0plFGbWaKHxaTPI4eDgWIiWr9TeyUekxIl1E8DUNxD1B1Ixf9Du1KvpZOOUw5fyosdsoRuwt7JypLJQ3ENBIG/c=;5:KPzEty6wwtQxGnBzP378JXEFs4p6Yy5VnTzPfhvPv26f7pyrmxaIgCnstKG+tjQ2cXL//cyjqlvpD7qXYw5R/Qag+FWCCjXxn7nWqgocWJb7l0pH8WUUBvcclIZbqYrcPmAAPGcWpXCwve2nLe3tOPRtnlWO3e++l7AGkCq2ovs=;24:cwMQPwSQeCUMiHv58obPijmPnTD7i57E79QVOANYEZOGfuLDcN2ApXW1n6bWUJCrhmpcK6sF6gPWYoqB2vQwmDm8gsxaUrb85FWeWYY7C2A=;7:t5I8FLEZDvTgxydEQf1T/PDfUsYG6fTH5mP9dpp4TGs2Oon4TRJsXwnm1f8f/1SfErPl43CKokjOyLSa28gzLjvuPkgIGvmpZt5C+x1Q/g/Bo3EKh+3iP7ZntWzRWdji8/XvbRxSWOhdD3pTiG4gaj4ZPvYtdlpIjOs2YSNukGpP/U0Z78roBNgQmXeNBDYztKkHKiTHpfrI0n21hxYoUayXcFVgmrssOhcm/wdRxn/eOYOs6GQe9H/Pq46DkcCt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 03:07:33.3270 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5214a4-62c3-437c-5219-08d57d8f4061
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2632
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 26 Feb 2018 17:34:11 +0300 Evgeniy Didin  wrote:

> For some 32-bit architectures calculation of DTO and STO timeout can be incorrect
> due to multiply overflow. Lets prevent this by casting multiply and result to u64.
> 
> Suggested by Jisheng Zhang.
> Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL is not reasonable
> because overflow happens on multiply and DIV_ROUND_UP_ULL helps
> with sum overflow.

hmmm, I mean something as below:

-cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
+cto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);

This could avoid build error in arm case.

> 
> ---
> Changes since v2:
> -add fix for cto_ms
> 
> Evgeniy Didin (2):
>   mmc: dw_mmc: Fix the DTO timeout overflow calculation for 32-bit
>     systems
>   mmc: dw_mmc: Fix the CTO overflow calculation for 32-bit systems

These two patches could be folded into one patch?

Thanks
