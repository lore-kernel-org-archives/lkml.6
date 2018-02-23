Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1757466-1519356311-2-14274363563525463896
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='CN'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519356310; b=bCfNy9i5nBgnwHK6EZVktVr662dnhT59+6nLr3R56iQzVvd
    ECN8vBI2+L/iDeJ3NWK61rZcukOEF/agRlsQq4wcMgLqnJSOsJilDy2Eh4j9NhfX
    PBUKclIUJ8lAIm57ad/cCbL4g0U66jFB/s72bNWubm2ahvGCYuh4O6BBR1UTzz4m
    Q3xQRB7Ou04Rm61ixlHSdbE6hqACjRPhTv3WVZ3TydRB249wVedfsPDVVevNreGi
    qUkBuums1oZGddAGy0+hXc3PGJ557dOpY2DuX33r/lRgmmCPD+BIaApjtH0G7XKe
    PJYdc0XMvstzeHfGbxHR9jIVouPTyaeeliW/SxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519356310; bh=6EnkIzk6zcajqKgWTJtdrzmI3plHDwW3LC8O59h+Ogo=; b=m
    FcXFGwzIyBv4Hgib7R9607CZhP5hVctLSLJ+KFveDRniZDkg2+YEuBGO/7EaKmlE
    OpjGqmhAiksNnIH64wphsdYDesoGoNPMZVa+MfsBoOHWYTRpEi8maW00IBSb8MeF
    57/kjqVTTBaQM3We/FjysYFEoHWxOxKANDdMvRdeGFEth1JfKvFIb6xg/+JdqKZN
    cNRM5oX6swVHxTU+3jgYujHk5MTb5WHY51oBJoepiZs3uOgYCkX7Yy4fWuKClLTn
    Cj/LLAPymEk8/ms93biRHwOG/3hTI47rdkZQDhOPSXVxddEtpu8+m6GdAF97z2vL
    HpFzj5mNGDAPz2HRaFYCg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=synaptics.onmicrosoft.com header.i=@synaptics.onmicrosoft.com header.b=XmI05vzh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-synaptics-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=synaptics.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synaptics.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=synaptics.onmicrosoft.com header.i=@synaptics.onmicrosoft.com header.b=XmI05vzh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-synaptics-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=synaptics.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synaptics.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751296AbeBWDZI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 22:25:08 -0500
Received: from mail-sn1nam02on0078.outbound.protection.outlook.com ([104.47.36.78]:10784
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750995AbeBWDZG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 22:25:06 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Fri, 23 Feb 2018 11:24:34 +0800
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
Subject: Re: [PATCH v2] mmc: dw_mmc: Fix the DTO timeout overflow
 calculation for 32-bit systems
Message-ID: <20180223112434.20bb1c2c@xhacker.debian>
In-Reply-To: <20180222133418.29336-1-Evgeniy.Didin@synopsys.com>
References: <20180222133418.29336-1-Evgeniy.Didin@synopsys.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: SG2PR06CA0104.apcprd06.prod.outlook.com (10.170.138.30) To
 BN6PR03MB2625.namprd03.prod.outlook.com (10.173.143.136)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8219c4fd-8517-4754-f1ea-08d57a6d07fe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR03MB2625;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;3:zYrkql5tshaUGdcUTAgTUcWe8BZjiQJRT76ccE3o29gwKi7SjqfTK33QhrE0s55FWrRP3ju7jXLzvyXbruBAdErESNbZoF42UrgGDCFW3HHvfrByYk16BWs0Ox8A+Yl5Q79kbQ4HyMZ4gNsfKV75WB66qSqp4LHUUDz6gdNY9LJZoYt5U5HmhQqW3FUtR+SwgV6j299NVjqtpOLwdiLqmtjuu3Rbc78d1CcFfJqNiN2Exjobd27HXA49UMheZyT5;25:r7r7KSm5IoYz2FovNAqrNMT9HVlPIN/0P4AUEwxt5gawNyIcAye6YYssAKQyvYFb/HjvXk0M/IfMC6F1JqwsQXnNxYDbV9spYuzO5BEUpdnsuzv0YKon62V3pZ+SxDKWbl0dxkhgPlVla3m2espeIDO2xD8eJSwNzF6ZZDIBUegCJhzwYimOXTnvus8772IA4JEqXXxh5ixOg4EKX6Ju2zOs7p/9TQoYET+G6Oy9R2bq6/FlFgTVbVkrsPx+/bFxLJz9Yhy0d2aCxRayfu1N+8kJHb8MTwbX/6U/PbJqauPRUs10G0g+wUqkwRrmnNZyjZPyAM4WO4sx8fQBbKM8bA==;31:ZYlXgYW1bEKOY3aqNIWsEZEWuxqBRh04bF0SvRwKvy0h+B4dKArrKiUvr5yGzGS86l6Ay1fJnPpPUMhnhp1Ps6T3Kb75KcYPGnULfQ8UP2f82K4sfTFcP70OQddkDL5OhkSPHaG0f9UlUInqhYzSw1mXgaDycHHn3gPJ83zh/VGwdwyLCaQKnnhXEtn5ThPi+PiXQao96yDKNCIrY1OILiMqOaV/wlkn5Q/j51PXdqk=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2625:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;20:CCEc+b72VxadOPeUz2uzxx1gt/eHKIR6WoNDEHoMf0Nr/uzHwd9LBk1aL4WEf77SQyh7PeFKo+PjHQ/XifH3l3vkUQsRjHnmLv4QEApd4V8XYi2B9/yi+iqQOZGPljqkccxHz+VaAYOOKtcYVnaKeerKfkNeXIFRWWM4sKpdyF1EDaTFA1jgbJsoAkD+FXJsA/JAGUTK4OjxUtAHfycz3VLlMYOf/CzMAQtfk+8mGUUsze/xKGHRfOInZroXHMM5vki9iwMP+3GX7139/fyfHverZwKjnGtmZp4efPdNoeY7rKNeJBHzsYtZ4vYEsNeQYZRL3tMH/FBG59LYMEG9fUnka/6gDxy65PRdBBPlKy03AlDQn3clpiPxoI+9aNQtFAHJPjc8r2YZTn3pIjdmMlhMqZ4QWEF1fhOeA+PjK5U=;4:st4MLpkP/srns/2igrtWhrCxUC7gsz9psZ+v7swTa/q4ognAFF+VIALegvYrZ3+sL+z+nQMdK/5Q6/a5Ut94Ww2KacMrLY6uoCeEzcn0ThX0kuJAQeS/G5osgubpaKkC9Wg1xV3ywW1IFrhJHCJxdLXjTj2atlsqYEYMZnmTaBdzj8w15RdFg53QqUpeOaDPIWbYWOisRFiRi1lpM2tBgDEbCeJGxqNLT3F4VcxGlKYcn6K0xkhNtxwVOFtVkHXJ5TyIL9n36g792C1p46ARobjR6sJsvNHpqOFuaPnFlrfk2iu9P9OGeBJnqcPvvCIiUN66MD5pixtgRaAxEknPISiHGi6f9f7Wd8gJpDeIzfc=
X-Microsoft-Antispam-PRVS: <BN6PR03MB26252156D378581053393DD7EDCC0@BN6PR03MB2625.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(258649278758335);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231101)(944501161)(6041288)(20161123558120)(201703131423095)(201703061421075)(201703161042150)(20161123564045)(20161123562045)(20161123560045)(6072148)(6042181)(201708071742011);SRVR:BN6PR03MB2625;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2625;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(199004)(189003)(8676002)(45080400002)(25786009)(66066001)(97736004)(2906002)(230700001)(5660300001)(7736002)(106356001)(50466002)(72206003)(86362001)(50226002)(7696005)(498600001)(305945005)(52116002)(8936002)(575784001)(47776003)(81156014)(105586002)(186003)(59450400001)(16526019)(23726003)(33896004)(55016002)(6506007)(81166006)(26005)(1076002)(76176011)(68736007)(7416002)(53936002)(9686003)(229853002)(6246003)(386003)(6666003)(6916009)(2950100002)(54906003)(4326008)(3846002)(6116002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2625;H:xhacker.debian;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2625;23:YEoM7lXhO8YLkDek6Q9bpmJEiE4pjoBroOKJS1V/4?=
 =?us-ascii?Q?oMt14VEx7nMzTp8fZqWMuN99oIqcfYlhT9lvSjB9XJPrthRCdynL6OGhHsqJ?=
 =?us-ascii?Q?Xyg4iS5mrdEFoPVt6fyt3+tUxnajdAyVATL+lXoQ1MZyqMm0eMY7TBu/mgkm?=
 =?us-ascii?Q?Q4KXqgVKPjNvnIDKtLGdTEkZ6B5HE7roSbtGQO9l72p461jeV/z4G0I4w0ar?=
 =?us-ascii?Q?ZkcunCHA6soykaW62S4y2IpkqSBwKEA7mnwdV2g4bsjlWOH2us2ZoBZUHlgC?=
 =?us-ascii?Q?Sx/vbaA8zfegO4W/nOK9ebl+/ERBDPPDm/jUmp3qGl9BbMVt64EyNwtxLZ1k?=
 =?us-ascii?Q?9n7ODCtm9LrSun8N4vCRN/Cot1jWB4IjPwQspyI6aYwdOnnLGRSxuE9A+koP?=
 =?us-ascii?Q?1HvGPv2Hqr/BCARMYv7EDcTbzHpvHimzM9qKE5CEPEIyhJd+PFbe0DLnLR1p?=
 =?us-ascii?Q?Wdu+8uo5C7C+7gYrTrrIomJagxj3kbX7Nq2iN3ZFXi0Dv9QISi36VCB9W8Fr?=
 =?us-ascii?Q?yx9ahFTAMSNdFHSEgIIRR94qrVlQ1qXlh5wX0xt3lzJ/hCpHKneF+Frm0IVi?=
 =?us-ascii?Q?Z46R3ELMIr6KncnNu22m+G1bj7ntQG8oSJ5SghklEN2+1zEX/FLMNPGp8zH3?=
 =?us-ascii?Q?NE3apNoIxWFMcT5O/LgU2ZRpAUweO0hsBeS0e4fmdPuB+tmuU2UwmZGHGCTp?=
 =?us-ascii?Q?XBCCoKidiYspt8f8qV0LCcI31nJ8KwWV+/DoVxKG3+LhFLvxHwzT/telzYMY?=
 =?us-ascii?Q?+tGl38PBas5+Q4wT6fACZZFUexvMXsGCJEhbvvCm834KlAlPZCw50WMaCZn4?=
 =?us-ascii?Q?70ETlS8H+4QtSCkvfRz/bmhfyrz8IG1a91UfaRRYywgK4QnRgX6lGGJp2jJf?=
 =?us-ascii?Q?jobMY9q5EwVCy0svm7gtqZCqm8bEn8+Ljj/ssaU8y20F291lfgMp5QEnWZxe?=
 =?us-ascii?Q?US39xkWNqTFTzFN+q5LguvAGB9eoEtUjVVDe46q91DjpE+f6xeZ5cLVtDezK?=
 =?us-ascii?Q?d+Mduaa2bHGkiTbHuBEOr4mrRlf3MNzxlgqXWsBghJtloul9A2mRn9P5Gb8z?=
 =?us-ascii?Q?40oEf3ZD+UttrxzbxCyFlzZrO+X+r+ZAeogj6Vrc4/h1vN75A3h7KUEOmqZT?=
 =?us-ascii?Q?c1aFsEcyGt2CWffXhk6+yk924qS0hD8jIk9A4vy2dkIcg6FQlIyd33Gj3kCN?=
 =?us-ascii?Q?PESTdCZ1nnvbxWnnZS+9B0ZoY2l8kfR12sL?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2625;6:+namSPMV6EJlVS7C/9FfidSCNEubm939Conq35AGceVM/zi/oG4x4/7hC68PZz9gqKAtkFOQuIpoTxP/rTW6Ah613SEb7F2sxn8prz9HRp42ux14+M7jKyceqk/jMk7QmjLzGfF+KDw0Ppu48WRNc5V9YPXCDFHcajL87MN1Lq4htlhmIq9CVr1wceJBzw8BNt0Do66aWuCClKCecffDa1vgqQKchK9mUTLkXsP5ETE832UBCxtadYHTLQ/BbzOiIrLFDK6vWI9+VIveWf61wiYIlYat9kadVg3BwjPwD1XVvfJLArkWhboHGJ7F7XZTNLVXvZbMn0RJCm8L+q4r1DgI+hqwkhAs0BWpkEPz1kE=;5:yARAE0uDkmzGwwtROr5HhpfL/egEoVHzrRDiziGigJC6BEHSyVIoaz526f3ceawhMs+CikcM1mPQQV3XabEQ5l1z+xm7yMIyYAUV8hsGn5i9v2FApZSIE9oDQj+su8BcvVsua70naUsUr2XBcYPpk6DroBs3gyx93wvfLFpChH0=;24:R7Ngf2By1TyKC8GRMw8/zv3dQWDbKLXaf6p39McOqNfnNNW7M6NtOeeKuELvdzdRlFkxH4PlB3wZp8ZoJAExeO1sB7QL9+KCXHs6bRmn9ug=;7:DRFIHNDvLQgdD7EBLpDU8LwB5tlGxE9mGju+uBk1GUy9EAUqS3nBLcrntvbhBnPxZ7FgI0lC+eb+ImUI6XsZtV8TDa9vP0dWtIvkZ0Yexzrr7lrHFgEIGpqNpXujbL2F9lqXBr58Yq2f+SHwcg7fcEPJTLdJ41KQRolZq88FwphHKkvMbp8ZkxaP0p43mmexBLuQyh/VY1y8M6FKu9JJhw0vKrmAAWdZIz938vIVIwXOCvm+zdIV01uU48bp6Jjg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 03:25:01.2747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8219c4fd-8517-4754-f1ea-08d57a6d07fe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2625
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 22 Feb 2018 16:34:18 +0300 Evgeniy Didin wrote:

> In commit 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation") have been made
> changes which cause multiply overflow for 32-bit systems.
> The broken timeout calculations caused false interrupt latency warnings
> and stacktrace splat (such as below) when accessing the SD Card.
> 
> | Running :  4M-check-reassembly-tcp-cmykw2-rotatew2.out -v0 -w1
> | -  Info: Finished target initialization.
> | mmcblk0: error -110 transferring data, sector 320544, nr 2048, cmd response
> |  0x900, card status 0x0
> | mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual
> | 396825HZ div = 63)
> | mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 25000000Hz, actual
> |  25000000HZ div = 1)
> | ------------[ cut here ]------------
> | softirq: huh, entered softirq 6 TASKLET 6f6a9412 with preempt_count 00000101,
> | exited with 00000100?
> | WARNING: CPU: 2 PID: 0 at ../lib/scatterlist.c:652 sg_miter_next+0x28/0x20c
> | Modules linked in:
> | CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.15.0 #57
> |
> | Stack Trace:
> |  arc_unwind_core.constprop.1+0xd0/0xf4
> |  dump_stack+0x68/0x80
> |  warn_slowpath_null+0x4e/0xec
> |  sg_miter_next+0x28/0x20c
> |  dw_mci_read_data_pio+0x44/0x190
> |  dw_mmc f000a000.mmc: Unexpected interrupt latency
> |   dw_mci_interrupt+0x3ee/0x530
> |  __handle_irq_event_percpu+0x56/0x150
> |  handle_irq_event+0x34/0x78
> |  handle_level_irq+0x8e/0x120
> |  generic_handle_irq+0x1c/0x2c
> |  idu_cascade_isr+0x30/0x6c
> |  __handle_domain_irq+0x72/0xc8
> |  ret_from_exception+0x0/0x8
> |---[ end trace 2a58c9af6c25fe51 ]---
> 
> Lets cast this multiply to u64 type which prevents overflow.
> 
> Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
> Fixes: ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files
> 
> Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
> 
> CC: Alexey Brodkin <abrodkin@synopsys.com>
> CC: Eugeniy Paltsev <paltsev@synopsys.com>
> CC: Douglas Anderson <dianders@chromium.org>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-kernel@vger.kernel.org
> CC: linux-snps-arc@lists.infradead.org
> Cc: <stable@vger.kernel.org> #  9d9491a7da2a mmc: dw_mmc: Fix the DTO timeout calculation
> ---
> Changes since v1:
> -uint64_t switched to u64
> -changed commit message
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0aa39975f33b..1a0b9751c67c 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1944,7 +1944,7 @@ static void dw_mci_set_drto(struct dw_mci *host)
>  	drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
>  	if (drto_div == 0)
>  		drto_div = 1;
> -	drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
> +	drto_ms = DIV_ROUND_UP((u64)MSEC_PER_SEC * drto_clks * drto_div,
>  			       host->bus_hz);

DIV_ROUND_UP_ULL?

>  
>  	/* add a bit spare time */
