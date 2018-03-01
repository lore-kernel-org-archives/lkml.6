Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1959376-1519883915-2-10199177915390318025
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
    t=1519883914; b=ZglCtfDGtF8ZEav3ddDfHIQ2URQWe+dZ7O5M82T4R4JKnPd
    /vBKxPY+s7lACy6MSF19FnlyUcZiPjJQ3JTomD+c/1Vgm2F0/WIfPIlUpg0eZSYK
    HQ4JB1p8oGiUo2jqNG8Hci+ZEJsozM/dyIj3UJiguiLaiWU9AUCUjXtX8iZZz5qW
    eT5kCkHpzcEaISblV446JrJJnxtlhjwjqBN46bsMZkepBTpqC8qxMQF9R5vZE+5Y
    N+tdoLX/GHPP6jL5yWrEq4LHZrqdHx4A2DUonAwij0//DX1hE+rCeRKRV/OvmjYf
    dk8EErjYhVOqHgx6O1id3PSoeiJf5RetUc6+sPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519883914; bh=pNMrRT0bqp3gY/6Umtd/FQGgcOi5idU0mTcaklavr2Y=; b=q
    pxPz5dXZUs9DgEx65N5jj4eCgRG7FoQQvvqCx02J78yp6E4gAjM8rCmfTUzn5Mnl
    AKsR+502b98zbDQIK21Lu8c1jg+jQmY5Dcmg+rP/p/Y/uhTG+3NAIyxg545i3C6S
    tWQbW+cWcQ6qtwAaeYpOjqpiuSBenx02p+PlQGV0GTLirgoMUhTGFG7xX+66zp5v
    pxHSpTcUmpesoC7icQsanH5foQ5TWeAFBLFIduxAasg12U7bg8q9CqHwTjqs+nSi
    n3gKZFTCMgyKl0FCa0NC+MVN+sdcmUoJnBO02x3zm7vr05BOj1iraMTKIA6rjnP4
    uFwBiiie7du+44i+AUnOg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=synaptics.onmicrosoft.com header.i=@synaptics.onmicrosoft.com header.b=Vv4ey5Gt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-synaptics-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=synaptics.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synaptics.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=synaptics.onmicrosoft.com header.i=@synaptics.onmicrosoft.com header.b=Vv4ey5Gt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-synaptics-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=synaptics.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synaptics.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966173AbeCAF6S (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 00:58:18 -0500
Received: from mail-by2nam03on0055.outbound.protection.outlook.com ([104.47.42.55]:26517
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966089AbeCAF6Q (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 00:58:16 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Thu, 1 Mar 2018 13:57:55 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc: <linux-mmc@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-snps-arc@lists.infradead.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v4] mmc: dw_mmc: Fix the DTO/CTO timeout overflow
 calculation for 32-bit systems
Message-ID: <20180301135755.7e26f12e@xhacker.debian>
In-Reply-To: <20180228115318.20154-1-Evgeniy.Didin@synopsys.com>
References: <20180228115318.20154-1-Evgeniy.Didin@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: HK2PR04CA0074.apcprd04.prod.outlook.com (10.170.154.146) To
 BN6PR03MB2627.namprd03.prod.outlook.com (10.173.143.138)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5002b53-0301-4e35-6b7c-08d57f396c1b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR03MB2627;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;3:vmLR1djOxtcHXYKW8mE6ld4gan0MpkE623EFaNAu7sYlp1sEvofv/LAFtZWvA8uhY+RwXCvqXiHhd0RLsW63D6VfwVlO1xGab5K7cWH8yYAzCWJJMZt8gNcRn6VcQal9ttv65WrfzfTvAuJmc2S4EsKG++OP8iMrhZVodvT5Dv2ZGXUazcGvecYZpHGQLxLUm0scPIK5EOlgw50RNTodTmmf+zeCYvMeRq5Q+1Mv5GELJ+66c6/Ih/0VqcICkwBR;25:8kkcwUHTjiMEMFLZjoO2uzU5KY6Sw78wP06obhd7JDmw5WgfEk83TwMTNrn/14CYX1Z/VkLdX3KE7z6Ur8F6MuGMuEkfz8U7eBJQb/v61YhZO9zFPu53F4iWyF1ffWZze/K3QDBmpWZNMBDbo/5MBcVc0ScIdCtFdrr4XoKSCXqPaR7+5OPhFdc87w0i6VGcl3MalUf04V4jh384iI0dv+jOCEAjXK08tI+lgnI2VZefeeesj56rx5YI0eYbh1aYtsE9U7fCqu7i4oK4G0NsZOyk2LmAdB5UNQuyL/KnBEzRcOMm/Kgh6jCMmX8Pn71VS3NZVKnRGJQSek62KlL3NA==;31:dF2//Ar/YnMZ12RrVzXYYlN6TLCFAcsiUjcpMUoa7jOLhoSGMto4WXf4KqQ2ie4lHLS9JhTuMVvxhQi+O+3p50X0SdM3EWll73owo9f1p9WXRCK5+D0JUh8Sa+eiHjwCx/CDskZO/Z0V8+4dnrwOlg4WCZUUZ6oVvkw9Nyt2y3zg4NQyKmMUWR8ZSy4irkuetKZPznGOVjcAHtPZHCWBc4u9ULbBTVobnRc+ukRJHCU=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2627:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;20:m65G+Pn2zC0h5oh3TKXocOAoinECi+6ZXdAK1YZ7zp9Jep82ZA1yiXHd/9tiSmEp7uYBkzvCGtZ/CFMN8lbzrAFHLl2AKXxiFof+7vgkntyxKrTTjOecKls0qZTRd6rPdH2KbnMRKDRglubluEF24TpTdzAbZ+d7FVl5JWlxIZ2BWBJvAUR3hwRg9i6Gxx6e/mEhKf7cCWFyXwiGUuTNV7ZXo2yZp9RqDtI3ym2RZZPnt/pj3kYpTRxnx+xM0KedRAZWrP+Z/5yEpKQLExjgLqPYb1YE8HnsA+JipzHaWu6KkhS9Oxe6uOq0L1L8lCxk/HEV0c2LUaHNE0KdoMzMmyMjXp7q1u8j6qhRz24fMONz6Q9tqtTLtU8GH/Aw/u5Dj7C3GR6YhptZZmnsMpw6Rymxx+f5L/daQ2Z6v4Ycsmg=;4:NjBKVAHiDF8j36Kroaf+WtKF1pblI60tk71iW4ThhxjnKlh65GvCNK7dLOWKCL4fFipP4RjJJVbgZ9mnDZWSIglUtwdKQEVnvGdeVu1YKQNYDeHDhlyjOOuoSrgTS47lb/EDnjbJ9VuzRhLwLfDGXfZCjLMo6SrUg6I2rjq0BsRzleyDfV2SCh1201+s28OFD+z12fIIkk7i4URxPkZKW1yeJcJIqODfmDF3ZiIuVXdl2zYwXsZWRqwTxpbvTKYetzf17vPlPBMUNw8pnrxUNuMFFSSrdyqbaQwp40+TF+WUDvziw0v1gIXJrI/eoJLdxb2J9BRPVGTqzxUYsvGDWdV2lFJTKbTuzuD2xmtqjs41gbZDZr2gtJbJX1Y1zl/w
X-Microsoft-Antispam-PRVS: <BN6PR03MB2627EE893A4EA386F2D42FEFEDC60@BN6PR03MB2627.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(85827821059158)(258649278758335);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501161)(52105095)(6041288)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR03MB2627;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2627;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(199004)(189003)(1076002)(81156014)(72206003)(478600001)(2950100002)(229853002)(81166006)(16526019)(39060400002)(6506007)(2906002)(26005)(50466002)(186003)(386003)(9686003)(6246003)(55016002)(316002)(54906003)(110136005)(6666003)(68736007)(230700001)(33896004)(50226002)(53936002)(8676002)(8936002)(66066001)(105586002)(47776003)(4326008)(25786009)(5660300001)(305945005)(52116002)(7736002)(7696005)(3846002)(97736004)(6116002)(23726003)(76176011)(106356001)(7416002)(86362001)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2627;H:xhacker.debian;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2627;23:jsuyTORtcK9HSNn4nJFfrKorVpQ8BhJxYLzTQvSkm?=
 =?us-ascii?Q?Xy2YvtjBv6WCppNUhRAm6ur8ifQJlCoKZ31cnmEVb12XNaXZYk5rM5qZBFZp?=
 =?us-ascii?Q?o03iapgUsVvKnWjgGWR5MWY7C5JnF5EYsLG19e5Uc6PIaV59LmtQf4L/ESQr?=
 =?us-ascii?Q?C5LBwYFhQvigUgFSRv0w4oanwG79tQzx7VAoRYYTyvIaj7S75PWBDn26uO2T?=
 =?us-ascii?Q?zB15nAtTgSI3kGjX+I0Ao6IyRlssahpM3xzhtAxZNQQUE1mOUeu0wme+gz6C?=
 =?us-ascii?Q?Xlot6MaqAAo+zIVl1Jz87KNuTbCPAw6BxVBB/ENN+ya6WwLVLI8Y7pvpSjnt?=
 =?us-ascii?Q?GyjL9CIEHRxWVam/viWKsUluyj0uh7mvl3FHaS3gYD7X60013wyVl0g+ubQz?=
 =?us-ascii?Q?XKkACT5FgDy5i8Z22nY9ZAog2tZJvK2YzTAVX6G9vVEudpEqqlYPrsuV+Zgj?=
 =?us-ascii?Q?NdFIX2rf+puBh7yyRaL5V54tIb8qKoFn9pHZolZaI1wonsT/T3qorG81cBK3?=
 =?us-ascii?Q?u5DalmdtSTpqHdlPb+h4LBv4Axv15iA+awLVR/ypC2AgPBhubEYNnGSWR/4N?=
 =?us-ascii?Q?wAJEsWZxPIiWlWnqyEFveL64MoC0t2pq4QRPpQZgXrTdoLHz59CzW8KGJryO?=
 =?us-ascii?Q?4Vi/ZMjaQy0Nv65BLnTKCdfPlJNo+6XMt0KIdqkTPpW94X1SHisnt2YqeXbx?=
 =?us-ascii?Q?VmSsuNzc+tvuTtKxKZllH812FioM6VEfSJCRJHRn2b4TB76dcsDn8StsJlci?=
 =?us-ascii?Q?n3JUNOxuGlAn4rc5BRFvYan7bZbUIgSWgL3KLagNQKc927S1GNXSTvDEbOKV?=
 =?us-ascii?Q?78aR+vOWCxllnD+Sa6IOWUqsf4O/duMofESJ2yA6YhjO6ud/peQajL0i7fIu?=
 =?us-ascii?Q?NIIeLbYzk89f8IYevYhNQEk19+xvdL2LunWsct3LGQjsMH7F8+MQ+780k5qj?=
 =?us-ascii?Q?ICoACPr9P5BZdzBLzNeGX7ZfaDkqZ6KgBcGvRWMhLlt3121NTL0OzPCWPGH0?=
 =?us-ascii?Q?H6EfjtaE7BgF5/yemLgccWbyxdQoCibQangxb4TiJN/WqTAf272PMqzkVSRV?=
 =?us-ascii?Q?/LAbWS8xtcjJWgi3Iy1axo0Z/78BDtQzWLN0+Vg/GA5RCxSx28vlZWAcFXQM?=
 =?us-ascii?Q?DeCTYz4CYMOIXblBKDJ1BOVws6wf0jjEfgZGGYRNfL3ckW7XkLBUBNJmeoCV?=
 =?us-ascii?Q?6xD/csXAy8em496Zqa9QlKOI3F0Lhejt2iVXDCXdNpeP/Kajym0sEqU9CAtk?=
 =?us-ascii?Q?tA15Vsy3YlNLIeHbzTkmnbJgcxPUdnpmTSV1GE2?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2627;6:YE5WjuR5m/8D+pB5svu2NyLOIASkvOlzETfq61jrzS4pDBwBiqYOR9CCTMvwmm24NbtB12Z08fMS4/tqwD8POv8CtKNw/OFoo1DQy/JmWV6AX1lah4KgcS7+wGT7sOpeWyGpvLz3Qesd1GlBOuUpgtBs+Uiqb7bQ3V1A+HM0Ph3NagRG/tep4RKuif6GqV/XJsR/iESLUMpK5V1ibkP0OK9GY7N/Fi8ZV2jwTq3YgJ0+4HGH7T4ng/xE49QYhdL0YlMOmP603rVe733C1gfKlR4PT4+t9RCSGy443/1nHtxzOSfEAJOzQHLBVxMcAIgbPm5t3HSB9JWTC5KFzhPxK324bVD/qPDI4z0y7YBdtSQ=;5:7zhQiUi85DtPOlwBJm/pzpysGlPgwtlqfNoBA6ALZc5o35qDFynDAnhATgzxuFvqzEseuLKLxa9ALUtXWj/WYkHAPSELeisUQG7mmXNG9AEaCmgD6T2LKsXEyqq4psP+HtE6TVGzoO243AKCJM56OQn8198rmHiiyYlxnIbGhJk=;24:3miZ8KS6SIyPk0+4oct3XelmPw7VihB90YaKlSI10Fs+OLPMFFcUP/RTajtqAV9iYhO4/94doyxhyu7isIE8XtZO8mCgzUO6m6Brqz1ZK8M=;7:Us6pGGTfWVj7U7xpmUhjKiiQ+cIsBoSmy8Hc+sJK28OlHJZisdpblBEiNxEpqBRfSqD/Jyh3XXNoDBwxheh/fFD1T+I46zNMFNVI/VcscspsZgSQYgkBuA3ixiDnRJu/bNQhRM/D7WW+6GbYiNfqNXkcISJZkyXQrkbH4e+z6ogm3B27KMu/N9nGJzi0raludi7ks4VGQBg8bxunlyVeoWUoU3x6GFIZhfktYs3bpcJ9DR2ySs6rnFklqGWbElOu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 05:58:11.2017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5002b53-0301-4e35-6b7c-08d57f396c1b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2627
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 28 Feb 2018 14:53:18 +0300 Evgeniy Didin wrote:

> In commit 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation") and
> commit 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation") 
> have been made changes which cause multiply overflow for 32-bit systems.
> The broken timeout calculations leads to unexpected ETIMEDOUT errors and 
> causes stacktrace splat (such as below) during normal data exchange 
> with SD-card.
> 
> | Running :  4M-check-reassembly-tcp-cmykw2-rotatew2.out -v0 -w1
> | -  Info: Finished target initialization.
> | mmcblk0: error -110 transferring data, sector 320544, nr 2048, cmd response
> |  0x900, card status 0x0
> 
> DIV_ROUND_UP_ULL helps to escape usage of __udivdi3() from libgcc and so
> code gets compiled on all 32-bit platforms as opposed to usage
> of DIV_ROUND_UP when we may only compile stuff on a very few arches.
> 
> Lets cast this multiply to u64 type which prevents overflow.

Reviewed-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

> 
> Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com> # ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files
> Fixes: 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation")
> Fixes: 4c2357f57dd5 ("mmc: dw_mmc: Fix the CTO timeout calculation")
> 
> Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
> 
> CC: Alexey Brodkin <abrodkin@synopsys.com>
> CC: Eugeniy Paltsev <paltsev@synopsys.com>
> CC: Douglas Anderson <dianders@chromium.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> CC: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> CC: Shawn Lin <shawn.lin@rock-chips.com>
> CC: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> CC: linux-kernel@vger.kernel.org
> CC: linux-snps-arc@lists.infradead.org
> Cc: <stable@vger.kernel.org> 
> ---
> Changes since v3:
> -Switch DIV_ROUND_UP macro to DIV_ROUND_UP_ULL
> -Make one patch from two patches
> -Modify commit message
> 
> Changes sinve v2:
> -add fix for cto_ms
> 
> Changes since v1:
> -uint64_t switched to u64
> 
>  drivers/mmc/host/dw_mmc.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0aa39975f33b..cba534d4c81b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -409,7 +409,9 @@ static inline void dw_mci_set_cto(struct dw_mci *host)
>  	cto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
>  	if (cto_div == 0)
>  		cto_div = 1;
> -	cto_ms = DIV_ROUND_UP(MSEC_PER_SEC * cto_clks * cto_div, host->bus_hz);
> +
> +	cto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * cto_clks * cto_div,
> +				  host->bus_hz);
>  
>  	/* add a bit spare time */
>  	cto_ms += 10;
> @@ -1944,8 +1946,9 @@ static void dw_mci_set_drto(struct dw_mci *host)
>  	drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
>  	if (drto_div == 0)
>  		drto_div = 1;
> -	drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
> -			       host->bus_hz);
> +
> +	drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
> +				   host->bus_hz);
>  
>  	/* add a bit spare time */
>  	drto_ms += 10;
